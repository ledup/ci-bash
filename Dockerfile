FROM mvdan/shfmt:v3.12.0 AS shfmt
FROM koalaman/shellcheck:v0.11.0 AS shellcheck

FROM debian:13
RUN apt-get update && apt-get install gosu && apt-get clean &&  useradd ci

COPY --from=shfmt /bin/shfmt /usr/local/bin/shfmt
COPY --from=shellcheck /bin/shellcheck /usr/local/bin/shellcheck

RUN chown root: /usr/local/bin/shellcheck

ADD scripts/entry.sh /entry.sh

ENTRYPOINT [ "/entry.sh" ]
