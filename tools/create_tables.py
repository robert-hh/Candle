#
# nomalize test data

def norm(fname):

    steps = 256
    tailsize = 1000

    liste = []
    with open(fname) as f:
        for l in f:
            liste.append([int(i, 10) for i in l.split(' ')])
        
    print ("Anzahl Daten", len(liste))

## Mittelwerte bestimmen    
    
    minvalue1 = 4096
    maxvalue1 = 0
    minvalue0 = 4096
    maxvalue0 = 0
    avg0 = 0
    avg1 = 0

    for i in liste:
        minvalue0 = min(minvalue0, i[0])
        maxvalue0 = max(maxvalue0, i[0])
        minvalue1 = min(minvalue1, i[1])
        maxvalue1 = max(maxvalue1, i[1])
        avg0 += i[0]
        avg1 += i[1]
            
    avg0 /= len(liste)            
    avg1 /= len(liste)            
    
    print("Min0 = ", minvalue0, ", Max0 = ", maxvalue0, "avg0 = ", avg0)
    print("Min1 = ", minvalue1, ", Max1 = ", maxvalue1, "avg1 = ", avg1)
## Mittelwerte Anfang und Ende bestimmen    
    avghead0 = 0
    avghead1 = 0
    for i in range (0,tailsize):
        avghead0 += liste[i][0]
        avghead1 += liste[i][1]
    
    avgtail0 = 0
    avgtail1 = 0
    for i in range (-(tailsize + 1),-1):
        avgtail0 += liste[i][0]
        avgtail1 += liste[i][1]
    
    avghead0 /= tailsize
    avgtail0 /= tailsize
    avghead1 /= tailsize
    avgtail1 /= tailsize
    print("avghead0 = ", avghead0, ", avgtail0 = ", avgtail0)
    print("avghead1 = ", avghead1, ", avgtail1 = ", avgtail1)
# Kurve kippen    
    avgstep0 = (avgtail0 - avghead0)/len(liste)
    avgstep1 = (avgtail1 - avghead1)/len(liste)
    
    
    for i in range(len(liste)):
        liste[i][0] -= int(i * avgstep0)
        liste[i][1] -= int(i * avgstep1)
## Nochmals Mittelwerte bestimmen
    minvalue1 = 2000000000
    maxvalue1 = 0
    minvalue0 = 2000000000
    maxvalue0 = 0
    
    for i in liste:
        minvalue0 = min(minvalue0, i[0])
        maxvalue0 = max(maxvalue0, i[0])
        minvalue1 = min(minvalue1, i[1])
        maxvalue1 = max(maxvalue1, i[1])
            
    print("Min0 = ", minvalue0, ", Max0 = ", maxvalue0)
    print("Min1 = ", minvalue1, ", Max1 = ", maxvalue1)
    
    avghead0 = 0
    avghead1 = 0
    for i in range (0,tailsize):
        avghead0 += liste[i][0]
        avghead1 += liste[i][1]
    
    avgtail0 = 0
    avgtail1 = 0
    for i in range (-(tailsize + 1),-1):
        avgtail0 += liste[i][0]
        avgtail1 += liste[i][1]
    
    avghead0 /= tailsize
    avgtail0 /= tailsize
    avghead1 /= tailsize
    avgtail1 /= tailsize
    print("avghead0 = ", avghead0, ", avgtail0 = ", avgtail0)
    print("avghead1 = ", avghead1, ", avgtail1 = ", avgtail1)
        
    divide0 = ((maxvalue0 - minvalue0 + 1) / steps)
    divide1 = ((maxvalue1 - minvalue1 + 1) / steps)
    
    avg0 = 0
    avg1 = 0
    for i in range(len(liste)):
        liste[i][0] = int((liste[i][0] - minvalue0) / divide0)
        liste[i][1] = int((liste[i][1] - minvalue1) / divide1)
        avg0 += liste[i][0]
        avg1 += liste[i][1]
    avg0 = int(avg0/len(liste)) 
    avg1 = int(avg1/len(liste)) 
# und nochmals mittelwerte

    minvalue1 = 4096
    maxvalue1 = 0
    minvalue0 = 4096
    maxvalue0 = 0

    for i in liste:
        minvalue0 = min(minvalue0, i[0])
        maxvalue0 = max(maxvalue0, i[0])
        minvalue1 = min(minvalue1, i[1])
        maxvalue1 = max(maxvalue1, i[1])
    
    print("Min0 = ", minvalue0, ", Max0 = ", maxvalue0, "avg0 = ", avg0)
    print("Min1 = ", minvalue1, ", Max1 = ", maxvalue1, "avg1 = ", avg1)
    
    with open(fname + "lr", "w") as f:
        for i in liste:
            f.write("%d %d\n" % (i[0], i[1]))

    
    with open(fname + "f1.h", "w") as f:
        f.write("const PROGMEM  uint8_t bright[] = {")
        for i in range(len(liste)):
            if (i % 20) == 0:
                f.write("\n    ")
            f.write("%d" % liste[i][0])
            if i < len(liste) - 1: 
                f.write(", ")
        f.write("\n};\n")

        f.write("const PROGMEM uint16_t offset_tbl[] = {\n")
        
        j = 0
        while j < len(liste):
            if abs(liste[j][0] - avg0) < 10:
                f.write("%d, " % j)
                print(j, ", ", end = "")
                j += len(liste) // (17)
            else:
                j += 1
        f.write("%d\n};\n" % len(liste))
        print()
        
    
    with open(fname + "f2.h", "w") as f:
        f.write("const PROGMEM  uint8_t bright[] = {")
        for i in range(len(liste)):
            if (i % 20) == 0:
                f.write("\n    ")
            f.write("%d" % liste[i][1])
            if i < len(liste) - 1: 
                f.write(", ")
        f.write("\n};\n")

        f.write("const PROGMEM uint16_t offset_tbl[] = {\n")
        
        j = 0
        while j < len(liste):
            if abs(liste[j][1] - avg1) < 10:
                f.write("%d, " % j)
                print(j, ", ", end = "")
                j += len(liste) // (17)
            else:
                j += 1
        f.write("%d\n};\n" % len(liste))
        print()
        
    print (len(liste))
