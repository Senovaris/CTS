statusDB = statusDB or {
  enabled = true,
  x = 0,
  y = 0,
  combatStatusLocked = true,
  font = "Fonts\\FRIZQT__.TTF",
  size = 14
}

CTS = CTS or {}

status = CreateFrame("Frame", "CombatStatus", UIParent, "BackdropTemplate")
status:SetSize(200, 80)
status:SetPoint("CENTER", UIParent, "CENTER", statusDB.x, statusDB.y)

-- Make draggable
status:SetMovable(true)
status:EnableMouse(false)
status:RegisterForDrag("LeftButton")
status:SetClampedToScreen(true)

status:SetScript("OnDragStart", function(self)
  if not statusDB.combatStatusLocked then
    self:StartMoving()
  end
end)

status:SetScript("OnDragStop", function(self)
  self:StopMovingOrSizing()
  local _, _, _, x, y = self:GetPoint()
  statusDB.x = x
  statusDB.y = y
end)

-- Backdrop setup
status:SetBackdrop({
  bgFile = "Interface/Tooltips/UI-Tooltip-Background",
  edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
  tile = true,
  tileSize = 16,
  edgeSize = 16,
  insets = { left = 2, right = 2, top = 2, bottom = 2 }
})
status:SetBackdropColor(0, 0, 0, 0)
status:SetBackdropBorderColor(0, 0, 0, 0)

local inCombatText = status:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
CTS.inCombatText = inCombatText
inCombatText:SetPoint("CENTER", status, "CENTER", 0, 10)
local font, size = inCombatText:GetFont()
inCombatText:SetFont(font, size, "OUTLINE, THIN")
inCombatText:SetText("In Combat")
inCombatText:SetTextColor(1, 0, 0, 1)
inCombatText:Hide()

local outCombatText = status:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
CTS.outCombatText = outCombatText
outCombatText:SetPoint("CENTER", status, "CENTER", 0, -10)
local font2, size2 = outCombatText:GetFont()
outCombatText:SetFont(font2, size2, "OUTLINE, THIN")
outCombatText:SetText("Out of Combat")
outCombatText:SetTextColor(0, 1, 0, 1)
outCombatText:Hide()

function CTS_UpdateStatusFont()
  local sp = statusDB.size * 1.1
  inCombatText:SetFont(statusDB.font, statusDB.size, "OUTLINE, THIN")
  outCombatText:SetFont(statusDB.font, statusDB.size, "OUTLINE, THIN")
  inCombatText:ClearAllPoints()
  inCombatText:SetPoint("CENTER", status, "CENTER", 0, sp / 2)
  outCombatText:ClearAllPoints()
  outCombatText:SetPoint("CENTER", status, "CENTER", 0, -sp / 2)
end

status:RegisterEvent("PLAYER_REGEN_DISABLED")
status:RegisterEvent("PLAYER_REGEN_ENABLED")
status:RegisterEvent("PLAYER_LOGIN")

local inCombatTimer
local outCombatTimer

status:SetScript("OnEvent", function(self, event)
  if event == "PLAYER_LOGIN" then
    local LEM = LibStub('LibEditMode')

    if LEM then
      local function onPositionChanged(frame, layoutName, point, x, y)
        if not statusDB.layouts then
          statusDB.layouts = {}
        end
        if not statusDB.layouts[layoutName] then
          statusDB.layouts[layoutName] = {}
        end

        statusDB.layouts[layoutName].point = point
        statusDB.layouts[layoutName].x = x
        statusDB.layouts[layoutName].y = y
      end

      local defaultPosition = {
        point = 'CENTER',
        x = 0,
        y = 0,
      }

      LEM:RegisterCallback('layout', function(layoutName)
        if not statusDB.layouts then
          statusDB.layouts = {}
        end
        if not statusDB.layouts[layoutName] then
          statusDB.layouts[layoutName] = {point = "CENTER", x = 0, y = 0}
        end

        status:ClearAllPoints()
        status:SetPoint(
          statusDB.layouts[layoutName].point or "CENTER",
          UIParent, 
          statusDB.layouts[layoutName].point or "CENTER",
          statusDB.layouts[layoutName].x or 0,
          statusDB.layouts[layoutName].y or 0)
        end)
        LEM:AddFrame(status, onPositionChanged, defaultPosition)
      end

    elseif event == "PLAYER_REGEN_DISABLED" then
      if inCombatTimer then
        inCombatTimer:Cancel()
      end
      inCombatText:Show()

      inCombatTimer = C_Timer.NewTimer(2, function()
        inCombatText:Hide()
      end)

    elseif event == "PLAYER_REGEN_ENABLED" then
      if outCombatTimer then
        outCombatTimer:Cancel()
      end
      outCombatText:Show()

      outCombatTimer = C_Timer.NewTimer(2, function()
        outCombatText:Hide()
      end)
    end
  end)
