package se.kth.iv1351.soundgoodjdbc.integration;

/**
 * Thrown when a call to the Sound Good database fails.
 */
public class SoundGoodDBException extends Exception {

    /**
     * Create a new instance thrown because of the specified reason.
     *
     * @param reason Why the exception was thrown.
     */
    public SoundGoodDBException(String reason) {
        super(reason);
    }

    /**
     * Create a new instance thrown because of the specified reason and exception.
     *
     * @param reason    Why the exception was thrown.
     * @param rootCause The exception that caused this exception to be thrown.
     */
    public SoundGoodDBException(String reason, Throwable rootCause) {
        super(reason, rootCause);
    }
}