#!/bin/bash

function namespaces {
    kubectl get namespaces | grep -v NAME | awk '{print$1}'
}

# $1 namespace
# $2 pod name
function exec_pod {
    kubectl exec --stdin --tty -n $1 $2 -- /home/erlang/relx remote_console
}

# $1 Namespace
# $2 search
function get_pods {
    GREP=${2-""}
    PODS=`kubectl get pods -n $1 | grep -v NAME | awk '{print$1}' | grep "$2"`
    echo "Choose Pod"
    select POD in $PODS; do
        exec_pod $1 $POD
    done
}

# $1 Pod regex
function select_namespace {
    echo "Choose namespace"
    NAMESPACES=`namespaces`
    select NAMESPACE in $NAMESPACES; do
        get_pods $NAMESPACE $1
    done
}

# $1 Pod regex
select_namespace $1