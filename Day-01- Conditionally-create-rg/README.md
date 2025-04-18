# Day-01 | Terraform Challenge with Hriyen – Conditional Resource Creation using count 

## Greetings! 👋

Welcome to the **Day-01 Terraform Challenge with Hriyen**! Every day, we'll be diving into real-world Terraform scenarios to enhance your skills. Let's get started with today's challenge!

---

### Challenge: Conditional Resource Creation using `count` 💡

#### **Scenario:**

You are building infrastructure for multiple environments: **dev**, **stage**, and **prod**. Your organization follows a policy where a **dedicated resource group** should only be created for **non dev** environments (i.e., **staging** and **prod**). For the **dev environment**, infrastructure will be created in a shared resource group.

---

#### **Your Challenge:**

Write a **Terraform configuration** using the **`count`** meta-argument to **conditionally create** an `azurerm_resource_group` only when the environment is **NOT dev**.

---

### 🔧 **Steps to Complete the Challenge:**
1. **Define the environment type** as `dev`, `staging`, or `prod`.
2. **Use `count`** to conditionally create the `azurerm_resource_group` resource based on the environment type.
3. **Test the configuration** by running `terraform plan` and `terraform apply` to verify the resource is created only for non dev environments.

---

### 💻 **Tips & Solution Structure:**
- **Variables:**
  - Define the environment and region in a variable.
- **Main Configuration:**
  - Use the `count` meta-argument to conditionally create the resource group.
- **Outputs:**
  - Output the name and ID of the resource group.

---

### 📌 **Reminder:**
- Let's work together and discuss the solutions every weekend.
- Don't forget to **like, subscribe, and comment** if you find the challenge useful!
  
**Happy Terraforming!** 🌍