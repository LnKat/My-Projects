from turtle import Turtle
import random

COLORS = ["red", "green", "blue", "yellow", "black", "purple", "sienna", "salmon", "pink", "orange", "peru", "magenta", "crimson", "dark goldenrod", "olive drab"]

class Cars:

    def __init__(self):
        self.all_cars = []
        step = -230
        # self.positions = []
        # while step < 250:
        #     if step!=-50 and step!=50:
        #         self.positions.append(step)
        #         step+=10
        
    def create_car(self):
        random_cance = random.randint(1,6)
        if random_cance == 1:
            # positions = [-220, -210, -200, -180, -100, -60, 20, 60, 100, 180, 220]
            new_car = Turtle()
            rand_color = random.choice(COLORS)
            rand_pos = random.randint(-250, 230)
            new_car.color(rand_color)
            new_car.shape("square")
            new_car.shapesize(1,2)
            new_car.penup()
            new_car.goto(340, rand_pos)
            self.all_cars.append(new_car)

    def move_cars(self, pace):
        for auto in self.all_cars:
            auto.backward(pace)

    # def collision(self,turtlex, turtley):
    #     for auto in self.all_cars:
    #         return auto.xcor()-turtlex<5 or auto.ycor()-turtley<5

        
            