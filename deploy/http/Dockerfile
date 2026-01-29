FROM golang:1.24  AS builder
ARG PROJECT_NAME
WORKDIR /build
ENV GOPROXY=https://goproxy.cn,https://goproxy.io,direct \
    GOPRIVATE="" \
    GONOSUMDB="" \
    GOSUMDB="sum.golang.google.cn"
COPY go.mod go.sum ./
COPY api/go.mod api/go.sum ./api/
RUN go mod download -x
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app ./internal/${PROJECT_NAME}


FROM debian:12
WORKDIR /app
COPY --from=builder /build/app ./
EXPOSE 80
ENTRYPOINT ["/app/app", "admin", "--addr=:80"]
