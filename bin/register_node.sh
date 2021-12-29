#!/bin/bash
# this is a simple wrapper which register a k8s node
# deps: yq
# $1 k8s id <k8s-cluster-01>
# $2 k8s url <https://api.k8s-cluster-01.localhost>
# $3 k8s token <sdfasdfasjdfla>
# $4 k8s cert in base64 encoded


cert_file="$1.cert"
config_dir="config"
cert_dir="${config_dir}/certs"
cert_path="/$cert_dir/$cert_file"
apiServer="$2"
token="$3"
echo "$1"

is_new=$(cert_path="$cert_path" yq eval '.clusters.[] | select(.ca == strenv(cert_path))' $config_dir/config.yaml | yq eval '.ca' -)
if [ "$is_new" == "null" ] ; then
	echo "new"
	cert_path="$cert_path" token="$token" apiServer="$apiServer" yq eval '.clusters + {"token": strenv(token), "apiServer": strenv(apiServer), "ca": strenv(cert_path)}' -i $config_dir/config.yaml
	echo "$4" | base64 -d > "$cert_dir/$cert_file"
else
	echo "already configured"
fi
