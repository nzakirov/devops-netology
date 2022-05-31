# 1.

- Электронные чеки в json виде

СУБД типа NoSQL документо-ориентированные, т.к. чек представляет собой отдельный самодостаточный документ.

- Склады и автомобильные дороги для логистической компании

Предпочтительнее использовать СУБД типа NoSQL графовые, т.к. склады и дороги между ними можно представить в виде графов, где вершинами будут склады, а ребрами будут дороги между ними. Для графов существуют множество алгоритмов поиска и тд.

- Генеалогические деревья

Лучше всего использовать СУБД типа NoSQL иерархические, т.к. проще всего представлять генеалогическое дерево в виде иерархической структуры - дерева.

- Кэш идентификаторов клиентов с ограниченным временем жизни для движка аутенфикации

Лучшим решением будет СУБД типа NoSQL ключ-значение, т.к. они имеют простую структуру и наиболее быстрые для таких задач.

- Отношения клиент-покупка для интернет-магазина

Выбором будет реляционные СУБД, т.к. в них данные хранятся в видет таблиц которые как раз реализуют отношения между сущностями.


# 2.

 -  *Данные записываются на все узлы с задержкой до часа (асинхронная запись)*

Данный пункт характеризует систему как согласованную по данным (C), т.к. на всех узлах будут одинаковые данные и доступную (А): CA, PA-EL  

- *При сетевых сбоях, система может разделиться на 2 раздельных кла

стера*

Это характеризует систему как устойчивую к разделению и доступную: PA, PA-EL

- *Система может не прислать корректный ответ или сбросить соединение*

Система не удовлетворяет доступности (A),  соответственно должна удовлетворять двум оставшимся тербованиям: PC, PC-ЕС  


# 3.  

Нет, не могут, т.к. в принципах BASE и ACID присутствуют взаимоисключающие, противоречащие друг другу утверждения о данных и операциях с ними.


# 4.

Pub/Sub это метод обмена сообщениями между сервисами, от англ. слов Publish (издатель) / Subscribe (подписка). Представляет собой асинхронный метод связи между сервисами, используемый в микросервисных архитектурах. Модель Pub/Sub  включает в себя:
- Издателя, который отправляет сообщение;
- Подписчитка, который получает сообщение через брокера сообщений.

Под требованя задания подходит система Redis. 

Недостатки:
Синтаксис не схож с SQL.
Доступ только по общему логину паролю.
Данные в момент работы хранятся в оперативной памяти, поэтому максимальный ее объем зависит от объема последней.