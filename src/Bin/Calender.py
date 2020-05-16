import collections as Col
import sys
# person_1 = ["4-16", "18-24"]
# person_2 = ["2-14", "17-24"]
# person_3 = ["6-8", "12-20"]
# person_4 = ["10-22"]
# allPeople = [person_1, person_2, person_3, person_4]


def parseSlot(list_of_slots):
    result = []
    for j in range(0, len(list_of_slots)):
        start_time = int(list_of_slots[j].split("-")[0])
        end_time = int(list_of_slots[j].split("-")[1])
        k = 0
        while (start_time + k) < end_time:
            result.append(str(start_time+k) + "-" + str(start_time+k+1))
            k += 1
    return result


def GetEnd(list2H, j):
    return int(list2H[j].split("-")[1])


def GetStart(list2H, j):
    return int(list2H[j].split("-")[0])


if __name__ == '__main__':
    allTimeSlots = []
    allCommon1HTime = []
    allCommon2HTime = []

    allPeople = []
    person1=[]
    person2=[]
    person3=[]
    person4=[]

    n = int(sys.argv[1])
 #   n = int(input("Enter the list size : "))
    for i in range(0, n):
        #print("Enter Person Nr°", i+1, ":")
        if i==0:
          # item = input()
            item = sys.argv[2]
          #  item = item.replace("'","")
            person1 = list(item.split(",")) 
          #  person1 = item.split(",")
            allPeople.append(person1)
        if i==1:
           item = sys.argv[3]
           person2 = list(item.split(",")) 
           #person2.append(item)
           allPeople.append(person2)
         #   item = item.replace("'","")
            
         #   person2 = item.split(",")   
           
        if i==2:
            item = sys.argv[4]
         #   item = item.replace("'","")
         #   person3.append(item)
            person3 = list(item.split(","))
        #    person3 = item.split(",")    
            allPeople.append(person3)
        if i==3:
            item = sys.argv[5]
          #   item = item.replace("'","")
           # person4.append(item)
            person4 = list(item.split(",")) 
          #  person4 = item.split(",")    
            allPeople.append(person4)




        #print("User List is ", allPeople)

    for j in range(0, 24):
        allTimeSlots.append(str(j) + "-" + str(j+1))
    commonFreeSlots = []
    for j in range(0, len(allTimeSlots)):
        timeSlotOk = True
        for k in range(0, len(allPeople)):
            person_free_slots = parseSlot(allPeople[k])
            if allTimeSlots[j] not in person_free_slots:
                timeSlotOk = False
                break
            if timeSlotOk:
                commonFreeSlots.append(allTimeSlots[j])

    c = Col.Counter(commonFreeSlots)
    for word, count in c.items():
        if count == n:
            allCommon1HTime.append(word)

    print('1/')
    for x in range(len(allCommon1HTime)):
        print(allCommon1HTime[x])

    i = 0
    while i < len(allCommon1HTime)-1:
        p0 = GetStart(allCommon1HTime, i)
        p1 = GetEnd(allCommon1HTime, i)
        p2 = GetStart(allCommon1HTime, i+1)
        p3 = GetEnd(allCommon1HTime, i+1)
        i += 1
        if p1 == p2:
            allCommon2HTime.append(str(p0) + "-" + str(p3))
            i += 1

    print('2/')
    for x in range(len(allCommon2HTime)):
        print(allCommon2HTime[x])
        sys.exit()
