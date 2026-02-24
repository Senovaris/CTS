function fade(text)
  text:SetAlpha(0)
  text:Show()
  local phase = "fadeIn"
  local elapsed = 0
  status:SetScript("OnUpdate", function(self, delta)
    if phase == "fadeIn" then
      elapsed = elapsed + delta
      local alpha = elapsed / 0.3
      text:SetAlpha(alpha)
      if elapsed > 0.3 then
        text:SetAlpha(1)
        phase = "hold"
        elapsed = 0
      end
    elseif phase == "hold" then
      elapsed = elapsed + delta
      if elapsed > 1.6 then
        phase = "fadeOut"
        elapsed = 0
      end
    elseif phase == "fadeOut" then
      elapsed = elapsed + delta
      local alpha = 1 - elapsed / 0.3
      text:SetAlpha(alpha)
      if elapsed > 0.3 then
        text:SetAlpha(0)
        self:SetScript("OnUpdate", nil)
      end
    end
  end)
end
