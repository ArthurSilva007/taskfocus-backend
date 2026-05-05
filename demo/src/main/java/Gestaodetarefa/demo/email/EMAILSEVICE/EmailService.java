package Gestaodetarefa.demo.email.EMAILSEVICE;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    /**
     * Envia um e-mail de notificação para um destinatário específico.
     * @param to o endereço de e-mail do destinatário.
     * @param subject o assunto do e-mail.
     * @param text o corpo do e-mail.
     */
    /**
     * Envia um e-mail de notificação para um destinatário específico.
     */
    public void sendNotificationEmail(String to, String subject, String text) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(to);
            message.setSubject(subject);
            message.setText(text);
            mailSender.send(message);
            System.out.println("Email de notificação enviado para: " + to);
        } catch (Exception e) {
            System.err.println("Erro ao enviar e-mail para " + to + ": " + e.getMessage());
        }
    }

    /**
     * Envia e-mail de boas-vindas para usuário recém-registrado.
     * Nota: Usuario é uma referência ao seu modelo. Ajuste conforme necessário.
     */
    public void enviarEmailBoasVindas(String email, String nome) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("Bem-vindo ao TaskFocus");
            message.setText("Olá " + nome + ", sua conta foi criada com sucesso!");
            mailSender.send(message);
            System.out.println("Email de boas-vindas enviado para: " + email);
        } catch (Exception e) {
            System.err.println("Erro ao enviar e-mail de boas-vindas para " + email + ": " + e.getMessage());
        }
    }
}