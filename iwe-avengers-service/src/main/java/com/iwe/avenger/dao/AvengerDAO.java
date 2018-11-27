package com.iwe.avenger.dao;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.Random;

import com.iwe.avenger.dynamodb.entity.Avenger;

public class AvengerDAO {

	private Map<String, Avenger> mapper = new HashMap<>();
	
	public AvengerDAO() {
		mapper.put("aaaa-bbbb-cccc-dddd", new Avenger("aaaa-bbbb-cccc-dddd", "Iron Man", "Tony Stark"));
	}
	
	public Optional<Avenger> search(String id) {
		return Optional.ofNullable(mapper.get(id));
	}

	public Avenger save(Avenger newAvenger) {
		newAvenger.setId(new Random().nextInt(100) + "abc");
		mapper.put(newAvenger.getId(), newAvenger);
		return newAvenger;
	}

	public void remove(Avenger avenger) {
		
	}

	public Avenger update(Avenger avenger) {
		return avenger;	
	}

}
