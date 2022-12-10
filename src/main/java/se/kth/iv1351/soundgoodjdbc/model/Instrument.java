package se.kth.iv1351.soundgoodjdbc.model;

/**
 * An instrument in the database.
 */
public class Instrument implements InstrumentDTO {
    private String instrument;
    private String brand;
    private int fee;
    private int instrumentId;

    /**
     * Creates an instrument.
     * @param instrument The type of instrumet.
     * @param brand The brand of the instrument.
     * @param fee The fee of the instrument.
     * @param instrumentId The instrument ID.
     */
    public Instrument(String instrument, String brand, int fee, int instrumentId) {
        this.instrument = instrument;
        this.brand = brand;
        this.fee = fee;
        this.instrumentId = instrumentId;
    }

    /**
     * @return The instrument.
     */
    public String getInstrument() {
        return instrument;
    }

    /**
     * @return The brand.
     */
    public String getBrand() {
        return brand;
    }

    /**
     * @return The fee.
     */
    public int getFee() {
        return fee;
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
        stringRepresentation.append("Instrument: [");
        stringRepresentation.append("type of instrument: ");
        stringRepresentation.append(instrument);
        stringRepresentation.append(", brand: ");
        stringRepresentation.append(brand);
        stringRepresentation.append(", fee: ");
        stringRepresentation.append(fee);
        stringRepresentation.append("]");
        return stringRepresentation.toString();
    }
}