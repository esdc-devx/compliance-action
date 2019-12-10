FROM mcr.microsoft.com/azure-cli:2.0.77

# --- Arguments ---
ARG TERRAFORM_VERSION="0.12.17"
ARG CONFTEST_VERSION="0.15.0"

# --- Re-usable environment variables ---
ENV TMP_DIR="/tmp"
ENV TERRAFORM_DIR="/opt/terraform"

# --- Install Terraform ---
WORKDIR ${TMP_DIR}
RUN wget -O terraform.zip https://releases.hashicorp.com/terraform/0.12.17/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN unzip terraform.zip
RUN mkdir ${TERRAFORM_DIR}
RUN mv terraform ${TERRAFORM_DIR}/.
RUN ln -s ${TERRAFORM_DIR}/terraform /usr/local/bin/terraform
RUN rm -rf ${TMP_DIR}/*

# --- Install ConfTest --- 
RUN wget https://github.com/instrumenta/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz
RUN tar xzf conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz
RUN mv conftest /usr/local/bin

WORKDIR /

ENTRYPOINT ["/src/main.sh"]
