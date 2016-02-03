# Chaos
GGJ2016 Game made with Godot!
Brief resumée from our Global Game Jam site:

"A local multiplayer about Chaos, Friends, ugly sprites and trying to get everyone on the same keyboard."

It features a randomized keyboard for the players.
(http://globalgamejam.org/2016/games/chaos)

## The creators
Big Camaro Team:

* Henrique Alves - Lead programmer, Game Designer.
* Gabriel Maia - Programmer, Level Designer.
* Daniel Capella - Play Tester, Music Designer.
* Thiago Viana - Play Tester.

## Installing instructions
This is the Source file of the game. To run it, you have to download Godot game engine first (http://www.godotengine.org); than, just clone the repository / download the .zip file, and import the project to the engine.

If you want only the complete game files (not the source!), you may find the download link on our GlobalGameJam page!

## How-to play
Okay, now it starts to get a little bit more complicated.

You see, this is a Jam game. You know it, I know it, and everyone else knows that I'm trying to make an excuse over how imbalanced the game is; and this is pretty much true. The game is imbalanced as hell. The game even features a very neat boss fight; but our team only knows that the boss fight works because we playtested it specifically. We could never reached the boss fight. Heck, even during the Jam presentations, the playtesters could only go as far as the end of the FIRST stage (there are SEVEN before the boss). So, you and your friends better prepare yourselfs after these instructions.

And by the way, you'll need friends to play this game: 2 of them, as a matter of fact. Your only objective is to destroy all crystals and push all buttons on each stage (pushing buttons recquire to do it at the same time as all other buttons!), and than you can go to the next stage. But the trick is, the keyboard keys are randomized. So you'll have to play finger-twister on the keyboard while trying to move your characters.
And that is pretty much it.

This game also features:
* Ugly sprites
* Nice 8-bit like soundtrack
* Possible bugs
* A boss fight (!!)
* Dark-Souls like difficulty

## How can I create a Stage?
It's very simple! (Sure enough, you'll need the source and the Godot engine to do that)

All the stages consist of a Node2D as a Root (with the Stage.gd script), and a Tilemap that implements the "Tileset.xml" Asset. You'll only need to 'draw' the map using the Tilemap, and the Stage.gd script will build the stage for you using the correct Scenes for each tile on the Tilemap.

Some nodes need parameters, though; for example, if you want a Turret in your stage, you'll have to add the scene in the root of the Stage and set the parameters on the Inspector (in the case of the Turret, the parameters are the velocity Vector of the bullets and the timelapse between each bullet).

You might want to use the "Stage.scn" Scene as a testing stage, since it is a stage that doesn't appear on the Game (only the Stage with numbers). To debug a stage, press F6 ("Play the edited scene" on Godot Editor). In that way, you'll play the specific Stage without worrying about the random keyboard (all players will have the default "WASD" key for movement).

## Do you regret making this Game??
Not at all!

Our objective was to create a Game in which the main attraction would be the players screaming over how to move their characters while everyone is messing up in the keyboard; and we accomplished that! We laughed a lot while playtesting it, and during the Jam final presentation everyone had a lot of fun. Yup, the game is imbalanced and there are a lot of bugs, but that's fixable (I guess). The main feature is still golden, and we learned a lot by creating this Magna Opus.
