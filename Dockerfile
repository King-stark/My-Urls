FROM golang:1.15-alpine AS build
ARG TARGETARCH
RUN apk add --update git
RUN git clone https://github.com/CareyWang/MyUrls /app
WORKDIR /app
RUN go env -w GO111MODULE="on" && go env -w GOPROXY="https://goproxy.cn,direct"
RUN go mod tidy 
RUN CGO_ENABLED=0 GOOS=linux GOARCH=${TARGETARCH} go build -o myurls main.go 

FROM nginx
WORKDIR /app
COPY --from=build /app/myurls ./
COPY public/* ./public/

COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh ./

EXPOSE 80
CMD [ "sh", "-c", "/app/start.sh" ]
