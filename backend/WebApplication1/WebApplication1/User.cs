using System.ComponentModel.DataAnnotations;

namespace WebApplication1
{
    public class User
    {
        [Key]
        public int Id { get; set; }
        [Required]
        public String Name { get; set; } = "";
        [Required]
        public string Address { get; set; } = "";

    }
}
