FROM golang:alpine AS builder
WORKDIR /app
COPY . .
RUN go build -ldflags="-w -s" -o 08arkose ./cmd/api/main.go

FROM alpine
WORKDIR /app
COPY --from=builder /app/08arkose .
RUN apk add --no-cache tzdata
ENV TZ=Asia/Shanghai
EXPOSE 8080
CMD ["/app/08arkose"]
