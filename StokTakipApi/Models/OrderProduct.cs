namespace StokTakipApi.Models
{
    public class OrderProduct
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int ProductId { get; set; }
        public bool Type { get; set; }
        public int Quantity { get; set; }  
        public int WarehouseId { get; set; }
    }
}
