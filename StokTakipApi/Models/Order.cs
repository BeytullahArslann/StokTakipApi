namespace StokTakipApi.Models
{
    public class Order
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int Price { get; set; }
        public DateTime Date { get; set; }
        public bool isCompleted { get; set; }
    }
}
