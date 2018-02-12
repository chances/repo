all: build install

.PHONY: build
build: build/build.ninja
	cd build && ninja

build/build.ninja:
	meson build --prefix=/usr

.PHONY: install
install:
	cd build && sudo ninja install

.PHONY: clean
clean:
	@rm -rf build
