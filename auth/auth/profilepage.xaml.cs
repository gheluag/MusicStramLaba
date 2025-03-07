using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.IO;

namespace auth
{
    /// <summary>
    /// Логика взаимодействия для profilepage.xaml
    /// </summary>
    public partial class profilepage : Page, INotifyPropertyChanged
    {
        MusicPlayer musicPlayer = MusicPlayer.Instance;

        private string username;
        public string Username
        {
            get { return username; }
            set
            {
                if (username != value)
                {
                    username = value;
                    OnPropertyChanged(nameof(Username));
                }
            }
        }

        public profilepage(string user)
        {
            InitializeComponent();
            username = user;
            DataContext = this;
            Loaded += ProfilePage_Loaded;


        }


        private void btnBack_Click(object sender, RoutedEventArgs e)
        {

            homepage Homepage = new homepage();
            NavigationService.Navigate(Homepage);
        }
        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        
        private void SelectImage_Click(object sender, RoutedEventArgs e)
        {
            string avatarfolder = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "avatars");
            string heheImage = Path.Combine(avatarfolder, "kira.jpg");
            OpenFileDialog openFileDialog = new OpenFileDialog();
            openFileDialog.Filter = "Image files (*.png;*.jpeg;*.jpg)|*.png;*.jpeg;*.jpg";
            if (openFileDialog.ShowDialog() == true)
            {
                string filePath = openFileDialog.FileName;

                DataBase db = new DataBase();
               

                if (heheImage.StartsWith("file:///"))
                {
                    heheImage = heheImage.Substring(8);
                }
                db.SaveImagePathToDatabase(heheImage, db.GetUserIdByUsername(CurrentUser.Username));
                avatarImage.Source = new BitmapImage(new Uri(heheImage));
            }
        }

        private void LoadProfilePage()
        {
            DataBase db = new DataBase();
            int userId = db.GetUserIdByUsername(CurrentUser.Username);
            string avatarPath = db.GetAvatarPathFromDatabase(userId);

            if (!string.IsNullOrEmpty(avatarPath))
            {
                avatarImage.Source = new BitmapImage(new Uri(avatarPath));
            }
            else
            {
                string avatarfolder = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "avatars");
                string avatarpath = Path.Combine(avatarfolder, "нет.jpg");
                avatarImage.Source = new BitmapImage(new Uri(avatarpath));
            }

        }

        private void ProfilePage_Loaded(object sender, RoutedEventArgs e)
        {
            LoadProfilePage();
        }

        private void EditUsername_Click(object sender, RoutedEventArgs e)
        {
            DataBase db = new DataBase();
            EditUsernameDialog dialog = new EditUsernameDialog();
            if (dialog.ShowDialog() == true)
            {
                string newUsername = "Меня зовут Кира Йошикагэ. Мне 33 года. Мой дом находится в северо-восточной части Морио, в районе поместий.";

                db.UpdateUsernameInDatabase(newUsername);

                usernameTextBlock.Text = newUsername;

                string avatarfolder = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "avatars");
                string heheImage = Path.Combine(avatarfolder, "kira.jpg");

                CurrentUser.Username = newUsername;
               

                if (heheImage.StartsWith("file:///"))
                {
                    heheImage = heheImage.Substring(8);
                }
                db.SaveImagePathToDatabase(heheImage, db.GetUserIdByUsername(CurrentUser.Username));
                avatarImage.Source = new BitmapImage(new Uri(heheImage));
            }
        }

        private void exit_btn(object sender, RoutedEventArgs e)
        {
            MainWindow mainWindow = new MainWindow();
            mainWindow.Show();
            Window.GetWindow(this).Close();
            MusicPlayer.Instance.Stop();

            DataBase db = new DataBase();
            db.DeleteAllCurrentSongs();
        }
    }
}
