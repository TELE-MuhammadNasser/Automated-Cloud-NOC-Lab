# 📡 AWS NOC Monitoring Lab

## 🚀 Overview
Automated **NOC Monitoring Lab** using **Terraform** on **AWS**. This project deploys a secure VPC with monitoring agents to track network health.

## 🖼️ Project Screenshots

### 1. Real-time Monitoring (Netdata Dashboard)
This proves the monitoring agent is active and collecting metrics.

![Netdata Dashboard](./image_c6a4aa.png)
![Netdata Dashboard](./image_c6a4ab.png)


### 2. Infrastructure Security (Inbound Rules)
Security Groups configured for SSH (22) and Netdata (19999).

![Security Rules](./image_c6baf2.png)

### 3. AWS Resource Map
Logical view of the VPC, Subnets, and Gateway.

![VPC Map](./image_c71928.png)

## 💻 Infrastructure as Code (IaC)
The environment is fully automated using **Terraform** to ensure consistency and speed.

### Configuration Files:
- **`main.tf`**: Defines the entire network topology (VPC, Subnet, IGW) and the Ubuntu 24.04 instances for the NOC Lab.
- **`outputs.tf`**: Automatically displays the Public IPs of the servers after deployment for immediate monitoring access.
