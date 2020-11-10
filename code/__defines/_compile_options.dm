#define BACKGROUND_ENABLED 0    // The default value for all uses of set background. Set background can cause gradual lag and is recommended you only turn this on if necessary.
								// 1 will enable set background. 0 will disable set background.

#define PRELOAD_RSC 1			/*set to:
								0 to allow using external resources or on-demand behaviour;
								1 to use the default behaviour (preload compiled in recourses, not player uploaded ones);
								2 for preloading absolutely everything;
								*/

// When this if-block is uncommented, we will use the rust-g (https://github.com/tgstation/rust-g) native library for fast logging.
#ifndef RUST_G
// Default automatic RUST_G detection.
// On Windows, looks in the standard places for `rust_g.dll`.
// On Linux, looks in `.`, `$LD_LIBRARY_PATH`, and `~/.byond/bin` for either of
// `librust_g.so` (preferred) or `rust_g` (old).

/* This comment bypasses grep checks */ /var/__rust_g

/proc/__detect_rust_g()
	if (world.system_type == UNIX)
		if (fexists("./librust_g.so"))
			// Use the local copy over.
			return __rust_g = "./librust_g.so"
		else if (fexists("./rust_g"))
			// Old filename.
			return __rust_g = "./rust_g"
		else if (fexists("[world.GetConfig("env", "HOME")]/.byond/bin/rust_g"))
			// Old filename in `~/.byond/bin`.
			return __rust_g = "rust_g"
		else
			// It's not in the current directory, so try others
			return __rust_g = "librust_g.so"
	else
		return __rust_g = "rust_g"

#define RUST_G (__rust_g || __detect_rust_g())
#endif

// ZAS Compile Options
//#define ZASDBG	 	// Uncomment to turn on super detailed ZAS debugging that probably won't even compile.
#define MULTIZAS		// Uncomment to turn on Multi-Z ZAS Support!

// Comment/Uncomment this to turn off/on shuttle code debugging logs
#define DEBUG_SHUTTLES

// If we are doing the map test build, do not include the main maps, only the submaps.
#if MAP_TEST
	#define USING_MAP_DATUM /datum/map
	#define MAP_OVERRIDE 1
#endif
