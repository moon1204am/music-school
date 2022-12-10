package se.kth.iv1351.soundgoodjdbc.model;

/**
 * Specifies a read-only view of an instrument.
 */
public interface InstrumentDTO {
    /**
     * @return The instrument.
     */
    public String getInstrument();

    /**
     * @return The brand.
     */
    public String getBrand();

    /**
     * @return The fee.
     */
    public int getFee();

    /**
     * @return The instrument ID.
     */
    public int getInstrumentId();
}