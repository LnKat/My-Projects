from tkinter import *
from tkinter import messagebox
from random import shuffle, choice, randint 
import pyperclip
import json

# ---------------------------- PASSWORD GENERATOR ------------------------------- #
def generate_password():
    letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
    numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
    symbols = ['!', '#', '$', '%', '&', '(', ')', '*', '+']

    l_list = [choice(letters) for l in range(randint(8, 10))]
    s_list = [choice(symbols) for s in range(randint(2, 4))]
    n_list = [choice(numbers) for n in range(randint(2, 4))]

    password_list = l_list + s_list + n_list

    shuffle(password_list)

    password = "".join(password_list)
    pass_entry.insert(0, password)
    pyperclip.copy(password)

# ---------------------------- SAVE PASSWORD ------------------------------- #
def save():
    web_data = web_entry.get()
    email_data = email_entry.get()
    pass_data = pass_entry.get()
    new_data = {
        web_data: {
            "email": email_data,
            "password": pass_data,
        }
    }

    if not web_data or not pass_data:
        messagebox.showinfo(title="Oops", message="Please don't leave any fields empty!")
    else:
        try:
            with open("data.json", mode="r") as file:
                #Reading old data
                data = json.load(file)
                #Updating old data with new data
                data.update(new_data)
        except FileNotFoundError:
            with open("data.json", mode="w") as file:
                json.dump(new_data, file, indent=4)
        else:
            with open("data.json", mode="w") as file:
                #Saving updated data
                json.dump(data, file, indent=4)
        finally:
            web_entry.delete(0, END)
            pass_entry.delete(0, END)

#--------------------------SEARCH PASSWORD------------------------------#
def find_password():
    website = web_entry.get()
    try:
        with open("data.json", mode="r") as file:
            data = json.load(file)
    except FileNotFoundError:
        messagebox.showinfo(title="Error", message="No Data File Found")
    else:
        if website in data:
            em = data[website]["email"]
            pas = data[website]["password"]
            messagebox.showinfo(title=website, message=f"Email: {em}\nPassword:\n{pas}")
        else:
            messagebox.showinfo(title="Oops", message=f"No details for {website} exist")


# ---------------------------- UI SETUP ------------------------------- #
window = Tk()
window.title("Password Manager")
window.config(padx=50, pady=50)

canvas = Canvas(width=200, height=200)
key_img = PhotoImage(file="logo.png")
canvas.create_image(100, 100, image=key_img)
canvas.grid(row=0, column=1)

#Labels
web_text = Label(text="Website:")
web_text.grid(row=1, column=0)
email_text = Label(text="Email/Username:")
email_text.grid(row=2, column=0)
pass_text = Label(text="Password:")
pass_text.grid(row=3, column=0)

#Entries
web_entry = Entry(width=26)
web_entry.grid(row=1, column=1)
web_entry.focus()
email_entry = Entry(width=47)
email_entry.grid(row=2, column=1, columnspan=2)
email_entry.insert(0, "katerinatsivra@gmail.com")
pass_entry = Entry(width=23, font="Arial 12")
pass_entry.grid(row=3, column=1)

#Buttons
generate_button = Button(text="Generate Password", width=17, command=generate_password)
generate_button.grid(row=3, column=2)
add_button = Button(width=44, text="Add", command=save)
add_button.grid(row=4, column=1, columnspan=2)
search_button = Button(text="Search", width=17, command=find_password)
search_button.grid(row=1, column=2)

window.mainloop()
