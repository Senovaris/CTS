local ADDON_NAME = "CTS"

local cts = CreateFrame("Frame", "CTSPanel", UIParent, "BackdropTemplate")
cts:SetSize(320, 320)
cts:SetPoint("CENTER")
cts:SetMovable(true)
cts:EnableMouse(true)
cts:RegisterForDrag("LeftButton")
cts:SetClampedToScreen(true)
cts:SetScript("OnDragStart", function(self) self:StartMoving() end)
cts:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
cts:SetBackdrop({
  bgFile = "Interface/Tooltips/UI-Tooltip-Background",
  edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
  tile = true,
  tileSize = 16,
  edgeSize = 16,
  insets = { left = 4, right = 4, top = 4, bottom = 4 },
})
cts:SetBackdropColor(0, 0, 0, 0.9)
cts:SetBackdropBorderColor(0, 0.6, 0.8, 0.8)
cts:Hide()

local title = cts:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
title:SetPoint("TOP", 0, -10)
title:SetText("|cff00d9ff" .. ADDON_NAME .. " Options|r")
title:SetTextColor(1, 1, 1, 1)

local editModeButton = CreateFrame("Button", nil, cts, "UIPanelButtonTemplate")
editModeButton:SetPoint("TOP", -110, -7)
editModeButton:SetSize(80, 22)
editModeButton:SetText("Edit Mode")
editModeButton:SetScript("OnClick", function()
  if EditModeManagerFrame:IsShown() then
    EditModeManagerFrame:Hide()
  else
    EditModeManagerFrame:Show()
  end
end)


local closeButton = CreateFrame("Button", nil, cts, "UIPanelCloseButton")
closeButton:SetPoint("TOPRIGHT", cts, "TOPRIGHT", -5, -5)


local activeTab = 1
local tabs = {}

local function CreateTabButton(parent, index, name, xOffset)
  local tab = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
  tab:SetSize(145, 30)
  tab:SetPoint("TOPLEFT", xOffset, -30)
  tab:SetText(name)

  tab:SetScript("OnClick", function()
    activeTab = index
    UpdateTabs()
  end)

  return tab
end
local function CreateTabContent(parent)
  local content = CreateFrame("Frame", nil, parent)
  content:SetPoint("TOPLEFT", 10, -70)
  content:SetPoint("BOTTOMRIGHT", -10, 10)
  content:Hide()
  return content
end

tabs[1] = {
  button = CreateTabButton(cts, 1, "Combat Timer", 10),
  content = CreateTabContent(cts)
}

tabs[2] = {
  button = CreateTabButton(cts, 2, "Combat Status", 155),
  content = CreateTabContent(cts)
}

function UpdateTabs()
  for i, tab in ipairs(tabs) do
    if i == activeTab then
      tab.button:GetFontString():SetTextColor(1, 0.82, 0, 1)
      tab.content:Show()
    else
      tab.button:GetFontString():SetTextColor(0.7, 0.7, 0.7, 1)
      tab.content:Hide()
    end
  end
end

UpdateTabs()


-- Make the slider --
local function CreateSlider(parent, label, yOffset, min, max, getValue, setValue)
  local slider = CreateFrame("Slider", nil, parent, "OptionsSliderTemplate")
  slider:SetPoint("TOPLEFT", 20, yOffset)
  slider:SetMinMaxValues(min, max)
  slider:SetValue(getValue())
  slider:SetValueStep(1)
  slider:SetObeyStepOnDrag(true)
  slider:SetWidth(200)

  slider.Text:SetText(label)
  slider.Low:SetText(min)
  slider.High:SetText(max)

  local valueText = slider:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
  valueText:SetPoint("TOP", slider, "BOTTOM", 0, 0)
  valueText:SetText(getValue())

  slider:SetScript("OnValueChanged", function(_, value)
    value = math.floor(value)
    valueText:SetText(value)
    setValue(value)
    UpdateDisplay(true)
  end)

  return slider
end

-- Make them checkboxes --
local function CreateCheckbox(parent, label, yOffset, getValue, setValue)
  local en = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
  en:SetPoint("TOPLEFT", 20, yOffset)
  local text = en:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  text:SetPoint("LEFT", en, "RIGHT", 5, 0)
  text:SetText(label)
  en:SetChecked(getValue())
  en:SetScript("OnClick", function(self)
    setValue(self:GetChecked())
  end)
  return en
end

-- Button --
local function CreateButton(parent, _, yOffset, onClickFunc)
  local ttb = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
  ttb:SetSize(80, 22)
  ttb:SetPoint("TOPLEFT", 200, yOffset)
  local ttt = ttb:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  ttt:SetPoint("CENTER", ttb, "CENTER", 0, 0)
  ttt:SetText("Show/Hide")
  ttb:SetScript("OnClick", onClickFunc)

  return ttb
end

-- Fonts --
local function CreateDropdown(parent, label, yOffset, options, getValue, setValue)
  local dp = CreateFrame("Frame", nil, parent, "UIDropDownMenuTemplate")
  dp:SetPoint("TOPLEFT", 10, yOffset)

  local lt = dp:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  lt:SetPoint("BOTTOMLEFT", dp, "TOPLEFT", 20, 3)
  lt:SetText(label)

  UIDropDownMenu_SetWidth(dp, 200)
  UIDropDownMenu_Initialize(dp, function(self, level)
    for i, option in ipairs(options) do
      local info = UIDropDownMenu_CreateInfo()
      info.text = option.name
      info.value = option.value
      info.func = function()
        setValue(option.value)
        UIDropDownMenu_SetText(dp, option.name)
      end
      info.checked = (getValue() == option.value)
      UIDropDownMenu_AddButton(info)
    end
  end)

  for i, option in ipairs(options) do
    if getValue() == option.value then
      UIDropDownMenu_SetText(dp, option.name)
      break
    end
  end

  return dp
end

local fO = {
  {name = "Expressway", value = "Interface\\AddOns\\CTS\\Media\\fonts\\Expressway.ttf"},
  {name = "Monas", value = "Interface\\AddOns\\CTS\\Media\\fonts\\Monas.ttf"},
  {name = "Accidental Presidency", value = "Interface\\AddOns\\CTS\\Media\\fonts\\Accidental_Presidency.ttf"},
  {name = "Action Man", value = "Interface\\AddOns\\CTS\\Media\\fonts\\ActionMan.ttf"},
  {name = "Continuum Medium", value = "Interface\\AddOns\\CTS\\Media\\fonts\\ContinuumMedium.ttf"},
  {name = "Die Die Die", value = "Interface\\AddOns\\CTS\\Media\\fonts\\DieDieDie.ttf"},
  {name = "Homespun", value = "Interface\\AddOns\\CTS\\Media\\fonts\\Homespun.ttf"},
  {name = "PT Sans Narrow", value = "Interface\\AddOns\\CTS\\Media\\fonts\\PTSansNarrow.ttf"}
}

-- Add the things to the things [Tab 1] --
tSS = CreateSlider(tabs[1].content, "Timer Font Size", -140, 8, 60,
function() return timerDB.size end,
function(val) timerDB.size = val
  if CTS_UpdateTimerFont then
    CTS_UpdateTimerFont()
  end
end)

eCT = CreateCheckbox(tabs[1].content,"Enable Combat Timer", -10,
function() return timerDB.enabled end,
function(val)
  timerDB.enabled = val
  if val then
    timer:Show()
  else
    timer:Hide()
  end
end)

tFD = CreateDropdown(tabs[1].content, "Timer Font", -70, fO,
function() return timerDB.font or "Interface\\AddOns\\CTS\\Media\\fonts\\Expressway.ttf" end,
function(val)
  timerDB.font = val
  if CTS_UpdateTimerFont then
    CTS_UpdateTimerFont()
  end
end)

tFD:SetScript("OnShow", function(self)
  local cF = timerDB.font or "Interface\\AddOns\\CTS\\Media\\fonts\\Expressway.ttf"
  for i, option in ipairs(fO) do
    if option.value == cF then
      UIDropDownMenu_SetText(self, option.name)
      break
    end
  end
end)

-- Add the things to the things [Tab 2] --
cSS = CreateSlider(tabs[2].content, "Combat Status Size", -140, 8, 60,
function() return statusDB.size end,
function(val) statusDB.size = val
  if CTS_UpdateStatusFont then
    CTS_UpdateStatusFont()
  end
end)

eCS = CreateCheckbox(tabs[2].content,"Enable Combat Status", -10,
function() return statusDB.enabled end,
function(val)
  statusDB.enabled = val
  if val then
    status:Show()
  else
    status:Hide()
  end
end)

sFD = CreateDropdown(tabs[2].content, "Timer Font", -70, fO,
function() return statusDB.font or "Interface\\AddOns\\CTS\\Media\\fonts\\Expressway.ttf" end,
function(val)
  statusDB.font = val
  if CTS_UpdateStatusFont then
    CTS_UpdateStatusFont()
  end
end)

sFD:SetScript("OnShow", function(self)
  local sF = statusDB.font or "Interface\\AddOns\\CTS\\Media\\fonts\\Expressway.ttf"
  for i, option in ipairs(fO) do
    if option.value == sF then
      UIDropDownMenu_SetText(self, option.name)
      break
    end
  end
end)

CreateButton(tabs[1].content, "TimerShow", -12, function()
  if timerText:IsShown() then
    timerText:Hide()
  else
    timerText:Show()
    CTS_UpdateTimerFont()
  end
end)

CreateButton(tabs[2].content, "StatusShow", -12, function()
  if CTS.inCombatText:IsShown() and CTS.outCombatText:IsShown() then
    CTS.inCombatText:Hide()
    CTS.outCombatText:Hide()
  else
    CTS.inCombatText:Show()
    CTS.outCombatText:Show()
  end
end)

SLASH_CTS1 = "/cts"
SlashCmdList["CTS"] = function()
  if cts:IsShown() then
    cts:Hide()
  else
    cts:Show()
  end
end

cts:SetScript("OnShow", function()
  eCT:SetChecked(timerDB.enabled)
  eCS:SetChecked(statusDB.enabled)
  cSS:SetValue(statusDB.size)
  tSS:SetValue(timerDB.size)
end)

C_Timer.After(1, function()
  print("|cff00d9ffCTS loaded!|r|cffFFFFFF Type /cts for options|r")
end)
