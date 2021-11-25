# docker-DonNetCoreTest
Пример контейнера для сервисов написанных на C# (DotNet Core)

## Описание

Этот образ содержит среды выполнения и библиотеки ASP.NET Core и .NET и оптимизирован для запуска приложений ASP.NET Core в производственной среде.
Более подробная информация находиться на оффициальном сайте [microsoft](https://docs.microsoft.com/ru-ru/aspnet/core/host-and-deploy/docker/building-net-docker-images?view=aspnetcore-6.0)

Список готовых образов с пред установленными пакетами dotnet core и aspnet можно посомтртеь на сайте [hab.docker.com](https://hub.docker.com/_/microsoft-dotnet-aspnet/)

Для корректного проброса порта сервиса необходимо обязательно прописать следующие команы в нутри контейнера
``` docker
EXPOSE 5000
ENV ASPNETCORE_URLS=http://*:5000
```

В настройках самого сервиса (файл appsettings.json) так же необходимо корректно прописать точку входа
``` json
 "EndPoints": {
      "Http": {
        "Url": "http://*:5000"
      }
```

## Использование

Сборка контейнера 
``` sh
docker build --tag webtest .
```

Запуск контейнера
``` sh
docker run -it --rm -p 5000:5000 --name webtest webtest:latest
```


## License
Licensed under the GPL-3.0 License.