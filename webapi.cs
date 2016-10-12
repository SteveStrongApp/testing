public class BooksController : ApiController
{

    public IEnumerable&lt;book> Get()
    {
        using (SampleDbEntities entities = new SampleDbEntities())
        {
            return entities.Books.ToList&lt;book>();
        }
    }
 

    public Book Get(int id)
    {
        using (SampleDbEntities entities = new SampleDbEntities())
        {
            return entities.Books.SingleOrDefault&lt;book>(b => b.ID == id);
        }
    }
 

    public HttpResponseMessage Post(Book value)
    {
        try
        {
            if (ModelState.IsValid)
            {
                using (SampleDbEntities entities = new SampleDbEntities())
                {
                    entities.Books.AddObject(value);
                    entities.SaveChanges();
                    return Request.CreateResponse(HttpStatusCode.OK);
                }
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, "Invalid Model");
            }
        }
        catch (Exception ex)
        {
            return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
        }
    }
 

    public HttpResponseMessage Put(int id, Book value)
    {
        try
        {
            using (SampleDbEntities entities = new SampleDbEntities())
            {
                Book foundBook = entities.Books.SingleOrDefault&lt;book>(b => b.ID == id);
                foundBook.BookName = value.BookName;
                entities.SaveChanges();
                return Request.CreateResponse(HttpStatusCode.OK);
            }
        }
        catch (Exception ex)
        {
            return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
        }
    }
 

    public HttpResponseMessage Delete(int id)
    {
        try
        {
            using (SampleDbEntities entities = new SampleDbEntities())
            {
                Book foundBook = entities.Books.SingleOrDefault&lt;book>(b => b.ID == id);
                entities.Books.DeleteObject(foundBook);
                entities.SaveChanges();
                return Request.CreateResponse(HttpStatusCode.OK);
            }
        }
        catch (Exception ex)
        {
            return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
        }
    }
}