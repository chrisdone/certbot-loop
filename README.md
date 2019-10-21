# certbot-loop

Make the alpine builder image:

    docker image build . -t certbot-loop

Build the binary:

    docker run --rm -v "$(pwd):$(pwd)" -w "$(pwd)" certbot-loop stack build --allow-different-user --system-ghc --ghc-options="-O0 -static -optl-static"

Build the final chrisdone/certbot-loop image:

    docker image build -f deploy.Dockerfile -t chrisdone/certbot-loop .

Push it to docker hub:

    docker push chrisdone/certbot-loop
