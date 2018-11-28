package com.iwe.avenger.dao;

import java.util.Optional;

import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapper;
import com.iwe.avenger.dynamodb.entity.Avenger;

public class AvengerDAO {

	private static DynamoDBMapper mapper = DynamoDBManager.mapper();
	
	public Optional<Avenger> search(String id) {
		final Avenger avenger = mapper.load(Avenger.class, id);
		return Optional.ofNullable(avenger);
	}

	public Avenger save(Avenger newAvenger) {
		mapper.save(newAvenger);
		return newAvenger;
	}

	public void remove(Avenger avenger) {
		mapper.delete(avenger);
	}
}
