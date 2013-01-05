namespace ConsoleApplication1.Aspects
{
    public interface ICache
    {
        object this[string key] { get; set; }
    }
}