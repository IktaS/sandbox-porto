deploy:
	docker build --network=host -t sandbox-porto .
	docker stop sandbox-porto || true && \
	docker remove sandbox-porto || true && \
	docker run -h sandbox \
	 --restart always \
	 --cap-drop NET_RAW \
	 --cap-drop NET_ADMIN \
	 --network none \
	 -m 256m --cpus=1 \
	 --name sandbox-porto \
	 -d sandbox-porto

render-sixel:
	img2sixel -h 500 -w auto ./public/profile.jpg > ./public/profile.sixel

render-cv-html:
	typst compile --format html ./scripts/cv.typ --features html cv.html
