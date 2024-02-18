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

# Controls whether to use the original spawn placement routine or the new bounded one
#SPAWN = -DSPAWN_ORIGINAL
SPAWN = -DSPAWN_NEW

# Controls whether to use the original random number generator or a linear congruential generator.
#RNG = -DRNG_ORIGINAL
RNG = -DRNG_LCG

# Controls whether debug messages created with include/debug.inc are recorded
DEBUG = -DDEBUG

DEFS = $(PLAYER_GRAPHICS) $(PLAYER_GENDER) $(GLADIATOR) $(FF_OR_MANA) $(RNG) $(SPAWN)

all: debug

check: $(ROM)
	md5sum -c $(ROM).md5

clean:
	-rm -rf .bin .obj .dep .gfx

debug: DEFS += $(DEBUG)
debug: $(ROM)

amanda: clean
amanda: DEFS = -DPLAYER_GRAPHICS_AMANDA -DPLAYER_GENDER_FEMALE -DGLADIATOR_DUKE -DMANA -DRNG_LCG -DSPAWN_NEW
amanda: $(ROM)
	-rm -f LotMS-Amanda-*.gb
	mv $(ROM) LotMS-Amanda-`date +%F`.gb

duke: clean
duke: DEFS = -DPLAYER_GRAPHICS_ORIGINAL -DPLAYER_GENDER_MALE -DGLADIATOR_AMANDA -DMANA -DRNG_LCG -DSPAWN_NEW
duke: $(ROM)
	-rm -f LotMS-Duke-*.gb
	mv $(ROM) LotMS-Duke-`date +%F`.gb

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

.PHONY: all clean $(ROM)
.SECONDARY:
