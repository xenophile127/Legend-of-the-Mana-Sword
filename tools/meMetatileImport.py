import sys
import glob
import xml.etree.ElementTree as et

labels = {0: 'metatilesOutdoor',
          1: 'metatilesTown',
          2: 'metatilesIndoor',
          3: 'metatilesCaves',
          4: 'metatilesTitle',
          5: 'metatilesWorldmap'}

if len(sys.argv) == 1:
  print("Use tile data from Mystic Editor sheet_??.txm files")
  print("to write a metatiles.asm file. Pass the base directory")
  print("of the decode as an argument.")
  print("Mystic Editor is available from:")
  print("https://github.com/arathron123/mystic-editor")
  exit()

# Read the Mystic Editor exported Tiled xml files
path = sys.argv[1] + '/spriteSheets/'
tables = sorted(glob.glob(path + 'sheet_??.tmx'))
output = []
for table in tables:
  tree = et.parse(table)
  root = tree.getroot()
  for child in root:
    if child.tag == 'layer':
      tiles = []
      for line in child[0].text.splitlines():
        if line:
          tiles.append(line.split(','))
    if child.tag == 'objectgroup':
      types = child
  metatiles = []
  for n,e in enumerate(types):
    metatile = []

    # Take two tile ids from each of two lines
    metatile.append(hex(0x100+int(tiles[2*(n//16)][(n%16)*2+0]) - 1)[-2:])
    metatile.append(hex(0x100+int(tiles[2*(n//16)][(n%16)*2+1]) - 1)[-2:])
    metatile.append(hex(0x100+int(tiles[1+2*(n//16)][(n%16)*2+0]) - 1)[-2:])
    metatile.append(hex(0x100+int(tiles[1+2*(n//16)][(n%16)*2+1]) - 1)[-2:])

    # Combine with collision/behavior values
    metatile.append(e[0][0].attrib['value'])
    metatile.append(e[0][1].attrib['value'])
    metatiles.append(metatile)
  output.append(metatiles)

# Write the assembly file
with open('metatiles.asm', 'w') as f:
  f.write("; Exported by meMetatileImport.py from a Mystic Editor decode.\n")
  f.write("; Mystic Editor is available from:\n")
  f.write("; https://github.com/arathron123/mystic-editor\n\n")
  f.write("; Each metatile is six bytes.\n")
  f.write(";  0-3: Tile graphic index.\n")
  f.write(";  4-5: Behavior and collision info.")
  for n,table in enumerate(output):
    f.write('\n' + labels[n] + ':\n')
    for i, tile in enumerate(table):
      f.write('    db   $' + ', $'.join(tile))
      f.write('                  ;; $' + hex(0x100+i)[-2:] + '\n')
