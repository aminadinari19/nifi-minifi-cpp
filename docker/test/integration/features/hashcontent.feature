Feature: Hash value is added to Flowfiles by HashContent processor
  In order to avoid duplication of content of Flowfiles
  As a user of MiNiFi
  I need to have HashContent processor to calculate and add hash value

Background:
  Given the content of "/tmp/output" is monitored

Scenario Outline: HashContent adds hash attribute to flowfiles
  Given a GetFile processor with the "Input Directory" property set to "/tmp/input"
  And a file with the content <content> is present in "/tmp/input"
  And a HashContent processor with the "Hash Attribute" property set to "hash"
  And the "Hash Algorithm" of the HashContent processor is set to "<hash_algorithm>"
  And a LogAttribute processor with the "LogLevel" property set to "trace"
  And the "success" relationship of the GetFile processor is connected to the HashContent
  And the "success" relationship of the HashContent processor is connected to the LogAttribute
  When the MiNiFi instance starts up
  Then the flowfile has an attribute called "hash" set to <hash_value>

  Examples:
    | content  | hash_algorithm | hash_value                                                       |
    | "test"   | MD5            | 098F6BCD4621D373CADE4E832627B4F6                                 |
    | "test"   | SHA1           | A94A8FE5CCB19BA61C4C0873D391E987982FBBD3                         |
    | "test"   | SHA256         | 9F86D081884C7D659A2FEAA0C55AD015A3BF4F1B2B0B822CD15D6C15B0F00A08 |
    | "coffee" | MD5            | 24EB05D18318AC2DB8B2B959315D10F2                                 |
    | "coffee" | SHA1           | 44213F9F4D59B557314FADCD233232EEBCAC8012                         |
    | "coffee" | SHA256         | 37290D74AC4D186E3A8E5785D259D2EC04FAC91AE28092E7620EC8BC99E830AA |