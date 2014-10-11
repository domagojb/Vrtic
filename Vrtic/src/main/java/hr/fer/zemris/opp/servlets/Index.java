package hr.fer.zemris.opp.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Starting servlet mapped to index.jsp, i.e. the loading page.
 * 
 * @author Domagoj Boros
 *
 */
@WebServlet("/index.jsp")
public class Index extends HttpServlet{

	/**
	 * Nemam pojma kaj je ovo, al bar ne baca warning.
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Klasa koja opisuje osobu sa njezinim imenom i prezimenom.
	 * 
	 * Napravljeno radi primjera.
	 * 
	 * @author domagoj
	 *
	 */
	public class Osoba {
		private String ime;
		private String prezime;
		
		Osoba(String ime, String prezime) {
			this.ime = ime;
			this.prezime = prezime;
		}
		
		public String getIme() {
			return ime;
		}
		
		public String getPrezime() {
			return prezime;
		}
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		// Kreiram listu osoba
		List<Osoba> osobe = new ArrayList<>();
		osobe.add(new Osoba("Domagoj", "Boroš"));
		osobe.add(new Osoba("Ivan", "Hrastinski"));
		osobe.add(new Osoba("Ivan", "Mandić"));
		osobe.add(new Osoba("Karlo", "čečura"));
		osobe.add(new Osoba("Zvonimir", "Gračak"));
		osobe.add(new Osoba("Vedran", "Komorčec"));
		osobe.add(new Osoba("Ivo", "Zubović"));
		
		// Tu listu mapiram u atribut koji se zove 'korisnici' i njega mogu
		// koristiti u .jsp datotekama
		req.setAttribute("korisnici", osobe);
		
		// Kazem servletu da kad obradi podatke iznad da otvori index.jsp
		// ovo je spranca
		req.getRequestDispatcher("/WEB-INF/pages/index.jsp").forward(req, resp);
	}
}
