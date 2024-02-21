from turtle import Screen
from snake import Snake
from food import Food
import time
from scoreboard import Scoreboard

screen = Screen()
screen.setup(width=600, height=600)
screen.bgcolor("black") 
screen.title("Snake game")
screen.tracer(0)

snake = Snake()
food = Food()
scoreboard = Scoreboard()

screen.listen()
screen.onkey(snake.up, "Up")
screen.onkey(snake.down, "Down")
screen.onkey(snake.right, "Right")
screen.onkey(snake.left, "Left")


game_on = True    
while game_on:
    screen.update()
    time.sleep(0.1)
    snake.move()

    #Detect collision with food
    if snake.head.distance(food) < 17 :
        food.refresh()
        scoreboard.update_score()
        snake.extend()

    #Detect collision with wall
    x = snake.head.xcor()
    y = snake.head.ycor()
    if (x < -290 or x > 290 or y > 290 or y < -290):
        scoreboard.game_over()
        game_on = False

    #Detect collision with tail 
    # for i in range(1, len(snake.whole_snake)-1):
    #     if snake.head.distance(snake.whole_snake[i]) < 10:
    #         scoreboard.game_over()
    #         game_on = False
    for snake_part in snake.whole_snake[1:]:
        if snake.head.distance(snake_part) < 10:
            scoreboard.game_over()
            game_on = False


       


screen.exitonclick()