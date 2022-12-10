package se.kth.iv1351.soundgoodjdbc.model;

//import java.sql.Date;
import java.sql.Timestamp;
import java.util.Date;

/**
 * Specifies a read-only view of a rental.
 */
public interface RentalDTO {

    /**
     * @return The start date.
     */
    public Timestamp getStartDate();

    /**
     * @return The end date.
     */
    public Timestamp getEndDate();

    /**
     * @return The student ID.
     */
    public int getStudentId();

    /**
     * @return The instrument ID.
     */
    public int getInstrumentId();
}
