hello_world: hello_world.o
		ld -macos_version_min 14.0.0 -o hello_world hello_world.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64

hello_world.o: hello_world.s
		as -o hello_world.o hello_world.s

run: hello_world
		@echo "--------------------"
	  ./hello_world