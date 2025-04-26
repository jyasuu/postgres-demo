
use std::io::{self, Write};
use std::time::Duration;
use std::{env, process};
use kafka::consumer::{Consumer, FetchOffset, GroupOffsetStorage};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let mut consumer = Consumer::from_hosts(vec!["localhost:9092".to_owned()])
        .with_topic_partitions("dbserver.public.users".to_owned(), &[0])
        .with_fallback_offset(FetchOffset::Earliest)
        .with_group("users".to_owned())
        .with_offset_storage(Some(GroupOffsetStorage::Kafka))
        .create()
        .unwrap();

    let stdout = io::stdout();
    let mut stdout = stdout.lock();
    let mut buf = Vec::with_capacity(1024);
    loop {
        for ms in consumer.poll().unwrap().iter() {
            for m in ms.messages() {
                // ~ clear the output buffer
                unsafe { buf.set_len(0) };
                // ~ format the message for output
                // let _ = writeln!(buf, "{}:{}@{}:", ms.topic(), ms.partition(), m.offset);
                buf.extend_from_slice(m.value);
                buf.push(b'\n');
                // ~ write to output channel
                // stdout.write_all(&buf)?;
                let str = std::str::from_utf8(&buf);
                println!("{:#?}", str);
                // println!("{:?}", m);
            }
            let _ = consumer.consume_messageset(ms);
        }
        consumer.commit_consumed().unwrap();
    }
}
