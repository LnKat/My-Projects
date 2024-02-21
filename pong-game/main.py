from turtle import Turtle, Screen
import paddle
import net
from ball import Ball
import time
import random
from scoreboard import Scoreboard

#Create the screen
screen = Screen()
screen.bgcolor("black")
screen.screensize(1200, 600)
screen.title("Pong")
screen.tracer(0) #animation is off

l_player = screen.textinput("PONG", "Name of first player:")
r_player = screen.textinput("PONG", "Name of second player:")

line = net.Line()

#Create the ball
ball = Ball()

# Create the net in the middle
net = net.Net()

l_scoreboard = Scoreboard(l_player, -300)
r_scoreboard = Scoreboard(r_player, 300)

# Create the paddles
r_paddle = paddle.Paddle(550)
l_paddle = paddle.Paddle(-550)

screen.onkey(r_paddle.up, "Up")
screen.onkey(r_paddle.down, "Down")
screen.onkeypress(l_paddle.up, "w")
screen.onkeypress(l_paddle.down, "s")
screen.listen()

starting_dir = "right"
step = 5
def pong():
    game_on = True
    global starting_dir
    global step
    if starting_dir == "right":
        starting = random.randint(-70, 70)
    else:
        starting = random.randint(100, 250)

    ball.setheading(starting)
   
    while game_on:
        time.sleep(0.02)
        screen.update() #animation on

    # Detect collision with walls and bounce
        if ball.ycor() > 300 or ball.ycor() < -300:
            ball.setheading(360-ball.heading())

    #Detect collision with paddle
        if (ball.distance(r_paddle) < 50 and ball.xcor() > 500)  or (ball.distance(l_paddle) < 50 and ball.xcor() < 500):
            ball.setheading(180-ball.heading())
            ball.forward(20)
            step +=1 

    #Update score
        
        if ball.xcor() > 680:
            l_scoreboard.update_score(l_player, -300)
            starting_dir = "left"
            step = 5
            break 
        elif ball.xcor() < -680:
            r_scoreboard.update_score(r_player, 300)
            starting_dir = "right"
            step = 5
            break
    
        ball.move(step)
        

game_goes_on = True
while game_goes_on:
    pong()
    ball = Ball()

screen.exitonclick()
