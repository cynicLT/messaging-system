package org.cynic.messaging.consumer.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.stream.messaging.Sink;
import org.springframework.integration.annotation.ServiceActivator;
import org.springframework.stereotype.Component;

@Component
public class EventProcessor {
    private static final Logger LOGGER = LoggerFactory.getLogger(EventProcessor.class);
    private final Sink sink;

    public EventProcessor(Sink sink) {
        this.sink = sink;
    }

    @ServiceActivator(inputChannel = Sink.INPUT)
    public void processMessage(String message) {
        LOGGER.info("--------------------------");
        LOGGER.info("{}", message);
        LOGGER.info("--------------------------");
    }
}
