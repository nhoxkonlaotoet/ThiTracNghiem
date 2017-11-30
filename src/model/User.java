package model;
public class User {
	private int id;
	private String username;
	private String password;
	private String role;
	private boolean status;
 
	public User() {
		super();
	}
 
	public User(int id, String username, String password, String role, boolean status) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
		this.setRole(role);
		this.status = status;
	}
 
	public String getUsername() {
		return username;
	}
 
	public void setUsername(String username) {
		this.username = username;
	}
 
	public String getPassword() {
		return password;
	}
 
	public void setPassword(String password) {
		this.password = password;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
 
}
