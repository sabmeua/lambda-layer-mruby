#!/bin/bash

cd /tmp

for rb in $(find -name '*.rb'); do
    /opt/bin/mrbc $rb
done

find -name '*.mrb' -exec zip -r lambda_function.zip {} +
