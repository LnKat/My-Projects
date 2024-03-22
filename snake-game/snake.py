from turtle import Turtle
STEP = 20
UP = 90
DOWN = 270
RIGHT = 0
LEFT = 180

class Snake:

    def __init__(self):
        self.whole_snake=[]
        self.create_snake()
        self.head = self.whole_snake[0]
    

    def create_snake(self):
        for x in range(3):
            x_pos = x*(-20)
            pos = (x_pos, 0)
            self.add(pos)
            # self.snake.setx(x*(-20))
    

    def add(self, position):
        self.snake = Turtle(shape = "square")
        self.snake.penup()
        self.snake.color("white")
        self.snake.goto(position)
        self.whole_snake.append(self.snake)
        

    def reset(self):
        for seg in self.whole_snake:
            seg.goto(1000,1000)
        self.whole_snake.clear()
        self.create_snake()
        self.head = self.whole_snake[0]

    def extend(self):
        self.add(self.whole_snake[-1].position())
        

    def right(self):
        if self.head.heading() != LEFT:
            self.head.setheading(RIGHT)
      

    def left(self):
        if self.head.heading() != RIGHT:
            self.head.setheading(LEFT)
       

    def up(self):
        if self.head.heading() != DOWN:
            self.head.setheading(UP)
    

    def down(self):
        if self.head.heading() != UP:
            self.head.setheading(DOWN)


    def move(self):
        for i in range(len(self.whole_snake)-1, 0, -1):
            new_x = self.whole_snake[i-1].xcor()
            new_y = self.whole_snake[i-1].ycor()
            self.whole_snake[i].goto(new_x, new_y)
        
        self.head.forward(STEP)  
