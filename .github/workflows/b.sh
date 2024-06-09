name: Custom Mắc Ọs

on: 
  workflow_dispatch:
 
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Getting Updates and Installing Tailscale, Git.
        run: |
          sudo apt update -y
          sudo apt install git wget tigervnc-standalone-server websockify novnc -y
          git clone https://github.com/dockur/macos.git
          cd macos
          rm Dockerfile
          docker build -t dockerd .
          wget https://github.com/jshruwyd/macos/raw/master/Dockerfile
          wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz && tar -xf ngrok-v3-stable-linux-amd64.tgz
          ./ngrok config add-authtoken 2bFmLPy2Pnmq673Nt2fidCw70ux_pk8P2PCkNUXbHiFyNn1x
          nohup ./ngrok http http://localhost:8006 &>/dev/null &
      - name: Copying Docker Container Files and Setting Everything Up.
        run: |
          docker run -it --rm -p 8006:8006 --device=/dev/kvm -v  /mnt:/storage --cap-add NET_ADMIN --stop-timeout 99999990 dockerd
