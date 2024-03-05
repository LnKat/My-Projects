from turtle import Turtle, Screen
from player import Tim
from cars import Cars
from scoreboard import Scoreboard
import time
import random

screen = Screen()
screen.setup(600,600)
screen.title("Turtle crossing")
screen.tracer(0)

tim = Tim()
score = Scoreboard()
car = Cars()

screen.onkey(tim.up, "Up")
screen.onkey(tim.down, "Down")
screen.listen()

points = 1
pace = 5
game_is_on = True
while game_is_on:
    time.sleep(0.1)
    screen.update()
    car.create_car()
    car.move_cars(pace)
    score.write_score(points)
    if tim.ycor() > 300:
        tim.create_tim()
        points+=1
        pace +=1
    for each_car in car.all_cars:
        if tim.distance(each_car)<18:   
            game_is_on = False
            score.game_over()
    




screen.exitonclick()