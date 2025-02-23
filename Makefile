exec:
	cmake --preset macos
	cmake --build build --parallel
	cmake --build build --target install
	./install/iosbuildbot

@PHONY: exec