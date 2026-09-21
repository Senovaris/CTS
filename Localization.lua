local _, namespace = ...

local L = setmetatable({}, {
	__index = function(t, k)
		local v = tostring(k)
		rawset(t, k, v)
		return v
	end,
})

namespace.L = L

local LOCALE = GetLocale()

-- local LOCALE = "frFR" -- force locale for testing

if LOCALE == "enUS" then
	return
end

if LOCALE == "deDE" then
	L["In Combat"] = "Im Kampf"
	L["Out of Combat"] = "Außerhalb des Kampfes"
	L["CTS Options"] = "CTS Optionen"
	L["Combat Timer"] = "Kampf-Timer"
	L["Combat Status"] = "Kampfstatus"
	L["Show / Hide"] = "Sichtbarkeit"
	L["Enable Combat Timer"] = "Kampf-Timer aktivieren"
	L["Font Size"] = "Schriftgröße"
	L["Enable Combat Status"] = "Kampfstatus aktivieren"
	L["Toggle Fade Animation"] = "Fade-Animation umschalten"
	L["Combat text size"] = "Größe des Kampftexts"
	L["Enable Only Out of Combat text"] = "Text nur außerhalb des Kampfes anzeigen"
	return
end

if LOCALE == "frFR" then
	L["In Combat"] = "En combat"
	L["Out of Combat"] = "Hors combat"
	L["CTS Options"] = "Options de CTS"
	L["Combat Timer"] = "Minuteur de combat"
	L["Combat Status"] = "État du combat"
	L["Show / Hide"] = "Visibilité"
	L["Enable Combat Timer"] = "Activer le minuteur"
	L["Font Size"] = "Taille de police"
	L["Enable Combat Status"] = "Activer l'état du combat"
	L["Toggle Fade Animation"] = "Activer/désactiver l'animation"
	L["Combat text size"] = "Taille du texte de combat"
	L["Enable Only Out of Combat text"] = "Afficher le texte uniquement hors combat"
	return
end

if LOCALE == "esES" or LOCALE == "esMX" then
	L["In Combat"] = "En combate"
	L["Out of Combat"] = "Fuera de combate"
	L["CTS Options"] = "Opciones de CTS"
	L["Combat Timer"] = "Temporizador de combate"
	L["Combat Status"] = "Estado de combate"
	L["Show / Hide"] = "Visibilidad"
	L["Enable Combat Timer"] = "Activar temporizador"
	L["Font Size"] = "Tamaño de fuente"
	L["Enable Combat Status"] = "Activar estado"
	L["Toggle Fade Animation"] = "Activar/desactivar la animación"
	L["Combat text size"] = "Tamaño del texto de combate"
	L["Enable Only Out of Combat text"] = "Mostrar texto solo fuera de combate"
	return
end

if LOCALE == "ptBR" then
	L["In Combat"] = "Em Combate"
	L["Out of Combat"] = "Fora de Combate"
	L["CTS Options"] = "Opções do CTS"
	L["Combat Timer"] = "Temporizador de Combate"
	L["Combat Status"] = "Status de Combate"
	L["Show / Hide"] = "Visibilidade"
	L["Enable Combat Timer"] = "Ativar temporizador"
	L["Font Size"] = "Tamanho da Fonte"
	L["Enable Combat Status"] = "Ativar status"
	L["Toggle Fade Animation"] = "Alternar Animação"
	L["Combat text size"] = "Tamanho do Texto de Combate"
	L["Enable Only Out of Combat text"] = "Mostrar texto apenas fora de combate"
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
