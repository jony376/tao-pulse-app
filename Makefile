.PHONY: help bootstrap clean format format-check analyze \
        run run-release build-apk build-appbundle build-ios

help:
	@echo "Available commands:"
	@echo ""
	@echo "  make bootstrap       - Install Flutter dependencies"
	@echo "  make clean           - Clean Flutter build files"
	@echo "  make format          - Format Dart code in lib/ and test/"
	@echo "  make format-check    - Check Dart formatting"
	@echo "  make analyze         - Run static analysis"
	@echo "  make run             - Run the app"
	@echo "  make run-release     - Run the app in release mode"
	@echo "  make build-apk       - Build Android release APK"
	@echo "  make build-appbundle - Build Android release app bundle"
	@echo "  make build-ios       - Build iOS release app without codesign"

bootstrap:
	flutter pub get

clean:
	flutter clean

format:
	dart format lib test

format-check:
	dart format --set-exit-if-changed lib test

analyze:
	flutter analyze

run:
	flutter run

run-release:
	flutter run --release

build-apk:
	flutter build apk --release

build-appbundle:
	flutter build appbundle --release

build-ios:
	flutter build ios --release --no-codesign
