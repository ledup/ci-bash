FROM mvdan/shfmt:v3.9.0 AS shfmt
FROM koalaman/shellcheck:v0.10.0 AS shellcheck

FROM debian:12
RUN apt-get update && apt-get install gosu && apt-get clean &&  useradd ci

COPY --from=shfmt /bin/shfmt /usr/local/bin/shfmt
COPY --from=shellcheck /bin/shellcheck /usr/local/bin/shellcheck

RUN chown root: /usr/local/bin/shellcheck

ADD scripts/entry.sh /entry.sh

ENTRYPOINT [ "/entry.sh" ]
