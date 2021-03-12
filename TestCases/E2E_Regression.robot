*** Settings ***
Library  Selenium2Library
Library  String    

#Resource    ../Resource/common.robot

*** Variables ***
${URL}    https://portal.uat.feedback180.com/auth/login
${BROWSER}    chrome 

${SurveyName}    E2E_RegressionTest

# Elements Login page
${InputUserName}    xpath=//input[@type='text']
${InputPassword}    xpath=//input[@type='password']
${btnSubmit}    xpath=//button[@class='bt-signIn appearance-filled full-width size-giant status-primary shape-round nb-transition']

# Elements Portal page
${genericDB_Text}    xpath=//nb-card-header//span
${Menu_CustomerInsight}    xpath=//a[@title='Customer Insight']
${Menu_Customers}    xpath=//a[@title='Customers']
${Menu_Users}    xpath=//a[@title='Users']
${Menu_GetFeedback}    xpath=//a[@title='GetFeedback']
${SwitchApp_GetFeedback}    xpath=//nb-card-body/div[1]/div[1]/a[1]
${Menu_CaseManagement}    xpath=//a[@title='Case Management']
${SwitchApp_CaseManagement}    xpath=//nb-card-body/div[1]/div[2]/a[1]
${btnSwitchApp}    xpath=//nb-actions[1]/nb-action[1]/button[1]

# Elements GetFeedback
${SurveyList}    xpath=//div[@id='c1']
${SurveySetup}    xpath=//div[@id='c2']
${Monitor}    xpath=//div[@id='c3']
${Home}    xpath=//div[@class='logo']
${btnNewSurvey}    xpath=//button[@class='btn btn-create-survey']
${InputSurveyName}    xpath=//input[@name='survey_name']
${btnConfirm}    xpath=//div[@class='modal-dialog modal-md']//button[@class='btn btn-confirm']
${stepPublished}    xpath=//div//div[@class='stepper-content'][3]//button
${btnPublished}    xpath=//button[@class='btn btn-publish']
${InputPublishName}    xpath=//input[@id='publish-name']
${btnSave}    xpath=//app-modal[@name='bs-example-modal-lg']//button[@class='btn btn-confirm']
${SurveyListTest}    xpath=//div[@class='x_content']//tr//span[contains(text(),'${SurveyName}')]
${PublishKey}    xpath=//div[@class='form-group']//label[@class='control-label publishkey-label']
${Loading}    xpath=//body/app-backdrop[1]/div[1]/div[1]/*[1]

# Elements Survey Conduct
${btnStart}    xpath=//button[@class='survey_button button_start']

*** Test Cases ***        
TC01 - Login
    Login
TC02 - GetFeedback        
    GetFeedback
    
*** Keywords ***
Login
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    ${btnSubmit}    20  
    Input Text    ${InputUserName}    saringkan@fb180.com 
    Input Text    ${InputPassword}    Z5AHUd 
    Click Button    ${btnSubmit}
    Wait Until Page Contains Element    ${Menu_CustomerInsight}    20
    # Verify (Text and Link)
    Element Text Should Be    ${genericDB_Text}    Generic dashboard
    Page Should Contain Link    ${Menu_CustomerInsight}   https://portal.uat.feedback180.com/admin/dashboard-customize             
    Page Should Contain Link    ${Menu_Customers}  https://portal.uat.feedback180.com/admin/customer/list 
    Page Should Contain Link    ${Menu_Users}  https://portal.uat.feedback180.com/admin/user/list
    Wait Until Page Contains Element    ${btnSwitchApp}    20  
    
GetFeedback 
    Click Button    ${btnSwitchApp}
    Wait Until Page Contains Element     ${SwitchApp_GetFeedback}     20
    Click Element    ${SwitchApp_GetFeedback}  
    Wait Until Page Contains Element    ${SurveyList}    20
    Wait Until Element Is Enabled    ${SurveyList}   
    Element Text Should Be    ${SurveyList}    Survey List 
    Element Text Should Be    ${SurveySetup}    Survey Setup
    Element Text Should Be    ${Monitor}    Monitor
    #Sleep    1s    
    Click Button    ${btnNewSurvey} 
    Sleep    1s
    Wait Until Page Contains Element    ${InputSurveyName}    20
    Wait Until Element Is Enabled    ${InputSurveyName}
    Input Text    ${InputSurveyName}    ${SurveyName}    
    Click Button    ${btnConfirm}
    Sleep    2s
    Reload Page
    Sleep    2s
      
    Wait Until Location Does Not Contain    ${Loading}       
    Wait Until Element Is Enabled    ${SurveyList}
    #Wait Until Page Contains Element    ${SurveyList}    20
    Click Button    ${SurveyList} 
    #Sleep    1s    
    #Wait Until Page Contains Element    ${SurveyListTest}    20
    Wait Until Location Does Not Contain    ${Loading} 
    Wait Until Element Is Enabled    ${SurveyListTest}
    Click Element    ${SurveyListTest}    
    
    ################
    # Setup survey #
    ################
    
    #Sleep    1s
    #Wait Until Page Contains Element    ${stepPublished}    20
    Wait Until Location Does Not Contain    ${Loading} 
    Wait Until Element Is Enabled    ${stepPublished}
    Click Button    ${stepPublished} 
    #Sleep    1s
    #Wait Until Page Contains Element    ${btnPublished}    20
    Wait Until Location Does Not Contain    ${Loading} 
    Wait Until Element Is Enabled    ${btnPublished}
    Click Button    ${btnPublished}   
    Sleep    1s
    Wait Until Page Contains Element    ${InputPublishName}    20 
    #Wait Until Element Is Enabled    ${InputPublishName}
    Input Text    ${InputPublishName}    ${SurveyName}  
    Click Button    ${btnSave}
    Wait Until Location Does Not Contain   ${Loading}
    Wait Until Element Is Enabled    ${PublishKey}
    #Wait Until Page Contains Element    ${PublishKey}    20 
    #Sleep    1s
    ${KeyS}    Get Text    ${PublishKey}
    Log    ${KeyS}
    ${Key}    Get Substring    ${KeyS}    0    11
    #Log   https://surveyconductapp-uat.azurewebsites.net/${Key} 
    Open Browser    https://surveyconductapp-uat.azurewebsites.net/${Key}    chrome
    #Sleep    3s
    Wait Until Element Is Enabled    ${btnStart}
    #Wait Until Page Contains Element    ${btnStart}    20 
    Close Browser
    Open Browser    https://surveyconductapp-uat.azurewebsites.net/${Key}    chrome
    #Sleep    3s
    Wait Until Element Is Enabled    ${btnStart}
    #Wait Until Page Contains Element    ${btnStart}    20
    Click Button    ${btnStart}     
    Close Browser
    Sleep    2s
    #Click Button    ${stepPublished}
    
    #Switch Window    
    
    

    
    
   
    
         


    
