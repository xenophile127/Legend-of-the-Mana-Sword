# [Legend of the Mana Sword](./) Lazy DX Colorization

The term "Lazy DX" was coined by amaturehr for a technique for improving colors on GBC without doing a full colorization. Full colorization usually requires a lot of code changes because most special effects (such as screen fades) do not work the same way.

However the GBC has a built-in backwards compatibility mode and a game can be optimized to look better when played under it. You can see how amaturehr uses this in [this video from Mega Man World 4 LDX](https://youtu.be/efG_vd0EuZE).

For Legend of the Mana Sword, Lazy DX methods are used to improve sprite and background appearances. 

## Sprites

| Game Boy | Game Boy Color Default | Game Boy Color BIOS | Game Boy Color Lazy DX |
| ![B&W 0](images/lazydx/demo0a.png) | ![Default 0](images/lazydx/demo0b.png) | ![BIOS 0](images/lazydx/demo0c.png) | ![Lazy 0](images/lazydx/demo0d.png) | 
| ![B&W 1](images/lazydx/demo1a.png) | ![Default 1](images/lazydx/demo1b.png) | ![BIOS 1](images/lazydx/demo1c.png) | ![Lazy 1](images/lazydx/demo1d.png) | 

The Game Boy has two sprite palettes.

For Final Fantasy Adventure  on black and white Game Boys the two palettes normally look identical.

On Game Boy Color there are default colors. Most of the time the two palettes are still the same, but if the BIOS (the code inside the GBC) recognizes a game it can pick other colors.

This rom hack has a change so that the GBC BIOS chooses a specific built in palette. This palette is exactly the same as its default except one of the sprite palettes uses blue instead of red.

Then certain sprites can be switched to the other palette so they can be blue instead of red or switched back to red instead of the new blue.

Two special effects change one of these palettes: The Dark (Blind) effect and boss damage flash. This means bosses and many enemies need to stay blue. It's a big restriction to this method.

## Backgrounds

| Black & White Original | Color Original | Black & White Modified | Color Modified |
| ![B&W Original 2](images/lazydx/demo2a.png) | !Color Original 2](images/lazydx/demo2b.png) | ![B&W Modified 2](images/lazydx/demo2c.png) | ![Color Modified 2](images/lazydx/demo2d.png) 

The GB only has one background palette, but on GBC this palette has green and blue. That allows some nice improvements. For instance, there are some screens that show the sky. Originally on GBC that sky would have been shown as green, but by changing the graphics it can be blue instead.
