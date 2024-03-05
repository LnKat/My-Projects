from turtle import Turtle

FONT = ('Courier', 24, 'normal')

class Scoreboard(Turtle):

    def __init__(self):
        super().__init__()
        self.hideturtle()
        self.penup()
        self.goto(-220,260)
        score = 1
        self.write_score(score)
       

    def write_score(self, score):
        # self.goto(-220,260)
        self.clear()
        self.write(f"Level: {score}", False, "center", FONT)

    def game_over(self):
        turtle= Turtle()
        turtle.hideturtle()
        # turtle.goto(0,0)
        turtle.write("GAME OVER", False, "center", FONT)
       