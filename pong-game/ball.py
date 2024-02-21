import turtle

class Ball(turtle.Turtle):

    def __init__(self):
        super().__init__()
        self.shape("circle")
        self.color("white")
        self.penup()
        

    def move(self, step):
        self.forward(step)

        

        