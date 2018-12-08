# example.conf: A single-node Flume configuration

# Name the components on this agent
a1.sources = r1
a1.sinks = k1
a1.channels = c1

# Describe/configure the source
a1.sources.r1.type = netcat
a1.sources.r1.bind = gw02.itversity.com
a1.sources.r1.port = 44444

# Describe the sink
a1.sinks.k1.type = logger

# Use a channel which buffers events in memory
a1.channels.c1.type = memory
a1.channels.c1.capacity = 1000
a1.channels.c1.transactionCapacity = 100

# Bind the source and sink to the channel
a1.sources.r1.channels = c1
a1.sinks.k1.channel = c1

flume-ng agent \
    --conf-file example.conf \
    --name a1 \
    -Dflume.root.logger=INFO,console


# Name the components on this agent
a1.sources = logsource
a1.sinks = loggersink hdfssink
a1.channels = loggerchannel hdfschannel

# Describe/configure the source
a1.sources.logsource.type = exec
a1.sources.logsource.command =tail -F /opt/gen_logs/logs/access.log


# Describe the sink
a1.sinks.loggersink.type = logger


# Use a channel which buffers events in memory
a1.channels.loggerchannel.type = memory
a1.channels.loggerchannel.capacity = 1000
a1.channels.loggerchannel.transactionCapacity = 100

# Bind the source and sink to the channel
a1.sources.logsource.channels = loggerchannel hdfschannel
a1.sinks.loggersink.channel = loggerchannel

# Describe the sink for hdfs
a1.sinks.hdfssink.type = hdfs
a1.sinks.hdfssink.hdfs.path = hdfs://nn01.itversity.com:8020/user/selvamsand/flume_example_%Y_%m_%d
a1.channels.hdfschannel.hdfs.fileType = DataStream
a1.sinks.hdfssink.hdfs.useLocalTimeStamp = true
a1.sinks.hdfssink.hdfs.rollInterval = 120
a1.sinks.hdfssink.hdfs.rollSize = 0
a1.sinks.hdfssink.hdfs.rollCount = 30
a1.sinks.hdfssink.hdfs.filePrefix = retail
a1.sinks.hdfssink.hdfs.fileSuffix = .txt

# Use a channel which buffers events in memory
a1.channels.hdfschannel.type = memory
a1.channels.hdfschannel.capacity = 1000
a1.channels.hdfschannel.transactionCapacity = 100


flume-ng agent  \
    --conf-file logtohdfs.conf \
    --name a1 \
    -Dflume.root.logger=INFO,console

