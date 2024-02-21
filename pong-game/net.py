from turtle import Turtle

class Net(Turtle):

    def __init__(self):
        super().__init__()
        self.color("white")
        self.pensize(5)
        self.hideturtle()
        self.speed("fastest")
        self.penup()
        self.create_net()


    def create_net(self):
        self.goto(0, -350)
        self.left(90)
        while self.ycor() < 350:
            self.forward(15)
            self.pendown()
            self.forward(15)
            self.penup()



class Line(Turtle):

    def __init__(self):
        super().__init__()
        self.hideturtle()
        self.color("white")
        up_line = 315
        down_line = -315
        self.draw_line(up_line)
        self.draw_line(down_line)


    def draw_line(self, pos):
        self.penup()
        self.goto(-600,pos)
        self.pendown()
        self.goto(600,pos)
