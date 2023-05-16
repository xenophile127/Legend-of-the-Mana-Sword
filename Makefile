ROM = rom.gb

SRCS = $(wildcard src/*.asm)
GFXS = $(shell find gfx/ -type f -name '*.png')

# Controls the graphics used from the main character
#PLAYER_GRAPHICS = -DPLAYER_GRAPHICS_ORIGINAL
PLAYER_GRAPHICS = -DPLAYER_GRAPHICS_AMANDA

# Controls what pronouns and gendered words characters use to refer to the main character.
#PLAYER_GENDER = -DPLAYER_GENDER_MALE
PLAYER_GENDER = -DPLAYER_GENDER_FEMALE

# Controls the name, pronouns, and graphics of the gladiator you meet in the beginning.
#GLADIATOR = -DGLADIATOR_AMANDA
GLADIATOR = -DGLADIATOR_DUKE

# Controls the name of the Nuke/Flare spell and maybe other things later.
FF_OR_MANA = -DMANA
#FF_OR_MANA = -DFINAL_FANTASY

DEFS = $(PLAYER_GRAPHICS) $(PLAYER_GENDER) $(GLADIATOR) $(FF_OR_MANA)

all: $(ROM)

check: $(ROM)
	md5sum -c $(ROM).md5

clean:
	-rm -rf .bin .obj .dep .gfx

$(ROM): $(patsubst src/%.asm,.obj/%.o,$(SRCS))
	@mkdir -p $(@D)
	rgblink -w -m $(basename $@).map -n $(basename $@).sym -o $@ $^
	rgbfix --validate $(FIXFLAGS) --pad-value 0x00 $@


.obj/%.o $(DEPDIR)/%.mk: src/%.asm $(patsubst gfx/%.png,.gfx/%.bin,$(GFXS))
	@mkdir -p $(dir .obj/$* .dep/$*)
	rgbasm $(DEFS) -Wall -Wextra --export-all -isrc -i.gfx -M .dep/$*.mk -MP -MQ .obj/$*.o -MQ .dep/$*.mk -o .obj/$*.o $<

.gfx/%.bin: gfx/%.png
	@mkdir -p $(dir .gfx/$*)
	rgbgfx -o .gfx/$*.bin $< -c '#ffffff,#c8c8c8,#646464,#000000'

ifneq ($(MAKECMDGOALS),clean)
-include $(patsubst src/%.asm,.dep/%.mk,$(SRCS))
endif

.PHONY: all clean
.SECONDARY:
