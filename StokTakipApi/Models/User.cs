using System.ComponentModel.DataAnnotations;

namespace StokTakipApi.Models
{
    public class User
    {
        [Key]
        public int userId { get; set; }

        public string userName { get; set; }
        public string userSurname { get; set; }
        public string Email { get; set; }
        public string password { get; set; }
        public int roleId { get; set; }
        public DateTime birthDate { get; set; }
        public Boolean isActive { get; set; }
    }
}
