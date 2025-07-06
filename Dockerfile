FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho
# Fazer isso antes de copiar o resto do código aproveita o cache de camadas do Docker
COPY requirements.txt .

# Instala as dependências do projeto
# A flag --no-cache-dir reduz o tamanho da imagem
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta 8000 para que o mundo externo possa acessar a aplicação
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner for iniciado
# O host 0.0.0.0 torna a aplicação acessível de fora do contêiner
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

