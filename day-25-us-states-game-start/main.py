import turtle
import pandas

screen = turtle.Screen()
screen.title("U.S States Game")
image = "blank_states_img.gif"
screen.addshape(image)
turtle.shape(image)

df = pandas.read_csv("50_states.csv")


def create_tim(x_axis, y_axis, answer, color):
    tim = turtle.Turtle()
    tim.color(color)
    tim.penup()
    tim.hideturtle()
    tim.goto(x_axis,y_axis)
    tim.write(answer)


def print_missed_states(correct_list):
    all_states = df.state.tolist()
    missed_list = [state for state in all_states if state not in correct_list]
    missed_df = pandas.DataFrame(missed_list)
    missed_df.to_csv("missed_states.csv")
    #Let's print missed states on the map!
    for missed_state in missed_list:
        state = df[df.state == missed_state]
        x = state.iloc[0,1]
        y = state.iloc[0,2]
        create_tim(x, y, missed_state, "red")
        

correct_guesses= 0
correct_state_list = []
while correct_guesses < 50:
    answer_state = screen.textinput(title=f"{correct_guesses}/50 States Correct", prompt="What's another state name?")
    answer_state = answer_state.title()
    # correct_state_list = [st for st in all_states ]
    if answer_state in df.state.values:
        correct_state_list.append(answer_state)
        correct_guesses+=1
        state = df[df.state == answer_state]
        x = state.iloc[0,1]
        y = state.iloc[0,2]
        create_tim(x,y, answer_state, "black")
    elif answer_state == "Exit":
        print_missed_states(correct_state_list)
        break



screen.exitonclick()
# screen.mainloop()


