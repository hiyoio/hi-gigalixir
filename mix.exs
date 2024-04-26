name: Deploy to Gigalixir

on:
  push:
    branches:
      - main  # 或者您使用的是哪个分支

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: '3.8'  # 根据您的项目指定Python版本

    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements.txt

    - name: Login to Gigalixir
      run: |
        pip install gigalixir
        gigalixir login -e ${{ secrets.GIGALIXIR_EMAIL }} -p ${{ secrets.GIGALIXIR_PASSWORD }} -y

    - name: Push to Gigalixir
      run: |
        git remote add gigalixir https://git.gigalixir.com/${{ secrets.GIGALIXIR_APP_NAME }}.git
        git push gigalixir main

