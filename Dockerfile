# Используем официальный образ Go
FROM golang:1.21-alpine AS builder

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем go.mod и go.sum для кэширования зависимостей
COPY go.mod go.sum ./
RUN go mod download

# Копируем остальные файлы
COPY . .

# Собираем приложение для Linux
RUN GOOS=linux GOARCH=amd64 go build -o ptserver ./cmd/PTServer/

# Устанавливаем права на выполнение
RUN chmod +x /app/ptserver

# Используем минимальный образ для запуска
FROM alpine:latest

WORKDIR /app

# Копируем собранное приложение из предыдущего шага
COPY --from=builder /app/ptserver /app/ptserver
COPY /templates /templates
COPY . .


# Открываем порт
EXPOSE $PORT

# Запускаем приложение
CMD ["./ptserver"]
