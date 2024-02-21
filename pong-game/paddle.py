from turtle import Turtle, Shape

class Paddle(Turtle):

    def __init__(self, where_to):
        super().__init__()
        self.create_paddle(where_to)
    

    def create_paddle(self, where_to):
        self.shape("square")
        self.shapesize(1, 5, 0)
        self.penup()
        self.setheading(90)
        self.goto(where_to,0)
        self.color("white")


    def up(self):
        self.forward(30)


    def down(self):
        self.backward(30)


