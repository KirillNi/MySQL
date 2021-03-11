-- Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT 
  gender,
  count(target_id) AS count_of_targets
  FROM likes
    JOIN profiles
      ON likes.user_id = profiles.user_id
  GROUP BY gender
  ORDER BY count_of_targets DESC LIMIT 1;
      

-- Подсчитать общее количество лайков десяти самым молодым пользователям
-- (сколько лайков получили 10 самых молодых пользователей)
-- Недодумал как все суммировать
SELECT 
  count(likes.target_id) AS likes_total
  FROM profiles 
    LEFT JOIN likes
      ON likes.target_id = profiles.user_id
        AND target_type_id = 2
  GROUP BY profiles.user_id 
  ORDER BY birthday DESC LIMIT 10
;


-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
SELECT 
  CONCAT(first_name, ' ', last_name) AS user,
  (count(likes.id) + count(media.id) + count(messages.id)) AS overall_activity
  FROM users
    LEFT JOIN likes
      ON likes.user_id = users.id
    LEFT JOIN media
      ON media.user_id = users.id
    LEFT JOIN messages
      ON messages.from_user_id = users.id
  GROUP BY USER 
  ORDER BY overall_activity
  LIMIT 10
;



	 
	 
