provider "google" {
  project = "projectse-432404"  # GCP 프로젝트 ID를 여기에 입력하세요.
  region  = "us-central1"           # VPC의 기본 리전을 설정하세요.
}

# VPC 네트워크 생성
resource "google_compute_network" "vpc_network" {
  name                    = "se-vpc"
  auto_create_subnetworks = false  # false로 설정하여 자동으로 서브넷을 생성하지 않도록 합니다.
}

# 서브넷 생성 (us-central1 리전)
resource "google_compute_subnetwork" "subnet_us_central" {
  name          = "us-subnet"
  ip_cidr_range = "172.16.31.0/24"  # 서브넷의 IP 범위
  region        = "us-central1"  # 서브넷이 위치할 리전
  network       = google_compute_network.vpc_network.id  # 생성된 VPC 네트워크를 참조
}


# 서브넷 생성 (europe-west1 리전)
resource "google_compute_subnetwork" "subnet_europe_west" {
  name          = "europe-subnet"
  ip_cidr_range = "172.16.32.0/24"  # 서브넷의 IP 범위
  region        = "europe-west1"  # 서브넷이 위치할 리전
  network       = google_compute_network.vpc_network.id  # 생성된 VPC 네트워크를 참조
}

# 서브넷 생성 (asia-northeast3 리전)
resource "google_compute_subnetwork" "subnet_asia_northeast" {
  name          = "asia-sunbet"
  ip_cidr_range = "172.16.33.0/24"  # 서브넷의 IP 범위
  region        = "asia-northeast3"  # 서브넷이 위치할 리전
  network       = google_compute_network.vpc_network.id  # 생성된 VPC 네트워크를 참조
}