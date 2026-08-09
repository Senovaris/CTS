local _, namespace = ...

local L = setmetatable({}, {
	__index = function(t, k)
		local v = tostring(k)
		rawset(t, k, v)
		return v
	end,
})

namespace.L = L

-- local LOCALE = GetLocale()
local LOCALE = "zhTW" -- force locale for testing

if LOCALE == "enUS" then
	-- English is the default, no translations needed
	return
end

if LOCALE == "deDE" then
	L["In Combat"] = "Im Kampf"
	L["Out of Combat"] = "Außerhalb des Kampfes"
	return
end

if LOCALE == "frFR" then
	L["In Combat"] = "En combat"
	L["Out of Combat"] = "Hors combat"
	return
end

if LOCALE == "esES" or LOCALE == "esMX" then
	L["In Combat"] = "En combate"
	L["Out of Combat"] = "Fuera de combate"
	return
end

if LOCALE == "ptBR" then
	L["In Combat"] = "Em Combate"
	L["Out of Combat"] = "Fora de Combate"
	return
end

if LOCALE == "ruRU" then
	L["In Combat"] = "В бою"
	L["Out of Combat"] = "Вне боя"
	L["CTS Options"] = "Настройки CTS"
	L["Combat Timer"] = "Таймер боя"
	L["Combat Status"] = "Статус боя"
	L["Show / Hide"] = "Видимость"
	L["Enable Combat Timer"] = "Включить таймер боя"
	L["Font Size"] = "Размер шрифта"
	L["Enable Combat Status"] = "Включить статус боя"
	L["Toggle Fade Animation"] = "Вкл./выкл. анимацию"
	L["Combat text size"] = "Размер текста боя"
	L["Enable Only Out of Combat text"] = "Показывать текст только вне боя"

	namespace.localeFont = "Interface\\AddOns\\CTS\\Media\\fonts\\Expressway.ttf"
	return
end

if LOCALE == "koKR" then
	L["In Combat"] = "전투 시작"
	L["Out of Combat"] = "전투 종료"
	L["CTS Options"] = "CTS 옵션"
	L["Combat Timer"] = "전투 타이머"
	L["Combat Status"] = "전투 상태"
	L["Show / Hide"] = "표시 / 숨기기"
	L["Enable Combat Timer"] = "전투 타이머 활성화"
	L["Font Size"] = "글자 크기"
	L["Enable Combat Status"] = "전투 상태 활성화"
	L["Toggle Fade Animation"] = "페이드 애니메이션 토글"
	L["Combat text size"] = "전투 텍스트 크기"
	L["Enable Only Out of Combat text"] = "‘전투 외’ 텍스트만 표시하도록 설정"

	namespace.localeFont = "Interface\\AddOns\\CTS\\Media\\fonts\\NotoSansKR-Regular.ttf"
	return
end

if LOCALE == "zhCN" then
	L["In Combat"] = "战斗中"
	L["Out of Combat"] = "脱离战斗"
	L["CTS Options"] = "CTS 设置"
	L["Combat Timer"] = "战斗计时器"
	L["Combat Status"] = "战斗状态"
	L["Show / Hide"] = "显示 / 隐藏"
	L["Enable Combat Timer"] = "启用战斗计时器"
	L["Font Size"] = "字体大小"
	L["Enable Combat Status"] = "启用战斗状态"
	L["Toggle Fade Animation"] = "切换淡入淡出动画"
	L["Combat text size"] = "战斗文字大小"
	L["Enable Only Out of Combat text"] = "仅在脱离战斗时显示文字"

	namespace.localeFont = "Interface\\AddOns\\CTS\\Media\\fonts\\NotoSansSC-Regular.ttf"
	return
end

if LOCALE == "zhTW" then
	L["In Combat"] = "戰鬥中"
	L["Out of Combat"] = "脫離戰鬥"
	L["CTS Options"] = "CTS 設定"
	L["Combat Timer"] = "戰鬥計時器"
	L["Combat Status"] = "戰鬥狀態"
	L["Show / Hide"] = "顯示 / 隱藏"
	L["Enable Combat Timer"] = "啟用戰鬥計時器"
	L["Font Size"] = "字體大小"
	L["Enable Combat Status"] = "啟用戰鬥狀態"
	L["Toggle Fade Animation"] = "切換淡入淡出動畫"
	L["Combat text size"] = "戰鬥文字大小"
	L["Enable Only Out of Combat text"] = "僅在脫離戰鬥時顯示文字"

	namespace.localeFont = "Interface\\AddOns\\CTS\\Media\\fonts\\NotoSansTC-Regular.ttf"
	return
end
