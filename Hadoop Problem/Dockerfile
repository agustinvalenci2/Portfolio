# Utiliza una imagen base de Ubuntu
FROM ubuntu:latest

# Instala las dependencias necesarias
RUN apt-get update && \
    apt-get install -y \
        wget \
        openjdk-8-jdk \
        ssh

# Descarga Hadoop 3.2.2 y descomprímelo
RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-3.2.2/hadoop-3.2.2.tar.gz && \
    tar -xzvf hadoop-3.2.2.tar.gz -C /opt/ && \
    rm hadoop-3.2.2.tar.gz











# Configura las variables de entorno de Hadoop
ENV HADOOP_HOME=/opt/hadoop-3.2.2
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
RUN apt-get update && \
    apt-get install -y default-jdk


# Configura las variables de entorno de Java
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

ENV PATH=$PATH:$JAVA_HOME/bin


# Configura las variables de entorno de Hadoop
ENV HDFS_NAMENODE_USER=root
ENV HDFS_DATANODE_USER=root
ENV HDFS_SECONDARYNAMENODE_USER=root
ENV YARN_RESOURCEMANAGER_USER=root
ENV YARN_NODEMANAGER_USER=root

# Configura las claves SSH para permitir conexiones localhost sin contraseña
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys

# Copia la configuración de Hadoop
COPY --chown=root:root config/* $HADOOP_HOME/etc/hadoop/


# Create a directory for your reducer script inside the Docker container
RUN mkdir /reducer

# Copy the reducer script from the host into the container
COPY reducer1.py /reducer/

# Set the working directory
WORKDIR /reducer
# Crear el usuario "valen"
RUN useradd -ms /bin/bash valen

# Establecer la contraseña para el usuario "valen"
RUN echo 'valen:tu_contraseña' | chpasswd

# Dar permisos de sudo al usuario "valen" si es necesario
RUN usermod -aG sudo valen

# Cambiar al usuario "valen"
USER valen

# Exponer los puertos necesarios para Hadoop (puertos predeterminados)
EXPOSE 9870 8088 8032 9000 22

# Ejecutar los servicios de Hadoop (NameNode, DataNode, ResourceManager, NodeManager, HistoryServer)
CMD service ssh start && $HADOOP_HOME/sbin/start-dfs.sh && $HADOOP_HOME/sbin/start-yarn.sh && tail -f /dev/null && mkdir hadoop-3.2.2/data/datanode/ && mkdir hadoop-3.2.2/data/namenode/