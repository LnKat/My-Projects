from turtle import Turtle
ALIGNMENT = "center"
FONT = ("Courier", 15, "normal")

class Scoreboard(Turtle):

    def __init__(self):
        super().__init__()
        self.goto(0,275)
        self.hideturtle()
        self.color("white")
        self.score = 0
        self.write_score()
        
    def write_score(self):
        self.write(f"Score: {self.score}", False, ALIGNMENT, FONT)   
        
    def update_score(self):
        self.clear()
        self.score +=1
        self.write_score()

    def game_over(self):
        self.goto(0,0)
        self.write("GAME OVER", False, ALIGNMENT, FONT)

