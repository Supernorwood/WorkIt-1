package entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Quotes {
	
	// FIELDS
		@Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
		private int id;
		
		private String quote;
		
		
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public String getQuote() {
			return quote;
		}
		public void setQuote(String quote) {
			this.quote = quote;
		}
		@Override
		public String toString() {
			return "Quotes [id=" + id + ", quote=" + quote + "]";
		}
		

		

}
