FROM certbot/certbot@sha256:512d36d96ae1fe4bcfbb8e3562822b3ad208a2750bbf3ba3eb746a0132982254
ADD .stack-work/dist/x86_64-linux/Cabal-2.2.0.1/build/certbot-loop/certbot-loop /bin/certbot-loop
ENTRYPOINT ["certbot-loop"]
