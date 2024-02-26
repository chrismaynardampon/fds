import tkinter as tk
from tkinter import messagebox

window = tk.Tk()
window.title("Python Window")
window.geometry("1050x400")
window.configure(bg="orange")

studrec = [["studid","studname","studadd","studcontact", "studcourse", "yearlevel"],["1","asd","asd","asd", "asd", "asd"]]

label = tk.Label(window, text="Student Registration", width=50, height= 1, bg="yellow", anchor="center")
label.config(font=("Courier", 10))
label.grid(column=1,row=1)

label = tk.Label(window, text="Student ID:", width=20, height= 1, bg="yellow", anchor="center")
label.grid(column=1,row=2)

label = tk.Label(window, text="Student Name:", width=20, height= 1, bg="yellow", anchor="center")
label.grid(column=1,row=3)

label = tk.Label(window, text="Student Address:", width=20, height= 1, bg="yellow", anchor="center")
label.grid(column=1,row=4)

label = tk.Label(window, text="Student Contact:", width=20, height= 1, bg="yellow", anchor="center")
label.grid(column=1,row=5)

label = tk.Label(window, text="Student Course:", width=20, height= 1, bg="yellow", anchor="center")
label.grid(column=1,row=6)

label = tk.Label(window, text="Student Year Lvl:", width=20, height= 1, bg="yellow", anchor="center")
label.grid(column=1,row=7)



sid = tk.StringVar()
studid = tk.Entry(window, textvariable=sid)
studid.grid(column=2,row=2)

sname = tk.StringVar()
studname = tk.Entry(window, textvariable=sname)
studname.grid(column=2,row=3)

sadd = tk.StringVar()
studadd = tk.Entry(window, textvariable=sadd)
studadd.grid(column=2,row=4)

scontact = tk.StringVar()
studcontact = tk.Entry(window, textvariable=scontact)
studcontact.grid(column=2,row=5)

scourse = tk.StringVar()
studcourse = tk.Entry(window, textvariable=scourse)
studcourse.grid(column=2,row=6)

sid = tk.StringVar()
studid = tk.Entry(window, textvariable=sid)
studid.grid(column=2,row=7)

def msgbox(msg,titlebar):
    result=messagebox.askokcancel(title=titlebar, message=msg)
    return result

def callback(event):
    li = []
    li=event.widget._values
    sid.set(studrec[li[i]][0])
    sname.set(studrec[li[i]][1])

def creategrid(n):
    for i in range(len(studrec)):
        for j in range(len(studrec[0])):
            mgrid = tk.Entry(window,width=15)
            mgrid.insert(tk.END, studrec[i][j])
            mgrid._values = mgrid.get(), i
            mgrid.grid(row=i+9, column=j+6)
            mgrid.bind("<Button>-1", callback)

def save():
    r=msgbox("save record","record")
def update():
    r=msgbox("update record","record")
def delete():
    r=msgbox("delete record","record")

savebtn = tk.Button(text="Save", command=save)
savebtn.grid(column=1,row=8)

deletebtn = tk.Button(text = "Delete", command=delete)
deletebtn.grid(column=2,row=8)

updatebtn = tk.Button(text = "Update", command=update)
updatebtn.grid(column=3,row=8)

creategrid(0)
window.mainloop()
