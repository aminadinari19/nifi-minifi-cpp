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
  And a PutFile processor with the "Directory" property set to "/tmp/output"
  And the "success" relationship of the GetFile processor is connected to the HashContent
  And the "success" relationship of the HashContent processor is connected to the PutFile
  When the MiNiFi instance starts up
  Then a flowfile with the content <content> is placed in the monitored directory in less than 10 seconds
  And the flowfile has an attribute called "hash" set to <hash_value>

  Examples:
    | content  | hash_algorithm | hash_value                                                       |
    | "test"   | MD5            | 098f6bcd4621d373cade4e832627b4f6                                 |
    #| "test"   | SHA1           | a94a8fe5ccb19ba61c4c0873d391e987982fbbd3                         |
    #| "test"   | SHA256         | 9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08 |
    #| "coffee" | MD5            | 24eb05d18318ac2db8b2b959315d10f2                                 |
    #| "coffee" | SHA1           | 44213f9f4d59b557314fadcd233232eebcac8012                         |
    #| "coffee" | SHA256         | 37290d74ac4d186e3a8e5785d259d2ec04fac91ae28092e7620ec8bc99e830aa |