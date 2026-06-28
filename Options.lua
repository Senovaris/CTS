local ADDON_NAME, namespace = ...
local kFTS = namespace.localeFont

AursUI.SetTheme(1, 0.4, 0)

local fO = {
  {name = "Expressway", value = "Interface\\AddOns\\CTS\\Media\\fonts\\Expressway.ttf"},
  {name = "Monas", value = "Interface\\AddOns\\CTS\\Media\\fonts\\Monas.ttf"},
  {name = "Accidental Presidency", value = "Interface\\AddOns\\CTS\\Media\\fonts\\Accidental_Presidency.ttf"},
  {name = "Action Man", value = "Interface\\AddOns\\CTS\\Media\\fonts\\ActionMan.ttf"},
  {name = "Continuum Medium", value = "Interface\\AddOns\\CTS\\Media\\fonts\\ContinuumMedium.ttf"},
  {name = "Die Die Die", value = "Interface\\AddOns\\CTS\\Media\\fonts\\DieDieDie.ttf"},
  {name = "Homespun", value = "Interface\\AddOns\\CTS\\Media\\fonts\\Homespun.ttf"},
  {name = "PT Sans Narrow", value = "Interface\\AddOns\\CTS\\Media\\fonts\\PTSansNarrow.ttf"},
}
if namespace.localeFont then
  table.insert(fO, {name = "Noto Sans Korean", value = "Interface\\AddOns\\CTS\\Media\\fonts\\NotoSansKR-Regular.ttf"})
  table.insert(fO, {name = "Noto Sans Simplified Chinese", value = "Interface\\AddOns\\CTS\\Media\\fonts\\NotoSansSC-Regular.ttf"})
  table.insert(fO, {name = "Noto Sans Traditional Chinese", value = "Interface\\AddOns\\CTS\\Media\\fonts\\NotoSansTC-Regular.ttf"})
end



-- Pre stuff loaded

local panel = AursUI.CreatePanel(340, 400, "CTS Options")

local tabs, UpdateTabs = AursUI.CreateTabs(panel, { "Combat Timer", "Combat Status" })

local L1 = AursUI.NewLayout(tabs[1].content, 16, -10)

local eCT = L1:Row({
  { type = "check", label = "Enable Combat Timer",
  getValue = function() return timerDB.enabled end,
  setValue = function(val)
    timerDB.enabled = val
    if val then timer:Show() else timer:Hide() end
  end
},
{ type = "button", label = "Show / Hide",
onClick = function()
  if timerText:IsShown() then
    timerText:Hide()
  else
    timerText:Show()
    CTS_UpdateTimerFont()
  end
end,
width = 90
    },
  }
)

L1:Space(12)
L1:Separator()
L1:Space(22)

tSS = L1:Slider("Font Size", 8, 60,
function() return timerDB.size end,
function(val)
  timerDB.size = val
  if CTS_UpdateTimerFont then CTS_UpdateTimerFont() end
end)
L1:Separator()

tFD = L1:Dropdown(fO,
function() return timerDB.font or "Interface\\AddOns\\CTS\\Media\\fonts\\Expressway.ttf" end,
function(val)
  timerDB.font = val
  if CTS_UpdateTimerFont then CTS_UpdateTimerFont() end
end,
220
)

local L2 = AursUI.NewLayout(tabs[2].content, 16, -10)

local showStatusText = false

local eCS = L2:Row({
  { type = "check", label = "Enable Combat Status",
  getValue = function() return statusDB.enabled end,
  setValue = function(val)
    statusDB.enabled = val
    if val then status:Show() else status:Hide() end
  end
},
{ type = "button", label = "Show / Hide",
onClick = function()
  status:SetScript("OnUpdate", nil)
  if not showStatusText then
    CTS.inCombatText:Show()
    CTS.inCombatText:SetAlpha(1)
    CTS.outCombatText:Show()
    CTS.outCombatText:SetAlpha(1)
    showStatusText = true
  else
    CTS.inCombatText:Hide()
    CTS.outCombatText:Hide()
    showStatusText = false
  end
end,
width = 90
    },
  }
)

tFT = L2:Check("Toggle Fade Animation",
function() return statusDB.fadeToggle end,
function(val)
  statusDB.fadeToggle = val
  fadeToggle = val
end)

L2:Separator()
L2:Space(22)

cSS = L2:Slider("Combat text size", 8, 60,
function() return statusDB.size end,
function(val) statusDB.size = val
  if CTS_UpdateStatusFont then CTS_UpdateStatusFont()
  end
end)

L2:Separator()
L2:Space(22)

sFD = L2:Dropdown(fO,
function() return statusDB.font or "Interface\\AddOns\\CTS\\Media\\fonts\\Expressway.ttf" end,
function(val)
  statusDB.font = val
  if CTS_UpdateStatusFont then CTS_UpdateStatusFont() end
end,
220
)

if kFTS then
  sFD:SetAlpha(0.4)
  sFD:EnableMouse(false)
end

panel:SetScript("OnShow", function()
  eCT.SetChecked(timerDB.enabled)
  tSS.SetValue(timerDB.size)
  tFD.SetSelected(timerDB.font or "Interface\\AddOns\\CTS\\Media\\fonts\\Expressway.ttf")
  eCS.SetChecked(statusDB.enabled)
  tFT.SetChecked(statusDB.fadeToggle)
  cSS.SetValue(statusDB.size)
  sFD.SetSelected(kFTS or statusDB.font or "Interface\\AddOns\\CTS\\Media\\fonts\\Expressway.ttf")
  UpdateTabs()
end)

SLASH_CTS1 = "/cts"
SlashCmdList["CTS"] = function()
  panel.Toggle()
end
