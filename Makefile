deploy:
	typst compile --format html ./scripts/cv.typ --features html ./scripts/cv.html
	docker build --network=host -t sandbox-porto .
	docker stop sandbox-porto || true && \
	docker remove sandbox-porto || true && \
	docker run -h sandbox \
	 --restart always \
	 --cap-drop NET_RAW \
	 --cap-drop NET_ADMIN \
	 --network none \
	 -m 128m --cpus=0.5 \
	 --name sandbox-porto \
	 -d sandbox-porto

render-sixel:
	img2sixel -h 500 -w auto ./public/profile.jpg > ./public/profile.sixel
