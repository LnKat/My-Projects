from turtle import Turtle


class Scoreboard(Turtle):

    def __init__(self, name, position):
        super().__init__()
        self.hideturtle()
        self.color("white")
        self.penup()
        self.score = 0
        self.create_board(name, position)

    def create_board(self, name, position):
        self.goto(position, 315)
        self.write(f"{name} : {self.score}" , False, "center", ("Courier", 25, "normal"))


    def update_score(self,name, position):
        self.score +=1
        self.clear()
        self.create_board(name, position)

    def game_over(self, position):
        self.goto(position, 0)
        self.write(f"You lost!" , False, "center", ("Courier", 30, "normal"))
        self.goto(-position, 0)
        self.write(f"You won!" , False, "center", ("Courier", 30, "normal"))