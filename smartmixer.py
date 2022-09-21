import time
import sys
import RPi.GPIO as GPIO
import json
import threading
import traceback
import pynput
import firebase_admin
import json
from datetime import datetime
from firebase_admin import credentials
from firebase_admin import db

GPIO.setmode(GPIO.BCM)

"""12345678"""
pin_1 = 7 #1번 모터(active high), 4개 릴레이 보드
pin_2 = 5 #2번 모터
pin_3 = 12 #3번 모터
pin_4 = 13 #4번 모터

touch_pin = 20

FLOW_RATE = 5.0/100.0

Solution=[]

# Firebase database 인증 및 앱 초기화
cred = credentials.Certificate('drinks.json')
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://smart-mixer-tukorea-s4-6-default-rtdb.firebaseio.com/'
    # 'databaseURL' : '데이터 베이스 url'
})
ref = db.reference()  # db 위치 지정, 기본 가장 상단을 가르킴

#칵테일 레시피 받아오기
drink_list = []
ref = db.reference('cocktail recipe')
drink_list2 = ref.get()
for i, v in drink_list2.items():
    drink_list.append({"name": i, "ingredients": v})



#Update Log
"""ref = db.reference('Log')"""
def UpdateLog(ref):
    for a, b in log.items():
        ref.update({a: b})

#Queue 가져오기
"""ref = db.reference('Queue') 사용"""
def GetQueue(ref):
    log = ref.get()
    Log = []
    name = ""
    user = ""
    pump = ""
    
    for a, b in log.items():
        if a == "pump_1":
            pump = pin_1
        elif a == "pump_2":
            pump = pin_2
        elif a == "pump_3":
            pump = pin_3
        elif a == "pump_4":
            pump = pin_4
        elif a == "name":
            name = b
        elif a == "user":
            user = b
        if type(b) == type (12):
            Log.append({"pump": pump, "volume": b})
    now = datetime.now()
    print(now)
    log["time"] = now.strftime("%Y-%m-%d %H:%M:%S")
    ref = db.reference('log')
    ref = ref.child(user)
    ref.update({name:log})
    return Log


#Queue Reset
"""ref = db.reference('Queue') 사용"""
def ResetQueue(ref):
    ref.set({None: {None: None}})

#Queue 가져오기
"""ref = db.reference('users') 사용"""
"""ref = ref.child('0veeGCxCAtOahBFZZxhT4VvSe8y1')"""
def GetCustom(ref, ID):
    ref = ref.child(ID)
    custom = ref.get()
    Custom = []
    for i, v in custom.items():
        Custom.append({"name": i, "value": v})
        for a in Log:
            if i in a["ingredients"]:
                a["ingredients"][i] = a["ingredients"][i] * v


class SmartMixer():
    def __init__(self):
        self.running = False

        # 펌프 초기화
        GPIO.setup(pin_1, GPIO.OUT, initial=GPIO.HIGH)
        GPIO.setup(pin_2, GPIO.OUT, initial=GPIO.HIGH)
        GPIO.setup(pin_3, GPIO.OUT, initial=GPIO.HIGH)
        GPIO.setup(pin_4, GPIO.OUT, initial=GPIO.HIGH)
        GPIO.setup(touch_pin, GPIO.IN)
        print("Done initiallizing")


    def startInterrupts(self):
        try:
            Solution=[]
            while True:
                try:
                    touch = GPIO.input(touch_pin)
                    if touch :
                        for a in GetQueue(db.reference('Queue')):
                            #ref = db.reference('Queue')
                            #GetQueue(ref)
                            
                            ref = db.reference('Queue')
                            ResetQueue(ref)
                            Solution.append({"pump" : a['pump'],"volume" : a['volume']})
                            self.makeDrink(Solution)
                    time.sleep(1)
                
                except AttributeError:
                    print("None")

        except KeyboardInterrupt:
            GPIO.cleanup()

    def pour(self, pin, waitTime):
        GPIO.output(pin, GPIO.LOW)
        time.sleep(waitTime)
        GPIO.output(pin, GPIO.HIGH)

    def makeDrink(self, Solution):
        self.running = True
        # Parse the drink ingredients and spawn threads for pumps
        maxTime = 0
        pumpThreads = []
        for ing in Solution:
            waitTime = ing["volume"] * FLOW_RATE
            if (waitTime > maxTime):
                maxTime = waitTime
                pump_t = threading.Thread(target=self.pour, args=(ing["pump"], waitTime))
                pumpThreads.append(pump_t)
                maxTime = 0
                Solution.remove(ing)

        # start the pump threads
        for thread in pumpThreads:
            thread.start()

        # wait for threads to finish
        for thread in pumpThreads:
            thread.join()

        # sleep for a couple seconds to make sure the interrupts don't get triggered
        time.sleep(2);

        # reenable interrupts
        # self.startInterrupts()
        self.running = False



    def run(self):
        self.startInterrupts()
        # main loop
        try:
            while True:
                time.sleep(0.1)

        except KeyboardInterrupt:
            GPIO.cleanup()  # clean up GPIO on CTRL+C exit
        #GPIO.cleanup()  # clean up GPIO on normal exit
        traceback.print_exc()


smartmixer = SmartMixer()
smartmixer.run()