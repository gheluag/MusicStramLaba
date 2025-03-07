using System;
using System.Collections.Generic;
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
using System.Windows.Shapes;

namespace auth
{
    /// <summary>
    /// Логика взаимодействия для createplaylist.xaml
    /// </summary>
    public partial class createplaylist : Window
    {
        public string PlaylistName { get; private set; }
        public createplaylist()
        {
            InitializeComponent();
        }

        private string[] randomNames = new string[]
             {
                "блиииииииин, боже мой",
                "плейлист украден",
                "ИЗВИНИСЬ ПЕРЕД РЫЦАРЕМ"
             };

        private void CreateButton_Click(object sender, RoutedEventArgs e)
        {
            DataBase db = new DataBase();

            Random rnd = new Random();

            int hehe = rnd.Next(0, 2);

            if (hehe == 0)

            {
                PlaylistName = randomNames[rnd.Next(0, randomNames.Length)];
                db.AddPlaylist(PlaylistName);
                int pl_id = db.GetPlaylistIdByName(PlaylistName);
                db.AddPlaylistForUser(CurrentUser.UserId, pl_id);
                
            }

            else if (hehe == 1)
            {
                PlaylistName = PlaylistTextBox.Text.Trim();
                db.AddPlaylist(PlaylistName);
                int pl_id = db.GetPlaylistIdByName(PlaylistName);
                db.AddPlaylistForUser(CurrentUser.UserId, pl_id);
            }

                

            DialogResult = true;
            Close();
            
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            DialogResult = false;
            Close();
        }
    }
}
