resource "local_file" "kubelet_node_ip_patch" {
  count = "${var.cni == "amazon-vpc" ? 1 : 0}"

  content = templatefile("${path.module}/templates/patches-strategic-merge-optional/kubelet-node-ip-patch.yaml", {
    controlplane_nodes    = "${var.controlplane_nodes}"
    cluster_name          = "${var.cluster_name}"
    worker_nodes          = "${var.worker_nodes}"
  })
  filename = "${path.module}/patches-strategic-merge/kubelet-node-ip-patch.yaml"
  file_permission = "0644"
}