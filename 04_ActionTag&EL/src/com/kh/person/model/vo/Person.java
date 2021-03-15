package com.kh.person.model.vo;
 
/*
 * bean 객체
 * 	- container(WAS=tomcate을 의미)가 관리하는 자바객체
 * 
 * 1. 기본생성자 반드시 작성
 * 2. getter/setter 반드시 작성 : 빈을 관리시에 필요.
 * 3. 필드(property)의 타입이 기본형/String이 아닌경우에는
 * 	  useBean태그에서 사용할 수 없고, scriptlet을 사용할 것.
 * 
 * */
public class Person {

	private String name;
	private char gender;
	private int age;
	private boolean married;
	public Person() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Person(String name, char gender, int age, boolean married) {
		super();
		this.name = name;
		this.gender = gender;
		this.age = age;
		this.married = married;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public char getGender() {
		return gender;
	}
	public void setGender(char gender) {
		this.gender = gender;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public boolean isMarried() {
		return married;
	}
	public void setMarried(boolean married) {
		this.married = married;
	}
	@Override
	public String toString() {
		return "Person [name=" + name + ", gender=" + gender + ", age=" + age + ", married=" + married + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + age;
		result = prime * result + gender;
		result = prime * result + (married ? 1231 : 1237);
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Person other = (Person) obj;
		if (age != other.age)
			return false;
		if (gender != other.gender)
			return false;
		if (married != other.married)
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}
	
	
}
