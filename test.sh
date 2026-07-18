#!/bin/bash

BLACK_TEXT=$'\033[0;90m'
RED_TEXT=$'\033[0;91m'
GREEN_TEXT=$'\033[0;92m'
YELLOW_TEXT=$'\033[0;93m'
BLUE_TEXT=$'\033[0;94m'
MAGENTA_TEXT=$'\033[0;95m'
CYAN_TEXT=$'\033[0;96m'
WHITE_TEXT=$'\033[0;97m'
RESET_FORMAT=$'\033[0m'
BOLD_TEXT=$'\033[1m'
UNDERLINE_TEXT=$'\033[4m'

clear

echo "${CYAN_TEXT}${BOLD_TEXT}==================================================================${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}    SUBSCRIBE TECH & CODE - INITIATING LAB EXECUTION...           ${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}==================================================================${RESET_FORMAT}"
echo

# Prompt user for Tester Email needed for Task 4
echo "${YELLOW_TEXT}${BOLD_TEXT}To complete Task 4, please enter the Tester Account Email (Username 2 from the lab instructions):${RESET_FORMAT}"
read -p "Tester Email: " TESTER_EMAIL
echo

# Step 1: Enable the IAP (Identity-Aware Proxy) service
echo "${GREEN_TEXT}${BOLD_TEXT}Enabling the IAP API...${RESET_FORMAT}"
gcloud services enable iap.googleapis.com

# Step 2: Set the project in gcloud configuration
echo "${MAGENTA_TEXT}${BOLD_TEXT}Setting the project in gcloud configuration...${RESET_FORMAT}"
gcloud config set project $DEVSHELL_PROJECT_ID

# Step 3: Clone the Python sample application repository
echo "${CYAN_TEXT}${BOLD_TEXT}Cloning the Python sample application repository...${RESET_FORMAT}"
rm -rf python-docs-samples # Clears directory in case script is run multiple times
git clone https://github.com/GoogleCloudPlatform/python-docs-samples.git

# Step 4: Navigate to the hello_world directory
echo "${RED_TEXT}${BOLD_TEXT}Navigating to the hello_world directory...${RESET_FORMAT}"
cd python-docs-samples/appengine/standard_python3/hello_world/

# Step 5: Create an App Engine application (Task 1: Explicitly set to europe-west4)
echo "${BLUE_TEXT}${BOLD_TEXT}Creating App Engine application in europe-west4 (Task 1)...${RESET_FORMAT}"
gcloud app create --project=$DEVSHELL_PROJECT_ID --region=europe-west4

# Step 6: Deploy the application
echo "${MAGENTA_TEXT}${BOLD_TEXT}Deploying the application (This takes a minute)...${RESET_FORMAT}"
gcloud app deploy --quiet

# Step 7: Authorize the test account access (Task 4)
echo "${GREEN_TEXT}${BOLD_TEXT}Authorizing Tester Account with IAP-secured Web App User role (Task 4)...${RESET_FORMAT}"
gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID \
    --member="user:$TESTER_EMAIL" \
    --role="roles/iap.httpsResourceAccessor"

echo
echo "${CYAN_TEXT}${BOLD_TEXT}=======================================================${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}       AUTOMATED TASKS (1 AND 4) COMPLETED!            ${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}=======================================================${RESET_FORMAT}"
echo
echo "${RED_TEXT}${BOLD_TEXT}ATTENTION: TASKS 2 AND 3 MUST BE COMPLETED MANUALLY!${RESET_FORMAT}"
echo "${WHITE_TEXT}The Cloud SDK does not support creating an 'External' OAuth Consent screen, so you must do it manually:${RESET_FORMAT}"
echo
echo "${YELLOW_TEXT}${BOLD_TEXT}--- MANUAL STEP 1 (Task 2: Configure OAuth) ---${RESET_FORMAT}"
echo "1. Go here: https://console.cloud.google.com/apis/credentials/consent?project=$DEVSHELL_PROJECT_ID"
echo "2. Select 'External' and click Create."
echo "3. Enter App Name: TechCode"
echo "4. Set 'User support email' & 'Developer contact email' to your Student account email."
echo "5. Click 'Save and Continue' 3 times to skip through Scopes and Test Users."
echo
echo "${YELLOW_TEXT}${BOLD_TEXT}--- MANUAL STEP 2 (Task 3: Enable IAP) ---${RESET_FORMAT}"
echo "1. Go here: https://console.cloud.google.com/security/iap?tab=applications&project=$DEVSHELL_PROJECT_ID"
echo "2. Find 'App Engine app' in the resource list."
echo "3. Toggle the IAP switch to 'ON'."
echo
echo "${GREEN_TEXT}${BOLD_TEXT}Once you complete these manual steps, click 'Check Progress' on all tasks!${RESET_FORMAT}"
echo "${RED_TEXT}${BOLD_TEXT}${UNDERLINE_TEXT}https://www.youtube.com/@TechCode9${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}Don't forget to Like, Share and Subscribe for more Videos${RESET_FORMAT}"
