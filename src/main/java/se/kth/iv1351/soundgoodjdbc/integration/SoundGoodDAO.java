package se.kth.iv1351.soundgoodjdbc.integration;

import se.kth.iv1351.soundgoodjdbc.model.Instrument;
import se.kth.iv1351.soundgoodjdbc.model.RentalDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SoundGoodDAO implements SoundGoodDB {
    private static final String INSTRUMENT_TABLE_NAME = "instrument";
    private static final String INSTRUMENT_PK_COLUMN_NAME = "id";
    private static final String INSTRUMENT_TYPE_COLUMN_NAME = "type_of_instrument";
    private static final String INSTRUMENT_BRAND_COLUMN_NAME = "brand";
    private static final String INSTRUMENT_FEE_COLUMN_NAME = "fee";
    private static final String INSTRUMENT_ID_FK_COLUMN_NAME = "instrument_id";

    private static final String RENTAL_TABLE_NAME = "rental";
    private static final String RENTAL_PK_COLUMN_NAME = "id";
    private static final String RENTAL_START_DATE_COLUMN_NAME = "start_date";
    private static final String RENTAL_END_DATE_COLUMN_NAME = "end_date";

    private static final String STUDENT_TABLE_NAME = "student";
    private static final String STUDENT_PK_COLUMN_NAME = "id";
    private static final String STUDENT_ID_FK_COLUMN_NAME = "student_id";

    private Connection connection;

    private PreparedStatement findAllInstrumentsStmt;
    private PreparedStatement rentInstrumentStmt;
    private PreparedStatement findRentalQuotaByStudentIdStmt;
    private PreparedStatement findNextRentalIdStmt;
    private PreparedStatement findAvailableStatusInstrumentStmt;
    private PreparedStatement terminateRentalStmt;
    // not implemented yet
    private PreparedStatement findStudentCurrentRentals;
    private PreparedStatement rentalExistsStmt;

    /**
     * Constructs a new DAO object connected to the Sound Good database.
     */
    public SoundGoodDAO() throws SoundGoodDBException {
        try {
            connectToSoundGoodDB();
            prepareStatements();
        } catch (ClassNotFoundException | SQLException exception) {
            throw new SoundGoodDBException("Could not connect to datasource.", exception);
        }
    }

    /**
     * Retrieves all available instruments.
     * @return A list with all existing instruments. The list is empty if there are no
     *         instruments.
     * @throws SoundGoodDBException If failed to search for instruments.
     */
    public List<Instrument> findAllInstruments() throws SoundGoodDBException {
        String failureMsg = "Could not list instruments.";
        List<Instrument> instruments = new ArrayList<>();
        try(ResultSet result = findAllInstrumentsStmt.executeQuery()) {
            while(result.next()) {
                instruments.add(new Instrument(result.getString(INSTRUMENT_TYPE_COLUMN_NAME),
                        result.getString(INSTRUMENT_BRAND_COLUMN_NAME),
                        result.getInt(INSTRUMENT_FEE_COLUMN_NAME),
                        result.getInt(INSTRUMENT_PK_COLUMN_NAME)));
            }
            connection.commit();
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        }
        return instruments;
    }

    /**
     * Gets the next ID number for a new rental.
     * @return The rental ID.
     * @throws SoundGoodDBException
     */
    private int getNextRentalId() throws SoundGoodDBException {
        int rentalId = 0;
        try (ResultSet result = findNextRentalIdStmt.executeQuery()) {
            while (result.next()) {
                rentalId = result.getInt(RENTAL_PK_COLUMN_NAME);
            }
            connection.commit();
        } catch (SQLException sqle) {
            handleException("Could not get rental id", sqle);
        }
        return rentalId;
    }

    /**
     * Checks if instrument is available or not.
     * @param instrumentId The instrument searched for.
     * @return If the instrument is available.
     * @throws SoundGoodDBException
     */
    public boolean isInstrumentAvailable(int instrumentId) throws SoundGoodDBException {
        String errorMsg = "Could not find available status for instrument";
        ResultSet result = null;
        boolean isAvailable = false;
        try {
            findAvailableStatusInstrumentStmt.setInt(1, instrumentId);
        } catch(SQLException sqle) {
            handleException("Could not set the given instrument", sqle);
        }
        try {
            result = findAvailableStatusInstrumentStmt.executeQuery();
            result.next();
            isAvailable = result.getBoolean(1);
            connection.commit();
        } catch(SQLException sqle) {
            handleException(errorMsg, sqle);
        } finally {
            closeResultSet(errorMsg, result);
        }
        return isAvailable;
    }

    /**
     * Creates a new rental.
     * @param rental The rental to create.
     * @throws SoundGoodDBException If failed to rent instrument.
     */
    public void rentInstrument(RentalDTO rental) throws SoundGoodDBException {
        String failureMsg = "Could not create rental: " + rental;
        int rentalId = getNextRentalId() + 1;
        try {
            rentInstrumentStmt.setInt(1, rental.getStudentId());
            rentInstrumentStmt.setInt(2, rentalId);
            rentInstrumentStmt.setTimestamp(3, rental.getStartDate());
            rentInstrumentStmt.setTimestamp(4, rental.getEndDate());
            rentInstrumentStmt.setInt(5, rental.getInstrumentId());
            int updatedRows = rentInstrumentStmt.executeUpdate();
            if (updatedRows != 1) {
                handleException(failureMsg, null);
            }
            connection.commit();
            System.out.println("Rent instrument successfully " + rental);
        } catch(SQLException sqle) {
            handleException(failureMsg, sqle);
        }
    }

    /**
     * Searches for all rentals by the student id.
     * @param studentId The student's ID number.
     * @return The number of all rentals that the student has made.
     * @throws SoundGoodDBException If failed to search for number of rentals.
     */
    public int findRentalQuotaByStudentId(int studentId) throws SoundGoodDBException {
        String failureMsg = "Could not retrieve rental quota.";
        try {
            findRentalQuotaByStudentIdStmt.setInt(1, studentId);
        } catch(SQLException sqle){
            handleException(failureMsg, sqle);
        }
        int nrOfRentals = 0;
        try(ResultSet result = findRentalQuotaByStudentIdStmt.executeQuery()) {
            while(result.next()) {
                nrOfRentals++;
            }
            connection.commit();
        } catch(SQLException sqle) {
            handleException(failureMsg, sqle);
        }
        return nrOfRentals;
    }

    /**
     * Terminates the instrument rental.
     * @param instrumentId The instrument to return
     * @throws SoundGoodDBException
     */
    public void terminateStudentRental(int studentId, int instrumentId, int rentalId) throws SoundGoodDBException {
        String failureMsg = "Could not terminate student rental.";
        boolean rentalExists = checkIfRentalExists(studentId, instrumentId, rentalId);
        if(rentalExists == false) {
            System.out.println("Rental does not exist for student with id " + studentId + ". Cannot terminate.");
            return;
        }
        try {
            terminateRentalStmt.setInt(1, studentId);
            terminateRentalStmt.setInt(2, instrumentId);
            terminateRentalStmt.setInt(3, rentalId);
            int updatedRows = terminateRentalStmt.executeUpdate();
            System.out.println("updated rows are " + updatedRows);
            if(updatedRows != 1) {
                handleException(failureMsg, null);
            }
            connection.commit();
            System.out.println("Terminated student rental for instrument ID " + instrumentId + " successfully.");
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        }
    }

    public boolean checkIfRentalExists(int student, int instrument, int rental) throws SoundGoodDBException {
        String failureMsg = "Could not check if rental exists";
        ResultSet result = null;
        boolean exists = false;
        try {
            rentalExistsStmt.setInt(1, student);
            rentalExistsStmt.setInt(2, instrument);
            rentalExistsStmt.setInt(3, rental);
            result = rentalExistsStmt.executeQuery();
            result.next();
            exists = result.getBoolean(1);
            connection.commit();
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        } finally {
            closeResultSet(failureMsg, result);
        }
        return exists;
    }

    private void connectToSoundGoodDB() throws ClassNotFoundException, SQLException {
        connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/soundgood",
                "postgres", "example");
        connection.setAutoCommit(false);
    }

    private void prepareStatements() throws SQLException {
        findAllInstrumentsStmt = connection.prepareStatement("SELECT " + INSTRUMENT_PK_COLUMN_NAME + ", " +
                INSTRUMENT_TYPE_COLUMN_NAME + ", " + INSTRUMENT_BRAND_COLUMN_NAME + ", " +
                INSTRUMENT_FEE_COLUMN_NAME + " FROM " + INSTRUMENT_TABLE_NAME + " WHERE " +
                INSTRUMENT_PK_COLUMN_NAME + " NOT IN " + "(SELECT " + INSTRUMENT_ID_FK_COLUMN_NAME +
                " FROM " + RENTAL_TABLE_NAME + " WHERE " + RENTAL_END_DATE_COLUMN_NAME + " > " + "NOW());");

        findNextRentalIdStmt = connection.prepareStatement("SELECT " + RENTAL_PK_COLUMN_NAME + " FROM " +
                RENTAL_TABLE_NAME + " ORDER BY " + RENTAL_TABLE_NAME + " DESC " + " LIMIT 1;");

        findRentalQuotaByStudentIdStmt = connection.prepareStatement("SELECT " + STUDENT_ID_FK_COLUMN_NAME + ", " +
                RENTAL_PK_COLUMN_NAME + " FROM " + RENTAL_TABLE_NAME + " WHERE " + RENTAL_END_DATE_COLUMN_NAME + " > NOW() "
                + " AND " + STUDENT_ID_FK_COLUMN_NAME + " = ?;");

        rentInstrumentStmt = connection.prepareStatement("INSERT INTO " + RENTAL_TABLE_NAME + " (" +
                STUDENT_ID_FK_COLUMN_NAME + ", " + RENTAL_PK_COLUMN_NAME + ", " + RENTAL_START_DATE_COLUMN_NAME +
                ", " + RENTAL_END_DATE_COLUMN_NAME + ", " + INSTRUMENT_ID_FK_COLUMN_NAME + ") " +
                "VALUES " + "(?, ?, ?, ?, ?);");

        findAvailableStatusInstrumentStmt = connection.prepareStatement("SELECT " + "EXISTS " + "(" +
                "SELECT " + INSTRUMENT_PK_COLUMN_NAME + ", " + INSTRUMENT_TYPE_COLUMN_NAME + ", " +
                INSTRUMENT_BRAND_COLUMN_NAME + ", " + INSTRUMENT_FEE_COLUMN_NAME + " FROM " +
                INSTRUMENT_TABLE_NAME + " WHERE " + INSTRUMENT_PK_COLUMN_NAME + " NOT IN " +
                "(SELECT " + INSTRUMENT_ID_FK_COLUMN_NAME + " FROM " + RENTAL_TABLE_NAME +
                " WHERE " + RENTAL_END_DATE_COLUMN_NAME + " > " + "NOW()) " + "AND " +
                INSTRUMENT_PK_COLUMN_NAME + " = " + "?);");

        terminateRentalStmt = connection.prepareStatement("UPDATE " + RENTAL_TABLE_NAME + " SET " +
                RENTAL_END_DATE_COLUMN_NAME + " = " + "NOW() " + "WHERE " + STUDENT_ID_FK_COLUMN_NAME + " = " +
                " ? " + "AND " + INSTRUMENT_ID_FK_COLUMN_NAME + " = " + "?" + " AND " + RENTAL_PK_COLUMN_NAME +
                " = " + "?;");

        rentalExistsStmt = connection.prepareStatement("SELECT EXISTS " + "(" + "SELECT " + RENTAL_PK_COLUMN_NAME +
                " FROM " + RENTAL_TABLE_NAME + " WHERE " + STUDENT_ID_FK_COLUMN_NAME + " = " + "?" +
                " AND " + INSTRUMENT_ID_FK_COLUMN_NAME + " = " + "?" + " AND " + RENTAL_END_DATE_COLUMN_NAME +
                " > " + "NOW()" + " AND " + RENTAL_PK_COLUMN_NAME + " = " + "?);");
    }

    private void handleException(String failureMsg, Exception cause) throws SoundGoodDBException {
        String completeFailureMsg = failureMsg;
        try {
            connection.rollback();
        } catch (SQLException rollbackExc) {
            completeFailureMsg = completeFailureMsg +
                    ". Also failed to rollback transaction because of: " + rollbackExc.getMessage();
        }

        if (cause != null) {
            throw new SoundGoodDBException(failureMsg, cause);
        } else {
            throw new SoundGoodDBException(failureMsg);
        }
    }

    private void closeResultSet(String failureMsg, ResultSet result) throws SoundGoodDBException {
        try {
            result.close();
        } catch (Exception e) {
            throw new SoundGoodDBException(failureMsg + " Could not close result set.", e);
        }
    }
}