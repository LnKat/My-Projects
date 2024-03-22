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
        with open("data.txt") as file:
            self.high_score = file.read()
        self.write_score()
        
    def write_score(self):
        self.write(f"Score: {self.score}  High Score: {self.high_score}", False, ALIGNMENT, FONT)   
        
    def update_score(self):
        self.clear()
        self.score +=1
        self.write_score()

    # def game_over(self):
    #     self.goto(0,0)
    #     self.write("GAME OVER", False, ALIGNMENT, FONT)
    def reset(self):
        if self.score > int(self.high_score):
            with open ("data.txt", mode="w") as file:
                self.high_score = self.score
                file.write(str(self.high_score))
        self.score = int(self.score)
        self.score = -1
        self.update_score()

