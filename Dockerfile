# ---- Этап 1: Сборка и тестирование ----
FROM php:8.2-cli AS builder

WORKDIR /app

# Копируем исходники
COPY src ./src

# ---- Этап 2: Минимальный образ для запуска ----
FROM php:8.2-cli

# Создаём непривилегированного пользователя
RUN useradd --create-home appuser
WORKDIR /home/appuser

# Копируем приложение
COPY --from=builder /app/src ./app

USER appuser

CMD ["php", "./app/index.php"]