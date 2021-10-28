/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.fakefileinputstream;

import java.io.FileDescriptor;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.channels.FileChannel;

/**
 *
 * @author triet
 */
public class FakeFileInputStream extends FileInputStream {

    private final InputStream sourceInput;

    // @Torben offered this solution, which does not need an existing file.
    public FakeFileInputStream(InputStream sourceInput) {
        super(new FileDescriptor());
        this.sourceInput = sourceInput;
    }

    @Override
    public int read() throws IOException {
        return sourceInput.read();
    }

    @Override
    public int read(byte[] b) throws IOException {
        return sourceInput.read(b);
    }

    @Override
    public int read(byte[] b, int off, int len) throws IOException {
        return sourceInput.read(b, off, len);
    }

    @Override
    public long skip(long n) throws IOException {
        return sourceInput.skip(n);
    }

    @Override
    public int available() throws IOException {
        return sourceInput.available();
    }

    @Override
    public void close() throws IOException {
        sourceInput.close();
        //super.close();
    }

    @Override
    public FileChannel getChannel() {
        throw new UnsupportedOperationException();
    }

    @Override
    public synchronized void mark(int readlimit) {
        sourceInput.mark(readlimit);
    }

    @Override
    public synchronized void reset() throws IOException {
        sourceInput.reset();
    }

    @Override
    public boolean markSupported() {
        return sourceInput.markSupported();
    }

}
