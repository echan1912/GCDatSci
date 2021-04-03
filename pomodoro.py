# import relevant modules https://medium.com/@fidel.esquivelestay/build-a-pomodoro-timer-using-python-d52509730f60

import time 
import datetime as dt 

import tkinter
from tkinter import messagebox
import winsound

import time

# countdown timer 
def countdown(t):
    while t: # while t > 0 for clarity 
      mins = t // 60
      secs = t % 60
      timer = '{:02d}:{:02d}'.format(mins, secs)
      print(timer, end="\r") # overwrite previous line 
      time.sleep(1)
      t -= 1
    print('Blast Off!!!')


countdown(int(t))


# pomodoro timer 
def pomodoro(): 
  print("Pomodoro starts now!")
  for i in range(4):
    t = 25*60
    while t: 
      mins = t // 60 
      secs = t % 60
      timer = '{:02d}:{:02d}'.format(mins, secs) 
      print(timer, end="\r") # overwrite previous line 
      time.sleep(1)
      t -= 1 
    print("Break Time!!")

    t = 5*60 
    while t: 
      mins = t // 60 
      secs = t % 60
      timer = '{:02d}:{:02d}'.format(mins, secs) 
      print(timer, end="\r") # overwrite previous line 
      time.sleep(1)
      t -= 1 
    print("Work Time!!")

t = input("Enter the time in minutes: ") 
# collect time information
t_now = dt.datetime.now() #current time
t_pom =  #want to set the time duration here, let user input
t_change = dt.timedelta(0,t_pom) #shows the time change
t_fut = t_now + t_change #future time
delta_sec =     #set break time between pomodoros, can choose to skip
t_fin = t_now + dt.timedelta(0, t_pom+delta_sec)

# user interface
root = tkinter.Tk()
root.withdraw()
#when it starts
messagebox.showinfo("The session has started!", "\nIt is now "+t_now.strftime("%H:%M") +
 "hrs. \nTimer set for     mins.") #need to modify this to show what user input
while True:
    if t_fut > t_now
        print('productivity in session')
    # after a pomodoro
    elif t_fut <= t_now <= t_fin
        print('Well Done!')
        if breaks == 0:
        # ring a bell 
            for i in range(): # check what this does
                winsound.Beep(i+60), 700)
            print('Onwards!')
else: 
    for i in range()
        winsound.Beep((i+60), 700)
    usr_ans = messagebox.askyesno("Would you like to start the next task?")
    if usr_ans == True:
        t_now = dt.datetime.now() 
        t_fut = t_now + t_change 
        t_fin = t_now + dt.timedelta(0, t_pom+delta_sec)
