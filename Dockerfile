FROM ghcr.io/dbt-labs/dbt-bigquery:1.7.0
WORKDIR /usr/app
ENV DBT_PROFILES_DIR=/usr/app
# COPY . .  <-- Professional setup mein hum ise hata dete hain aur Volume use karte hain
# Dockerfile ki akhri line badal dein
ENTRYPOINT []

# Container ko zinda rakhne ke liye simple command
CMD ["tail", "-f", "/dev/null"]