# Pasos iniciales
## Importar todas las dependencias

- Abrir la terminal:
- Ejecutar:   ```flutter pub get```

## Crear el contenedor docker

- Abrir la terminal y acceda al directorio docker:
```cd docker```
- Ejecutar:   ```docker-compose up```

## Crear proyecto Firebase
- [Web Firebase](https://firebase.google.com)

Para generar el SHA-1 que es la clave o huella que necesita firebase puedes hacer lo siguiente:

- Abrir la terminal y acceder al directorio android ```cd android```
- Ejecutar el comando ```./gradlew signingReport```

Una vez culminada la creacion de la configuracion de la misma se veria de esta manera 

<p align="center">
    <img src="img/firebase.png" height="300">
</p>

## Configurar keycloak

Estos pasos son un poco extensos pero tratare de resumirlos.
- Acceder a la consola de administracion y logearse

[Consola de administracion](http://localhost:5002)

- Crear un reino, en mi caso cree ```realm_pohapp```
<p align="center">
    <img src="img/realm.png" height="300">
</p>

- Crear un Cliente, en mi caso ```pohapp```
<p align="center">
    <img src="img/client.png" height="300">
</p>
Las configuraciones de de acceso y redirect los deje inicialmente en todos *
<p align="center">
    <img src="img/client-access.png" height="300">
</p>

El resto se mantiene igual

- Acceder a Identify providers
<p align="center">
    <img src="img/identify.png" height="300">
</p>

Seleccionar la opcion de google

Se les completara automaticamente el Redirect Uri
Deberan rellenar los campos de ```Client ID``` y ```Client Secret``` con los datos provedidos por el proyecto Firebase
<p align="center">
    <img src="img/config-identity.png" height="300">
</p>

Mas abajo en el item ```Scope``` completamos con ```email profile openid```

Posteriormente guardamos cambios

Y accedemos a la pestaña de Permissions
<p align="center">
    <img src="img/permissions.png" height="300">
</p>
 Y habilitamos Permissions

 En Permissions list abrimos la ruta ```token-exchange```
<p align="center">
    <img src="img/permi-detail.png" height="300">
</p>

Desde alli accederemos a Client details como se ve marcada en la imagen
<p align="center">
    <img src="img/policies.png" height="300">
</p>

Desde alli accedemos a la pestaña Policies o politicas y creamos una 
<p align="center">
    <img src="img/politica.png" height="300">
</p>

Le agregamos un nombre y seleccionamos nuestro Cliente en mi caso pohapp

Logic ```Positive```

Le damos a guardar y volvemos a Identify Providers

<p align="center">
    <img src="img/vuelta-identif.png" height="300">
</p>

Abrimos nuestra configuracion ```google```, la pestaña ```Permissions```, la ruta ```token-exchange``` 

<p align="center">
    <img src="img/permissions.png" height="300">
</p>
Seleccionamos la politica que creamos 
<p align="center">
    <img src="img/config-policies.png" height="300">
</p>

Guardamos y tenemos lista la configuracion del keycloak.

## Configuracion de la app Flutter

Abrimos el main y ajustamos las rutas a nuestro keycloak con la ip de nuestro proyecto local o el host de nuestro servidor 

<p align="center">
    <img src="img/config-app.png" height="300">
</p>
