deploy:
	docker build -t neofetch-porto .
	docker run --name neofetch-porto -d neofetch-porto