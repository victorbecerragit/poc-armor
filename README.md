# Cloud Armor POC - GCP Terraform Demonstration

A proof-of-concept repository demonstrating how to implement **Google Cloud Armor** security policies on Google Cloud Platform (GCP) using Terraform. This project includes examples for both GCE (Compute Engine) and GKE (Kubernetes Engine) deployments.

## Overview

Cloud Armor provides DDoS protection and security policy enforcement at Google's edge. This repository contains Terraform configurations to set up Cloud Armor in two scenarios:

1. **GCE (Compute Engine)** - Traditional VM-based infrastructure with load balancing
2. **GKE (Kubernetes Engine)** - Kubernetes cluster with Global Load Balancer

## Directory Structure

### `/demo_gce`
Demonstrates Cloud Armor on Google Compute Engine with:
- GCE instances running NGINX as backend servers
- Load balancing configuration
- Firewall rules and network setup
- Cloud Armor security policies with DDoS protection rules
- Example stress-testing configuration for validation

### `/demo_gke`
Demonstrates Cloud Armor on Google Kubernetes Engine with:
- GKE cluster provisioning
- VPC network configuration
- Global Load Balancer (GLB) setup
- Cloud Armor security policies
- Kubernetes application deployments (hello-app, zone printer)
- Certificate management
- Network Endpoint Groups (NEGs) for Kubernetes integration

## Key Features

- **DDoS Protection**: Cloud Armor security policies to block malicious traffic
- **IP Blacklisting**: Deny traffic from specified IP ranges
- **IP Whitelisting**: Allow traffic from trusted IP ranges (commented examples provided)
- **Terraform Infrastructure as Code**: Complete IaC implementation for reproducible deployments
- **Multi-Environment**: Examples for both compute and Kubernetes workloads

## Prerequisites

- Terraform installed
- GCP project with appropriate permissions
- GCP service account credentials
- Required GCP APIs enabled (Compute Engine, Kubernetes Engine, Cloud Armor, etc.)

## Notes

- This is an older proof-of-concept based on a production customer implementation
- Terraform code may require minimal updates for current GCP provider versions
- Review and customize variables, IP lists, and security rules for your use case
