# Use an official lightweight image
FROM alpine:3.19

# Copy your docker-compose.yml for reference (optional)
COPY docker-compose.yml /app/docker-compose.yml

# Default command prints instructions (since this image itself does nothing)
CMD ["sh", "-c", "echo 'Run this stack with: docker-compose up'"]
