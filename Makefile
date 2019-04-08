
# Golang Server
# https://github.com/gedw99/blasty
# Note FLutter desktop makes it MUCH easier to develop with because
# the compile time is much less.

# Flutter Test harness
# https://github.com/AppleEducate/plugins/tree/master/packages
# This is a perfect Test harness.


# Versioning
# Commented out because no tag yet on the repo.
#Version := $(shell git describe --tags --dirty)
Version := dev
GitCommit := $(shell git rev-parse HEAD)
LDFLAGS := "-s -w -X main.Version=$(Version) -X main.GitCommit=$(GitCommit)"

# golang libb
GO_NAME=blasty
GO_BRANCH=master
GO_LIB=github.com/gedw99/$(GO_NAME)
GO_LIB_FSPATH=$(GOPATH)/src/$(GO_LIB)


# flutter lib
NAME=plugins
BRANCH=master
LIB=github.com/AppleEducate/$(NAME)
LIB_FSPATH=$(GOPATH)/src/$(LIB)

# flu example name to run ( note the naming convention !!)
# change these to run the differnet examples 
EX_NAME=data_tables_example
EX_PLUG=data_tables/example

# flu paths
EX_FLU_GOPATH=$(LIB)/packages/$(EX_PLUG)
EX_FLU_FSPATH=$(LIB_FSPATH)/packages/$(EX_PLUG)




print:

	@echo 	
	@echo GO_NAME : $(GO_NAME)
	@echo GO_BRANCH : $(GO_BRANCH)
	@echo GO_LIB : $(GO_LIB)
	@echo GO_LIB_FSPATH  : $(GO_LIB_FSPATH)
	@echo 

	@echo 	
	@echo NAME : $(NAME)
	@echo BRANCH : $(BRANCH)
	@echo LIB : $(LIB)
	@echo LIB_FSPATH  : $(LIB_FSPATH)
	@echo 

	@echo 
	@echo EX_APP_NAME  : $(EX_APP_NAME)
	@echo EX_PLUG  : $(EX_PLUG)
	
	@echo EX_FLU_GOPATH  : $(EX_FLU_GOPATH)
	@echo EX_FLU_FSPATH  : $(EX_FLU_FSPATH)
	@echo 




git-clone:
  ## install on gopath
	mkdir -p $(LIB_FSPATH)
	cd $(LIB_FSPATH) && cd .. && rm -rf $(NAME) && git clone https://$(LIB).git
	
	# THIS IS WHERE THE CODE IS.
	cd $(LIB_FSPATH) && git checkout $(BRANCH)

git-pull:
	cd $(LIB_FSPATH) && cd git pull

git-clean:
	# delte everything
	rm -rf $(LIB_FSPATH)

dep-status:
	cd $(LIB_FSPATH) && git status


### Git PR
	# https://scotch.io/tutorials/github-pull-requests-extension-for-visual-studio-code#toc-create-a-github-project
	

	# in joe, set remote





dep-all: dep-os dep dep-modules
	# get all deps

dep-os:

	# scaleway cli (# scw is the bin)
	# https://github.com/scaleway/scaleway-cli
	go get -u github.com/scaleway/scaleway-cli/cmd/scw
	cd ${GOPATH}/src/github.com/scaleway/scaleway-cli/cmd/scw && go install .

	## ssh keys management (# skm is the bin)
	# https://github.com/TimothyYe/skm
	go get -u github.com/TimothyYe/skm/cmd/skm
	cd ${GOPATH}/src/github.com/TimothyYe/skm/cmd/skm && go install .

	# Flutter mobile boot strapper
	# https://github.com/leoafarias/fvm
	go get -u github.com/leoafarias/fvm
	cd ${GOPATH}/src/github.com/leoafarias/fvm && go install .

	# Flutter desktop boot strapper
	# https://github.com/go-flutter-desktop/hover
	go get -u github.com/go-flutter-desktop/hover


dep-modules:
	# nul


code:
	cd $(LIB_FSPATH) && code .




### Inject


inject-icon:
	# Mobile App Icon
	# https://dev.to/rkowase/how-to-generate-flutter-app-icons-for-ios-and-android-11gc
	code --goto $(EX_FLU_LIB_FSPATH)/pubspec.yaml:27

	mkdir -p $(EX_FLU_LIB_FSPATH)/icon
	cp ./../../logo.png $(EX_FLU_LIB_FSPATH)/icon/icon.png
	cd $(EX_FLU_LIB_FSPATH) && flutter pub get
	cd $(EX_FLU_LIB_FSPATH) && flutter pub pub run flutter_launcher_icons:main

inject-name:
	# App Name
	# Android - works :)
	
	code --goto $(EX_FLU_LIB_FSPATH)/android/app/build.gradle:36
	code --goto $(EX_FLU_LIB_FSPATH)/android/app/src/debug/AndroidManifest.xml:2
	code --goto $(EX_FLU_LIB_FSPATH)/android/app/src/main/AndroidManifest.xml:2
	code --goto $(EX_FLU_LIB_FSPATH)/android/app/src/main/AndroidManifest.xml:41

	## IOS - not possible :)
	# <key>CFBundleDisplayName</key>
	#code --goto $(EX_FLU_LIB_FSPATH)/ios/Runner/Info.plist:14


inject-appbar:
	# App Bar Logo 
	code --goto $(EX_FLU_LIB_FSPATH)/lib/main.dart:226

inject-content:

	# Text (zefyr --> RTEditor)
	#code --goto $(EX_FLU_LIB_FSPATH)/lib/src/full_page.dart:26

	# Text (zefyr --> RTEditor)
	#code --goto $(EX_FLU_LIB_FSPATH)/lib/src/view.dart:14

### Golang

build:
	# all OS systems with LDFLAGS.
	# Darwin
	cd $(GO_LIB_FSPATH) && CGO_ENABLED=0 GOOS=darwin go build -ldflags $(LDFLAGS) -a -installsuffix cgo -o $(PWD)/bin/$(NAME)-darwin
	# Linux
	cd $(GO_LIB_FSPATH) && CGO_ENABLED=0 GOOS=linux go build -ldflags $(LDFLAGS) -a -installsuffix cgo -o $(PWD)/bin/$(NAME)-linux
	# Windows
	cd $(GO_LIB_FSPATH) && CGO_ENABLED=0 GOOS=windows go build -ldflags $(LDFLAGS) -a -installsuffix cgo -o $(PWD)/bin/$(NAME)-windows
	# ARM 6
	cd $(GO_LIB_FSPATH) && CGO_ENABLED=0 GOOS=linux GOARCH=arm GOARM=6 go build -ldflags $(LDFLAGS) -a -installsuffix cgo -o $(PWD)/bin/$(NAME)-armhf
	# ARM 64
	cd $(GO_LIB_FSPATH) && CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -ldflags $(LDFLAGS) -a -installsuffix cgo -o $(PWD)/bin/$(NAME)-arm64

client-run:
	cd $(PWD)/bin && ./$(NAME)-darwin client

server-run:
	cd $(PWD)/bin && ./$(NAME)-darwin server

server-kill:
	# TO kill what ever is using port 8000
	sudo kill `sudo lsof -t -i:8000`




## flu mob

flu-mob-run:
	# Works on Android :)
	# IOS not possible due to java only lib. 
	# IOS - Not work on IOS sim !. DO a "pod repo update" to fix

	# Iphone SE
	# Ipad (5th gen)
	# Anroid (nexus 5x real)

	flutter emulators --launch apple_ios_simulator
	cd $(EX_FLU_FSPATH) && flutter run -d all

flu-mob-build:
	# Android ONLY because cant do for IOS !
	cd $(EX_FLU_FSPATH) && flutter build apk

flu-mob-deploy:
	# Android 
	# -Ensure no IOS simulators on 

	# debug
	# -d all will push it to all connected devices ( android )
	cd $(EX_FLU_FSPATH) && flutter install build/app/outputs/apk/app.apk -d all

	# release
	#cd $(EX_FLU_LIB_FSPATH) && flutter install build/app/outputs/apk/release/app-release.apk


### DESK

flu-desk-init:
	# Add Desktop stuff to it.
	cd $(EX_FLU_FSPATH) && hover init $(EX_FLU_GOPATH)

	## Copy main_desktop
	#cp main_desktop.dart $(HOV_EX_FSPATH)/hover01/lib

flu-desk-build:
	# build the Desktop app.
	cd $(EX_FLU_FSPATH) && hover build ./desktop/build/outputs/darwin/$(EX_NAME)

flu-desk-run:
	# run must be run from the dir where the exe is!
	cd $(EX_FLU_FSPATH)/desktop/build/outputs/darwin && ./$(EX_NAME)

flu-desk-runhot:
	cd $(EX_FLU_FSPATH) && hover run --target $(EX_FLU_FSPATH)/lib/main.dart




	
