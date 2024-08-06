# Legend of the Mana Sword
Improving and bug fixing Final Fantasy Adventure, the first game in the Mana series. Releases available on [Romhacking.net](https://www.romhacking.net/hacks/6550/).

## Building
Legend of the Mana Sword is built on top of [FFA-Disassembly](https://github.com/daid/FFA-Disassembly) which has made many larger changes possible. Building consists of assembling the source.
1. Install [RGBDS](https://rgbds.gbdev.io/).
2. Look in the [`Makefile`](Makefile) for any commented out options you may want to enable.
3. Run `make`.

## Documentation
- The [`docs`](docs) folder contains some outdated docs from the beginning of the disassembly, but should be used for documentation going forward.
- A lot of documentation is captured within the source in a scattered fashion.
- On the [Romhacking.net](https://www.romhacking.net/hacks/6550/) page there is documentation you would expect in a release, including a change log that predates the use of Git.
- There is also a forum thread for Legend of the Mana Sword on the [Romhacking.net Forum](https://www.romhacking.net/forum/index.php?topic=34237). Among other things the first post includes a list of what is "in scope" for changes.
- There is also a lot of information captured in the Discord chat for [mystic-editor](https://github.com/arathron123/mystic-editor), a Final Fantasy Adventure editor which Legend of the Mana Sword owes a great amount.

## Contributing
Most contributions should have an issue before a pull request, or the romhacking.net Forum  can be used for introductions.
- **Bug reporting:** Most releases of Legend of the Mana Sword have contained regressions that were not discovered during testing. There are also many bugs from the original cartridge releases that still have not been fixed. If you find a bug, report an issue.
- **Documentation:** Writing documentation is great. This project--like most--has grown gradually in complexity without documentation keeping up.
- **Changing code and graphics (or other assets):** Not all changes are within scope. Many people have strongly held opinions and sometimes there is no one right answer. Bug fixes that seem simple and obvious may have side effects you haven't considered. Some changes should be added with a conditional define in the `Makefile`. When in doubt, open an issue.
- **Colorization:** Work on colorization has begun. There has never been a fan-made colorization of a Game Boy game that satisfied everyone. There is a goal to make it easy for relatively untechnical people to make their own color choices. This is still at a very early stage with more documentation in [`docs/colorization.md`](docs/colorization.md).

  > 💡**Note:** Originally released in Japan as Seiken Densetsu (聖剣伝説), the American localization changed the name to Final Fantasy Adventure. For the European release the name was changed again to Mystic Quest as no games in the Final Fantasy series had been released there at that time. It received a remake/reboot game titled Sword of Mana, then a Japan-only mobile port once again just called Seiken Densetsu, and finally (to date) a 3d remake called Adventures of Mana.
  > 
  > The name Legend of the Mana Sword was chosen based on the original Japanese name. Any confusion with the fourth game in the Mana series is regretable.
