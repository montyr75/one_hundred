# One Hundred

A web app that uses [AngularDart](https://webdev.dartlang.org/angular) and
[AngularDart Components](https://webdev.dartlang.org/components).

### The Game

This is a simple, multiplayer dice game in which the goal is to reach 100 points.

### Rules

- During a turn, a player rolls a single six-sided die.
    - If the result is anything but 1, that result is added to the player's points for the turn. The player must then decide whether to pass play to the next player or roll again, risking a result of 1.
    - If any roll comes up 1, any accumulated points for the turn are lost and play passes to the next player.