FROM mcr.microsoft.com/dotnet/sdk:7.0 as builder
WORKDIR /source
ARG TARGETPLATFORM
ARG TARGETARCH
ARG BUILDPLATFORM
COPY . .
RUN echo $TARGETPLATFORM && echo $TARGETARCH && echo $BUILDPLATFORM
RUN dotnet restore -a $TARGETARCH  && dotnet publish -c release -o /app -a $TARGETARCH --self-contained false --no-restore

CMD dotnet /app/Worker.dll
