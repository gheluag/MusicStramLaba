drop database if exists music_streaming;
create database  if not exists music_streaming;

use music_streaming;


drop table if exists `users`;
create table if not exists `users` (
id_user int primary key auto_increment not null unique,
username char(55) not null unique,
passw char(255) not null
);



drop table if exists artist_acc;
create table if not exists artist_acc(
id_artist_acc int primary key auto_increment not null unique,
artist_name_log char(55) not null unique,
passw char(255) not null
);

drop table if exists `artist`;
create table if not exists `artist` (
id_artist int primary key auto_increment not null unique,
artist_name char(55) not null unique,
description text,
artist_acc_id INT not null,
foreign key (artist_acc_id) REFERENCES artist_acc(id_artist_acc)
);



drop table if exists `genre`;
create table if not exists `genre` (
id_genre int auto_increment not null unique,
genre_name char(55)
);



drop table if exists `album`;
create table if not exists `album` (
id_album int primary key auto_increment not null unique,
album_name char(255) not null,
date_of_pub datetime not null default now()
);


drop table if exists `song`;
create table if not exists `song` (
id_song int primary key auto_increment not null unique,
song_name char(255) not null,
date_of_pub datetime not null default now(),
duration char(255) not null,
lyrics text,
listens int default 0,
artist_id int not null,
genre_id int not null,
foreign key (`artist_id`) references `artist` (`id_artist`) on delete cascade on update cascade,
foreign key (`genre_id`) references `genre` (`id_genre`) on delete cascade on update cascade
);



drop table if exists `album_song`;
create table if not exists `album_song` (
id_alb_song int primary key auto_increment not null unique,
album_id int not null,
song_id int not null,
foreign key (`album_id`) references `album` (`id_album`) on delete cascade on update cascade,
foreign key (`song_id`) references `song` (`id_song`) on delete cascade on update cascade
);



drop table if exists `playlist`;
create table if not exists `playlist` (
id_playlist int primary key auto_increment not null unique,
playlist_name char(255) not null,
upd_date datetime not null default now()
);



drop table if exists liked_song;
create table if not exists liked_song(
id_like_song int primary key auto_increment not null unique,
user_id int not null,
song_id int not null,
foreign key (`user_id`) references `users` (`id_user`) on delete cascade on update cascade,
foreign key (`song_id`) references `song` (`id_song`) on delete cascade on update cascade
);

drop table if exists liked_arist;
create table if not exists liked_artist(
id_like_artist int primary key auto_increment not null unique,
user_id int not null,
artist_id int not null,
foreign key (`user_id`) references `users` (`id_user`) on delete cascade on update cascade,
foreign key (`artist_id`) references `artist` (`id_artist`) on delete cascade on update cascade
);


drop table if exists liked_album;
create table if not exists liked_album(
id_like_album int primary key auto_increment not null unique,
album_id int not null,
user_id int not null,
foreign key (`user_id`) references `users` (`id_user`) on delete cascade on update cascade,
foreign key (`album_id`) references `album` (`id_album`) on delete cascade on update cascade
);




drop table if exists `user_playlist`;
create table if not exists `user_playlist` (
id_us_play int primary key auto_increment not null unique,
user_id int not null,
playlist_id int not null,
foreign key (`user_id`) references `users` (`id_user`) on delete cascade on update cascade,
foreign key (`playlist_id`) references `playlist` (`id_playlist`) on delete cascade on update cascade
);


drop table if exists `playlist_song`;
create table if not exists `playlist_song` (
id_play_song int primary key auto_increment not null unique,
playlist_id int not null,
song_id int not null,
foreign key (`playlist_id`) references `playlist` (`id_playlist`) on delete cascade on update cascade,
foreign key (`song_id`) references `song` (`id_song`) on delete cascade on update cascade
);



CREATE TABLE ListenedSongs (
    id_listened_song INT PRIMARY KEY AUTO_INCREMENT,
    genre_id int,
    user_id INT,
    listenedDate DATETIME,
    song_id int,
    artist_id int,
    album_id int,
foreign key (`genre_id`) references `genre` (`id_genre`) on delete cascade on update cascade,
foreign key (`user_id`) references `users` (`id_user`) on delete cascade on update cascade,
foreign key (`song_id`) references `song` (`id_song`) on delete cascade on update cascade,
foreign key (`artist_id`) references `artist` (`id_artist`) on delete cascade on update cascade,
foreign key (`album_id`) references `album` (`id_album`) on delete cascade on update cascade
);

CREATE TABLE RandomSong (
    id INT,
    song_name VARCHAR(255),
    artist_name VARCHAR(255),
    listens INT,
    duration varchar(255),
    image_file VARCHAR(500),
    audio_file VARCHAR(500),
    genre_name VARCHAR(255),
    song_date DATE
);

drop table if exists  CurrentSong;
CREATE table if not exists CurrentSong (
    id_curr_song INT PRIMARY KEY,
    song_name VARCHAR(255),
    artist_name char(255),
    image_file text
);



ALTER TABLE song ADD COLUMN audio_file text;
ALTER TABLE song ADD COLUMN image_file text;
ALTER TABLE album ADD COLUMN image_file text;
ALTER TABLE artist ADD COLUMN avatar_file varchar(500) default "нет.jpg";
ALTER TABLE users ADD COLUMN avatar_file varchar(500);
ALTER TABLE playlist ADD COLUMN image_file varchar(600);



INSERT INTO `users` (`id_user`, `username`, `passw`) VALUES (1, 'legushka', '$2a$11$hYRlADHc83Nt9zrxuQDfVe6fbLZpfFiGCOGwT8KcKMfKRgoz/1NZe');
 
-- ------------------------------------------------------------------


-- -------------------------------------------------------------------------

INSERT INTO `artist_acc` (`id_artist_acc`, `artist_name_log`, `passw`) VALUES (1, 'pyrokinesis', '$2a$11$hYRlADHc83Nt9zrxuQDfVe6fbLZpfFiGCOGwT8KcKMfKRgoz/1NZe' );
INSERT INTO `artist_acc` (`id_artist_acc`, `artist_name_log`, `passw`) VALUES (2, 'ssshhhiiittt!', '$2a$11$hYRlADHc83Nt9zrxuQDfVe6fbLZpfFiGCOGwT8KcKMfKRgoz/1NZe' );
INSERT INTO `artist_acc` (`id_artist_acc`, `artist_name_log`, `passw`) VALUES (3, 'лсп', '$2a$11$hYRlADHc83Nt9zrxuQDfVe6fbLZpfFiGCOGwT8KcKMfKRgoz/1NZe' );
INSERT INTO `artist_acc` (`id_artist_acc`, `artist_name_log`, `passw`) VALUES (4, 'вышел покурить', '$2a$11$hYRlADHc83Nt9zrxuQDfVe6fbLZpfFiGCOGwT8KcKMfKRgoz/1NZe');
INSERT INTO `artist_acc` (`id_artist_acc`, `artist_name_log`, `passw`) VALUES (6, 'валентин стрыкало', '$2a$11$hYRlADHc83Nt9zrxuQDfVe6fbLZpfFiGCOGwT8KcKMfKRgoz/1NZe');
INSERT INTO `artist_acc` (`id_artist_acc`, `artist_name_log`, `passw`) VALUES (8, 'шары', '$2a$11$hYRlADHc83Nt9zrxuQDfVe6fbLZpfFiGCOGwT8KcKMfKRgoz/1NZe');
INSERT INTO `artist_acc` (`id_artist_acc`, `artist_name_log`, `passw`) VALUES (9, 'несогласие', '$2a$11$hYRlADHc83Nt9zrxuQDfVe6fbLZpfFiGCOGwT8KcKMfKRgoz/1NZe');
INSERT INTO `artist_acc` (`id_artist_acc`, `artist_name_log`, `passw`) VALUES (10, 'наверное радость', '$2a$11$hYRlADHc83Nt9zrxuQDfVe6fbLZpfFiGCOGwT8KcKMfKRgoz/1NZe');
INSERT INTO `artist_acc` (`id_artist_acc`, `artist_name_log`, `passw`) VALUES (14, 'вокруг фонарного столба', '$2a$11$hYRlADHc83Nt9zrxuQDfVe6fbLZpfFiGCOGwT8KcKMfKRgoz/1NZe');
INSERT INTO `artist_acc` (`id_artist_acc`, `artist_name_log`, `passw`) VALUES (18, 'gone.fludd', '$2a$11$hYRlADHc83Nt9zrxuQDfVe6fbLZpfFiGCOGwT8KcKMfKRgoz/1NZe');
INSERT INTO `artist_acc` (`id_artist_acc`, `artist_name_log`, `passw`) VALUES (24, 'гречка', '$2a$11$hYRlADHc83Nt9zrxuQDfVe6fbLZpfFiGCOGwT8KcKMfKRgoz/1NZe');
INSERT INTO `artist_acc` (`id_artist_acc`, `artist_name_log`, `passw`) VALUES (25, 'галантерея', '$2a$11$hYRlADHc83Nt9zrxuQDfVe6fbLZpfFiGCOGwT8KcKMfKRgoz/1NZe');

-- ------------------------------------------------------------------------------------------------------

INSERT INTO `artist` (`id_artist`, `artist_name`, `description`, `avatar_file`, `artist_acc_id`) VALUES (1, 'pyrokinesis', '', "пиро.png", 1);
INSERT INTO `artist` (`id_artist`, `artist_name`, `description`, `avatar_file`, `artist_acc_id`) VALUES (2, 'ssshhhiiittt!', '', "щит.png", 2);
INSERT INTO `artist` (`id_artist`, `artist_name`, `description`, `avatar_file`, `artist_acc_id`) VALUES (3, 'лсп', '', "лсп.png", 3);
INSERT INTO `artist` (`id_artist`, `artist_name`, `description`, `avatar_file`, `artist_acc_id`) VALUES (4, 'вышел покурить', '', "вп.png", 4);
INSERT INTO `artist` (`id_artist`, `artist_name`, `description`, `avatar_file`, `artist_acc_id`) VALUES (6, 'валентин стрыкало', '', "валя.png", 6);
INSERT INTO `artist` (`id_artist`, `artist_name`, `description`, `avatar_file`, `artist_acc_id`) VALUES (8, 'шары', '', "шары.png", 8);
INSERT INTO `artist` (`id_artist`, `artist_name`, `description`, `avatar_file`, `artist_acc_id`) VALUES (9, 'несогласие', '', "несогласие.png", 9);
INSERT INTO `artist` (`id_artist`, `artist_name`, `description`, `avatar_file`, `artist_acc_id`) VALUES (10, 'наверное радость', '', "наверное.png", 10);
INSERT INTO `artist` (`id_artist`, `artist_name`, `description`, `avatar_file`, `artist_acc_id`) VALUES (14, 'вокруг фонарного столба', '',"вфс.png", 14);
INSERT INTO `artist` (`id_artist`, `artist_name`, `description`, `avatar_file`, `artist_acc_id`) VALUES (18, 'gone.fludd', '', "фладда.png", 18);
INSERT INTO `artist` (`id_artist`, `artist_name`, `description`, `avatar_file`, `artist_acc_id`) VALUES (24, 'гречка', '', "гречка.png", 24);
INSERT INTO `artist` (`id_artist`, `artist_name`, `description`, `avatar_file`, `artist_acc_id`) VALUES (25, 'галантерея', '', "галантерея.png", 25);




-- -----------------------------------------------------------------------------------------
INSERT INTO `genre` (`id_genre`, `genre_name`) VALUES (1, 'рок');
INSERT INTO `genre` (`id_genre`, `genre_name`) VALUES (2, 'рэп');
INSERT INTO `genre` (`id_genre`, `genre_name`) VALUES (3, 'пост-панк');
INSERT INTO `genre` (`id_genre`, `genre_name`) VALUES (4, 'альтернатива');
INSERT INTO `genre` (`id_genre`, `genre_name`) VALUES (5, 'инди');


-- -----------------------------------------------------------------------------------------

INSERT INTO `album` (`id_album`, `album_name`, `date_of_pub`,  `image_file` ) VALUES (1, 'развлечение', '2016-03-27 00:00:00', "развлечение.png");
INSERT INTO `album` (`id_album`, `album_name`, `date_of_pub`,  `image_file` ) VALUES (2, 'питер, чай, не франция', '2020-01-01 00:00:00', "питер.png");
INSERT INTO `album` (`id_album`, `album_name`, `date_of_pub`,  `image_file` ) VALUES (4, 'tragic city', '2017-02-05 00:00:00',  "трэджик.png");
INSERT INTO `album` (`id_album`, `album_name`, `date_of_pub`,  `image_file` ) VALUES (5, 'моя милая пустота', '2019-10-26 00:00:00', "пустота.png");
INSERT INTO `album` (`id_album`, `album_name`, `date_of_pub`,  `image_file` ) VALUES (6, 'я так ненавижу это', '2017-06-11 00:00:00', "ненавижу.png");
INSERT INTO `album` (`id_album`, `album_name`, `date_of_pub`,  `image_file` ) VALUES (7, 'смирись и расслабься', '2012-03-15 00:00:00', "смирись.png");
INSERT INTO `album` (`id_album`, `album_name`, `date_of_pub`,  `image_file` ) VALUES (8, 'часть чего-то большего', '2016-03-03 00:00:00', "частьбольшего.png");
INSERT INTO `album` (`id_album`, `album_name`, `date_of_pub`,  `image_file` ) VALUES (9, 'третья жизнь', '2021-07-24 00:00:00', "третья.png");
INSERT INTO `album` (`id_album`, `album_name`, `date_of_pub`,  `image_file` ) VALUES (11, 'зло', '2019-10-26 00:00:00', "зло.png");
INSERT INTO `album` (`id_album`, `album_name`, `date_of_pub`,  `image_file` ) VALUES (12, 'remastered', '2020-10-23 00:00:00', "ремастер.png");
INSERT INTO `album` (`id_album`, `album_name`, `date_of_pub`,  `image_file` ) VALUES (13, 'середина грустных лет', '2017-03-04 00:00:00', "середина.png");
INSERT INTO `album` (`id_album`, `album_name`, `date_of_pub`,  `image_file` ) VALUES (14, 'саморазрушение', '2021-05-15 00:00:00', "самораз.png");
INSERT INTO `album` (`id_album`, `album_name`, `date_of_pub`,  `image_file` ) VALUES (15, 'вторая жизнь', '2019-05-04 00:00:00', "вторая.png");
INSERT INTO `album` (`id_album`, `album_name`, `date_of_pub`,  `image_file` ) VALUES (16, 'маленькая часть чужих проблем', '2019-10-05 00:00:00', "частьпроблем.png");
INSERT INTO `album` (`id_album`, `album_name`, `date_of_pub`,  `image_file` ) VALUES (18, 'rawlove', '2023-06-07 00:00:00', "равлов.png"); 
INSERT INTO `album` (`id_album`, `album_name`, `date_of_pub`,  `image_file` ) VALUES (19, 'видеоигры', '2021-06-07 00:00:00', "видеоигры.png"); 
INSERT INTO `album` (`id_album`, `album_name`, `date_of_pub`,  `image_file` ) VALUES (20, 'геометрия тьмы', '2022-08-07 00:00:00', "геометрия.png"); 
INSERT INTO `album` (`id_album`, `album_name`, `date_of_pub`,  `image_file` ) VALUES (21, 'все в порядке, все пройдет', '2021-06-07 00:00:00', "несогласие.png"); 


-- -----------------------------------------------------------------------------------------------------------------

INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) values (1, 'моя милая пустота', '2019-08-12 00:00:00', '3:39',  NULL, 254361, 1, 2, "пустота.mp3", "пустота.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (2, 'не твои дела', '2018-01-19 00:00:00', '3:44', NULL, 14325, 4, 2, "не твои дела.mp3", "вп.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (3, 'синее', '2015-11-02 00:00:00', '3:29', NULL, 5246323, 3, 2, "синее.mp3", "трэджик.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (4, 'все в порядке, все пройдет', '2020-05-31 00:00:00', '3:50', NULL, 6811, 9, 3, "впорядке.mp3", "несогласие.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) values (5, 'тени', '2016-10-09 00:00:00', '5:44', NULL, 87364567, 6, 1, "тени.mp3", "развлечение.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (6, '92', '2016-10-09 00:00:00', '3:50', null, 9465782, 6, 1, "92.mp3", "развлечение.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (7, 'бесполезно', '2016-10-09 00:00:00', '7:04', NULL, 8675432, 6, 1, "бесполезно.mp3", "развлечение.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (9, 'канкан', '2017-02-26 00:00:00', '4:14', NULL, 343657, 3, 2, "канкан.mp3", "трэджик.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (10, 'прощай', '2018-12-14 00:00:00', '3:25', NULL, 63225, 2, 3, "прощай.mp3", "вторая.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (11, 'первомай', '2012-05-05 00:00:00', '3:36', NULL, 67876, 6, 1, "первомай.mp3", "смирись.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (12, 'герметика', '2022-07-06 00:00:00', '3:39', NULL, 674563, 1, 2, "герметика.mp3", "геометрия.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (13, 'мискузи мадам', '2020-10-05 00:00:00', '1:33', NULL, 543546, 1, 2, "мискузи мадам.mp3", "питер.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (14, 'веснушки', '2020-06-26 00:00:00', '3:28', NULL, 784637, 1, 2, "веснушки.mp3", "питер.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (16, 'архив', '2018-07-10 00:00:00', '2:43', NULL, 890524, 4, 2, "архив.mp3", "вп.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (17, 'май', '2018-12-10 00:00:00', '7:29', NULL, 6394785, 2, 1, "май.mp3", "вторая.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (18, 'улица сталеваров', '2015-01-03', '4:19', NULL, 174209, 6, 1, "улица.mp3", "частьбольшего.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (19, 'держать это в себе', '2018-03-27 00:00:00', '3:37', NULL, 76452, 2, 3, "держать.mp3", "ненавижу.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (20, 'хватит', '2017-03-27 00:00:00', '4:07', NULL, 74932, 2, 3, "хватит.mp3", "ненавижу.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) values (21, 'море', '2019-09-06 00:00:00', '4:42',  NULL, 643892, 2, 3, "море.mp3", "ремастер.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (22, 'сёрф-панк', '2021-09-29 00:00:00', '3:06', NULL, 9876543, 2, 1, "серфпанк.mp3", "серфпанк.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (23, 'молот ведьм', '2019-03-28 00:00:00', '2:34', NULL, 564523, 1, 2, "молот ведьм.mp3", "молот.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (24, 'да что романтичного в птичках?', '2020-06-27 00:00:00', '2:10', NULL, 762513, 1, 2, "птички.mp3", "питер.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (27, 'офисный стиляга', '2013-07-04 00:00:00', '2:13', NULL, 74526, 6, 1, "стиляга.mp3", "частьбольшего.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (28, 'ты не такая', '2016-10-09 00:00:00', '3:58', NULL, 31580472, 6, 1, "ты не такая.mp3", "частьбольшего.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (29, 'фанк', '2012-02-21 00:00:00', '3:13', NULL, 781461, 6, 1, "фанк.mp3", "смирись.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (30, 'кладбище самолетов', '2013-04-28 00:00:00', '5:52', NULL, 574186936, 6, 1, "кладбище.mp3", "частьбольшего.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (31, 'лунный свет', '2020-10-21 00:00:00', '3:36', null, 21648, 14, 2, "лунный свет.mp3", "видеоигры.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (32, 'дворы', '2018-09-26 00:00:00', '2:45', null, 4561812, 2, 3, "дворы.mp3", "зло.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (33, 'лучше, чем интернет', '2012-04-06 00:00:00', '3:00', NULL, 4567218, 3, 2, "лучше.mp3", "еп.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (34, 'ветрянка', '2022-05-09 00:00:00', '2:48', NULL, 5486378, 1, 2, "ветрянка.mp3", "геометрия.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (38, 'диско элизиум', '2022-02-10 00:00:00', '3:14', NULL, 631865, 1, 2, "диско элизиум.mp3", "диско.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (42, 'танцы', '2019-11-28 00:00:00', '2:55', NULL, 21465214, 2, 4, "танцы.mp3","лето.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (49, 'притча во языцех', '2022-07-08 00:00:00', '3:03', NULL, 244565, 1, 2, "притча.mp3",  "геометрия.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (50, 'бинокль', '2020-09-14 00:00:00', '3:29', NULL, 1236523, 3, 2, "бинокль.mp3",  "ван.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (51, 'патрон', '2019-09-21 00:00:00', '3:30', NULL, 764327, 3, 2, "патрон.mp3", "патрон.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (53, 'закат', '2019-02-01', '4:01', NULL, 387651, 2, 3, "закат.mp3", "ремастер.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (55, 'лучше/проще', '2019-06-10', '3:14', NULL, 4561, 14, 5, "лучше проще.mp3", "видеоигры.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (56, 'тебя нет', '2018-09-26 00:00:00', '4:23', NULL, 15671, 2, 3, "тебя нет.mp3", "зло.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (59, 'клише', '2017-06-24 00:00:00', '2:47', NULL, 3526, 14, 5, "клише.mp3", "видеоигры.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (61, 'улицы', '2017-10-23 00:00:00', '4:36', NULL, 4565631, 10, 3, "улицы.mp3", "улицы.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (62, 'сок', '2020-05-25 00:00:00', '2:13', NULL, 647133, 18, 5, "сок.mp3", "фладда.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (63, 'один', '2020-09-30 00:00:00', '4:13', NULL, 541761, 3, 2, "один.mp3", "ван.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (65, 'рустем', '2012-04-25 00:00:00', '3:32', NULL, 7467876, 6, 3, "рустем.mp3", "смирись.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (66, 'айсберг', '2019-06-12 00:00:00', '3:39', NULL, 7844512, 2, 1, "айсберг.mp3", "третья.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (67, 'романтическая', '2020-08-20 00:00:00', '3:09', NULL, 5214421, 25, 1, "романтическая.mp3", "галантерея.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (68, 'среди разрушенных панельных домов', '2019-01-05 00:00:00', '3:31', NULL, 523255, 10, 2, "панели.mp3", "самораз.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (69, 'коктейль', '2013-02-14 00:00:00', '3:03', NULL, 3585221, 3, 2, "коктейль.mp3", "еп.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (72, 'реквием', '2020-05-15 00:00:00', '4:05', NULL, 454797, 2, 1, "реквием.mp3", "третья.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (73, 'солнце горящего дня', '2019-01-05 00:00:00', '3:05', NULL, 45652, 10, 3, "солнце.mp3", "самораз.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (76, 'во что я влюблен', '2017-10-09 00:00:00', '3:19', NULL, 36787, 2, 5, "влюблен.mp3", "первая.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (77, 'альма-матер', '2020-07-09 00:00:00', '2:38', NULL, 546514, 1, 2, "альмаматер.mp3", "питер.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (78, 'жду любви', '2019-01-11 00:00:00', '3:54', NULL, 465541, 9, 1, "ждулюбви.mp3", "несогласие.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (79, 'сколопендра', '2019-06-21 00:00:00', '3:19', NULL, 653122, 1, 2, "сколопендра.mp3", "пустота.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (80, 'нэнси-дрю', '2021-12-13 00:00:00', '3:54', NULL, 467612, 8, 4, "нэнси.mp3", "нэнси.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (81, 'сегодня воскресенье', '2020-07-13 00:00:00', '4:30', NULL, 245678, 8, 1, "воскресенье.mp3", "частьпроблем.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (82, 'завтра понедельник', '2020-07-13 00:00:00', '4:14', NULL, 456787, 8, 1, "понедельник.mp3", "частьпроблем.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (83, 'гранжстайл', '2019-03-19 00:00:00', '2:14', NULL, 2456795, 24, 1, "гранжстайл.mp3", "гранж.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (84, '100% surf', '2017-12-16 00:00:00', '2:53', NULL, 217551, 2, 1, "серф.mp3", "середина.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (85, 'гори', '2014-08-10 00:00:00', '2:25', NULL, 5412, 6, 1, "гори.mp3", "гори.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (96, 'виа долороса', '2019-02-08 00:00:00', '3:06', NULL, 821344, 1, 2, "виа долороса.mp3", "пустота.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (97, 'смысл жизни', '2020-05-26 00:00:00', '3:46', NULL, 6754, 9, 3, "смысл.mp3", "несогласие.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (98, 'менять?', '2019-02-21 00:00:00', '3:14', NULL, 73541, 14, 5, "менять.mp3", "видеоигры.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (99, 'не скучай', '2018-09-26 00:00:00', '4:13', NULL, 67431, 2, 3, "не скучай.mp3", "зло.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (102, 'зависимость', '2020-10-05 00:00:00', '2:46', NULL, 543546, 1, 2, "зависимость.mp3", "питер.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (103, 'абсолютно черное тело', '2020-10-05 00:00:00', '2:49', NULL, 543546, 1, 2, "тело.mp3", "питер.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (106, 'чемпионы пепла', '2020-10-05 00:00:00', '3:33', NULL, 543546, 1, 2, "пепел.mp3", "питер.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (109, 'когда-нибудь', '2018-09-26 00:00:00', '2:51', NULL, 67431, 2, 3, "когданибудь.mp3", "зло.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (110, 'самый худший ученик', '2018-09-26 00:00:00', '4:20', NULL, 67431, 2, 3, "ученик.mp3", "зло.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (111, 'вишенка', '2018-09-26 00:00:00', '4:35', NULL, 67431, 2, 3, "вишенка.mp3", "зло.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (113, 'всегда', '2018-03-27 00:00:00', '4:25', NULL, 56346, 2, 1, "всегда.mp3", "ненавижу.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (115, 'корабль', '2018-03-27 00:00:00', '3:47', NULL, 164331, 2, 1, "корабль.mp3", "ненавижу.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (118, 'мы', '2018-03-27 00:00:00', '4:21', NULL, 357631, 2, 1, "мы.mp3", "ненавижу.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (119, 'звездные ночи', '2017-12-16 00:00:00', '4:25', NULL, 7431, 2, 4, "звездные ночи.mp3", "середина.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (122, 'середина грустных лет', '2017-12-16 00:00:00', '4:20', NULL, 82142, 2, 1, "середина.mp3", "середина.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (123, 'цунами демоны', '2023-06-17 00:00:00', '3:35', NULL, 6328, 2, 1, "цунами.mp3", "равлов.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (125, 'окно', '2023-06-17 00:00:00', '2:33', NULL, 467223, 2, 1, "окно.mp3", "равлов.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (126, 'мама луна', '2023-06-17 00:00:00', '4:17', NULL, 642315, 2, 1, "мама луна.mp3", "равлов.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (129, 'даунхилл', '2023-06-17 00:00:00', '3:27', NULL, 661982, 2, 1, "даунхилл.mp3", "равлов.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (137, 'танцы', '2013-04-28', '2:58', NULL, 873675, 6, 3, "танцывал.mp3", "частьбольшего.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (139, 'взрослые травмы', '2013-04-28', '2:48', NULL, 78146567, 6, 3, "травмы.mp3", "частьбольшего.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (140, 'ускользает', '2016-10-09 00:00:00', '5:05', NULL, 4571834, 6, 3, "ускользает.mp3", "развлечение.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (141, 'решится само собой', '2016-10-09 00:00:00', '4:12', NULL, 65416734, 6, 3, "решится.mp3", "развлечение.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (142, 'делать это трезвым', '2016-10-09 00:00:00', '3:13', NULL, 76546789, 6, 3, "трезвым.mp3", "развлечение.png");
INSERT INTO song (id_song, song_name, date_of_pub, duration, lyrics, listens, artist_id, genre_id, audio_file, image_file) VALUES (143, 'подворотня мой дом', '2016-10-09 00:00:00', '3:21', NULL, 12345661, 6, 3, "подворотня.mp3", "развлечение.png");



-- ---------------------------------------------------------------------------------------

INSERT INTO `album_song` (`album_id`, `song_id`) VALUES  -- рав
(18, 123),  (18, 125), (18, 126), (18, 129),
(16, 81), (16, 82), -- часть проблем
(15, 17), (15, 10), -- вторая
(14, 68), (14, 73), -- саморазр
(13, 84), (13, 119),(13, 122), -- середина
(12, 21), (12, 53), -- ремастер
(11, 32), (11, 56),(11, 99),(11, 109),(11, 110),(11, 111), -- зло
(9, 66),(9, 72), -- третья
(8, 18),(8, 27),(8, 28),(8, 30),(8, 139), -- часть большего
(7, 11),(7, 29),(7, 65), -- смирись
(6, 19),(6, 20),(6, 113),(6, 115),(6, 118), -- ненавижу
(5, 1),(5, 79),(5, 96), -- пустота
(4, 9),(4, 3), -- треджик
(2, 13),(2, 14),(2, 77),(2, 24),(2, 102),(2, 103),(2, 106), -- питер
(1, 7),(1, 5),(1, 6),(1, 140),(1, 141),(1, 142),(1, 143), -- развл
(20, 12),(20, 34),(20, 49), -- геометрия
(19, 31),(19, 55),(19, 98), -- видеоигры
(21, 4),(21, 78),(21, 97); -- все в порядке





