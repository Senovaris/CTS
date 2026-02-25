local _, namespace = ...

local L = setmetatable({}, { __index = function(t, k)
  local v = tostring(k)
  rawset(t, k, v)
  return v
end })

namespace.L = L

local LOCALE = GetLocale()
-- local LOCALE = "koKR"          -- force locale for testing

if LOCALE == "enUS" then
  -- English is the default, no translations needed
  return end

  if LOCALE == "deDE" then
    L["In Combat"]      = "Im Kampf"
    L["Out of Combat"]  = "Außerhalb des Kampfes"
    return end

    if LOCALE == "frFR" then
      L["In Combat"]      = "En Combat"
      L["Out of Combat"]  = "Hors Combat"
      return end

      if LOCALE == "esES" or LOCALE == "esMX" then
        L["In Combat"]      = "En Combate"
        L["Out of Combat"]  = "Fuera de Combate"
        return end

        if LOCALE == "ptBR" then
          L["In Combat"]      = "Em Combate"
          L["Out of Combat"]  = "Fora de Combate"
          return end

          if LOCALE == "ruRU" then
            L["In Combat"]      = "В бою"
            L["Out of Combat"]  = "Вне боя"
            return end

            if LOCALE == "koKR" then
              L["In Combat"]      = "전투 시작"
              L["Out of Combat"]  = "전투 종료"
              namespace.localeFont = "Interface\\AddOns\\CTS\\Media\\fonts\\NotoSansKR-Regular.ttf"
              return end

              if LOCALE == "zhCN" then
                L["In Combat"]      = "战斗中"
                L["Out of Combat"]  = "非战斗状态"
                namespace.localeFont = "Interface\\AddOns\\CTS\\Media\\fonts\\NotoSansSC-Regular.ttf"
                return end

                if LOCALE == "zhTW" then
                  L["In Combat"]      = "戰鬥中"
                  L["Out of Combat"]  = "非戰鬥狀態"
                  namespace.localeFont = "Interface\\AddOns\\CTS\\Media\\fonts\\NotoSansTC-Regular.ttf"
                  return end
