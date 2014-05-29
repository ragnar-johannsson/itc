## Itc

Itc is an iTunes command line client. It indexes iTunes' Music Library XML file into a SQLite3 database for faster lookup and provides shell tab completion for metadata.


### Installation

Install the gem:

    $ gem install itc

Copy the tab completion definitions under `extra/completion/` to the appropriate paths for your system and shell.


### Usage

After installing, start by indexing the iTunes Music Library:

    $ itc index

This generates a SQLite3 database in `$HOME/.itc.db` which will act as a cache for the iTunes Music Library XML files. Rerun the index command after adding new content to iTunes. Alternatively, add it to crontab to keep things in sync. 

After indexing you can start querying the library:

    $ itc list artist

will return a list of all artists in the library.

    $ itc play artist=Daft\ Punk

will start to play all songs and albums by Daft Punk in the Library.

    $ itc play artist=Ibrahim\ Maalouf album=Wind

will play the album Wind by Ibrahim Maalouf. Notice that if the tab completions are installed there is no need to laboriously spell out full names for the filters as they will tab complete just fine.

Recognized filters for the **list** and **play** commands are `artist`, `album`, `song`, `year` and `genre`. 

Following are all recognized commands:

* **index** - (Re)index the music database
* **list** - Search for tracks
* **next** - Skip to next song
* **pause** - Pause playing
* **play** - Commence playing
* **previous** - Go back one song
* **status** - Show playing status, playlist position

To gauge the position within the current album or playlist use the **status** command:

    $ itc play artist=Emika album=DVA
    $ itc next 
    $ itc status
       Emika - DVA - Hush (Interlude) feat. Michaela Srumova
     ▶ Emika - DVA - Young Minds
       Emika - DVA - She Beats
       Emika - DVA - Filters
       Emika - DVA - After The Fall
       Emika - DVA - Sing To Me
       Emika - DVA - Dem Worlds
       Emika - DVA - Primary Colours
       Emika - DVA - Sleep With My Enemies
       Emika - DVA - Wicked Game
       Emika - DVA - Fight For Your Love
       Emika - DVA - Mouth To Mouth
       Emika - DVA - Searching
       Emika - DVA - Centuries
       Emika - DVA - Criminal Gift
    $


### License

BSD 2-Clause. See the LICENSE file for details.
