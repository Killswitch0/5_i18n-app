# i18n

* Библиотека включает в себя 2 важных и часто используемых метода: localize - локализует объекты даты и времени в формате локали,
 translate - ищет переводы текста. 
 В Rails существуют хэлперы, поэтому можно просто писать во вью l(Time.now, format: :short) и t('.title') 
 
* Смотри config\application.rb, controllers\application_controller.rb, views\users\index.html.erb,
  views\users\show.html.erb, config/routes.rb
  
* Плюарные формы: смотри в views\welcome\index.html.erb, config\locales\en.yml - читай начиная с activerecord

* Уязвимость к xss атакам смотри config\locales\en.yml и ru/yml, views\welcome\index.html.erb
  Если вы просто записываете в какой-то из ключей в yml файле переводов, а дальше на странице где-то вызываете
  в качесвте html, то он у вас отработает в качестве xss атаки.
  
* Локализация проекта в котексте наличия общих форматов для даты и времени, с которой мы работаем.
  Для этого есть метод localize или мини-хэлпер l. Смотри в views\welcome\index.html.erb.
