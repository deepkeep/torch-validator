FROM docker.deepkeep.co/deepkeep/torch

RUN luarocks install nngraph
RUN luarocks install csv2tensor
RUN luarocks install lua-cjson

WORKDIR /
COPY validate.lua validate.lua

# This assumes that /packages/network and /packages/validation-data
# have been mounted (both directories containing the extracted deepkeep packages)

ENV NETWORK=/packages/network/network.t7
ENV VALIDATION_DATA=/packages/validation-data/data.csv

CMD ["th", "validate.lua"]
