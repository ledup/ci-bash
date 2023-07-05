FROM mvdan/shfmt:v3.7.0 as shfmt
FROM koalaman/shellcheck:v0.9.0 as shellcheck

FROM debian:12
RUN apt-get update && apt-get install gosu && apt-get clean &&  useradd ci

COPY --from=shfmt /bin/shfmt /usr/local/bin/shfmt
COPY --from=shellcheck /bin/shellcheck /usr/local/bin/shellcheck

RUN chown root: /usr/local/bin/shellcheck

ADD scripts/entry.sh /entry.sh

ENTRYPOINT [ "/entry.sh" ]
