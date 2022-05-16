namespace StokTakipApi.Models
{
    public class OrderTable
    {
        public int OrderId { get; set; }
        public string UserName { get; set; }
        public int  Price { get; set; }
        public DateTime Date { get; set; }
        public bool Type { get; set; }
    }
}
