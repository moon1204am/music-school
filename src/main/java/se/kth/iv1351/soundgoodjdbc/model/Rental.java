package se.kth.iv1351.soundgoodjdbc.model;

import java.util.Date;
import java.sql.Timestamp;
import java.util.Calendar;

/**
 * A rental in the database.
 */
public class Rental implements RentalDTO {
    private Timestamp startDate;
    private Timestamp endDate;
    private int studentId;
    private int instrumentId;

    /**
     * Creates a rental for the specified student
     * @param startDate The start date.
     * @param endDate The end date.
     * @param studentId The student renting the instrumet.
     * @param instrumentId The instrument rented
     */
    public Rental(Timestamp startDate, Timestamp endDate, int studentId, int instrumentId) {
        this.startDate = getStartDate();
        this.endDate = getEndDate();
        this.studentId = studentId;
        this.instrumentId = instrumentId;
    }

    /**
     * Creates a rental for the specified student without a start date and end date.
     * @param studentId The student renting the instrumet.
     * @param instrumentId The instrument rented
     */
    public Rental(int studentId, int instrumentId) {
        this.startDate = getStartDate();
        this.endDate = getEndDate();
        this.studentId = studentId;
        this.instrumentId = instrumentId;
    }

    /**
     * @return The start date.
     */
    public Timestamp getStartDate() {
        startDate = new Timestamp(System.currentTimeMillis());
        return startDate;
    }

    /**
     * @return The end date.
     */
    public Timestamp getEndDate() {
        Date date = new Date();
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.add(Calendar.YEAR, 1);
        endDate = new Timestamp(c.getTime().getTime());
        return endDate;
    }

    /**
     * @return The student ID.
     */
    public int getStudentId() {
        return studentId;
    }

    /**
     * @return The instrument ID.
     */
    public int getInstrumentId() {
        return instrumentId;
    }

    /**
     * @return A string representation of all fields in this object.
     */
    @Override
    public String toString() {
        StringBuilder stringRepresentation = new StringBuilder();
        stringRepresentation.append("Rental: [");
        stringRepresentation.append("start date: ");
        stringRepresentation.append(getStartDate());
        stringRepresentation.append(", end date: ");
        stringRepresentation.append(getEndDate());
        stringRepresentation.append(", student id: ");
        stringRepresentation.append(studentId);
        stringRepresentation.append(", instrument id: ");
        stringRepresentation.append(instrumentId);
        stringRepresentation.append("]");
        return stringRepresentation.toString();
    }
}
