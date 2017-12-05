# docker-xmr-stak-cpu
[xmr-stak](https://github.com/fireice-uk/xmr-stak) miner in an Alpine Docker image. 

The goal of this project is to quickly enable you to mine Monero with the xmr-stak miner without the hassle of knowing how to install or secure it. 
Using an [Alpine Linux](https://www.alpinelinux.org/) container you get the benefit of Pax and grsecuirty and, on top of this the miner runs under its own user.

# How to use
```bash
# docker run rnellen/docker-xmr-stak POOL WALLET PASSWORD WORKERS
# docker run rnellen/docker-xmr-stak pool.supportxmr.com:5555 43mFtFyNtTK2jkQ5StmRonL9uU1dSCj3iRKo9g8RFME7ZYT5P4bUeBqJas1FHwwTWHS1VuQuy5wzm3UijLpyQ4VQ9iYDLAw x 2
```

# Donate
XMR: `43mFtFyNtTK2jkQ5StmRonL9uU1dSCj3iRKo9g8RFME7ZYT5P4bUeBqJas1FHwwTWHS1VuQuy5wzm3UijLpyQ4VQ9iYDLAw`
