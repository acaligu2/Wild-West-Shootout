# Wild-West-Shootout

Made using Xcode and SpriteKit in Swift

Wild West Shootout is a two-player reaction-based game. 

You have wound up in a duel with your opponent, tap your side of the screen faster than the other player in order to win. Once the timer hits 0, both players are able to draw their pistols and shoot. The player with the faster reaction time will win. This is implemented using the onTouchBegan() function in SpriteKit. The timestamps of the touches are compared to determine the winner.

The player can select from one or two-player gameplay. To implement a single-player mode, I wait between 8 and 14 frames, randomly, to decide when the CPU should fire its gun. The gameplay still features the same tap-to-shoot functionality for the player.

My main focus of this project was to create a visually appealing game. I did all the art myself using pixilart.com
