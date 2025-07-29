FROM golang:1.21 as base

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

# final stage with - distroless image
FROM gcr.io/distroless/base

# Copy the binary from the previous stage
COPY --from=base /app/main .

# Copy the static files from the previous stage
COPY --from=base /app/static ./static

EXPOSE 3000

CMD ["./main"]