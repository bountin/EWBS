binary = ./dlv.i386-apple-darwin-iodbc
options = -N75 -silent

DLV = $(binary) $(options)
test2:
	$(DLV) -filter=substation,generator,battery,c_in,c_out,p_in,p_out,c,p,const s.dl g.dl b.dl connect.dl sample_test.dl | sed -e 's/[\{\}]//g' -e 's/, /\'$$'\n/g' | sort | nl
test:
	./testrunner.sh
