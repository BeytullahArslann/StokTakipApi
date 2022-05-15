namespace StokTakipApi.Models
{
    public class ProductDetailWarehouse
    {
        public int OrderNumber { get; set; }
        public int Quantity { get; set; }
        public DateTime Date { get; set; }
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public string ProductCode { get; set; }
        public string ProductDescription { get; set; }
        public int ProductUnitPrice { get; set; }
    }
}
