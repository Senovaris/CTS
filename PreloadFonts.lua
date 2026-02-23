local fonts = {
  "Interface\\AddOns\\CTS\\Media\\fonts\\Expressway.ttf",
  "Interface\\AddOns\\CTS\\Media\\fonts\\Monas.ttf",
  "Interface\\AddOns\\CTS\\Media\\fonts\\Accidental_Presidency.ttf",
  "Interface\\AddOns\\CTS\\Media\\fonts\\ActionMan.ttf",
  "Interface\\AddOns\\CTS\\Media\\fonts\\ContinuumMedium.ttf",
  "Interface\\AddOns\\CTS\\Media\\fonts\\DieDieDie.ttf",
  "Interface\\AddOns\\CTS\\Media\\fonts\\Homespun.ttf",
  "Interface\\AddOns\\CTS\\Media\\fonts\\PTSansNarrow.ttf",
  "Interface\\AddOns\\CTS\\Media\\fonts\\NotoSansKR-Regular.ttf",
  "Interface\\AddOns\\CTS\\Media\\fonts\\NotoSansSC-Regular.ttf",
  "Interface\\AddOns\\CTS\\Media\\fonts\\NotoSansTC-Regular.ttf"
}

local preloader = CreateFrame("Frame")
local fontStrings = {}

preloader:RegisterEvent("PLAYER_ENTERING_WORLD")
preloader:SetScript("OnEvent", function(self, event)
  if event == "PLAYER_ENTERING_WORLD" then
    for i, fontPath in ipairs(fonts) do
      local fs = UIParent:CreateFontString(nil, "OVERLAY")
      fs:SetFont(fontPath, 14, "OUTLINE")
      fs:SetText("Loading...")
      fs:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
      fs:SetAlpha(0.01)
      fontStrings[i] = fs
    end
    C_Timer.After(0.1, function()
      for _, fs in ipairs(fontStrings) do
        fs:Hide()
      end
    end)

    self:UnregisterAllEvents()
  end
end)
