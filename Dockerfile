FROM mcr.microsoft.com/dotnet/runtime:5.0.12-alpine3.14-amd64
LABEL maintainer="dfofanov@gmail.com"

ENV GODEBUG="madvdontneed=1"
ENV ASPNET_VERSION=5.0.12

RUN export BACKEND=noninteractive \
    && wget -O aspnetcore.tar.gz https://dotnetcli.azureedge.net/dotnet/aspnetcore/Runtime/$ASPNET_VERSION/aspnetcore-runtime-$ASPNET_VERSION-linux-musl-x64.tar.gz \
    && aspnetcore_sha512='f5f58aee8d497e39b931354357c14c654acf2025c71435273d1d3c086410366352c6814c39ce7d5752ae0bbf293d99fa351c30a56b95ebeb82dcc8eb5269f2bb' \
    && echo "$aspnetcore_sha512  aspnetcore.tar.gz" | sha512sum -c - \
    && tar -ozxf aspnetcore.tar.gz -C /usr/share/dotnet ./shared/Microsoft.AspNetCore.App \
    && rm aspnetcore.tar.gz \
    && touch /var/log/cron.log \
    && ln -sf /proc/1/fd/1 /var/log/cron.log

WORKDIR /app
COPY ./src/ /app

EXPOSE 5000
ENV ASPNETCORE_URLS=http://*:5000

HEALTHCHECK --interval=5s --timeout=10s --retries=3 CMD curl -sS 127.0.0.1:5000 || exit 1

ENTRYPOINT ["dotnet", "./WebTest.dll"]