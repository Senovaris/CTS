timerDB = timerDB or {
  enabled = true,
  x = 0,
  y = -55,
  locked = true,
  font = "Interface\\AddOns\\CTS\\Media\\fonts\\Expressway.ttf",
  size = 14
}

timer = CreateFrame("Frame", "CombatTimer", UIParent, "BackdropTemplate")
timer:SetSize(100, 20)
timer:SetPoint("CENTER", UIParent, "CENTER", timerDB.x, timerDB.y)
timer:SetMovable(true)
timer:EnableMouse(false)
timer:RegisterForDrag("LeftButton")
timer:SetClampedToScreen(true)

timer:SetScript("OnDragStart", function(self)
  if not timerDB.locked then
    self:StartMoving()
  end
end)

timer:SetScript("OnDragStop", function(self)
  self:StopMovingOrSizing()

  local _, _, _, x, y = self:GetPoint()
  timerDB.x = x
  timerDB.y = y
end)

if not timer.NineSlice then
  timer:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 16,
    insets = { left = 2, right = 2, top = 2, bottom = 2 }
  })
  timer:SetBackdropColor(0.05, 0.05, 0.08, 0.95)
  timer:SetBackdropBorderColor(0.73, 0.60, 0.97, 1)
end

timer:SetBackdropColor(0, 0, 0, 0)
timer:SetBackdropBorderColor(0, 0, 0, 0)



timerText = timer:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
timerText:SetPoint("CENTER", timer, "CENTER", 0, 0)
local font, size = timerText:GetFont()
-- timerText:SetFont(timerDB.font, timerDB.size, "OUTLINE, THIN") -- Not Needed but kept in for safety
timerText:SetText("[0.00]")
timerText:SetTextColor(1, 1, 1, 1) -- White
timerText:Hide()

function CTS_UpdateTimerFont()
  timerText:SetFont(timerDB.font, timerDB.size, "OUTLINE, THIN")
end

timer:RegisterEvent("PLAYER_REGEN_DISABLED")
timer:RegisterEvent("PLAYER_REGEN_ENABLED")
timer:RegisterEvent("PLAYER_LOGIN")

local combatStartTime

timer:SetScript("OnEvent", function(self, event)
  if event == "PLAYER_LOGIN" then
    timerDB = timerDB or {
      enabled = true,
      x = 0,
      y = 55,
      locked = true,
      font = "Interface\\AddOns\\CTS\\Media\\fonts\\Expressway.ttf",
      size = 14
    }

    timer:ClearAllPoints()
    timer:SetPoint("CENTER", UIParent, "CENTER", timerDB.x, timerDB.y)
    CTS_UpdateTimerFont()

    local LEM = LibStub('LibEditMode')

    if LEM then
      local function onPositionChanged(frame, layoutName, point, x, y)
        if not timerDB.layouts then
          timerDB.layouts = {}
        end
        if not timerDB.layouts[layoutName] then
          timerDB.layouts[layoutName] = {}
        end

        timerDB.layouts[layoutName].point = point
        timerDB.layouts[layoutName].x = x
        timerDB.layouts[layoutName].y = y
      end

      local defaultPosition = {
        point = 'CENTER',
        x = 0,
        y = 0,
      }

      LEM:RegisterCallback('layout', function(layoutName)
        if not timerDB.layouts then
          timerDB.layouts = {}
        end
        if not timerDB.layouts[layoutName] then
          timerDB.layouts[layoutName] = {point = "CENTER", x = 0, y = 0}
        end

        timer:ClearAllPoints()
        timer:SetPoint(
          timerDB.layouts[layoutName].point or "CENTER",
          UIParent,
          timerDB.layouts[layoutName].point or "CENTER", 
          timerDB.layouts[layoutName].x or 0,
          timerDB.layouts[layoutName].y or 0)
        end)
        LEM:AddFrame(timer, onPositionChanged, defaultPosition)
      end

    elseif event == "PLAYER_REGEN_DISABLED" then
      combatStartTime = GetTime()
      timerText:Show()
      timer:SetBackdropColor(0, 0, 0, 0)
      timer:SetBackdropBorderColor(0, 0, 0, 0)

    elseif event == "PLAYER_REGEN_ENABLED" then
      combatStartTime = nil
      timerText:Hide()
      if not timerDB.locked then
        timer:SetBackdropColor(0.05, 0.05, 0.08, 0.95)
        timer:SetBackdropBorderColor(0.73, 0.60, 0.97, 1)
      end
    end
  end)
  timer:SetScript("OnUpdate", function (self, elapsed)
    if combatStartTime then
      local elapsedTime = GetTime() - combatStartTime
      local minutes = math.floor(elapsedTime / 60)
      local seconds = math.floor(elapsedTime % 60)
      timerText:SetText(string.format("[%d:%02d]", minutes, seconds))
    end
  end)
