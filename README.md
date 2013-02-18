# ANE7z

Adobe AIR iOS Native Extension to decompres 7z files.

Uses a slightly modified verion of lzmaSDK https://github.com/mdejong/lzmaSDK

## Features:

* Decompress 7z ( Sync/Async )
* Decompress single file from 7z to disc  ( Sync/Async ) 


## Todo
 * Add working example
 * Get list of 7z contents before uncompress
 * Add compression methods

## ANE7z static Methods

#### decompress(source : File, destination : File) : Array;

    Synchronously decompress the source file in to destination folder.
    If folder don't exist it will be created
    
#### decompressAsync(source : File, destination : File) : void;

    Asynchronously decompress the source file in to destination folder.
    If folder don't exist it will be created.
    
    Dispatches ANE7zEvent.UN7Z_START when the process starts.
    Dispatches ANE7zEvent.UN7Z_END when the process ends.
    Dispatches ANE7zEvent.UN7Z_PROGRESS each time a file in the 7z is decompressed.
        event.eventData will contain:
        * current   -> current index of decompressed file
        * total     -> total files to decompress inside zip   
   
    
#### extractEntry(source : File, destination : File, entry : String) : Boolean;

    Synchronously extracts a single file from "source" named "entry" to the destination file.
    Return true if extraction was done correctly
    
#### extractEntryAsync(source : File, destination : File, entry : String) : void;

    Asynchronously extracts a single file from "source" named "entry" to the destination file.
    Dispatches ANE7zEvent.UN7Z_ENTRY_START when the process starts.
    Dispatches ANE7zEvent.UN7Z_ENTRY_END when the process ends.
        event.eventData will contain:
        * success   -> if extraction was done correctly   
    
## License

<!-- Creative Commons License -->
<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/"><img alt="Creative Commons License" border="0" src="http://i.creativecommons.org/l/by-sa/3.0/88x31.png" class="cc-button"/></a><div class="cc-info"><span xmlns:cc="http://creativecommons.org/ns#" xmlns:dc="http://purl.org/dc/elements/1.1/"><span id="work_title" property="dc:title">ANE7z</span> by <a rel="cc:attributionURL" property="cc:attributionName" href="http://www.xperiments.es">Pedro Casaubon</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/">Creative Commons Attribution-ShareAlike 3.0 License</a>. <span rel="dc:source" href="https://github.com/xperiments/ANEFileSyncInterface"/></span></div>

A slightly modified version of [lzmaSDK](https://github.com/mdejong/lzmaSDK) that is licensed under the [Public domain](https://github.com/samsoffes/ssziparchive/raw/master/LICENSE)
## Thanks

Thanks [mdejong](http://www.modejong.com/) for creating [lzmaSDK](https://github.com/mdejong/lzmaSDK) which ANE7z is based on
