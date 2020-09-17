# Build executable
FROM golang as builder
WORKDIR /app/
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /go/bin/tarpit .

# Add it into a scratch image
FROM scratch
COPY --from=builder /go/bin/tarpit /tarpit

# run it as a limited user
EXPOSE 8080
USER 82:82
CMD [ "/tarpit"]