package parser;

import org.eclipse.jdt.core.JavaCore;
import org.eclipse.jdt.core.dom.AST;
import org.eclipse.jdt.core.dom.ASTParser;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        byte[] encoded = new byte[0];
        try {
            encoded = Files.readAllBytes(Paths.get(args[0]));
        } catch (IOException e) {
            e.printStackTrace();
            return;
        }
        String source = new String(encoded, StandardCharsets.UTF_8);
        Integer times = Integer.parseInt(args[1]);

        long startTime = System.currentTimeMillis();
        for (int i = 0; i < times; i++) {
            ASTParser parser = ASTParser.newParser(AST.JLS8);
            parser.setKind(ASTParser.K_COMPILATION_UNIT);

            parser.setSource(source.toCharArray());
            Map options = JavaCore.getOptions();
            JavaCore.setComplianceOptions(JavaCore.VERSION_1_8, options);
            parser.setCompilerOptions(options);

            parser.createAST(null);
        }

        System.out.printf("%dms\n", System.currentTimeMillis() - startTime);
    }
}