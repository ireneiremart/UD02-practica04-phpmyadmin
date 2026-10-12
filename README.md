![Captura 1](capturas/imagen_01.png)

**Práctica 4	phpmyadmin**

1. Instalación phpmyadmin.

![Captura 2](capturas/imagen_02.png)  
![Captura 3](capturas/imagen_03.png)  
![Captura 4](capturas/imagen_04.png)  
![Captura 5](capturas/imagen_05.png)  
alumno

![Captura 6](capturas/imagen_06.png)  
![Captura 7](capturas/imagen_07.png)

2. Configurar nginx.

![Captura 8](capturas/imagen_08.png)  
![Captura 9](capturas/imagen_09.png)  
![Captura 10](capturas/imagen_10.png)

3. Comprobar versión php.

![Captura 11](capturas/imagen_11.png)

4. Comprobar las extensiones de php.

![Captura 12](capturas/imagen_12.png)

5. Comprobar si phpmyadmin está bien instalado.

![Captura 13](capturas/imagen_13.png)

6. Comprobar ubicación de phpmyadmin. 

![Captura 14](capturas/imagen_14.png)

7. Comprobar que phpmyadmin abre desde el navegador de cliente.

![Captura 15](capturas/imagen_15.png)

8. Comprobamos que podemos entrar en mariadb

![Captura 16](capturas/imagen_16.png)

9. Comprobar los métodos de autentificación de los usuarios.

![Captura 17](capturas/imagen_17.png)

10. Modificar la contraseña de root.

![Captura 18](capturas/imagen_18.png)

11. Comprobar que se ha guardado la contraseña de root.

![Captura 19](capturas/imagen_19.png)

12. Iniciar configuración segura de mariadb

![Captura 20](capturas/imagen_20.png)

13. Comprobar que al entrar con el usuario root, pide contraseña y nos deja entrar correctamente. 

![Captura 21](capturas/imagen_21.png)

14. Comprobar acceso desde phpmyadmin desde el navegador con el usuario root.

![Captura 22](capturas/imagen_22.png)  
![Captura 23](capturas/imagen_23.png)

15. Crear un usuario para phpmyadmin.

![Captura 24](capturas/imagen_24.png)

16. Asignar permisos a irene.

![Captura 25](capturas/imagen_25.png)

17. Verificar los permisos.

![Captura 26](capturas/imagen_26.png)

18. Comprobamos que podemos entrar vía web con en nuevo usuario.

![Captura 27](capturas/imagen_27.png)

19. htpasswd.  
    1. Comprobar htpasswd.

![Captura 28](capturas/imagen_28.png)  
No está instalado

2. Instalamos.

![Captura 29](capturas/imagen_29.png)

3. Volvemos a comprobar.

![Captura 30](capturas/imagen_30.png)

20. Crear archivo de contraseñas.

![Captura 31](capturas/imagen_31.png)

21. Preparar protección para phpmyadmin.  
    1. Antes de nada hacemos una copia de seguridad de la configuración.

![Captura 32](capturas/imagen_32.png)

2. Editamos la configuración.

![Captura 33](capturas/imagen_33.png)  
![Captura 34](capturas/imagen_34.png)

22. Comprobar configuración de nginx.

![Captura 35](capturas/imagen_35.png)

23. Aplicar cambios nginx.

![Captura 36](capturas/imagen_36.png)

24. Comprobar la doble autenticación.

![Captura 37](capturas/imagen_37.png)  
![Captura 38](capturas/imagen_38.png)

25. Automatización con bash.  
    1. Crear carpeta del proyecto.

![Captura 39](capturas/imagen_39.png)

2. Crear .env

![Captura 40](capturas/imagen_40.png)  
![Captura 41](capturas/imagen_41.png)

3. Crear .gitignore

![Captura 42](capturas/imagen_42.png)  
![Captura 43](capturas/imagen_43.png)  
Ignoramos el .env y las copias de seguridad \*.bak

4. Crear install\_lemp.sh

![Captura 44](capturas/imagen_44.png)  
![Captura 45](capturas/imagen_45.png)

5. Comprobar que no tiene errores.

![Captura 46](capturas/imagen_46.png)

6. Dar permisos de ejecución.

![Captura 47](capturas/imagen_47.png)

7. Crear install\_phpmyadmin.sh

![Captura 48](capturas/imagen_48.png)

![Captura 49](capturas/imagen_49.png)

8. Comprobar sintaxis.

![Captura 50](capturas/imagen_50.png)

9. Dar permisos.

![Captura 51](capturas/imagen_51.png)

26. Guardar configuración nginx.

![Captura 52](capturas/imagen_52.png)

27. Guardar copia de .env sin las contraseñas.

![Captura 53](capturas/imagen_53.png)

28. Comprobar estructura del proyecto.

![Captura 54](capturas/imagen_54.png)

29. Crear repositorio Git.

![Captura 55](capturas/imagen_55.png)

30. Comprobamos Git y entramos dentro de la carpeta del proyecto.

![Captura 56](capturas/imagen_56.png)

31. Añadimos la copia del .env a .gitignore para no subirlo a git.

![Captura 57](capturas/imagen_57.png)

32. Inicializar repositorio.

![Captura 58](capturas/imagen_58.png)

33. Crear el user name.

![Captura 59](capturas/imagen_59.png)

34. Configurar el correo.

![Captura 60](capturas/imagen_60.png)

35. Ver archivos pendientes de subir a git.

![Captura 61](capturas/imagen_61.png)

36. Preparar los archivos git add .

37. Crear primer commit.

![Captura 62](capturas/imagen_62.png)

38. Conectar git con Github.

![Captura 63](capturas/imagen_63.png)

39. Comprobar dirección con git.

![Captura 64](capturas/imagen_64.png)

40. Asegurarnos que la rama principal es main.

![Captura 65](capturas/imagen_65.png)

41. Creo un nuevo token.

![Captura 66](capturas/imagen_66.png)   
![Captura 67](capturas/imagen_67.png)

42. Git push.

![Captura 68](capturas/imagen_68.png)

43. Crear github pages.

![Captura 69](capturas/imagen_69.png)

44. Creamos un index.html 

![Captura 70](capturas/imagen_70.png)  
![Captura 71](capturas/imagen_71.png)

45. Lo añadir al repositorio.

![Captura 72](capturas/imagen_72.png)

46. Hacemos un commit.

![Captura 73](capturas/imagen_73.png)

47. Subimos a github.

**![Captura 74](capturas/imagen_74.png)**

48. Comprobamos que ya vemos la página.  
      
    https\://ireneiremart.github.io/UD02-practica04-phpmyadmin/

![Captura 75](capturas/imagen_75.png)
