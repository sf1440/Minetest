# Minetest Webassembly Mod Overview #

## __Wasm Mod Structure__ ##

### init.lua ###
* Contains a function definition to create a simple mod
* Creates a block with a single image used as the texture

### mod.c ###
* Source code of mod before being compiled to wasm
* This does not need to be included in the mod directory, it is simply here to show what was compiled to wasm
* Could be any language with wasm as a compile target, as long as function names match

### mod.conf ###
* Contains basic mod meta info
* For mod to be recognized as wasm, wasm setting must equal yes (wasm = yes)

### mod.js ###
* Runs our wasm source code
* Calls each of the getters within the wasm source and builds a mod object from them
* Ultimately returns this mod object to c++ for parsing
* In the future, could be used to import objects and/or functions into wasm

### mod.wasm ###
* Actual mod source code
* Very simple in its current state, just getters that return strings of mod info

## __Classes Added to Minetest Source__ ##

### WasmLoader ###
* Activates Spidermonkey and runs mod.js source file.
* Gathers mod info from js and returns it as a vector of strings

### WasmInjector ###
* Called in WasmLoader.load_wasm
* Opens given js file and replaces the wasm file path found within the file with raw wasm bytes
* Does not run any js, only performs simple file I/O all from within c++
* Looks for wasm file path within custom delimiter (%wb../path/to/file.wasmwb%)
* Not an ideal solution, just a fairly hacky way to get wasm into our js files
    * Ideally, the mod.js would open the wasm itself and load the bytes that way from within Spidermonkey
    * This class was made because common methods did not work within Spidermonkey (fetch, XMLHttpRequest, etc.)

## __Minetest Source Code Changes__ ##

### src/content/mods.cpp ###
* Added a check for wasm flag in mod.conf
* If present, sets wasm flag to true within ModSpec

### src/script/cpp_api/s_base.cpp ###
* Added new function, loadModWasm, which calls loadScriptWasm
* Added new function, loadScriptWasm
    * First uses WasmLoader to gather mod data into vector
    * Next runs the init.lua associated with the mod
    * Finally pushes the mod data onto lua stack and calls the init.lua function to create the mod

### src/server/mods.cpp ###
* Added a check for the wasm flag within a ModSpec
* If flag is true, loadModWasm is called rather than the typical loadMod function
