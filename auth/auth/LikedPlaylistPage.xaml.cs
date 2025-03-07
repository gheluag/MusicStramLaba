﻿using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Threading;

namespace auth
{
    /// <summary>
    /// Логика взаимодействия для LikedPlaylistPage.xaml
    /// </summary>
    public partial class LikedPlaylistPage : Page
    {
        public int UserId { get; set; }
        DataBase database = new DataBase();
        MusicPlayer musicPlayer = MusicPlayer.Instance;

        public Song CurrentlyPlayingSong { get; set; }


        private SongPlayer _songPlayer;
        

       
        public LikedPlaylistPage()
        {

            InitializeComponent();
            LoadLikedSongs();
            DataContext = this;
            musicPlayer = MusicPlayer.Instance;
            _songPlayer = new SongPlayer();
            _songPlayer.SongChanged += SongPlayer_SongChanged;

            LoadCurrentSongFromDatabase();

            MusicPlayer.Instance.PositionChanged += Instance_PositionChanged;

            MusicPlayer.Instance.MediaEnded += MusicPlayer_MediaEnded;

        }

        private void artistname_MouseEnter(object sender, MouseEventArgs e)
        {
            TextBlock textBlock = (TextBlock)sender;
            Utils.SetUnderlineAndHandCursor(textBlock);
        }

        private void artistname_MouseLeave(object sender, MouseEventArgs e)
        {
            TextBlock textBlock = (TextBlock)sender;
            Utils.RemoveUnderlineAndSetArrowCursor(textBlock);
        }

        private void artistname_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            e.Handled = true;

            Utils.OpenArtistPage((TextBlock)sender, NavigationService, database);
        }

        private void SongPlayer_SongChanged(object sender, SongChangedEventArgs e)
        {
            Utils.Update_SongChanged(albumArtImage, songTitleTextBlock, artistTextBlock, e);
        }


        private void gohome(object sender, RoutedEventArgs e)
        {
            Utils.NavigateToHomePage(NavigationService);
        }

        private void gosearch(object sender, RoutedEventArgs e)
        {
            Utils.NavigateToSearchPage(NavigationService);
        }


        private void PlayStop_Click(object sender, RoutedEventArgs e)
        {
            Utils.HandlePlayPauseButton(playStop_btn);
        }


        // плейлист

        private ObservableCollection<string> playlists;

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {

            DataBase db = new DataBase();
            int userId = db.GetUserIdByUsername(CurrentUser.Username);
            List<string> playlistNames = db.GetUserPlaylists(userId);

            playlists = new ObservableCollection<string>(playlistNames);

            PlaylistListBox.ItemsSource = playlists;

            Utils.LoadPageData(database, listBoxLikedArtists, listBoxLikedAlbums, playStop_btn);
        }


        private void OpenCreatePlaylistWindow(object sender, RoutedEventArgs e)
        {
            Utils.OpenCreatePlaylistWindow(playlists, PlaylistListBox, database);
        }

        // открыть плейлист

        private void OpenPlaylistPage(object sender, MouseButtonEventArgs e)
        {
            TextBlock textBlock = sender as TextBlock;
            Utils.NavigateToPlaylistPage(textBlock, NavigationService, database);
        }

        // artist page

        private void OpenArtistPage(object sender, MouseButtonEventArgs e)
        {
            Utils.OpenArtistPage((TextBlock)sender, NavigationService, database);
        }

        // страница альбомов
        private void OpenAlbumPage(object sender, MouseButtonEventArgs e)
        {
            Utils.OpenAlbumPage((TextBlock)sender, NavigationService, database);
        }


        private void LoadLikedSongs()
        {
            UpdateLiked();
        }
        List<Song> likedSongs;
        private void UpdateLiked()
        {
            string songfolder = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "oblojka");
            DataBase db = new DataBase();
            int userId = db.GetUserIdByUsername(CurrentUser.Username);
            likedSongs = db.GetLikedSongs(userId);
            LikedSongsListBox.ItemsSource = likedSongs;
            foreach (var song in likedSongs)
            {
                song.IsSongliked = db.IsSongliked(db.GetUserIdByUsername(CurrentUser.Username), song.Id);
                song.LikeBtnSymb = song.IsSongliked ? "♥️" : "♡";
                string songFilePath = Path.Combine(songfolder, song.PathToImage);
                song.PathToImage = songFilePath;
            }

            if (PlaybackManager.Instance.newSongSelected || PlaybackManager.Instance.playbackQueue.Count == 0)
            {
                PlaybackManager.Instance.ClearQueue();
                PlaybackManager.Instance.AddSongsToQueue(likedSongs);
                PlaybackManager.Instance.newSongSelected = false;
            }
        }

        private void LikeButton_song(object sender, RoutedEventArgs e)
        {
            Button button = (Button)sender;
            Song song = (Song)button.DataContext;
            Utils.HandleLikeButtonClick(button, song, database);

            UpdateLiked();
        }

        // menu
        private void MoreOptionsButton_Click(object sender, RoutedEventArgs e)
        {
            Button button = sender as Button;
            Song song = button.DataContext as Song;
            Utils.OpenContextMenu(button, song);
        }

        private void AddToPlaylist_Click(object sender, RoutedEventArgs e)
        {
            Utils.AddToPlaylist(sender as MenuItem, database);
        }


        // удалить пл
        private void DeletePlaylist(object sender, MouseButtonEventArgs e)
        {
            Utils.DeletePlaylist((TextBlock)sender, PlaylistListBox, database);
        }

        // playsong

        private void SongSelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ListBox listBox = sender as ListBox;
            PlaybackManager.Instance.ClearQueue();
            PlaybackManager.Instance.AddSongsToQueue(likedSongs);
            PlaybackManager.Instance.newSongSelected = false;
            Utils.HandleSongSelectionChanged(listBox, musicPlayer, _songPlayer, playStop_btn, database);
        }

        private void MusicPlayer_MediaEnded(object sender, EventArgs e)
        {
            Utils.HandleMediaEnded(_songPlayer, playStop_btn, database);
        }

        public void LoadCurrentSongFromDatabase()
        {
            Song currentSong = database.GetCurrentSong();

            if (currentSong != null)
            {
                _songPlayer.CurrentSong = currentSong;
            }
        }


        // очередь


        private void NextSongButton_Click(object sender, RoutedEventArgs e)
        {
            Utils.HandleNextSongButtonClick(musicPlayer, _songPlayer, database);
        }

        private void PreviousSongButton_Click(object sender, RoutedEventArgs e)
        {
            Utils.HandlePreviousSongButtonClick(musicPlayer, _songPlayer, database);
        }

        private void songProgress_ValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e)
        {
            Utils.HandleSongProgressValueChanged(songProgress, e.NewValue);
        }

        private void Instance_PositionChanged(object sender, EventArgs e)
        {
            Utils.HandlePlayerPositionChanged(songProgress);
        }

    }
}
