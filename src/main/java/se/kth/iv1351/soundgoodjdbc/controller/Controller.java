package se.kth.iv1351.soundgoodjdbc.controller;

import se.kth.iv1351.soundgoodjdbc.integration.SoundGoodDAO;
import se.kth.iv1351.soundgoodjdbc.integration.SoundGoodDBException;
import se.kth.iv1351.soundgoodjdbc.model.InstrumentDTO;
import se.kth.iv1351.soundgoodjdbc.model.InstrumentException;
import se.kth.iv1351.soundgoodjdbc.model.Rental;
import se.kth.iv1351.soundgoodjdbc.model.RentalException;

import java.util.List;

public class Controller {
    private final SoundGoodDAO soundgoodDb;

    /**
     * Creates a new instance, and retrieves a connection to the database.
     * @throws SoundGoodDBException If unable to connect to the database.
     */
    public Controller() throws SoundGoodDBException {
        soundgoodDb = new SoundGoodDAO();
    }

    /**
     * Lists all instruments in the SoundGood database.
     * @return A list containing all instruments. The list is empty if there
     *         are no instruments.
     * @throws InstrumentException If unable to retrieve instruments.
     */
    public List<? extends InstrumentDTO> getAllInstruments() throws InstrumentException {
        try {
            return soundgoodDb.findAllInstruments();
        } catch (Exception e) {
            throw new InstrumentException("Unable to list instruments.", e);
        }
    }

    /**
     * Rents an instrument for a student.
     * @param studentId The student that wants to rent.
     * @param instrumentId The instrument to rent.
     * @throws RentalException
     * @throws SoundGoodDBException
     */
    public void rentInstrument(int studentId, int instrumentId) throws RentalException, SoundGoodDBException {
        String failureMsg = "Could not create rental for: " + studentId;
        if(soundgoodDb.findRentalQuotaByStudentId(studentId)>= 2) {
            throw new RentalException("Reached maximum rental quota of 2 instruments.");
        }

        if(!soundgoodDb.isInstrumentAvailable(instrumentId)) {
            throw new RentalException("Instrument is not available at the moment.");
        }

        try {
            soundgoodDb.rentInstrument(new Rental(studentId, instrumentId));
        } catch (Exception e) {
            throw new RentalException(failureMsg, e);
        }
    }

    /**
     * Terminates the rental for the specified instrument.
     * @param instrumentId The instrument to return.
     * @throws RentalException
     */
    public void terminateStudentRental(int studentId, int instrumentId, int rentalId) throws RentalException {
        String failureMsg = "Could not terminate rental for rental ID: " + rentalId;
        try {
            soundgoodDb.terminateStudentRental(studentId, instrumentId, rentalId);
        } catch (Exception e) {
            throw new RentalException(failureMsg, e);
        }
    }
}