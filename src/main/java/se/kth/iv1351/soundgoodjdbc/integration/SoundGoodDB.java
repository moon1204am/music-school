package se.kth.iv1351.soundgoodjdbc.integration;

import se.kth.iv1351.soundgoodjdbc.model.Instrument;
import se.kth.iv1351.soundgoodjdbc.model.RentalDTO;

import java.util.List;

public interface SoundGoodDB {
    List<Instrument> findAllInstruments() throws SoundGoodDBException;

    boolean isInstrumentAvailable(int instrumentId) throws SoundGoodDBException;

    void rentInstrument(RentalDTO rental) throws SoundGoodDBException;

    int findRentalQuotaByStudentId(int studentId) throws SoundGoodDBException;

    void terminateStudentRental(int studentId, int instrumentId, int rentalId) throws SoundGoodDBException;

    boolean checkIfRentalExists(int student, int instrument, int rental) throws SoundGoodDBException;



}
