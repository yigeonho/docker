# SSH 및 HTTP/HTTPS 방화벽 규칙 추가
resource "google_compute_firewall" "allow-ssh-http-https" {
  name    = "allow-ssh-http-https"
  network = "se-vpc"  # 기존 VPC 네트워크 이름을 지정
  
  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "8080", "3306"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["master", "worker1", "worker2"]
}

# us-central1 인스턴스 생성 및 Nginx, Tomcat 8.5, MariaDB 설치
resource "google_compute_instance" "master_instance" {
  name         = "master-instance"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  tags         = ["master"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnet_us_central.id  # 사용 중인 서브넷 이름을 지정
    access_config {}
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y nginx tomcat9 mariadb-server

    # Nginx 설정 및 시작
    sudo systemctl start nginx
    sudo systemctl enable nginx

    # Tomcat 설정 및 시작
    sudo systemctl start tomcat9
    sudo systemctl enable tomcat9

    # MariaDB 설정 및 시작
    sudo systemctl start mariadb
    sudo systemctl enable mariadb
  EOF
}

# europe-west1 인스턴스 생성 및 Nginx, Tomcat 8.5, MariaDB 설치
resource "google_compute_instance" "worker1_instance" {
  name         = "worker1-instance"
  machine_type = "e2-medium"
  zone         = "europe-west1-c"
  tags         = ["worker1"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnet_europe_west.id  # 사용 중인 서브넷 이름을 지정
    access_config {}
  }

   metadata_startup_script = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y nginx tomcat9 mariadb-server

    # Nginx 설정 및 시작
    sudo systemctl start nginx
    sudo systemctl enable nginx

    # Tomcat 설정 및 시작
    sudo systemctl start tomcat9
    sudo systemctl enable tomcat9

    # MariaDB 설정 및 시작
    sudo systemctl start mariadb
    sudo systemctl enable mariadb
  EOF
}

# asia-northeast3 인스턴스 생성 및 Nginx, Tomcat 8.5, MariaDB 설치
resource "google_compute_instance" "worker2_instance" {
  name         = "worker2-instance"
  machine_type = "e2-medium"
  zone         = "asia-northeast3-a"
  tags         = ["worker2"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnet_asia_northeast.id  # 사용 중인 서브넷 이름을 지정
    access_config {}
  }
 metadata_startup_script = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y nginx tomcat9 mariadb-server

    # Nginx 설정 및 시작
    sudo systemctl start nginx
    sudo systemctl enable nginx

    # Tomcat 설정 및 시작
    sudo systemctl start tomcat9
    sudo systemctl enable tomcat9

    # MariaDB 설정 및 시작
    sudo systemctl start mariadb
    sudo systemctl enable mariadb
  EOF
}