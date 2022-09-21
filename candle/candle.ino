// Eine LED mit 256 Stufen
// the setup routine runs once when you press reset:
#include <avr/pgmspace.h>
#include <avr/interrupt.h>
#include <avr/power.h>
#include <avr/sleep.h>
#include <avr/wdt.h>
//#include <avr/cores/tiny/core_adc.h>

// Data captured from a real candle, 1 per byte
#include "data_2.h"

#define VCC_PIN 0 // Ouput for Vcc measuring
#define LDR 1 //  Output controlling LDR
#define LED1 4 // Output of LED
#define SENSE 1 // Number of ADC
#define SENSE_PIN 2 //Number of port PIN for ADC1
#define STATUS 4

uint8_t ldr_state;
uint8_t vcc_state;
uint16_t prev;

#define OFF_LIMIT 850 // 800 // Values normalized for 3.7 V Vbat
#define ON_LIMIT  750 //700
#define VCC_LOW 207  // 2.75V: (Vcc - 0.3) * 1024/12.1
#define VCC_HIGH 220 // 2.9V: (Vcc - 0.3) * 1024/12.1

#define DEBUGLED 0

void wdt_init(void) __attribute__((naked)) __attribute__((section(".init1")));

void wdt_init(void)
{
    MCUSR = 0;
    wdt_disable();

    return;
}

void setup()
{
    // initialize the digital pins
#ifdef _AVR_IOTNX5_H_
    WDTCR |= (1 << WDIE); // reenable interrupt to prevent system reset
    // digitalWrite(LED_BOARD, LOW);
    power_usi_disable();
    ACSR |= _BV(ACD);                         //disable the analog comparator
//    analogReference(ADC_Reference_Internal_1p1);
    analogReference(INTERNAL1V1);
#else
    WDTCSR |= (1 << WDIE); // reenable interrupt to prevent system reset
#endif
    pinMode(LED1, OUTPUT); //LED on Model A
    pinMode(SENSE_PIN, INPUT);
    pinMode(VCC_PIN, INPUT);
    pinMode(LDR, INPUT);
#if DEBUGLED
    pinMode(STATUS, OUTPUT);
#endif
//    digitalWrite(LDR, HIGH);
    ldr_state = 1;  // start with light on
    vcc_state = 1;
// read LDR to seed RNG
    pinMode(LDR, OUTPUT);
    digitalWrite(LDR, HIGH);
    myrand(analogRead(SENSE) & 0xff);
    digitalWrite(LDR, LOW);
    pinMode(LDR, INPUT);

}

// the loop routine runs over and over again forever:
void loop()
{
    uint8_t index, mode;
    uint16_t offset, len, bright, vcc;

// Read VCC
    pinMode(VCC_PIN, OUTPUT);
    digitalWrite(VCC_PIN, HIGH);
    vcc = analogRead(SENSE);
    digitalWrite(VCC_PIN, LOW);
    pinMode(VCC_PIN, INPUT);

// Read LDR
    pinMode(LDR, OUTPUT);
    digitalWrite(LDR, HIGH);
    bright = analogRead(SENSE);
    digitalWrite(LDR, LOW);
    pinMode(LDR, INPUT);

// compensate brightness for changing vcc
    len = ((vcc * 121 + 512) >> 10) + 3;  // 10 times actual Vcc after Diode, rounded
    bright = (bright * 34) / len; // 34 = 10 times (mean Vcc - 0.3V)

#if DEBUGLED
    digitalWrite(STATUS, vcc_state);
#endif

    if (ldr_state != 0 && vcc_state != 0) {  // LED flickers
        wdt_disable();
        index = myrand(0) & 0x0f;
        offset = pgm_read_word_near(offset_tbl + index) >> 1;
        len = (pgm_read_word_near(offset_tbl + index + 1) >> 1) - offset;
        section(offset, len);  // Display
// Test LDR
        if (bright > OFF_LIMIT) { // Daytime, switch off
            ldr_state = 0;
            analogWrite(LED1, 0); // Switch off
        }
// Test VCC
        if (vcc < VCC_LOW) {  // Battery low, switch off
            vcc_state = 0;
            analogWrite(LED1, 0); // Switch off
        }
    } else {

        system_sleep(WDTO_8S, SLEEP_MODE_PWR_DOWN);  // Sleep for 8 sec.

// Test LDR
        if ((ldr_state == 0) && (bright < ON_LIMIT)) {  // Nighttime, switch on
            ldr_state = 1;
        }
// Test VCC, in case the battery recovers
        if ((vcc_state == 0) && (vcc > VCC_HIGH)) {
            vcc_state = 1;
        }
    }
}
// display a section
void section(uint16_t offset, uint16_t len)
{
    int i;
    uint16_t val;

    for (i = 0; i < len; i++) {
        val = pgm_read_byte_near(bright + offset + i); // one values per byte
        if (val < 128) {
            val = (val * val) >> 7;
        } else {
            val = 256 - val;
            val = 255 - ((val * val) >> 7);
        }
        blink(val);  //
    }

}
// display a value
void blink(uint16_t val)
{
    analogWrite(LED1, (val + 2 * prev) / 3); // interim step
    delay(33);
    analogWrite(LED1, (val * 2 + prev) / 3); // interim step
    delay(33);
    analogWrite(LED1, val);
    delay(33);
    prev = val;
}

// Additive RNG along Donal Knuth

uint8_t myrand(uint8_t noise)
{
    static uint8_t set[] = {
        21,  49, 217,  45,   6,  22, 161,  31,  61, 231,
        169,  17,  42, 173, 218, 194, 186, 170,  20,  89,
        44, 138, 163,  58,  30,  34, 220,  31, 134, 130,
        36,  42,  20,  98, 246,  23, 124, 121,  48,  16,
        92,   8,  82,  64,  94,  11, 250,  64, 214, 164,
        88,  87,  67, 225,  23
    };
    static uint16_t k = 54;
    static uint16_t j = 23;
    static uint16_t modulus = 256;
    uint8_t retval;
    int8_t i;

    if (noise != 0) {
        for (i = 0; i < sizeof(set); i++) {
            set[i] = (set[i] + noise) % modulus;
        }
    }

    set[k] = (set[k] + set[j]) % modulus;
    retval = set[k];
    k = (k - 1) % sizeof(set);
    j = (j - 1) % sizeof(set);
    return retval;
}

//****************************************************************
// set system into the sleep state
// system wakes up when wtchdog is timed out
void system_sleep(int duration, int mode)
{
    wdt_enable(duration);
    set_sleep_mode(mode); // sleep mode is set here
    wdt_reset();
#ifdef _AVR_IOTNX5_H_
    WDTCR |= (1 << WDIE); // reenable interrupt to prevent system reset
    ADCSRA &= ~_BV(ADEN);                     //disable ADC
#else
    WDTCSR |= (1 << WDIE); // reenable interrupt to prevent system reset
#endif

    sleep_enable();
    sleep_bod_disable();
    sleep_cpu();
    sleep_disable();                     // System continues execution here when watchdog timed out
#ifdef _AVR_IOTNX5_H_
    ADCSRA |= _BV(ADEN);                     //enable ADC
#endif
}

//****************************************************************

ISR(WDT_vect)
{
    wdt_disable();
}
