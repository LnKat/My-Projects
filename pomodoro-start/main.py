from tkinter import *
# ---------------------------- CONSTANTS ------------------------------- #
PINK = "#e2979c"
RED = "#e7305b"
GREEN = "#9bdeac"
YELLOW = "#f7f5dd"
FONT_NAME = "Courier"
WORK_MIN = 25
SHORT_BREAK_MIN = 5
LONG_BREAK_MIN = 20
reps = 0
new_text = ""
tik_tok = None

# ---------------------------- TIMER RESET ------------------------------- # 
def reset_timer():
    window.after_cancel(tik_tok)
    canvas.itemconfig(timer_text, text="00:00")
    checks.config(text="")
    timer.config(text="Timer")
    global reps
    reps = 0


# ---------------------------- TIMER MECHANISM ------------------------------- # 
def start_timer():
    global reps
    reps+=1
    txt = "Break"
    time = SHORT_BREAK_MIN
    col = PINK
    if reps % 2 != 0:
        time =  WORK_MIN
        txt = "Work"
        col = GREEN
    elif reps % 8 == 0:
        time = LONG_BREAK_MIN
        txt = "Break"
        col = RED
    timer.config(text=txt, fg = col)
    
    count_down(time*60)
    

# ---------------------------- COUNTDOWN MECHANISM ------------------------------- # 
def count_down(count):
    global new_text
    min = count // 60
    sec = count % 60
    canvas.itemconfig(timer_text, text=f"{min}:{sec:02d}")
    if count>0:
        global tik_tok
        tik_tok = window.after(1000, count_down, count-1)
    else:
        start_timer()
        if reps % 2 == 0: 
            new_text += " ✔"
            checks.config(text=new_text)

# ---------------------------- UI SETUP ------------------------------- #
window = Tk()
window.title("Pomodoro")
window.config(padx=100, pady=50, bg=YELLOW)

canvas = Canvas(width=200, height=224, bg=YELLOW, highlightthickness=0)
tomato_img = PhotoImage(file="tomato.png")
canvas.create_image(100, 112, image=tomato_img)
timer_text = canvas.create_text(110, 130, text="00:00", fill="white", font=(FONT_NAME, 30, "bold"))
canvas.grid(row=1, column=1)

timer = Label(text="Timer", fg=GREEN, bg=YELLOW, font=("Comic Sans MS", 45, "bold"))
timer.grid(row=0, column=1)

start = Button(text="Start", background="white", command=start_timer)
start.grid(row=2, column=0)

reset = Button(text="Reset", background="white", command=reset_timer)
reset.grid(row=2, column=2)

checks = Label(fg=GREEN, bg=YELLOW, font=("Comic Sans MS", 28, "bold"))
checks.grid(row=3, column=1)


window.mainloop()