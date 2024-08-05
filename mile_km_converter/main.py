from tkinter import *


def convertion():
    miles= float(entry.get())
    calc = str(miles * 1.60934)
    label_result["text"] = calc


window = Tk()
window.title("Miles to Km Converter")
#window.minsize(width=400, height=300)
window.config(padx=50, pady=50)

label_mi = Label(text="Miles", font=("Arial",15))git 
label_mi.grid(row=0,column=2)
label_mi.config(padx=15, pady=15)

label_eq = Label(text="is equal to", font=("Arial",15))
label_eq.grid(row=1,column=0)
label_eq.config(padx=15, pady=15)

label_km = Label(text="Km", font=("Arial",15))
label_km.grid(row=1,column=2)
label_km.config(padx=15, pady=15)

entry = Entry(width=10)
entry.insert(END, string="0")
entry.grid(row=0, column=1)

label_result = Label(text="0")
label_result.grid(row=1,column=1)
label_result.config(padx=15, pady=15)

button = Button(text="Calculate", command=convertion)
button.grid(row=2, column=1)
button.config(padx=15, pady=15)


window.mainloop()