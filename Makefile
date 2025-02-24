deploy:
	docker build -t neofetch-porto .
	docker stop neofetch-porto || true && \
	docker remove neofetch-porto || true && \
	docker run --restart always --name neofetch-porto -d neofetch-porto