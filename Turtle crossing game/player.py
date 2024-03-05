from turtle import Turtle

class Tim(Turtle):

    def __init__(self):
        super().__init__()
        self.create_tim()
        

    def create_tim(self):
        self.shape("turtle")
        self.penup()
        self.setheading(90)
        self.goto(0, -280)

    def up(self):
        self.forward(10)

    def down(self):
        self.backward(10)

