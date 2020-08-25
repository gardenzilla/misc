SUBDIRS := \
  client \
  api \
  user_microservice \
  email_microservice

all: $(SUBDIRS)

$(SUBDIRS):
  # Run make release in each subdirs
	$(MAKE) -C $@ release
	# Run local docker build per subdirs
	docker build -t $@ ./$@
  
.PHONY: all $(SUBDIRS)
