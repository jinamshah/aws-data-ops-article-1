from pyspark.sql import SparkSession, SQLContext
try:
    spark = SparkSession.builder.appName(
        'map-reduce-test').getOrCreate()
    sc = spark.sparkContext
    sqlContext = SQLContext(sc)
except Exception as e:
    raise Exception("Error" + ' ' + str(e))
