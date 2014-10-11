package hr.fer.zemris.opp.password;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Static class that takes a password/string
 * and calculates it's SHA-1 hash.
 * 
 * @author Domagoj Boros
 *
 */
public class PasswordHasher {

	/**
	 * Returns a hex encoded SHA-1 hash for given password.
	 * 
	 * @param password to encrypt
	 * @return encrypted password SHA-1 hex encoded hash
	 */
	public static String getHexHash(String password) {
		MessageDigest md = null;
		try {
			md = MessageDigest.getInstance("SHA-1");
		} catch (NoSuchAlgorithmException e) {
			System.out.println("Error getting message digest for password hash calculation.");
			System.out.println(e.getMessage());
		}
		
		return bytesToHex(md.digest(password.getBytes()));
	}

	/**
	 * Turns an array of bytes into a hex coded string.
	 * 
	 * @param bytes
	 *            to convert
	 * @return hex coded string from bytes
	 */
	public static String bytesToHex(byte[] bytes) {
		final char[] hexArray = "0123456789ABCDEF".toCharArray();
		char[] hexChars = new char[bytes.length * 2];
		for (int j = 0; j < bytes.length; j++) {
			int v = bytes[j] & 0xFF;
			hexChars[j * 2] = hexArray[v >>> 4];
			hexChars[j * 2 + 1] = hexArray[v & 0x0F];
		}
		return new String(hexChars);
	}
	
}
