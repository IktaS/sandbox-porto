deploy:
	docker build -t neofetch-porto .
	docker stop neofetch-porto || true && \
	docker remove neofetch-porto || true && \
	docker run --restart always --name neofetch-porto -d neofetch-porto

render-sixel:
	img2sixel -h 500 -w auto ./public/profile.jpg > ./public/profile.sixel