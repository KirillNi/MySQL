-- Проанализировать какие запросы могут выполняться наиболее
-- часто в процессе работы приложения и добавить необходимые индексы.

-- Поиск группы
CREATE INDEX communities_name_idx ON communities(name);

-- Поиск пользователя по городу, стране
CREATE INDEX profiles_city_country_idx ON profiles(city, country);

-- Поиск медиа
CREATE INDEX posts_head_idx ON posts(head);


-- Задание на оконные функции
-- Построить запрос, который будет выводить следующие столбцы:
-- имя группы;
-- среднее количество пользователей в группах;
-- самый молодой пользователь в группе;
-- самый старший пользователь в группе;
-- общее количество пользователей в группе;
-- всего пользователей в системе;
-- отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100.
SELECT DISTINCT communities.name,
  count(communities_users.user_id) OVER() / max(communities.id) OVER() AS avg_users,
  min(profiles.birthday) OVER w AS old_user,
  max(profiles.birthday) OVER w AS young_user,
  count(communities_users.user_id) OVER w AS users_in_group,
  count(users.id) OVER() AS count_of_users,
  count(communities_users.user_id) OVER w / count(users.id) OVER() * 100 AS "%%"
    FROM communities_users
      JOIN communities
        ON communities.id = communities_users.community_id 
      JOIN profiles
        ON profiles.user_id = communities_users.user_id 
      JOIN users
        ON users.id = profiles.user_id 
        WINDOW w AS (PARTITION BY communities.id);
             