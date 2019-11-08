package library.kubernetes.admission.opa_global.lib.opa_global

admission_review(reasons) = {
	"apiVersion": "admission.k8s.io/v1beta1",
	"kind": "AdmissionReview",
	"response": response(reasons),
}

response(reasons) = {"allowed": true} {
	count(reasons) == 0
}

response(reasons) = {"allowed": false, "status": {"reason": msg}} {
	count(reasons) > 0
	msg := concat(", ", reasons)
}