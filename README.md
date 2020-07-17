# Basic Minecraft Lookalike (Godot)

This is a basic Minecraft lookalike made from scratch using Godot 3.2.1 and GDscript. While the goal originally was to make it as close to Minecraft as possible, I have gotten second thoughts as I do not want to infringe on Microsoft's and Mojang Studios intellectual property. This makes the future of this project uncertain.

![alt text](https://repository-images.githubusercontent.com/280267214/fb289800-c84d-11ea-8cb1-6692ebc0e5c4)

### Added functionalities:
- Procedurally generated world with customizable height, render distance, blocks and tree frequency (as variables at the top of the "Verden"-script).
- Character movement, including jumping, crouching and sprinting.
- Ability to destroy and place blocks.
- Switching between 1st-person and 3rd-person perspective using F5
- Toggling information like FPS, player position and player speed using F3.

### Lacking functionalities (at least the most critical):
- Ability to continously load more terrain as you move around.
- Ability to choose what blocks to place down.
- Different biomes
- Water physics
- Performance optimization
- Saving and loading the world
- Menu and settings interface
- Multiplayer

### How to test and edit
1. Download Godot (version 3.2.1 for guarantied compatibility) from https://godotengine.org/
2. Download zip or clone this repository (you can safely ignore any warnings from Chrome).
3. If you downloaded zip, the extract it.
4. Open Godot and import the downloaded repository by navigating to it's file named "project.godot".
5. Now you can edit it and/ or play it.
---
Beware:
- Some variable names, node names and push comments are in norwegian.
- The game seems to have a visual bug and FPS-drops in the newest Godot version.
