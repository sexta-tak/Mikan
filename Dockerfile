FROM ubuntu:18.04
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y upgrade && apt-get -y install sudo vim okteta git curl build-essential python3-distutils \
    qemu dosfstools ovmf \
    uuid-dev clang-7 lld-7 llvm-7-dev nasm acpica-tools xauth unzip \
    language-pack-ja-base language-pack-ja locales && \
    locale-gen ja_JP.UTF-8 && \
    echo "export LANG='ja_JP.UTF-8'" >> "${HOME}/.profile" && \
    echo "export LANG='ja_JP.UTF-8'" >> "${HOME}/.bashrc"
    
RUN for item in \
    llvm-PerfectShuffle \
    llvm-ar \
    llvm-as \
    llvm-bcanalyzer \
    llvm-cat \
    llvm-cfi-verify \
    llvm-comfig \
    llvm-cov \
    llvm-c-test \
    llvm-cvtres \
    llvm-cxxdump \
    llvm-diff \
    llvm-dlltool \
    llvm-dwarfdump \
    llvm-dwp \
    llvm-exegesis \
    llvm-extract \
    llvm-lib \
    llvm-link \
    llvm-lto \
    llvm-lto2 \
    llvm-mc \
    llvm-mca \
    llvm-modextract \
    llvm-mt \
    llvm-nm \
    llvm-objcopy \
    llvm-objdump \
    llvm-opt-report \
    llvm-pdbutil \
    llvm-profdata \
    llvm-ranlib \
    llvm-rc \
    llvm-readelf \
    llvm-readobj \
    llvm-rtdyld \
    llvm-size \
    llvm-split \
    llvm-stress \
    llvm-strings \
    llvm-strip \
    llvm-symbolizer \
    llvm-tblgen \
    llvm-undname \
    llvm-xray \
    ld.lld \
    lld-link \
    clang \
    clang++ \
    clang-cpp \
    ; do \
        update-alternatives --install "/usr/bin/${item}" "${item}" "/usr/bin/${item}-7" 50 \
    ; done


ENV LANG "ja_JP.UTF-8"

COPY entrypoint.sh /root/
COPY osbook.sh /root/
COPY source.sh /root/
COPY .vimrc /root/

# ENTRYPOINT ["/root/entrypoint.sh"]
CMD ["bash"]
