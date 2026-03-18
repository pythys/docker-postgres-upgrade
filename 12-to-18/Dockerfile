#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM postgres:18-bookworm

RUN set -eux; apt-get update; apt-get install -y --no-install-recommends ca-certificates gnupg wget; wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/postgresql.gpg; rm -rf /var/lib/apt/lists/*

RUN printf 'deb https://apt-archive.postgresql.org/pub/repos/apt bookworm-pgdg-archive main\n' > /etc/apt/sources.list.d/pgdg.list



RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		postgresql-12='12.22-3.pgdg12+1' \
	; \
	apt-get clean; \
	rm -rf /var/lib/apt/lists/*

ENV PGBINOLD /usr/lib/postgresql/12/bin
ENV PGBINNEW /usr/lib/postgresql/18/bin
RUN set -eux; \
	"$PGBINOLD/postgres" --version; \
	"$PGBINNEW/postgres" --version

ENV PGDATAOLD /var/lib/postgresql/12/data
ENV PGDATANEW /var/lib/postgresql/18/docker

RUN install \
		--verbose \
		--owner postgres \
		--group postgres \
		--mode 1777 \
		--directory \
		"$PGDATAOLD" \
		"$PGDATANEW"

WORKDIR /var/lib/postgresql

COPY docker-upgrade /usr/local/bin/

ENTRYPOINT ["docker-upgrade"]

# recommended: --link
CMD ["pg_upgrade"]
