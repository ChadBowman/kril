/**
 * Autogenerated by Avro
 *
 * DO NOT EDIT DIRECTLY
 */
package com.orthus.gdax.schemas;

import org.apache.avro.specific.SpecificData;
import org.apache.avro.message.BinaryMessageEncoder;
import org.apache.avro.message.BinaryMessageDecoder;
import org.apache.avro.message.SchemaStore;

@SuppressWarnings("all")
/** A trade occured */
@org.apache.avro.specific.AvroGenerated
public class Trade extends org.apache.avro.specific.SpecificRecordBase implements org.apache.avro.specific.SpecificRecord {
  private static final long serialVersionUID = -483293117328206630L;
  public static final org.apache.avro.Schema SCHEMA$ = new org.apache.avro.Schema.Parser().parse("{\"type\":\"record\",\"name\":\"Trade\",\"namespace\":\"com.orthus.gdax.schemas\",\"doc\":\"A trade occured\",\"fields\":[{\"name\":\"price\",\"type\":{\"type\":\"string\",\"avro.java.string\":\"String\",\"java-class\":\"java.math.BigDecimal\"},\"doc\":\"Price of product at trade.\\n         * U.S. Dollar / product cost\"},{\"name\":\"timestamp\",\"type\":{\"type\":\"long\",\"logicalType\":\"timestamp-millis\"},\"doc\":\"Time trade occured\"},{\"name\":\"productId\",\"type\":{\"type\":\"string\",\"avro.java.string\":\"String\"},\"doc\":\"Product identifer\"}],\"version\":1}");
  public static org.apache.avro.Schema getClassSchema() { return SCHEMA$; }
}
