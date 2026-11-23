# Reconstructed from the lab report screenshots (Figure 6.7.2, and 6.14.9 for the healthcheck fix).
# The healthcheck uses 127.0.0.1 (the post-fix version); the original used localhost, see docs Troubleshooting.
# BUILD_HOST value is shown as "docker-host-kong" in the report; the author suffix is replaced with "lab" here.

# Stage 1: build the static landing page with injected metadata
FROM alpine:3.19 AS builder

WORKDIR /build
COPY html/ ./html/

RUN apk add --no-cache gettext && \
    export BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") && \
    export BUILD_HOST="docker-host-lab" && \
    envsubst '$BUILD_DATE $BUILD_HOST' < html/index.html > html/index.final.html && \
    mv html/index.final.html html/index.html

# Stage 2: final hardened nginx image
FROM nginx:1.27-alpine

RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /build/html/ /usr/share/nginx/html/

RUN nginx -t

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://127.0.0.1/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
