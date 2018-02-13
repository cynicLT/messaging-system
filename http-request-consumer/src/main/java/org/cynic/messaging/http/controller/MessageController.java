package org.cynic.messaging.http.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.stream.messaging.Source;
import org.springframework.http.HttpStatus;
import org.springframework.messaging.support.MessageBuilder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MessageController {

    private final Source source;

    private final String prefix;

    public MessageController(Source source, @Value("${http.prefix:''}") String prefix) {
        this.source = source;
        this.prefix = prefix;
    }

    @PostMapping("/send-message")
    @ResponseStatus(HttpStatus.ACCEPTED)
    public void sendMessage(@RequestBody String message) {
        source.output().
                send(MessageBuilder.
                        withPayload(String.join("|", prefix, message)).
                        build()
                );
    }
}
