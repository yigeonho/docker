# Use an official Python runtime as a parent image
FROM python:3.8-slim
# 앱 디렉터리 생성
RUN mkdir -p /app

# 작업 디렉터리 설정
WORKDIR /app

# 현재 디렉터리의 모든 파일을 이미지 내부의 /app 디렉터리에 복사합니다.
ADD . /app
# Install any needed packages specified in requirements.txt
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

ENV FLASK_APP=app/init.py

# Run app.py when the container launches
CMD ["flask", "run", "--host=0.0.0.0"]

