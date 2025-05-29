using Book_Management.Models;
using System.Linq;

namespace Book_Management.Services
{
    public class BookService
    {
        private List<Book> books;

        public BookService()
        {
            books = new List<Book>();
            books.Add(new Book()
            {
                Id = 1,
                Title = "Test1",
                Author = "Vishal Patel",
                Genre = "Fiction"
            });
            books.Add(new Book()
            {
                Id = 2,
                Title = "Test2",
                Author = "C",
                Genre = "Cozy corner"
            });
        }

        public List<Book> GetBooks()
        {
            return books;
        }

        public Book GetBookById(int id)
        {
            return books?.FirstOrDefault(book => book.Id == id);
        }

        public void AddBook(Book book)
        {
            book.Id = books.Count + 1;
            books.Add(book);
        }

        public int UpdateBook(Book book)
        {
            Book bookToBeUpdated = GetBookById(book.Id);
            if (bookToBeUpdated == null)
            {
                return -1;
            }
            else
            {
                bookToBeUpdated.Title = book.Title;
                bookToBeUpdated.Author = book.Author;
                bookToBeUpdated.Genre = book.Genre;
                return 1;
            }
        }

        public int DeleteBook(int id)
        {
            Book bookToBeRemoved = GetBookById(id);
            if (bookToBeRemoved == null)
            {
                return -1;
            }
            else
            {
                books.Remove(bookToBeRemoved);
                return 1;
            }
        }
    }
}
