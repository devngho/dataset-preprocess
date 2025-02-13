export CLUSTER_NAME=devngho-dedup-clusters
export PROJECT_ID=gaenari
export REGION=asia-northeast3
export ZONE=asia-northeast3-a
export INPUT_GCS_PATH="gs://devngho-dedup-clusters/input"
export OUTPUT_GCS_PATH="gs://devngho-dedup-clusters/output"

gcloud dataproc clusters create $CLUSTER_NAME \
   --enable-component-gateway \
   --region $REGION \
   --zone $ZONE \
   --master-machine-type n2d-standard-16 \
   --master-boot-disk-size 200 \
   --num-workers 4 \
   --worker-machine-type n2d-standard-16 \
   --worker-boot-disk-size 200 \
   --image-version 2.2-debian12 \
   --project $PROJECT_ID \
   --properties="^#^dataproc:pip.packages=xxhash==3.5.0,numpy==1.26.4,scipy==1.11.4,graphframes==0.6" \
   --public-ip-address

gcloud dataproc jobs submit pyspark --cluster ${CLUSTER_NAME}\
   --region $REGION \
   --project $PROJECT_ID \
   --jars gs://spark-lib/bigquery/spark-3.3-bigquery-0.32.2.jar \
   --driver-log-levels root=FATAL,__main__=DEBUG \
   --properties="spark.executor.memory"="50g","spark.driver.memory"="8g","spark.executor.cores"="14","spark.jars.packages=graphframes:graphframes:0.8.2-spark3.2-s_2.12" \
   minhash_spark.py -- --input $INPUT_GCS_PATH --output $OUTPUT_GCS_PATH --column text