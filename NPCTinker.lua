

-- _   _ ____   ____ _____ _       _             
--| \ | |  _ \ / ___|_   _(_)_ __ | | _____ _ __ 
--|  \| | |_) | |     | | | | '_ \| |/ / _ \ '__|
--| |\  |  __/| |___  | | | | | | |   <  __/ |   
--|_| \_|_|    \____| |_| |_|_| |_|_|\_\___|_|   
--

-- Autor: Norte (Discord: norte.m2) (X.com/norte_m2)


-- ===============================
-- ========== FRAME TOP (OCULTO) =
-- ===============================

local NPCFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
NPCFrame:SetSize(200, 50)
NPCFrame:SetPoint("TOP", UIParent, "TOP", 0, -100)
NPCFrame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 }
})
NPCFrame:Hide() -- Ocultamos el frame visualmente

local scaleText = NPCFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
scaleText:SetPoint("CENTER")
scaleText:SetText("SCALE: ---")




-- ===============================
-- ===== NPC VENTANA PRINCIPAL ===
-- ===============================

local function CrearNPCVentana()
    local NPCVentanaPrincipal = CreateFrame("Frame", "NPCVentanaPrincipal", UIParent, "BackdropTemplate")
    NPCVentanaPrincipal:SetSize(400, 60)
    NPCVentanaPrincipal:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    
    -- Backdrop transparente
    NPCVentanaPrincipal:SetBackdrop({
        bgFile = nil, -- sin fondo
        edgeFile = nil, -- sin borde
        tile = false,
        tileSize = 0,
        edgeSize = 0,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })

    NPCVentanaPrincipal:EnableMouse(true)
    NPCVentanaPrincipal:SetMovable(true)
    NPCVentanaPrincipal:RegisterForDrag("LeftButton")
    NPCVentanaPrincipal:SetScript("OnDragStart", NPCVentanaPrincipal.StartMoving)
    NPCVentanaPrincipal:SetScript("OnDragStop", NPCVentanaPrincipal.StopMovingOrSizing)

    -- Botón de cerrar (X)
    local closeButtonNPC = CreateFrame("Button", nil, NPCVentanaPrincipal, "UIPanelCloseButton")
    closeButtonNPC:SetPoint("TOPRIGHT", -34, -32)

    -- Título
    local title = NPCVentanaPrincipal:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -38)
    title:SetText("NPC Tinker")

    -- Área de arrastre invisible: cubre todo el frame para que sea fácil de mover
    local dragHandle = CreateFrame("Frame", nil, NPCVentanaPrincipal)
    dragHandle:SetAllPoints(NPCVentanaPrincipal)
    dragHandle:SetFrameLevel(NPCVentanaPrincipal:GetFrameLevel())
    dragHandle:EnableMouse(true)
    dragHandle:RegisterForDrag("LeftButton")
    dragHandle:SetScript("OnDragStart", function() NPCVentanaPrincipal:StartMoving() end)
    dragHandle:SetScript("OnDragStop", function() NPCVentanaPrincipal:StopMovingOrSizing() end)

    NPCVentanaPrincipal:Hide()
    return NPCVentanaPrincipal
end

local NPCVentanaPrincipal = CrearNPCVentana()


-- Icono de fondo detrás del título
--local banner = NPCVentanaPrincipal:CreateTexture(nil, "BACKGROUND")
--banner:SetTexture("Interface/Barbershop/UI-Barbershop-Banner")
--banner:SetSize(350, 175) -- ajusta el tamaño que quieras
--banner:SetPoint("TOP", 40, 48) -- ajusta la posición detrás del título



-- ===========================================================
-- ========== ABRIR CON COMANDO LA VENTANA PRINCIPAL =========
-- ===========================================================

SLASH_NPCVENTANA1 = "/npctinker"
SLASH_NPCVENTANA2 = "/npc"
SlashCmdList["NPCVENTANA"] = function()
    if NPCVentanaPrincipal:IsShown() then
        NPCVentanaPrincipal:Hide()
    else
        NPCVentanaPrincipal:Show()
    end
end







-- ===============================
-- ========== SUBVENTANAS =========
-- ===============================

-- Subventana Editar NPC invisible
local SubventanaNPCEdit = CreateFrame("Frame", "SubventanaNPCEdit", NPCVentanaPrincipal, "BackdropTemplate")
SubventanaNPCEdit:SetSize(400, 40)
SubventanaNPCEdit:SetPoint("TOP", NPCVentanaPrincipal, "BOTTOM", 0, -10)
SubventanaNPCEdit:SetBackdrop({
    bgFile = nil,    -- sin fondo
    edgeFile = nil,  -- sin borde
    tile = false,
    tileSize = 0,
    edgeSize = 0,
    insets = { left = 0, right = 0, top = 0, bottom = 0 }
})
SubventanaNPCEdit:Hide()

-- Subventana Animaciones
local SubventanaNPCAnims = CreateFrame("Frame", "SubventanaNPCAnims", NPCVentanaPrincipal, "BackdropTemplate")
SubventanaNPCAnims:SetSize(330, 130)
SubventanaNPCAnims:SetPoint("TOP", NPCVentanaPrincipal, "BOTTOM", 0, -40)
SubventanaNPCAnims:SetBackdrop({
    bgFile = nil,    -- sin fondo
    edgeFile = nil,  -- sin borde
    tile = false,
    tileSize = 0,
    edgeSize = 0,
})
SubventanaNPCAnims:Hide()



-- ===============================
-- ========== BOTONES =============
-- ===============================


-- Botón Editar NPC
local BotonNPCEdit = CreateFrame("Button", "BotonNPCEdit", NPCVentanaPrincipal)
BotonNPCEdit:SetSize(170, 73)
BotonNPCEdit:SetPoint("TOPLEFT", NPCVentanaPrincipal, "TOPLEFT", 30, -40)

-- Textura normal
BotonNPCEdit.textura = BotonNPCEdit:CreateTexture(nil,"BACKGROUND")
BotonNPCEdit.textura:SetAllPoints()
BotonNPCEdit.textura:SetTexture("Interface\\AddOns\\NPCTinker\\imagenes\\boton-n")

-- Highlight
BotonNPCEdit:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\boton-h")

-- Texto
BotonNPCEdit.texto = BotonNPCEdit:CreateFontString(nil,"OVERLAY","GameFontNormal")
BotonNPCEdit.texto:SetPoint("CENTER", BotonNPCEdit, "CENTER", 0, 0)
BotonNPCEdit.texto:SetText("Customización")
BotonNPCEdit.texto:SetFont(BotonNPCEdit.texto:GetFont(), 12) -- sin OUTLINE

-- Botón Animaciones
local BotonNPCAnims = CreateFrame("Button", "BotonNPCAnims", NPCVentanaPrincipal)
BotonNPCAnims:SetSize(170, 73)
BotonNPCAnims:SetPoint("LEFT", BotonNPCEdit, "RIGHT", -3, 0)

-- Textura normal
BotonNPCAnims.textura = BotonNPCAnims:CreateTexture(nil,"BACKGROUND")
BotonNPCAnims.textura:SetAllPoints()
BotonNPCAnims.textura:SetTexture("Interface\\AddOns\\NPCTinker\\imagenes\\boton-n")

-- Highlight
BotonNPCAnims:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\boton-h")

-- Texto
BotonNPCAnims.texto = BotonNPCAnims:CreateFontString(nil,"OVERLAY","GameFontNormal")
BotonNPCAnims.texto:SetPoint("CENTER", BotonNPCAnims, "CENTER", 0, 0)
BotonNPCAnims.texto:SetText("Animaciones")
BotonNPCAnims.texto:SetFont(BotonNPCAnims.texto:GetFont(), 12) -- sin OUTLINE








-- ===============================
-- ========== FUNCIONALIDAD =======
-- ===============================

local function cerrarSubventanas()
    SubventanaNPCEdit:Hide()
    SubventanaNPCAnims:Hide()
end

BotonNPCEdit:SetScript("OnClick", function()
    if SubventanaNPCEdit:IsShown() then
        SubventanaNPCEdit:Hide()
    else
        cerrarSubventanas()
        SubventanaNPCEdit:Show()
    end
end)

BotonNPCAnims:SetScript("OnClick", function()
    if SubventanaNPCAnims:IsShown() then
        SubventanaNPCAnims:Hide()
    else
        cerrarSubventanas()
        SubventanaNPCAnims:Show()
    end
end)







-- ===============================
-- ========== BOTONES SUBVENTANA EDITAR NPC =========
-- ===============================

local iconSize = 75
local iconSpacing = -20

local botonesInfo = {
    {nombre="BotonEditarNPCRaza", normal="Interface\\AddOns\\NPCTinker\\imagenes\\raza-n.blp", clicked="Interface\\AddOns\\NPCTinker\\imagenes\\raza-h.blp", tooltip="Editar Raza y Género"},
    {nombre="BotonEditarNPCCara", normal="Interface\\AddOns\\NPCTinker\\imagenes\\cara-n.blp", clicked="Interface\\AddOns\\NPCTinker\\imagenes\\cara-h.blp", tooltip="Editar Cara y Piel"},
    {nombre="BotonEditarNPCCabello", normal="Interface\\AddOns\\NPCTinker\\imagenes\\pelo-n.blp", clicked="Interface\\AddOns\\NPCTinker\\imagenes\\pelo-h.blp", tooltip="Editar Pelo"},
    {nombre="BotonEditarNPCAbalorios", normal="Interface\\AddOns\\NPCTinker\\imagenes\\collar-n.blp", clicked="Interface\\AddOns\\NPCTinker\\imagenes\\collar-h.blp", tooltip="Editar Abalorios"},
    {nombre="BotonEditarNPCCuerpo", normal="Interface\\AddOns\\NPCTinker\\imagenes\\cuerpo-n.blp", clicked="Interface\\AddOns\\NPCTinker\\imagenes\\cuerpo-h.blp", tooltip="Editar Cuerpo"},
	{nombre="BotonEditarNPCChat", normal="Interface\\AddOns\\NPCTinker\\imagenes\\chat-n.blp", clicked="Interface\\AddOns\\NPCTinker\\imagenes\\chat-h.blp", tooltip="Otras Opciones"},
}

local totalWidth = (#botonesInfo * iconSize) + ((#botonesInfo - 1) * iconSpacing)
local startX = -totalWidth / 2

local botones = {}

-- Función para resetear todos los botones a normal (-n) y marcar como inactivo
local function resetBotones()
    for _, b in ipairs(botones) do
        b:SetNormalTexture(b.normal)
        b.activo = false
    end
end

for i, info in ipairs(botonesInfo) do
    local boton = CreateFrame("Button", info.nombre, SubventanaNPCEdit)
    boton:SetSize(iconSize, iconSize)
    boton.normal = info.normal       -- textura normal
    boton.clicked = info.clicked     -- textura cuando está activo
    boton:SetNormalTexture(info.normal)
    boton:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\seleccion.blp", "ADD") -- hover
    boton.activo = false  -- estado inicial

    -- Posición centrada
    boton:SetPoint("TOPLEFT", SubventanaNPCEdit, "TOP", startX + (i-1)*(iconSize + iconSpacing), -25)

    -- Tooltip al pasar el ratón
    boton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText(info.tooltip)
        GameTooltip:Show()
    end)
    boton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- Click: toggle entre normal y clicked
    boton:SetScript("OnClick", function(self)
        if self.activo then
            -- Si ya estaba activo, desactivarlo
            self:SetNormalTexture(self.normal)
            self.activo = false
        else
            -- Resetear todos los demás botones a normal
            resetBotones()
            -- Activar este botón
            self:SetNormalTexture(self.clicked)
            self.activo = true
        end

        -- Aquí puedes poner el código de mostrar/ocultar tu sección asociada
        -- Ejemplo:
        -- if SeccionRaza:IsShown() then SeccionRaza:Hide() else cerrarTodasSecciones(); SeccionRaza:Show() end
    end)

    botones[i] = boton
end






-- ===============================
-- VENTANA SELECCION DE RAZA
-- ===============================

-- Crea una ventana grande independiente (hija de SubventanaNPCEdit para que se oculte con la subventana)
local VentanaSeleccionRaza = CreateFrame("Frame", "VentanaSeleccionRaza", SubventanaNPCEdit, "BackdropTemplate")
VentanaSeleccionRaza:SetSize(300, 350)
VentanaSeleccionRaza:SetPoint("TOP", SubventanaNPCEdit, "BOTTOM", 0, -55)
VentanaSeleccionRaza:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 8, right = 8, top = 8, bottom = 8 }
})
VentanaSeleccionRaza:Hide()

-- NO tocamos el SetScript existente del botón de Raza.
-- En su lugar, añadimos un HookScript para no romper la lógica previa.
BotonEditarNPCRaza:HookScript("OnClick", function()
    if VentanaSeleccionRaza:IsShown() then
        VentanaSeleccionRaza:Hide()
    else
        VentanaSeleccionRaza:Show()
    end
end)

-- Al pulsar otros botones hermanos, cerramos esta ventana grande
local function CerrarVentanaSeleccionRaza() VentanaSeleccionRaza:Hide() end
BotonEditarNPCCara:HookScript("OnClick", CerrarVentanaSeleccionRaza)
BotonEditarNPCCabello:HookScript("OnClick", CerrarVentanaSeleccionRaza)
BotonEditarNPCAbalorios:HookScript("OnClick", CerrarVentanaSeleccionRaza)
BotonEditarNPCCuerpo:HookScript("OnClick", CerrarVentanaSeleccionRaza)
BotonEditarNPCChat:HookScript("OnClick", CerrarVentanaSeleccionRaza)

-- ===============================
-- ========== BOTONES DENTRO DE VentanaSeleccionRaza =========
-- ===============================

-- Variable global para almacenar la raza y el género del NPC
-- Por defecto es human_m
local NPCRazaGenero = "human_m"

-- Función para cambiar la raza, manteniendo el género actual
local function CambiarRaza(nuevaRaza)
    local genero = NPCRazaGenero:match("_(.)$") or "m"  -- obtiene la "m" o "f"
    NPCRazaGenero = nuevaRaza.."_"..genero
    -- Aquí puedes añadir cualquier acción adicional que necesites al cambiar la raza
end

-- Función para cambiar el género, manteniendo la raza actual
local function CambiarGenero(nuevoGenero)
    local raza = NPCRazaGenero:match("^(.-)_") or "human" -- obtiene la parte antes del "_"
    NPCRazaGenero = raza.."_"..nuevoGenero
    -- Aquí puedes añadir cualquier acción adicional que necesites al cambiar el género
end

-- Configuración de botones de raza
local iconSize = 40
local iconSpacingX = 10
local iconSpacingY = 10
local startX = -2 * (iconSize + iconSpacingX)  -- centra la primera columna
local startY = -30  -- desde la parte superior de la ventana

local columnas = {
{ {icon="Interface\\Icons\\human_m", texto="Humano", say=".ph forge npc outfit race 1"},
  {icon="Interface\\Icons\\dwarf_m", texto="Enano", say=".ph forge npc outfit race 3"},
  {icon="Interface\\Icons\\nelf_m", texto="Elfo de la Noche", say=".ph forge npc outfit race 4"},
  {icon="Interface\\Icons\\gnome_m", texto="Gnomo", say=".ph forge npc outfit race 7"},
  {icon="Interface\\Icons\\draenei_m", texto="Draenei", say=".ph forge npc outfit race 11"},
  {icon="Interface\\Icons\\worgen_m", texto="Huargen", say=".ph forge npc outfit race 22"} },
{ {icon="Interface\\Icons\\voidelf_m", texto="Elfo del Vacío", say=".ph forge npc outfit race 29"},
  {icon="Interface\\Icons\\lightforged_m", texto="Forjado por la Luz", say=".ph forge npc outfit race 30"},
  {icon="Interface\\Icons\\darkiron_m", texto="Enano Hierronegro", say=".ph forge npc outfit race 34"},
  {icon="Interface\\Icons\\kultiran_m", texto="Humano de Kul Tiras", say=".ph forge npc outfit race 32"},
  {icon="Interface\\Icons\\mechagnome_m", texto="Mecagnomo", say=".ph forge npc outfit race 37"} },
{ {icon="Interface\\Icons\\panda_m", texto="Pandaren", say=".ph forge npc outfit race 26"} },
{ {icon="Interface\\Icons\\nightborne_m", texto="Nocheterna", say=".ph forge npc outfit race 27"},
  {icon="Interface\\Icons\\highmountain_m", texto="Tauren Montealto", say=".ph forge npc outfit race 28"},
  {icon="Interface\\Icons\\maghar_m", texto="Orco Mag'har", say=".ph forge npc outfit race 36"},
  {icon="Interface\\Icons\\zandalari_m", texto="Trol Zandalari", say=".ph forge npc outfit race 31"},
  {icon="Interface\\Icons\\vulpera_m", texto="Vulpera", say=".ph forge npc outfit race 35"} },
{ {icon="Interface\\Icons\\orc_m", texto="Orco", say=".ph forge npc outfit race 2"},
  {icon="Interface\\Icons\\forsaken_m", texto="No-Muerto", say=".ph forge npc outfit race 5"},
  {icon="Interface\\Icons\\tauren_m", texto="Tauren", say=".ph forge npc outfit race 6"},
  {icon="Interface\\Icons\\troll_m", texto="Trol", say=".ph forge npc outfit race 8"},
  {icon="Interface\\Icons\\belf_m", texto="Elfo de Sangre", say=".ph forge npc outfit race 10"},
  {icon="Interface\\Icons\\goblin_m", texto="Goblin", say=".ph forge npc outfit race 9"} }
}

local botonesRaza = {}
local contador = 1

for col = 1, #columnas do
    local columna = columnas[col]
    for fila = 1, #columna do
        local info = columna[fila]
        local nombreBoton = "BotonRaza"..contador
        local boton = CreateFrame("Button", nombreBoton, VentanaSeleccionRaza)
        boton:SetSize(iconSize, iconSize)
        boton:SetNormalTexture(info.icon)
        boton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")

        -- posición según columna y fila
        local offsetX = startX + (col-1)*(iconSize + iconSpacingX)
        boton:SetPoint("TOP", VentanaSeleccionRaza, "TOP", offsetX, startY - (fila-1)*(iconSize + iconSpacingY))

        -- Tooltip
        boton:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            GameTooltip:SetText(info.texto)
            GameTooltip:Show()
        end)
        boton:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)

        -- Acción al hacer click: cambia la raza y dice el mensaje
        boton:SetScript("OnClick", function()
            CambiarRaza(info.icon:match("(%w+)_m$") or "human") -- extrae el nombre base del icono
            SendChatMessage(info.say, "SAY")
        end)

        botonesRaza[contador] = boton
        contador = contador + 1
    end
end





-- ===============================
-- ==== Botón desplegable para SubventanaOtrasRazas ====
-- ===============================

-- Botón flecha dentro de VentanaSeleccionRaza
local BotonDesplegableOtrasRazas = CreateFrame("Button", "BotonDesplegableOtrasRazas", VentanaSeleccionRaza)
BotonDesplegableOtrasRazas:SetSize(30, 30)
BotonDesplegableOtrasRazas:SetPoint("TOPRIGHT", VentanaSeleccionRaza, "TOPRIGHT", 10, -34)
BotonDesplegableOtrasRazas:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
BotonDesplegableOtrasRazas:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
BotonDesplegableOtrasRazas:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")

-- Tooltip para el botón desplegable
BotonDesplegableOtrasRazas:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP")
    GameTooltip:SetText("Otras Razas")  -- texto que quieras mostrar
    GameTooltip:Show()
end)

BotonDesplegableOtrasRazas:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)

-- Subventana que se creará al abrir
local SubventanaOtrasRazas = nil

BotonDesplegableOtrasRazas:SetScript("OnClick", function()
    if SubventanaOtrasRazas and SubventanaOtrasRazas:IsShown() then
        SubventanaOtrasRazas:Hide()
    else
        -- Crear subventana si no existe
        if not SubventanaOtrasRazas then
            SubventanaOtrasRazas = CreateFrame("Frame", "SubventanaOtrasRazas", VentanaSeleccionRaza, "BackdropTemplate")
            SubventanaOtrasRazas:SetSize(150, 350)
            SubventanaOtrasRazas:SetPoint("TOPLEFT", VentanaSeleccionRaza, "TOPRIGHT", 13, 0)
            SubventanaOtrasRazas:SetBackdrop({
                bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
                edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
                tile = true, tileSize = 32, edgeSize = 32,
                insets = {left=8, right=8, top=8, bottom=8}
            })

            -- Iconos en 2 columnas con 5 iconos cada una
local columnas = {
    { -- primera columna
        {icon="Interface\\Icons\\naga_m", texto="Naga", say=".ph forge npc outfit race 13", raza="naga"},
        {icon="Interface\\Icons\\vrykul", texto="Vrykul", say=".ph forge npc outfit race 16", raza="vrykul"},
        {icon="Interface\\Icons\\w3reforgedforesttroll", texto="Trol del Bosque", say=".ph forge npc outfit race 18", raza="foresttroll"},
        {icon="Interface\\Icons\\eps_wc3_skeleton", texto="Esqueleto", say=".ph forge npc outfit race 15", raza="skeleton"},
        {icon="Interface\\Icons\\eps_hs_grimytauren", texto="Taunka", say=".ph forge npc outfit race 19", raza="taunka"},
        {icon="Interface\\Icons\\broken", texto="Tábido", say=".ph forge npc outfit race 14", raza="broken"}
    },
    { -- segunda columna
        {icon="Interface\\Icons\\w3reforgedtuskaargold", texto="Colmillarr", say=".ph forge npc outfit race 17", raza="tuskarr"},
        {icon="Interface\\Icons\\eps_wc3h_humanpeasantwc1", texto="Humano Delgado", say=".ph forge npc outfit race 33", raza="thinhuman"},
        {icon="Interface\\Icons\\w3reforgedicetrolltrapper", texto="Trol de Hielo", say=".ph forge npc outfit race 21", raza="icetroll"},
        {icon="Interface\\Icons\\eps_wc3h_undeadretournedskeleton", texto="Esqueleto Vrykul", say=".ph forge npc outfit race 20", raza="northrendskeleton"},
        {icon="Interface\\Icons\\eps_wc3h_felorcspear", texto="Orco Vil", say=".ph forge npc outfit race 12", raza="felorc"}
    }
}



            local iconSize = 40
            local spacingX, spacingY = 10, 10
            local startX, startY = 30, -30

            for col = 1, #columnas do
                local columna = columnas[col]
                for fila = 1, #columna do
                    local info = columna[fila]
                    local boton = CreateFrame("Button", "BotonOtrasRazas"..col..fila, SubventanaOtrasRazas)
                    boton:SetSize(iconSize, iconSize)
                    boton:SetNormalTexture(info.icon)
                    boton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
                    local offsetX = startX + (col-1)*(iconSize + spacingX)
                    local offsetY = startY - (fila-1)*(iconSize + spacingY)
                    boton:SetPoint("TOPLEFT", SubventanaOtrasRazas, "TOPLEFT", offsetX, offsetY)

                    -- Tooltip
                    boton:SetScript("OnEnter", function(self)
                        GameTooltip:SetOwner(self, "ANCHOR_TOP")
                        GameTooltip:SetText(info.texto)
                        GameTooltip:Show()
                    end)
                    boton:SetScript("OnLeave", function()
                        GameTooltip:Hide()
                    end)

                    -- Acción al click
                    boton:SetScript("OnClick", function()
					
					
 -- Actualiza NPCRazaGenero usando el campo 'raza' de la tabla
    local nuevaRaza = info.raza or "human"
    CambiarRaza(nuevaRaza)

    -- Envía el mensaje principal
    SendChatMessage(info.say, "SAY")

    -- Opcional: muestra en la consola qué raza se ha seleccionado
    print("Seleccionada raza:", info.texto, "| NPCRazaGenero:", NPCRazaGenero)
end)



                end
            end
        end
		
		
		
		
        SubventanaOtrasRazas:Show()
    end
end)





-- ===============================
-- ==== Botón ELEGIR GENERO ====
-- ===============================



-- Botón Masculino
local BotonRazaMasculino = CreateFrame("Button", "BotonRazaMasculino", VentanaSeleccionRaza)
BotonRazaMasculino:SetSize(70, 70)
BotonRazaMasculino:SetPoint("BOTTOM", VentanaSeleccionRaza, "BOTTOM", -30, 12)
BotonRazaMasculino:SetNormalTexture("Interface\\AddOns\\NPCTinker\\imagenes\\hombre-n.blp")
BotonRazaMasculino:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\hombre-h.blp", "ADD")

BotonRazaMasculino:SetScript("OnClick", function()
    CambiarGenero("m")
    SendChatMessage(".ph forge npc outfit gender male", "SAY")
end)

BotonRazaMasculino:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP")
    GameTooltip:SetText("Cuerpo Masculino")
    GameTooltip:Show()
end)
BotonRazaMasculino:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)

-- Botón Femenino
local BotonRazaFemenino = CreateFrame("Button", "BotonRazaFemenino", VentanaSeleccionRaza)
BotonRazaFemenino:SetSize(70, 70)
BotonRazaFemenino:SetPoint("BOTTOMLEFT", BotonRazaMasculino, "BOTTOMRIGHT", -12, 0)
BotonRazaFemenino:SetNormalTexture("Interface\\AddOns\\NPCTinker\\imagenes\\mujer-n.blp")
BotonRazaFemenino:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\mujer-h.blp", "ADD")

BotonRazaFemenino:SetScript("OnClick", function()
    CambiarGenero("f")
    SendChatMessage(".ph forge npc outfit gender female", "SAY")
end)

BotonRazaFemenino:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP")
    GameTooltip:SetText("Cuerpo Femenino")
    GameTooltip:Show()
end)
BotonRazaFemenino:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)











-- ===============================
-- ========== TABLA DE COMPARAR DISPLAYS =========
-- ===============================







TablaDisplaysGenero = { 
    ["57899"] = { raza = "human", genero = "m" },
    ["56658"] = { raza = "human", genero = "f" },
    ["51894"] = { raza = "orc", genero = "m" },
    ["53762"] = { raza = "orc", genero = "f" },
    ["49242"] = { raza = "dwarf", genero = "m" },
    ["53768"] = { raza = "dwarf", genero = "f" },
    ["54918"] = { raza = "nightelf", genero = "m" },
    ["54439"] = { raza = "nightelf", genero = "f" },
    ["54041"] = { raza = "undead", genero = "m" },
    ["56327"] = { raza = "undead", genero = "f" },
    ["55077"] = { raza = "tauren", genero = "m" },
    ["56316"] = { raza = "tauren", genero = "f" },
    ["51877"] = { raza = "gnome", genero = "m" },
    ["53291"] = { raza = "gnome", genero = "f" },
    ["59071"] = { raza = "troll", genero = "m" },
    ["59223"] = { raza = "troll", genero = "f" },
    ["6894"]  = { raza = "goblin", genero = "m" },
    ["6895"]  = { raza = "goblin", genero = "f" },
    ["62127"] = { raza = "bloodelf", genero = "m" },
    ["62128"] = { raza = "bloodelf", genero = "f" },
    ["57027"] = { raza = "draenei", genero = "m" },
    ["58232"] = { raza = "draenei", genero = "f" },
    ["16981"] = { raza = "felorc", genero = "m" },
    ["17402"] = { raza = "naga", genero = "m" },
    ["17403"] = { raza = "naga", genero = "f" },
    ["17576"] = { raza = "broken", genero = "m" },
    ["17578"] = { raza = "skeleton", genero = "m" },
    ["21685"] = { raza = "vrykul", genero = "m" },
    ["21780"] = { raza = "tuskarr", genero = "m" },
    ["21963"] = { raza = "foresttroll", genero = "m" },
    ["26316"] = { raza = "taunka", genero = "m" },
    ["26871"] = { raza = "northrendskeleton", genero = "m" },
    ["26873"] = { raza = "icetroll", genero = "m" },
    ["29422"] = { raza = "worgen", genero = "m" },
    ["29423"] = { raza = "worgen", genero = "f" },
    ["38551"] = { raza = "pandaren", genero = "m" },
    ["38552"] = { raza = "pandaren", genero = "f" },
    ["75078"] = { raza = "nightborne", genero = "m" },
    ["75079"] = { raza = "nightborne", genero = "f" },
    ["75080"] = { raza = "highmountain", genero = "m" },
    ["75081"] = { raza = "highmountain", genero = "f" },
    ["75082"] = { raza = "voidelf", genero = "m" },
    ["75083"] = { raza = "voidelf", genero = "f" },
    ["75084"] = { raza = "lightforged", genero = "m" },
    ["75085"] = { raza = "lightforged", genero = "f" },
    ["79100"] = { raza = "zandalari", genero = "m" },
    ["79101"] = { raza = "zandalari", genero = "f" },
    ["80387"] = { raza = "kultiran", genero = "m" },
    ["80388"] = { raza = "kultiran", genero = "f" },
    ["82317"] = { raza = "thinhuman", genero = "m" },
    ["83910"] = { raza = "darkiron", genero = "m" },
    ["83911"] = { raza = "darkiron", genero = "f" },
    ["83913"] = { raza = "vulpera", genero = "m" },
    ["83914"] = { raza = "vulpera", genero = "f" },
    ["84558"] = { raza = "maghar", genero = "m" },
    ["84560"] = { raza = "maghar", genero = "f" },
    ["90786"] = { raza = "mechagnome", genero = "m" },
    ["90787"] = { raza = "mechagnome", genero = "f" },
}





-- ===============================
-- ========== SEGUN SEA EL DISPLAY ACTUALIZAR LA VARIABLE NPCRazaGenero=========
-- ===============================








-- Función para actualizar NPCRazaGenero a partir de DisplayIDNPC
local function ActualizarRazaGenero()
    if not DisplayIDNPC then return end
    for key, info in pairs(TablaDisplaysGenero) do
        -- Comparamos solo hasta la longitud mínima entre la clave de la tabla y DisplayIDNPC
        local len = math.min(#key, #DisplayIDNPC)
        if string.sub(key, 1, len) == string.sub(DisplayIDNPC, 1, len) then
            -- Actualizamos la variable NPCRazaGenero
            NPCRazaGenero = info.raza.."_"..info.genero
            --- print("NPCRazaGenero actualizado:", NPCRazaGenero)
            break
        end
    end
end







-- ===============================
-- TABLA DE OPCIONES DE CUSTOMIZACIÓN
-- ===============================



OpcionCustomizacion = {
    ["face"] = 1,
    ["facialhair"] = 1,
    ["haircolor"] = 1,
    ["hairstyle"] = 1,
    ["piercings"] = 1,
    ["skincolor"] = 1,
    ["accentcolor"] = 1,
    ["arm(left)"] = 1,
    ["arm(right)"] = 1,
    ["armbands"] = 1,
    ["bandages"] = 1,
    ["beard"] = 1,
    ["blindfold"] = 1,
    ["body"] = 1,
    ["bodyfur"] = 1,
    ["bodymarkings"] = 1,
    ["bodypaint"] = 1,
    ["bodypaintcolor"] = 1,
    ["bodypiercings"] = 1,
    ["bodyrune"] = 1,
    ["bodyshape"] = 1,
    ["bodytattoo"] = 1,
    ["bodytype"] = 1,
    ["bracelets"] = 1,
    ["browpiercing"] = 1,
    ["chestmodification"] = 1,
    ["chin"] = 1,
    ["chinjewelry"] = 1,
    ["chinmodification"] = 1,
    ["claws"] = 1,
    ["complexion"] = 1,
    ["eargauge"] = 1,
    ["earmodification"] = 1,
    ["earrings"] = 1,
    ["ears"] = 1,
    ["earstyle"] = 1,
    ["eyebrows"] = 1,
    ["eyecolor"] = 1,
    ["eyeshape"] = 1,
    ["eyetype"] = 1,
    ["facefeatures"] = 1,
    ["facejewelry"] = 1,
    ["facemarkings"] = 1,
    ["facemodification"] = 1,
    ["facepaint"] = 1,
    ["facerune"] = 1,
    ["faceshape"] = 1,
    ["facetattoo"] = 1,
    ["facetendrils"] = 1,
    ["facetype"] = 1,
    ["fangs"] = 1,
    ["feather"] = 1,
    ["feathercolor"] = 1,
    ["flower"] = 1,
    ["foremane"] = 1,
    ["furcolor"] = 1,
    ["garment"] = 1,
    ["gemcolor"] = 1,
    ["goatee"] = 1,
    ["goggles"] = 1,
    ["grime"] = 1,
    ["hair"] = 1,
    ["hairaccents"] = 1,
    ["hairaccessory"] = 1,
    ["hairdecoration"] = 1,
    ["hairgradient"] = 1,
    ["hairhighlight"] = 1,
    ["hairstreaks"] = 1,
    ["hand(left)"] = 1,
    ["hand(right)"] = 1,
    ["handjewelry"] = 1,
    ["headdress"] = 1,
    ["hips"] = 1,
    ["hornaccessories"] = 1,
    ["horncolor"] = 1,
    ["horndecoration"] = 1,
    ["hornmarkings"] = 1,
    ["horns"] = 1,
    ["hornstyle"] = 1,
    ["hornwraps"] = 1,
    ["jawdecoration"] = 1,
    ["jawjewelry"] = 1,
    ["jewelrycolor"] = 1,
    ["leg(left)"] = 1,
    ["leg(right)"] = 1,
    ["luminoushands"] = 1,
    ["makeup"] = 1,
    ["mane"] = 1,
    ["mouthpiercing"] = 1,
    ["mustache"] = 1,
    ["necklace"] = 1,
    ["nose"] = 1,
    ["nosepiercing"] = 1,
    ["nosering"] = 1,
    ["optics"] = 1,
    ["paintcolor"] = 1,
    ["pattern"] = 1,
    ["patterncolor"] = 1,
    ["posture"] = 1,
    ["ribs"] = 1,
    ["runes"] = 1,
    ["runescolor"] = 1,
    ["runecolor"] = 1,
    ["scars"] = 1,
    ["secondaryearstyle"] = 1,
    ["secondaryeyecolor"] = 1,
    ["sideburns"] = 1,
    ["skintype"] = 1,
    ["snout"] = 1,
    ["spine"] = 1,
    ["stubble"] = 1,
    ["tail"] = 1,
    ["taildecoration"] = 1,
    ["tattoo"] = 1,
    ["tattoocolor"] = 1,
    ["tattoostyle"] = 1,
    ["tendrils"] = 1,
    ["tentacles"] = 1,
    ["tuskdecoration"] = 1,
    ["tusks"] = 1,
    ["vinecolor"] = 1,
    ["vines"] = 1,
    ["wristjewelry"] = 1,
}























-- ===============================
-- VARIABLE DETECTAR INFO NPC
-- ===============================

-- Variable global por defecto
DetectarInfoNPC = true

SLASH_AUTOACTUALIZARNPC1 = "/autoactualizarnpc"
SlashCmdList["AUTOACTUALIZARNPC"] = function()
    if DetectarInfoNPC then
        print("Auto-actualizar NPC: |cff00ff00ACTIVADO|r")
    else
        print("Auto-actualizar NPC: |cffff0000DESACTIVADO|r")
    end
end




-- ===============================
-- ========== AL HACER TARGET A UN NPC PASAN COSAS =========
-- ===============================


-- Variable global para almacenar el DisplayID del NPC seleccionado
DisplayIDNPC = nil

-- ===============================
-- REGISTRO DE EpsilonLib AddonCommands
-- ===============================

local sendAddonCmd
if EpsilonLib and EpsilonLib.AddonCommands then
    sendAddonCmd = EpsilonLib.AddonCommands.Register("NPCTinker")
else
    -- Fallback por si EpsilonLib aún no está cargado en el momento de evaluación
    function sendAddonCmd(command, callbackFn, forceShowMessages)
        if EpsilonLib and EpsilonLib.AddonCommands then
            sendAddonCmd = EpsilonLib.AddonCommands.Register("NPCTinker")
            sendAddonCmd(command, callbackFn, forceShowMessages)
            return
        end
        print("[NPCTinker] EpsilonLib no disponible, no se puede obtener info del NPC.")
    end
end

-- Tabla compartida donde cada sección de UI registra su función de refresco.
-- ProcesarNPCInfo la invoca tras actualizar NPCRazaGenero.
local NPCTinker_UIActualizadores = {}

-- Callback que recibe la respuesta de "npc info" y extrae el DisplayID
local function ProcesarNPCInfo(isCommandSuccessful, repliesList)
    if not isCommandSuccessful or not repliesList or not repliesList[1] then return end

    local mensaje = repliesList[1]
    -- Limpia códigos de color de WoW (igual que PhaseToolkit)
    mensaje = mensaje:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")

    local despuesDisplayID = string.match(mensaje, "DisplayID:%s*(.+)")
    if despuesDisplayID then
        local numeros = string.match(despuesDisplayID, "%d+")
        if numeros then
            DisplayIDNPC = string.sub(numeros, 1, 5)
            ActualizarRazaGenero()
            -- Ahora que NPCRazaGenero está actualizado, refrescamos toda la UI.
            -- Dos pasadas: la 1ª actualiza Show/Hide de cada opción según la nueva raza.
            -- La 2ª reposiciona con los estados Show/Hide ya correctos (las posiciones
            -- dependen de si el frame vecino está visible, así que necesitan la 1ª pasada completa).
            for _, fn in ipairs(NPCTinker_UIActualizadores) do fn() end
            for _, fn in ipairs(NPCTinker_UIActualizadores) do fn() end
        end
    end
end

-- Frame para detectar cambio de target
local FrameNPC = CreateFrame("Frame")
FrameNPC:RegisterEvent("PLAYER_TARGET_CHANGED")

FrameNPC:SetScript("OnEvent", function(_, event)
    if not DetectarInfoNPC then return end

    if event == "PLAYER_TARGET_CHANGED" then
        if UnitExists("target") and not UnitIsPlayer("target") then
            sendAddonCmd("npc info", ProcesarNPCInfo, false)
        end
    end
end)

















-- ===============================
-- VENTANA OPCIONES DE CARA
-- ===============================

local VentanaOpcionesCara = CreateFrame("Frame", "VentanaOpcionesCara", SubventanaNPCEdit, "BackdropTemplate")
VentanaOpcionesCara:SetSize(300, 350)
VentanaOpcionesCara:SetPoint("TOP", SubventanaNPCEdit, "BOTTOM", 0, -55)
VentanaOpcionesCara:SetBackdrop(nil)
VentanaOpcionesCara:Hide()

-- Toggle con botón principal
BotonEditarNPCCara:HookScript("OnClick", function()
    if VentanaOpcionesCara:IsShown() then
        VentanaOpcionesCara:Hide()
    else
        VentanaOpcionesCara:Show()
        ReposicionarBoton(VentanaOpcionesCara)
    end
end)

-- Cerrar con otros botones
local function CerrarVentanaOpcionesCara()
    VentanaOpcionesCara:Hide()
end
for _, BotonCerrarVentana in ipairs({
    BotonEditarNPCRaza, BotonEditarNPCCabello,
    BotonEditarNPCAbalorios, BotonEditarNPCCuerpo, BotonEditarNPCChat
}) do
    BotonCerrarVentana:HookScript("OnClick", CerrarVentanaOpcionesCara)
end




-- ===============================
-- FUNCIÓN GENÉRICA SUBVENTANAS
-- ===============================

local NPCTinkerOpcionesCara = {}

local function NPCTinkerCrearSubVentanaOpcion(configuracion)
    local datosVentana = {
        numero = 0,
        valor = 1,
        texto = nil,
        frame = nil,
        editBoxFrame = nil,
    }
    NPCTinkerOpcionesCara[configuracion.nombre] = datosVentana

    local MarcoOpcion = CreateFrame("Frame", "SubVentana"..configuracion.nombre, VentanaOpcionesCara, "BackdropTemplate")
    MarcoOpcion:SetSize(240, 60)
    MarcoOpcion:SetBackdrop(nil)
    MarcoOpcion:Hide()
    datosVentana.frame = MarcoOpcion

    configuracion.posicionFn(MarcoOpcion)

    -- Etiqueta
    local EtiquetaOpcion = MarcoOpcion:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    EtiquetaOpcion:SetPoint("LEFT", MarcoOpcion, "LEFT", 7, 0)
    EtiquetaOpcion:SetFont("Fonts\\FRIZQT__.TTF", 14)
    EtiquetaOpcion:SetText(configuracion.textoLabel)

    -- Botón Izquierda
    local BotonIzquierda = CreateFrame("Button", nil, MarcoOpcion)
    BotonIzquierda:SetSize(35, 35)
    BotonIzquierda:SetPoint("LEFT", EtiquetaOpcion, "RIGHT", 16, 0)
    BotonIzquierda:SetNormalTexture("Interface\\AddOns\\NPCTinker\\imagenes\\izq-n.blp")
    BotonIzquierda:SetPushedTexture("Interface\\AddOns\\NPCTinker\\imagenes\\izq-n.blp")
    BotonIzquierda:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\izq-h.blp", "ADD")
    BotonIzquierda:SetScript("OnClick", function()
        if datosVentana.valor > 1 then
            datosVentana.valor = datosVentana.valor - 1
            datosVentana.texto:SetText(datosVentana.valor.." / "..datosVentana.numero)
            SendChatMessage(".ph forge npc outfit custo "..configuracion.comando.." "..datosVentana.valor, "GUILD")
        end
    end)

    -- Botón Derecha
    local BotonDerecha = CreateFrame("Button", nil, MarcoOpcion)
    BotonDerecha:SetSize(35, 35)
    BotonDerecha:SetPoint("LEFT", BotonIzquierda, "RIGHT", 107, 0)
    BotonDerecha:SetNormalTexture("Interface\\AddOns\\NPCTinker\\imagenes\\der-n.blp")
    BotonDerecha:SetPushedTexture("Interface\\AddOns\\NPCTinker\\imagenes\\der-n.blp")
    BotonDerecha:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\der-h.blp", "ADD")
    BotonDerecha:SetScript("OnClick", function()
        if datosVentana.valor < datosVentana.numero then
            datosVentana.valor = datosVentana.valor + 1
            datosVentana.texto:SetText(datosVentana.valor.." / "..datosVentana.numero)
            SendChatMessage(".ph forge npc outfit custo "..configuracion.comando.." "..datosVentana.valor, "GUILD")
        end
    end)

    -- Botón Central con número
    local BotonCentral = CreateFrame("Button", nil, MarcoOpcion)
    BotonCentral:SetSize(110, 64)
    BotonCentral:SetPoint("LEFT", BotonIzquierda, "RIGHT", -2, 0)
    BotonCentral:SetNormalTexture("Interface\\AddOns\\NPCTinker\\imagenes\\boton-n.blp")
    BotonCentral:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\boton-h.blp", "ADD")

    datosVentana.texto = BotonCentral:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    datosVentana.texto:SetPoint("CENTER", BotonCentral, "CENTER", 0, 0)
    datosVentana.texto:SetFont("Fonts\\FRIZQT__.TTF", 14)
    datosVentana.texto:SetText(datosVentana.valor.." / "..datosVentana.numero)

    -- EditBox toggle
    BotonCentral:SetScript("OnClick", function()
        if datosVentana.editBoxFrame then
            datosVentana.editBoxFrame:Hide()
            datosVentana.editBoxFrame = nil
            return
        end
        local MarcoEditBox = CreateFrame("Frame", nil, MarcoOpcion, "BackdropTemplate")
        MarcoEditBox:SetSize(80, 36)
        MarcoEditBox:SetPoint("LEFT", BotonDerecha, "RIGHT", 10, 0)
        MarcoEditBox:SetBackdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true, tileSize = 16, edgeSize = 16,
            insets = { left=4, right=4, top=4, bottom=4 }
        })
        MarcoEditBox:SetBackdropColor(0,0,0,0.7)

        local CajaTexto = CreateFrame("EditBox", nil, MarcoEditBox, "InputBoxTemplate")
        CajaTexto:SetSize(50,20)
        CajaTexto:SetPoint("CENTER", MarcoEditBox, "CENTER", 2, 0)
        CajaTexto:SetFont("Fonts\\FRIZQT__.TTF", 14)
        CajaTexto:SetAutoFocus(true)
        CajaTexto:SetText(tostring(datosVentana.valor))
        CajaTexto:SetMaxLetters(2)
        CajaTexto:SetNumeric(true)

        CajaTexto:SetScript("OnEnterPressed", function(self)
            local valorIngresado = tonumber(self:GetText())
            if valorIngresado then
                if valorIngresado < 1 then valorIngresado = 1 end
                if valorIngresado > datosVentana.numero then valorIngresado = datosVentana.numero end
                datosVentana.valor = valorIngresado
                datosVentana.texto:SetText(datosVentana.valor.." / "..datosVentana.numero)
                SendChatMessage(".ph forge npc outfit custo "..configuracion.comando.." "..datosVentana.valor, "GUILD")
            end
            self:ClearFocus()
            MarcoEditBox:Hide()
            datosVentana.editBoxFrame = nil
        end)
        datosVentana.editBoxFrame = MarcoEditBox
    end)

    -- Función de actualización
    datosVentana.actualizar = function()
        MarcoOpcion:ClearAllPoints()
        configuracion.posicionFn(MarcoOpcion)
        local raza, genero = (NPCRazaGenero or ""):match("^([^_]+)_([^_]+)$")
        local nuevoNumero = 0
        if raza and genero and TablaOpcionesCustomizacionRaza then
            local datosRaza = TablaOpcionesCustomizacionRaza[raza]
            local datosGenero = datosRaza and datosRaza[genero]
            if datosGenero and datosGenero[configuracion.comando] then
                nuevoNumero = datosGenero[configuracion.comando]
            end
        end
        if datosVentana.numero ~= nuevoNumero then
            datosVentana.numero = nuevoNumero
            if datosVentana.valor > datosVentana.numero then datosVentana.valor = 1 end
            datosVentana.texto:SetText(datosVentana.valor.." / "..datosVentana.numero)
            if datosVentana.numero == 0 then MarcoOpcion:Hide() else MarcoOpcion:Show() end
        end
    end
end


-- ===============================
-- CREACIÓN DE TODAS LAS OPCIONES
-- ===============================

NPCTinkerCrearSubVentanaOpcion({
    nombre="SkinColor", textoLabel="Piel:", comando="skincolor",
    posicionFn=function(f) f:SetPoint("CENTER", VentanaOpcionesCara, "CENTER", 52, 150) end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="Face", textoLabel="Cara:", comando="face",
    posicionFn=function(f)
        if SubVentanaSkinColor and SubVentanaSkinColor:IsShown() then
            f:SetPoint("CENTER", SubVentanaSkinColor, "CENTER", -4, -35)
        else
            f:SetPoint("CENTER", SubVentanaSkinColor, "CENTER", -4, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="FaceShape", textoLabel="Forma de la Cara:", comando="faceshape",
    posicionFn=function(f)
        if SubVentanaFace and SubVentanaFace:IsShown() then
            f:SetPoint("CENTER", SubVentanaFace, "CENTER", -86, -35)
        else
            f:SetPoint("CENTER", SubVentanaFace, "CENTER", -86, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="EyeColor", textoLabel="Color de Ojos:", comando="eyecolor",
    posicionFn=function(f)
        if SubVentanaFaceShape and SubVentanaFaceShape:IsShown() then
            f:SetPoint("CENTER", SubVentanaFaceShape, "CENTER", 19, -35)
        else
            f:SetPoint("CENTER", SubVentanaFaceShape, "CENTER", 19, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="SecondaryEyeColor", textoLabel="Color Secundario de Ojos:", comando="secondaryeyecolor",
    posicionFn=function(f)
        if SubVentanaEyeColor and SubVentanaEyeColor:IsShown() then
            f:SetPoint("CENTER", SubVentanaEyeColor, "CENTER", -84, -35)
        else
            f:SetPoint("CENTER", SubVentanaEyeColor, "CENTER", -84, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="EyeType", textoLabel="Tipo de Ojos:", comando="eyetype",
    posicionFn=function(f)
        if SubVentanaSecondaryEyeColor and SubVentanaSecondaryEyeColor:IsShown() then
            f:SetPoint("CENTER", SubVentanaSecondaryEyeColor, "CENTER", 93, -35)
        else
            f:SetPoint("CENTER", SubVentanaSecondaryEyeColor, "CENTER", 93, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="Ears", textoLabel="Orejas:", comando="ears",
    posicionFn=function(f)
        if SubVentanaEyeType and SubVentanaEyeType:IsShown() then
            f:SetPoint("CENTER", SubVentanaEyeType, "CENTER", 46, -35)
        else
            f:SetPoint("CENTER", SubVentanaEyeType, "CENTER", 46, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="EarStyle", textoLabel="Orejas:", comando="earstyle",
    posicionFn=function(f)
        if SubVentanaEars and SubVentanaEars:IsShown() then
            f:SetPoint("CENTER", SubVentanaEars, "CENTER", 0, -35)
        else
            f:SetPoint("CENTER", SubVentanaEars, "CENTER", 0, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="SecondaryEarStyle", textoLabel="Oreja Izquierda:", comando="secondaryearstyle",
    posicionFn=function(f)
        if SubVentanaEarStyle and SubVentanaEarStyle:IsShown() then
            f:SetPoint("CENTER", SubVentanaEarStyle, "CENTER", -63, -35)
        else
            f:SetPoint("CENTER", SubVentanaEarStyle, "CENTER", -63, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="Fangs", textoLabel="Colmillos:", comando="fangs",
    posicionFn=function(f)
        if SubVentanaSecondaryEarStyle and SubVentanaSecondaryEarStyle:IsShown() then
            f:SetPoint("CENTER", SubVentanaSecondaryEarStyle, "CENTER", 42, -35)
        else
            f:SetPoint("CENTER", SubVentanaSecondaryEarStyle, "CENTER", 42, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="Tendrils", textoLabel="Apéndices:", comando="tendrils",
    posicionFn=function(f)
        if SubVentanaFangs and SubVentanaFangs:IsShown() then
            f:SetPoint("CENTER", SubVentanaFangs, "CENTER", -10, -35)
        else
            f:SetPoint("CENTER", SubVentanaFangs, "CENTER", -10, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="HornDecoration", textoLabel="Decoración de Cuernos:", comando="horndecoration",
    posicionFn=function(f)
        if SubVentanaTendrils and SubVentanaTendrils:IsShown() then
            f:SetPoint("CENTER", SubVentanaTendrils, "CENTER", -91, -35)
        else
            f:SetPoint("CENTER", SubVentanaTendrils, "CENTER", -91, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="Nose", textoLabel="Nariz:", comando="nose",
    posicionFn=function(f)
        if SubVentanaHornDecoration and SubVentanaHornDecoration:IsShown() then
            f:SetPoint("CENTER", SubVentanaHornDecoration, "CENTER", 130, -35)
        else
            f:SetPoint("CENTER", SubVentanaHornDecoration, "CENTER", 130, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="Chin", textoLabel="Barbilla:", comando="chin",
    posicionFn=function(f)
        if SubVentanaNose and SubVentanaNose:IsShown() then
            f:SetPoint("CENTER", SubVentanaNose, "CENTER", -15, -35)
        else
            f:SetPoint("CENTER", SubVentanaNose, "CENTER", -15, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="Snout", textoLabel="Hocico:", comando="snout",
    posicionFn=function(f)
        if SubVentanaChin and SubVentanaChin:IsShown() then
            f:SetPoint("CENTER", SubVentanaChin, "CENTER", 0, -35)
        else
            f:SetPoint("CENTER", SubVentanaChin, "CENTER", 0, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="Tusks", textoLabel="Colmillos:", comando="tusks",
    posicionFn=function(f)
        if SubVentanaSnout and SubVentanaSnout:IsShown() then
            f:SetPoint("CENTER", SubVentanaSnout, "CENTER", -16, -35)
        else
            f:SetPoint("CENTER", SubVentanaSnout, "CENTER", -16, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="Scars", textoLabel="Cicatrices:", comando="scars",
    posicionFn=function(f)
        if SubVentanaTusks and SubVentanaTusks:IsShown() then
            f:SetPoint("CENTER", SubVentanaTusks, "CENTER", 0, -35)
        else
            f:SetPoint("CENTER", SubVentanaTusks, "CENTER", 0, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="HornStyle", textoLabel="Tipo de Cuernos:", comando="hornstyle",
    posicionFn=function(f)
        if SubVentanaScars and SubVentanaScars:IsShown() then
            f:SetPoint("CENTER", SubVentanaScars, "CENTER", -47, -35)
        else
            f:SetPoint("CENTER", SubVentanaScars, "CENTER", -47, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="HornColor", textoLabel="Color de Cuernos:", comando="horncolor",
    posicionFn=function(f)
        if SubVentanaHornStyle and SubVentanaHornStyle:IsShown() then
            f:SetPoint("CENTER", SubVentanaHornStyle, "CENTER", -7, -35)
        else
            f:SetPoint("CENTER", SubVentanaHornStyle, "CENTER", -7, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="HornMarkings", textoLabel="Marcas de Cuernos:", comando="hornmarkings",
    posicionFn=function(f)
        if SubVentanaHornColor and SubVentanaHornColor:IsShown() then
            f:SetPoint("CENTER", SubVentanaHornColor, "CENTER", -11, -35)
        else
            f:SetPoint("CENTER", SubVentanaHornColor, "CENTER", -11, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="HornWraps", textoLabel="Vendajes de Cuernos:", comando="hornwraps",
    posicionFn=function(f)
        if SubVentanaHornMarkings and SubVentanaHornMarkings:IsShown() then
            f:SetPoint("CENTER", SubVentanaHornMarkings, "CENTER", -12, -35)
        else
            f:SetPoint("CENTER", SubVentanaHornMarkings, "CENTER", -12, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="Blindfold", textoLabel="Venda en los Ojos:", comando="blindfold",
    posicionFn=function(f)
        if SubVentanaHornWraps and SubVentanaHornWraps:IsShown() then
            f:SetPoint("CENTER", SubVentanaHornWraps, "CENTER", 17, -35)
        else
            f:SetPoint("CENTER", SubVentanaHornWraps, "CENTER", 17, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcion({
    nombre="Horns", textoLabel="Cuernos:", comando="horns",
    posicionFn=function(f)
        if SubVentanaBlindfold and SubVentanaBlindfold:IsShown() then
            f:SetPoint("CENTER", SubVentanaBlindfold, "CENTER", 71, -35)
        else
            f:SetPoint("CENTER", SubVentanaBlindfold, "CENTER", 71, 0)
        end
    end
})


NPCTinkerCrearSubVentanaOpcion({
    nombre="HornAccessories", textoLabel="Accesorios de Cuernos:", comando="hornaccessories",
    posicionFn=function(f)
        if SubVentanaHorns and SubVentanaHorns:IsShown() then
            f:SetPoint("CENTER", SubVentanaHorns, "CENTER", -106, -35)
        else
            f:SetPoint("CENTER", SubVentanaHorns, "CENTER", -106, 0)
        end
    end
})













-- ===============================
-- EVENTOS GENERALES
-- ===============================

local FrameCara = CreateFrame("Frame")
FrameCara:RegisterEvent("ADDON_LOADED")
FrameCara:RegisterEvent("CHAT_MSG_SYSTEM")

-- Registramos el refresco de UI en la tabla compartida.
-- ProcesarNPCInfo lo llamará una vez que NPCRazaGenero esté actualizado.
table.insert(NPCTinker_UIActualizadores, function()
    for _, datos in pairs(NPCTinkerOpcionesCara) do
        if datos.actualizar then datos.actualizar() end
    end
end)

FrameCara:SetScript("OnEvent", function(_, event)
    if event == "ADDON_LOADED" then
        for _, datos in pairs(NPCTinkerOpcionesCara) do
            if datos.actualizar then datos.actualizar() end
        end
    else
        -- CHAT_MSG_SYSTEM: refresco por si un comando externo cambió algo
        C_Timer.After(0.05, function()
            for _, datos in pairs(NPCTinkerOpcionesCara) do
                if datos.actualizar then datos.actualizar() end
            end
        end)
    end
end)











































---------------------------------------------------------------------------

-- ===============================
-- VENTANA OPCIONES DE CABELLO
-- ===============================

local VentanaOpcionesCabello = CreateFrame("Frame", "VentanaOpcionesCabello", SubventanaNPCEdit, "BackdropTemplate")
VentanaOpcionesCabello:SetSize(300, 350)
VentanaOpcionesCabello:SetPoint("TOP", SubventanaNPCEdit, "BOTTOM", 0, -55)
VentanaOpcionesCabello:SetBackdrop(nil)
VentanaOpcionesCabello:Hide()

-- Toggle con botón principal
BotonEditarNPCCabello:HookScript("OnClick", function()
    if VentanaOpcionesCabello:IsShown() then
        VentanaOpcionesCabello:Hide()
    else
        VentanaOpcionesCabello:Show()
        ReposicionarBoton(VentanaOpcionesCabello)
    end
end)

-- Cerrar con otros botones
local function CerrarVentanaOpcionesCabello()
    VentanaOpcionesCabello:Hide()
end
for _, BotonCerrarVentana in ipairs({
    BotonEditarNPCRaza, BotonEditarNPCCara,
    BotonEditarNPCAbalorios, BotonEditarNPCCuerpo, BotonEditarNPCChat
}) do
    BotonCerrarVentana:HookScript("OnClick", CerrarVentanaOpcionesCabello)
end



-- ===============================
-- FUNCIÓN GENÉRICA SUBVENTANAS
-- ===============================

local NPCTinkerOpcionesCabello = {}

local function NPCTinkerCrearSubVentanaOpcionCabello(configuracion)
    local datosVentana = {
        numero = 0,
        valor = 1,
        texto = nil,
        frame = nil,
        editBoxFrame = nil,
    }
    NPCTinkerOpcionesCabello[configuracion.nombre] = datosVentana

    local MarcoOpcion = CreateFrame("Frame", "SubVentana"..configuracion.nombre, VentanaOpcionesCabello, "BackdropTemplate")
    MarcoOpcion:SetSize(240, 60)
    MarcoOpcion:SetBackdrop(nil)
    MarcoOpcion:Hide()
    datosVentana.frame = MarcoOpcion

    configuracion.posicionFn(MarcoOpcion)

    -- Etiqueta
    local EtiquetaOpcion = MarcoOpcion:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    EtiquetaOpcion:SetPoint("LEFT", MarcoOpcion, "LEFT", 7, 0)
    EtiquetaOpcion:SetFont("Fonts\\FRIZQT__.TTF", 14)
    EtiquetaOpcion:SetText(configuracion.textoLabel)

    -- Botón Izquierda
    local BotonIzquierda = CreateFrame("Button", nil, MarcoOpcion)
    BotonIzquierda:SetSize(35, 35)
    BotonIzquierda:SetPoint("LEFT", EtiquetaOpcion, "RIGHT", 16, 0)
    BotonIzquierda:SetNormalTexture("Interface\\AddOns\\NPCTinker\\imagenes\\izq-n.blp")
    BotonIzquierda:SetPushedTexture("Interface\\AddOns\\NPCTinker\\imagenes\\izq-n.blp")
    BotonIzquierda:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\izq-h.blp", "ADD")
    BotonIzquierda:SetScript("OnClick", function()
        if datosVentana.valor > 1 then
            datosVentana.valor = datosVentana.valor - 1
            datosVentana.texto:SetText(datosVentana.valor.." / "..datosVentana.numero)
            SendChatMessage(".ph forge npc outfit custo "..configuracion.comando.." "..datosVentana.valor, "GUILD")
        end
    end)

    -- Botón Derecha
    local BotonDerecha = CreateFrame("Button", nil, MarcoOpcion)
    BotonDerecha:SetSize(35, 35)
    BotonDerecha:SetPoint("LEFT", BotonIzquierda, "RIGHT", 107, 0)
    BotonDerecha:SetNormalTexture("Interface\\AddOns\\NPCTinker\\imagenes\\der-n.blp")
    BotonDerecha:SetPushedTexture("Interface\\AddOns\\NPCTinker\\imagenes\\der-n.blp")
    BotonDerecha:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\der-h.blp", "ADD")
    BotonDerecha:SetScript("OnClick", function()
        if datosVentana.valor < datosVentana.numero then
            datosVentana.valor = datosVentana.valor + 1
            datosVentana.texto:SetText(datosVentana.valor.." / "..datosVentana.numero)
            SendChatMessage(".ph forge npc outfit custo "..configuracion.comando.." "..datosVentana.valor, "GUILD")
        end
    end)

    -- Botón Central con número
    local BotonCentral = CreateFrame("Button", nil, MarcoOpcion)
    BotonCentral:SetSize(110, 64)
    BotonCentral:SetPoint("LEFT", BotonIzquierda, "RIGHT", -2, 0)
    BotonCentral:SetNormalTexture("Interface\\AddOns\\NPCTinker\\imagenes\\boton-n.blp")
    BotonCentral:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\boton-h.blp", "ADD")

    datosVentana.texto = BotonCentral:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    datosVentana.texto:SetPoint("CENTER", BotonCentral, "CENTER", 0, 0)
    datosVentana.texto:SetFont("Fonts\\FRIZQT__.TTF", 14)
    datosVentana.texto:SetText(datosVentana.valor.." / "..datosVentana.numero)

    -- EditBox toggle
    BotonCentral:SetScript("OnClick", function()
        if datosVentana.editBoxFrame then
            datosVentana.editBoxFrame:Hide()
            datosVentana.editBoxFrame = nil
            return
        end
        local MarcoEditBox = CreateFrame("Frame", nil, MarcoOpcion, "BackdropTemplate")
        MarcoEditBox:SetSize(80, 36)
        MarcoEditBox:SetPoint("LEFT", BotonDerecha, "RIGHT", 10, 0)
        MarcoEditBox:SetBackdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true, tileSize = 16, edgeSize = 16,
            insets = { left=4, right=4, top=4, bottom=4 }
        })
        MarcoEditBox:SetBackdropColor(0,0,0,0.7)

        local CajaTexto = CreateFrame("EditBox", nil, MarcoEditBox, "InputBoxTemplate")
        CajaTexto:SetSize(50,20)
        CajaTexto:SetPoint("CENTER", MarcoEditBox, "CENTER", 2, 0)
        CajaTexto:SetFont("Fonts\\FRIZQT__.TTF", 14)
        CajaTexto:SetAutoFocus(true)
        CajaTexto:SetText(tostring(datosVentana.valor))
        CajaTexto:SetMaxLetters(2)
        CajaTexto:SetNumeric(true)

        CajaTexto:SetScript("OnEnterPressed", function(self)
            local valorIngresado = tonumber(self:GetText())
            if valorIngresado then
                if valorIngresado < 1 then valorIngresado = 1 end
                if valorIngresado > datosVentana.numero then valorIngresado = datosVentana.numero end
                datosVentana.valor = valorIngresado
                datosVentana.texto:SetText(datosVentana.valor.." / "..datosVentana.numero)
                SendChatMessage(".ph forge npc outfit custo "..configuracion.comando.." "..datosVentana.valor, "GUILD")
            end
            self:ClearFocus()
            MarcoEditBox:Hide()
            datosVentana.editBoxFrame = nil
        end)
        datosVentana.editBoxFrame = MarcoEditBox
    end)

    -- Función de actualización
    datosVentana.actualizar = function()
        MarcoOpcion:ClearAllPoints()
        configuracion.posicionFn(MarcoOpcion)
        local raza, genero = (NPCRazaGenero or ""):match("^([^_]+)_([^_]+)$")
        local nuevoNumero = 0
        if raza and genero and TablaOpcionesCustomizacionRaza then
            local datosRaza = TablaOpcionesCustomizacionRaza[raza]
            local datosGenero = datosRaza and datosRaza[genero]
            if datosGenero and datosGenero[configuracion.comando] then
                nuevoNumero = datosGenero[configuracion.comando]
            end
        end
        if datosVentana.numero ~= nuevoNumero then
            datosVentana.numero = nuevoNumero
            if datosVentana.valor > datosVentana.numero then datosVentana.valor = 1 end
            datosVentana.texto:SetText(datosVentana.valor.." / "..datosVentana.numero)
            if datosVentana.numero == 0 then MarcoOpcion:Hide() else MarcoOpcion:Show() end
        end
    end
end


-- ===============================
-- CREACIÓN DE TODAS LAS OPCIONES
-- ===============================

NPCTinkerCrearSubVentanaOpcionCabello({
    nombre="HairStyle", textoLabel="Peinado:", comando="hairstyle",
    posicionFn=function(f) f:SetPoint("CENTER", VentanaOpcionesCabello, "CENTER", 21, 150) end
})

NPCTinkerCrearSubVentanaOpcionCabello({
    nombre="HairColor", textoLabel="Color de Pelo:", comando="haircolor",
    posicionFn=function(f)
        if SubVentanaHairStyle and SubVentanaHairStyle:IsShown() then
            f:SetPoint("CENTER", SubVentanaHairStyle, "CENTER", -40, -35)
        else
            f:SetPoint("CENTER", SubVentanaHairStyle, "CENTER", -40, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionCabello({
    nombre="HairGradient", textoLabel="Color degradado de Pelo:", comando="hairgradient",
    posicionFn=function(f)
        if SubVentanaHairColor and SubVentanaHairColor:IsShown() then
            f:SetPoint("CENTER", SubVentanaHairColor, "CENTER", -79, -35)
        else
            f:SetPoint("CENTER", SubVentanaHairColor, "CENTER", -79, 0)
        end
    end
})


NPCTinkerCrearSubVentanaOpcionCabello({
    nombre="HairStreaks", textoLabel="Color de Mechas:", comando="hairstreaks",
    posicionFn=function(f)
        if SubVentanaHairGradient and SubVentanaHairGradient:IsShown() then
            f:SetPoint("CENTER", SubVentanaHairGradient, "CENTER", 57, -35)
        else
            f:SetPoint("CENTER", SubVentanaHairGradient, "CENTER", 57, 0)
        end
    end
})


NPCTinkerCrearSubVentanaOpcionCabello({
    nombre="FurColor", textoLabel="Color de Pelaje:", comando="furcolor",
    posicionFn=function(f)
        if SubVentanaHairStreaks and SubVentanaHairStreaks:IsShown() then
            f:SetPoint("CENTER", SubVentanaHairStreaks, "CENTER", 12, -35)
        else
            f:SetPoint("CENTER", SubVentanaHairStreaks, "CENTER", 12, 0)
        end
    end
})


NPCTinkerCrearSubVentanaOpcionCabello({
    nombre="Mane", textoLabel="Melena:", comando="mane",
    posicionFn=function(f)
        if SubVentanaFurColor and SubVentanaFurColor:IsShown() then
            f:SetPoint("CENTER", SubVentanaFurColor, "CENTER", 55, -35)
        else
            f:SetPoint("CENTER", SubVentanaFurColor, "CENTER", 55, 0)
        end
    end
})


NPCTinkerCrearSubVentanaOpcionCabello({
    nombre="Foremane", textoLabel="Flequillo:", comando="foremane",
    posicionFn=function(f)
        if SubVentanaMane and SubVentanaMane:IsShown() then
            f:SetPoint("CENTER", SubVentanaMane, "CENTER", -7, -35)
        else
            f:SetPoint("CENTER", SubVentanaMane, "CENTER", -7, 0)
        end
    end
})


NPCTinkerCrearSubVentanaOpcionCabello({
    nombre="Vines", textoLabel="Enredaderas:", comando="vines",
    posicionFn=function(f)
        if SubVentanaForemane and SubVentanaForemane:IsShown() then
            f:SetPoint("CENTER", SubVentanaForemane, "CENTER", -23, -35)
        else
            f:SetPoint("CENTER", SubVentanaForemane, "CENTER", -23, 0)
        end
    end
})


NPCTinkerCrearSubVentanaOpcionCabello({
    nombre="VineColor", textoLabel="Color de Enredaderas:", comando="vinecolor",
    posicionFn=function(f)
        if SubVentanaVines and SubVentanaVines:IsShown() then
            f:SetPoint("CENTER", SubVentanaVines, "CENTER", -65, -35)
        else
            f:SetPoint("CENTER", SubVentanaVines, "CENTER", -65, 0)
        end
    end
})


NPCTinkerCrearSubVentanaOpcionCabello({
    nombre="Eyebrows", textoLabel="Cejas:", comando="eyebrows",
    posicionFn=function(f)
        if SubVentanaVineColor and SubVentanaVineColor:IsShown() then
            f:SetPoint("CENTER", SubVentanaVineColor, "CENTER", 111, -35)
        else
            f:SetPoint("CENTER", SubVentanaVineColor, "CENTER", 111, 0)
        end
    end
})


NPCTinkerCrearSubVentanaOpcionCabello({
    nombre="FacialHair", textoLabel="Vello Facial:", comando="facialhair",
    posicionFn=function(f)
        if SubVentanaEyebrows and SubVentanaEyebrows:IsShown() then
            f:SetPoint("CENTER", SubVentanaEyebrows, "CENTER", -44, -35)
        else
            f:SetPoint("CENTER", SubVentanaEyebrows, "CENTER", -44, 0)
        end
    end
})


NPCTinkerCrearSubVentanaOpcionCabello({
    nombre="Beard", textoLabel="Barba:", comando="beard",
    posicionFn=function(f)
        if SubVentanaFacialHair and SubVentanaFacialHair:IsShown() then
            f:SetPoint("CENTER", SubVentanaFacialHair, "CENTER", 43, -35)
        else
            f:SetPoint("CENTER", SubVentanaFacialHair, "CENTER", 43, 0)
        end
    end
})


NPCTinkerCrearSubVentanaOpcionCabello({
    nombre="Stubble", textoLabel="Barba en la Piel:", comando="stubble",
    posicionFn=function(f)
        if SubVentanaBeard and SubVentanaBeard:IsShown() then
            f:SetPoint("CENTER", SubVentanaBeard, "CENTER", -70, -35)
        else
            f:SetPoint("CENTER", SubVentanaBeard, "CENTER", -70, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionCabello({
    nombre="Sideburns", textoLabel="Patillas:", comando="sideburns",
    posicionFn=function(f)
        if SubVentanaStubble and SubVentanaStubble:IsShown() then
            f:SetPoint("CENTER", SubVentanaStubble, "CENTER", 60, -35)
        else
            f:SetPoint("CENTER", SubVentanaStubble, "CENTER", 60, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionCabello({
    nombre="Mustache", textoLabel="Bigote:", comando="mustache",
    posicionFn=function(f)
        if SubVentanaSideburns and SubVentanaSideburns:IsShown() then
            f:SetPoint("CENTER", SubVentanaSideburns, "CENTER", 4, -35)
        else
            f:SetPoint("CENTER", SubVentanaSideburns, "CENTER", 4, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionCabello({
    nombre="goatee", textoLabel="Perilla:", comando="goatee",
    posicionFn=function(f)
        if SubVentanaMustache and SubVentanaMustache:IsShown() then
            f:SetPoint("CENTER", SubVentanaMustache, "CENTER", 4, -35)
        else
            f:SetPoint("CENTER", SubVentanaMustache, "CENTER", 4, 0)
        end
    end
})




-- ===============================
-- EVENTOS GENERALES
-- ===============================

local FrameCabello = CreateFrame("Frame")
FrameCabello:RegisterEvent("ADDON_LOADED")
FrameCabello:RegisterEvent("CHAT_MSG_SYSTEM")

table.insert(NPCTinker_UIActualizadores, function()
    for _, datos in pairs(NPCTinkerOpcionesCabello) do
        if datos.actualizar then datos.actualizar() end
    end
end)

FrameCabello:SetScript("OnEvent", function(_, event)
    if event == "ADDON_LOADED" then
        for _, datos in pairs(NPCTinkerOpcionesCabello) do
            if datos.actualizar then datos.actualizar() end
        end
    else
        C_Timer.After(0.05, function()
            for _, datos in pairs(NPCTinkerOpcionesCabello) do
                if datos.actualizar then datos.actualizar() end
            end
        end)
    end
end)

















-- ===============================

-- ===============================

-- ===============================

-- ===============================

-- ===============================











-- ===============================
-- VENTANA OPCIONES DE ABALORIOS
-- ===============================

local VentanaOpcionesAbalorios = CreateFrame("Frame", "VentanaOpcionesAbalorios", SubventanaNPCEdit, "BackdropTemplate")
VentanaOpcionesAbalorios:SetSize(300, 350)
VentanaOpcionesAbalorios:SetPoint("TOP", SubventanaNPCEdit, "BOTTOM", 0, -55)
VentanaOpcionesAbalorios:SetBackdrop(nil)
VentanaOpcionesAbalorios:Hide()

-- Toggle con botón principal
BotonEditarNPCAbalorios:HookScript("OnClick", function()
    if VentanaOpcionesAbalorios:IsShown() then
        VentanaOpcionesAbalorios:Hide()
    else
        VentanaOpcionesAbalorios:Show()
        ReposicionarBoton(VentanaOpcionesAbalorios)
    end
end)

-- Cerrar con otros botones
local function CerrarVentanaOpcionesAbalorios()
    VentanaOpcionesAbalorios:Hide()
end
for _, BotonCerrarVentana in ipairs({
    BotonEditarNPCRaza, BotonEditarNPCCara,
    BotonEditarNPCCabello, BotonEditarNPCCuerpo, BotonEditarNPCChat
}) do
    BotonCerrarVentana:HookScript("OnClick", CerrarVentanaOpcionesAbalorios)
end


-- ===============================
-- FUNCIÓN GENÉRICA SUBVENTANAS
-- ===============================

local NPCTinkerOpcionesAbalorios = {}

local function NPCTinkerCrearSubVentanaOpcionAbalorios(configuracion)
    local datosVentana = {
        numero = 0,
        valor = 1,
        texto = nil,
        frame = nil,
        editBoxFrame = nil,
    }
    NPCTinkerOpcionesAbalorios[configuracion.nombre] = datosVentana

    local MarcoOpcion = CreateFrame("Frame", "SubVentana"..configuracion.nombre, VentanaOpcionesAbalorios, "BackdropTemplate")
    MarcoOpcion:SetSize(240, 60)
    MarcoOpcion:SetBackdrop(nil)
    MarcoOpcion:Hide()
    datosVentana.frame = MarcoOpcion

    configuracion.posicionFn(MarcoOpcion)

    -- Etiqueta
    local EtiquetaOpcion = MarcoOpcion:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    EtiquetaOpcion:SetPoint("LEFT", MarcoOpcion, "LEFT", 7, 0)
    EtiquetaOpcion:SetFont("Fonts\\FRIZQT__.TTF", 14)
    EtiquetaOpcion:SetText(configuracion.textoLabel)

    -- Botón Izquierda
    local BotonIzquierda = CreateFrame("Button", nil, MarcoOpcion)
    BotonIzquierda:SetSize(35, 35)
    BotonIzquierda:SetPoint("LEFT", EtiquetaOpcion, "RIGHT", 16, 0)
    BotonIzquierda:SetNormalTexture("Interface\\AddOns\\NPCTinker\\imagenes\\izq-n.blp")
    BotonIzquierda:SetPushedTexture("Interface\\AddOns\\NPCTinker\\imagenes\\izq-n.blp")
    BotonIzquierda:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\izq-h.blp", "ADD")
    BotonIzquierda:SetScript("OnClick", function()
        if datosVentana.valor > 1 then
            datosVentana.valor = datosVentana.valor - 1
            datosVentana.texto:SetText(datosVentana.valor.." / "..datosVentana.numero)
            SendChatMessage(".ph forge npc outfit custo "..configuracion.comando.." "..datosVentana.valor, "GUILD")
        end
    end)

    -- Botón Derecha
    local BotonDerecha = CreateFrame("Button", nil, MarcoOpcion)
    BotonDerecha:SetSize(35, 35)
    BotonDerecha:SetPoint("LEFT", BotonIzquierda, "RIGHT", 107, 0)
    BotonDerecha:SetNormalTexture("Interface\\AddOns\\NPCTinker\\imagenes\\der-n.blp")
    BotonDerecha:SetPushedTexture("Interface\\AddOns\\NPCTinker\\imagenes\\der-n.blp")
    BotonDerecha:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\der-h.blp", "ADD")
    BotonDerecha:SetScript("OnClick", function()
        if datosVentana.valor < datosVentana.numero then
            datosVentana.valor = datosVentana.valor + 1
            datosVentana.texto:SetText(datosVentana.valor.." / "..datosVentana.numero)
            SendChatMessage(".ph forge npc outfit custo "..configuracion.comando.." "..datosVentana.valor, "GUILD")
        end
    end)

    -- Botón Central con número
    local BotonCentral = CreateFrame("Button", nil, MarcoOpcion)
    BotonCentral:SetSize(110, 64)
    BotonCentral:SetPoint("LEFT", BotonIzquierda, "RIGHT", -2, 0)
    BotonCentral:SetNormalTexture("Interface\\AddOns\\NPCTinker\\imagenes\\boton-n.blp")
    BotonCentral:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\boton-h.blp", "ADD")

    datosVentana.texto = BotonCentral:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    datosVentana.texto:SetPoint("CENTER", BotonCentral, "CENTER", 0, 0)
    datosVentana.texto:SetFont("Fonts\\FRIZQT__.TTF", 14)
    datosVentana.texto:SetText(datosVentana.valor.." / "..datosVentana.numero)

    -- EditBox toggle
    BotonCentral:SetScript("OnClick", function()
        if datosVentana.editBoxFrame then
            datosVentana.editBoxFrame:Hide()
            datosVentana.editBoxFrame = nil
            return
        end
        local MarcoEditBox = CreateFrame("Frame", nil, MarcoOpcion, "BackdropTemplate")
        MarcoEditBox:SetSize(80, 36)
        MarcoEditBox:SetPoint("LEFT", BotonDerecha, "RIGHT", 10, 0)
        MarcoEditBox:SetBackdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true, tileSize = 16, edgeSize = 16,
            insets = { left=4, right=4, top=4, bottom=4 }
        })
        MarcoEditBox:SetBackdropColor(0,0,0,0.7)

        local CajaTexto = CreateFrame("EditBox", nil, MarcoEditBox, "InputBoxTemplate")
        CajaTexto:SetSize(50,20)
        CajaTexto:SetPoint("CENTER", MarcoEditBox, "CENTER", 2, 0)
        CajaTexto:SetFont("Fonts\\FRIZQT__.TTF", 14)
        CajaTexto:SetAutoFocus(true)
        CajaTexto:SetText(tostring(datosVentana.valor))
        CajaTexto:SetMaxLetters(2)
        CajaTexto:SetNumeric(true)

        CajaTexto:SetScript("OnEnterPressed", function(self)
            local valorIngresado = tonumber(self:GetText())
            if valorIngresado then
                if valorIngresado < 1 then valorIngresado = 1 end
                if valorIngresado > datosVentana.numero then valorIngresado = datosVentana.numero end
                datosVentana.valor = valorIngresado
                datosVentana.texto:SetText(datosVentana.valor.." / "..datosVentana.numero)
                SendChatMessage(".ph forge npc outfit custo "..configuracion.comando.." "..datosVentana.valor, "GUILD")
            end
            self:ClearFocus()
            MarcoEditBox:Hide()
            datosVentana.editBoxFrame = nil
        end)
        datosVentana.editBoxFrame = MarcoEditBox
    end)

    -- Función de actualización
    datosVentana.actualizar = function()
        MarcoOpcion:ClearAllPoints()
        configuracion.posicionFn(MarcoOpcion)
        local raza, genero = (NPCRazaGenero or ""):match("^([^_]+)_([^_]+)$")
        local nuevoNumero = 0
        if raza and genero and TablaOpcionesCustomizacionRaza then
            local datosRaza = TablaOpcionesCustomizacionRaza[raza]
            local datosGenero = datosRaza and datosRaza[genero]
            if datosGenero and datosGenero[configuracion.comando] then
                nuevoNumero = datosGenero[configuracion.comando]
            end
        end
        if datosVentana.numero ~= nuevoNumero then
            datosVentana.numero = nuevoNumero
            if datosVentana.valor > datosVentana.numero then datosVentana.valor = 1 end
            datosVentana.texto:SetText(datosVentana.valor.." / "..datosVentana.numero)
            if datosVentana.numero == 0 then MarcoOpcion:Hide() else MarcoOpcion:Show() end
        end
    end
end


-- ===============================
-- CREACIÓN DE TODAS LAS OPCIONES
-- ===============================

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="necklace", textoLabel="Collar:", comando="necklace",
    posicionFn=function(f) f:SetPoint("CENTER", VentanaOpcionesAbalorios, "CENTER", 37, 150) end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Earrings", textoLabel="Pendientes:", comando="earrings",
    posicionFn=function(f)
        if SubVentananecklace and SubVentananecklace:IsShown() then
            f:SetPoint("CENTER", SubVentananecklace, "CENTER", -37, -35)
        else
            f:SetPoint("CENTER", SubVentananecklace, "CENTER", -37, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Eargauge", textoLabel="Dilatación de Oreja:", comando="eargauge",
    posicionFn=function(f)
        if SubVentanaEarrings and SubVentanaEarrings:IsShown() then
            f:SetPoint("CENTER", SubVentanaEarrings, "CENTER", -59, -35)
        else
            f:SetPoint("CENTER", SubVentanaEarrings, "CENTER", -59, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Piercings", textoLabel="Piercings:", comando="piercings",
    posicionFn=function(f)
        if SubVentanaEargauge and SubVentanaEargauge:IsShown() then
            f:SetPoint("CENTER", SubVentanaEargauge, "CENTER", 74, -35)
        else
            f:SetPoint("CENTER", SubVentanaEargauge, "CENTER", 74, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Nosepiercing", textoLabel="Piercings de Nariz:", comando="nosepiercing",
    posicionFn=function(f)
        if SubVentanaPiercings and SubVentanaPiercings:IsShown() then
            f:SetPoint("CENTER", SubVentanaPiercings, "CENTER", -65, -35)
        else
            f:SetPoint("CENTER", SubVentanaPiercings, "CENTER", -65, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Nosering", textoLabel="Aro en la Nariz:", comando="nosering",
    posicionFn=function(f)
        if SubVentanaNosepiercing and SubVentanaNosepiercing:IsShown() then
            f:SetPoint("CENTER", SubVentanaNosepiercing, "CENTER", 21, -35)
        else
            f:SetPoint("CENTER", SubVentanaNosepiercing, "CENTER", 21, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Mouthpiercing", textoLabel="Piercings en la Boca:", comando="mouthpiercing",
    posicionFn=function(f)
        if SubVentanaNosering and SubVentanaNosering:IsShown() then
            f:SetPoint("CENTER", SubVentanaNosering, "CENTER", -36, -35)
        else
            f:SetPoint("CENTER", SubVentanaNosering, "CENTER", -36, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Bodypiercings", textoLabel="Piercings en el Cuerpo:", comando="bodypiercings",
    posicionFn=function(f)
        if SubVentanaMouthpiercing and SubVentanaMouthpiercing:IsShown() then
            f:SetPoint("CENTER", SubVentanaMouthpiercing, "CENTER", -17, -35)
        else
            f:SetPoint("CENTER", SubVentanaMouthpiercing, "CENTER", -17, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Feather", textoLabel="Plumas:", comando="feather",
    posicionFn=function(f)
        if SubVentanaBodypiercings and SubVentanaBodypiercings:IsShown() then
            f:SetPoint("CENTER", SubVentanaBodypiercings, "CENTER", 112, -35)
        else
            f:SetPoint("CENTER", SubVentanaBodypiercings, "CENTER", 112, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Feathercolor", textoLabel="Color de las Plumas:", comando="feathercolor",
    posicionFn=function(f)
        if SubVentanaFeather and SubVentanaFeather:IsShown() then
            f:SetPoint("CENTER", SubVentanaFeather, "CENTER", -89, -35)
        else
            f:SetPoint("CENTER", SubVentanaFeather, "CENTER", -89, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Headdress", textoLabel="Diadema:", comando="headdress",
    posicionFn=function(f)
        if SubVentanaFeathercolor and SubVentanaFeathercolor:IsShown() then
            f:SetPoint("CENTER", SubVentanaFeathercolor, "CENTER", 76, -35)
        else
            f:SetPoint("CENTER", SubVentanaFeathercolor, "CENTER", 76, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Goggles", textoLabel="Gafas:", comando="goggles",
    posicionFn=function(f)
        if SubVentanaHeaddress and SubVentanaHeaddress:IsShown() then
            f:SetPoint("CENTER", SubVentanaHeaddress, "CENTER", 23, -35)
        else
            f:SetPoint("CENTER", SubVentanaHeaddress, "CENTER", 23, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Optics", textoLabel="Ópticas:", comando="optics",
    posicionFn=function(f)
        if SubVentanaGoggles and SubVentanaGoggles:IsShown() then
            f:SetPoint("CENTER", SubVentanaGoggles, "CENTER", -16, -35)
        else
            f:SetPoint("CENTER", SubVentanaGoggles, "CENTER", -16, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Facefeatures", textoLabel="Rasgos Faciales:", comando="facefeatures",
    posicionFn=function(f)
        if SubVentanaOptics and SubVentanaOptics:IsShown() then
            f:SetPoint("CENTER", SubVentanaOptics, "CENTER", -56, -35)
        else
            f:SetPoint("CENTER", SubVentanaOptics, "CENTER", -56, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Flower", textoLabel="Flor:", comando="flower",
    posicionFn=function(f)
        if SubVentanaFacefeatures and SubVentanaFacefeatures:IsShown() then
            f:SetPoint("CENTER", SubVentanaFacefeatures, "CENTER", 86, -35)
        else
            f:SetPoint("CENTER", SubVentanaFacefeatures, "CENTER", 86, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Facejewelry", textoLabel="Joyería Facial:", comando="facejewelry",
    posicionFn=function(f)
        if SubVentanaFlower and SubVentanaFlower:IsShown() then
            f:SetPoint("CENTER", SubVentanaFlower, "CENTER", -67, -35)
        else
            f:SetPoint("CENTER", SubVentanaFlower, "CENTER", -67, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Jawjewelry", textoLabel="Joyería de Mandíbula:", comando="jawjewelry",
    posicionFn=function(f)
        if SubVentanaFacejewelry and SubVentanaFacejewelry:IsShown() then
            f:SetPoint("CENTER", SubVentanaFacejewelry, "CENTER", -57, -35)
        else
            f:SetPoint("CENTER", SubVentanaFacejewelry, "CENTER", -57, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Chinjewelry", textoLabel="Joyería de Barbilla:", comando="chinjewelry",
    posicionFn=function(f)
        if SubVentanaJawjewelry and SubVentanaJawjewelry:IsShown() then
            f:SetPoint("CENTER", SubVentanaJawjewelry, "CENTER", 23, -35)
        else
            f:SetPoint("CENTER", SubVentanaJawjewelry, "CENTER", 23, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Handjewelry", textoLabel="Joyería en las Manos:", comando="handjewelry",
    posicionFn=function(f)
        if SubVentanaChinjewelry and SubVentanaChinjewelry:IsShown() then
            f:SetPoint("CENTER", SubVentanaChinjewelry, "CENTER", -20, -35)
        else
            f:SetPoint("CENTER", SubVentanaChinjewelry, "CENTER", -20, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Jewelrycolor", textoLabel="Color de Joyería:", comando="jewelrycolor",
    posicionFn=function(f)
        if SubVentanaHandjewelry and SubVentanaHandjewelry:IsShown() then
            f:SetPoint("CENTER", SubVentanaHandjewelry, "CENTER", 34, -35)
        else
            f:SetPoint("CENTER", SubVentanaHandjewelry, "CENTER", 34, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Gemcolor", textoLabel="Color de las Gemas:", comando="gemcolor",
    posicionFn=function(f)
        if SubVentanaJewelrycolor and SubVentanaJewelrycolor:IsShown() then
            f:SetPoint("CENTER", SubVentanaJewelrycolor, "CENTER", -23, -35)
        else
            f:SetPoint("CENTER", SubVentanaJewelrycolor, "CENTER", -23, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Accentcolor", textoLabel="Color de Vestimentas:", comando="accentcolor",
    posicionFn=function(f)
        if SubVentanaGemcolor and SubVentanaGemcolor:IsShown() then
            f:SetPoint("CENTER", SubVentanaGemcolor, "CENTER", -14, -35)
        else
            f:SetPoint("CENTER", SubVentanaGemcolor, "CENTER", -14, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Facemodification", textoLabel="Modificación Facial:", comando="facemodification",
    posicionFn=function(f)
        if SubVentanaAccentcolor and SubVentanaAccentcolor:IsShown() then
            f:SetPoint("CENTER", SubVentanaAccentcolor, "CENTER", 10, -35)
        else
            f:SetPoint("CENTER", SubVentanaAccentcolor, "CENTER", 10, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Earmodification", textoLabel="Modificación de las Orejas:", comando="earmodification",
    posicionFn=function(f)
        if SubVentanaFacemodification and SubVentanaFacemodification:IsShown() then
            f:SetPoint("CENTER", SubVentanaFacemodification, "CENTER", -52, -35)
        else
            f:SetPoint("CENTER", SubVentanaFacemodification, "CENTER", -52, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Chinmodification", textoLabel="Modificación de la Barbilla:", comando="chinmodification",
    posicionFn=function(f)
        if SubVentanaEarmodification and SubVentanaEarmodification:IsShown() then
            f:SetPoint("CENTER", SubVentanaEarmodification, "CENTER", 0, -35)
        else
            f:SetPoint("CENTER", SubVentanaEarmodification, "CENTER", 0, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionAbalorios({
    nombre="Chestmodification", textoLabel="Modificación del Pecho:", comando="chestmodification",
    posicionFn=function(f)
        if SubVentanaChinmodification and SubVentanaChinmodification:IsShown() then
            f:SetPoint("CENTER", SubVentanaChinmodification, "CENTER", 22, -35)
        else
            f:SetPoint("CENTER", SubVentanaChinmodification, "CENTER", 22, 0)
        end
    end
})



-- ===============================
-- EVENTOS GENERALES
-- ===============================

local FrameAbalorios = CreateFrame("Frame")
FrameAbalorios:RegisterEvent("ADDON_LOADED")
FrameAbalorios:RegisterEvent("CHAT_MSG_SYSTEM")

table.insert(NPCTinker_UIActualizadores, function()
    for _, datos in pairs(NPCTinkerOpcionesAbalorios) do
        if datos.actualizar then datos.actualizar() end
    end
end)

FrameAbalorios:SetScript("OnEvent", function(_, event)
    if event == "ADDON_LOADED" then
        for _, datos in pairs(NPCTinkerOpcionesAbalorios) do
            if datos.actualizar then datos.actualizar() end
        end
    else
        C_Timer.After(0.05, function()
            for _, datos in pairs(NPCTinkerOpcionesAbalorios) do
                if datos.actualizar then datos.actualizar() end
            end
        end)
    end
end)





















-- ===============================

-- ===============================

-- ===============================

-- ===============================

-- ===============================





-- ===============================
-- VENTANA OPCIONES DE CUERPO
-- ===============================

local VentanaOpcionesCuerpo = CreateFrame("Frame", "VentanaOpcionesCuerpo", SubventanaNPCEdit, "BackdropTemplate")
VentanaOpcionesCuerpo:SetSize(300, 350)
VentanaOpcionesCuerpo:SetPoint("TOP", SubventanaNPCEdit, "BOTTOM", 0, -55)
VentanaOpcionesCuerpo:SetBackdrop(nil)
VentanaOpcionesCuerpo:Hide()

-- Toggle con botón principal
BotonEditarNPCCuerpo:HookScript("OnClick", function()
    if VentanaOpcionesCuerpo:IsShown() then
        VentanaOpcionesCuerpo:Hide()
    else
        VentanaOpcionesCuerpo:Show()
        ReposicionarBoton(VentanaOpcionesCuerpo)
    end
end)

-- Cerrar con otros botones
local function CerrarVentanaOpcionesCuerpo()
    VentanaOpcionesCuerpo:Hide()
end
for _, BotonCerrarVentana in ipairs({
    BotonEditarNPCRaza, BotonEditarNPCCara,
    BotonEditarNPCCabello, BotonEditarNPCAbalorios, BotonEditarNPCChat
}) do
    BotonCerrarVentana:HookScript("OnClick", CerrarVentanaOpcionesCuerpo)
end


-- ===============================
-- FUNCIÓN GENÉRICA SUBVENTANAS
-- ===============================

local NPCTinkerOpcionesCuerpo = {}

local function NPCTinkerCrearSubVentanaOpcionCuerpo(configuracion)
    local datosVentana = {
        numero = 0,
        valor = 1,
        texto = nil,
        frame = nil,
        editBoxFrame = nil,
    }
    NPCTinkerOpcionesCuerpo[configuracion.nombre] = datosVentana

    local MarcoOpcion = CreateFrame("Frame", "SubVentana"..configuracion.nombre, VentanaOpcionesCuerpo, "BackdropTemplate")
    MarcoOpcion:SetSize(240, 60)
    MarcoOpcion:SetBackdrop(nil)
    MarcoOpcion:Hide()
    datosVentana.frame = MarcoOpcion

    configuracion.posicionFn(MarcoOpcion)

    -- Etiqueta
    local EtiquetaOpcion = MarcoOpcion:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    EtiquetaOpcion:SetPoint("LEFT", MarcoOpcion, "LEFT", 7, 0)
    EtiquetaOpcion:SetFont("Fonts\\FRIZQT__.TTF", 14)
    EtiquetaOpcion:SetText(configuracion.textoLabel)

    -- Botón Izquierda
    local BotonIzquierda = CreateFrame("Button", nil, MarcoOpcion)
    BotonIzquierda:SetSize(35, 35)
    BotonIzquierda:SetPoint("LEFT", EtiquetaOpcion, "RIGHT", 16, 0)
    BotonIzquierda:SetNormalTexture("Interface\\AddOns\\NPCTinker\\imagenes\\izq-n.blp")
    BotonIzquierda:SetPushedTexture("Interface\\AddOns\\NPCTinker\\imagenes\\izq-n.blp")
    BotonIzquierda:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\izq-h.blp", "ADD")
    BotonIzquierda:SetScript("OnClick", function()
        if datosVentana.valor > 1 then
            datosVentana.valor = datosVentana.valor - 1
            datosVentana.texto:SetText(datosVentana.valor.." / "..datosVentana.numero)
            SendChatMessage(".ph forge npc outfit custo "..configuracion.comando.." "..datosVentana.valor, "GUILD")
        end
    end)

    -- Botón Derecha
    local BotonDerecha = CreateFrame("Button", nil, MarcoOpcion)
    BotonDerecha:SetSize(35, 35)
    BotonDerecha:SetPoint("LEFT", BotonIzquierda, "RIGHT", 107, 0)
    BotonDerecha:SetNormalTexture("Interface\\AddOns\\NPCTinker\\imagenes\\der-n.blp")
    BotonDerecha:SetPushedTexture("Interface\\AddOns\\NPCTinker\\imagenes\\der-n.blp")
    BotonDerecha:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\der-h.blp", "ADD")
    BotonDerecha:SetScript("OnClick", function()
        if datosVentana.valor < datosVentana.numero then
            datosVentana.valor = datosVentana.valor + 1
            datosVentana.texto:SetText(datosVentana.valor.." / "..datosVentana.numero)
            SendChatMessage(".ph forge npc outfit custo "..configuracion.comando.." "..datosVentana.valor, "GUILD")
        end
    end)

    -- Botón Central con número
    local BotonCentral = CreateFrame("Button", nil, MarcoOpcion)
    BotonCentral:SetSize(110, 64)
    BotonCentral:SetPoint("LEFT", BotonIzquierda, "RIGHT", -2, 0)
    BotonCentral:SetNormalTexture("Interface\\AddOns\\NPCTinker\\imagenes\\boton-n.blp")
    BotonCentral:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\boton-h.blp", "ADD")

    datosVentana.texto = BotonCentral:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    datosVentana.texto:SetPoint("CENTER", BotonCentral, "CENTER", 0, 0)
    datosVentana.texto:SetFont("Fonts\\FRIZQT__.TTF", 14)
    datosVentana.texto:SetText(datosVentana.valor.." / "..datosVentana.numero)

    -- EditBox toggle
    BotonCentral:SetScript("OnClick", function()
        if datosVentana.editBoxFrame then
            datosVentana.editBoxFrame:Hide()
            datosVentana.editBoxFrame = nil
            return
        end
        local MarcoEditBox = CreateFrame("Frame", nil, MarcoOpcion, "BackdropTemplate")
        MarcoEditBox:SetSize(80, 36)
        MarcoEditBox:SetPoint("LEFT", BotonDerecha, "RIGHT", 10, 0)
        MarcoEditBox:SetBackdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true, tileSize = 16, edgeSize = 16,
            insets = { left=4, right=4, top=4, bottom=4 }
        })
        MarcoEditBox:SetBackdropColor(0,0,0,0.7)

        local CajaTexto = CreateFrame("EditBox", nil, MarcoEditBox, "InputBoxTemplate")
        CajaTexto:SetSize(50,20)
        CajaTexto:SetPoint("CENTER", MarcoEditBox, "CENTER", 2, 0)
        CajaTexto:SetFont("Fonts\\FRIZQT__.TTF", 14)
        CajaTexto:SetAutoFocus(true)
        CajaTexto:SetText(tostring(datosVentana.valor))
        CajaTexto:SetMaxLetters(2)
        CajaTexto:SetNumeric(true)

        CajaTexto:SetScript("OnEnterPressed", function(self)
            local valorIngresado = tonumber(self:GetText())
            if valorIngresado then
                if valorIngresado < 1 then valorIngresado = 1 end
                if valorIngresado > datosVentana.numero then valorIngresado = datosVentana.numero end
                datosVentana.valor = valorIngresado
                datosVentana.texto:SetText(datosVentana.valor.." / "..datosVentana.numero)
                SendChatMessage(".ph forge npc outfit custo "..configuracion.comando.." "..datosVentana.valor, "GUILD")
            end
            self:ClearFocus()
            MarcoEditBox:Hide()
            datosVentana.editBoxFrame = nil
        end)
        datosVentana.editBoxFrame = MarcoEditBox
    end)

    -- Función de actualización
    datosVentana.actualizar = function()
        MarcoOpcion:ClearAllPoints()
        configuracion.posicionFn(MarcoOpcion)
        local raza, genero = (NPCRazaGenero or ""):match("^([^_]+)_([^_]+)$")
        local nuevoNumero = 0
        if raza and genero and TablaOpcionesCustomizacionRaza then
            local datosRaza = TablaOpcionesCustomizacionRaza[raza]
            local datosGenero = datosRaza and datosRaza[genero]
            if datosGenero and datosGenero[configuracion.comando] then
                nuevoNumero = datosGenero[configuracion.comando]
            end
        end
        if datosVentana.numero ~= nuevoNumero then
            datosVentana.numero = nuevoNumero
            if datosVentana.valor > datosVentana.numero then datosVentana.valor = 1 end
            datosVentana.texto:SetText(datosVentana.valor.." / "..datosVentana.numero)
            if datosVentana.numero == 0 then MarcoOpcion:Hide() else MarcoOpcion:Show() end
        end
    end
end


-- ===============================
-- CREACIÓN DE TODAS LAS OPCIONES
-- ===============================

NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Bodyshape", textoLabel="Forma del Cuerpo:", comando="bodyshape",
    posicionFn=function(f) f:SetPoint("CENTER", VentanaOpcionesCuerpo, "CENTER", -48, 150) end
})

NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Bodytype", textoLabel="Tipo de Cuerpo:", comando="bodytype",
    posicionFn=function(f)
        if SubVentanaBodyshape and SubVentanaBodyshape:IsShown() then
            f:SetPoint("CENTER", SubVentanaBodyshape, "CENTER", 14, -35)
        else
            f:SetPoint("CENTER", SubVentanaBodyshape, "CENTER", 14, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Body2", textoLabel="Tipo de Cuerpo:", comando="body",
    posicionFn=function(f)
        if SubVentanaBodytype and SubVentanaBodytype:IsShown() then
            f:SetPoint("CENTER", SubVentanaBodytype, "CENTER", 2, -35)
        else
            f:SetPoint("CENTER", SubVentanaBodytype, "CENTER", 2, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Posture", textoLabel="Postura:", comando="posture",
    posicionFn=function(f)
        if SubVentanaBody2 and SubVentanaBody2:IsShown() then
            f:SetPoint("CENTER", SubVentanaBody2, "CENTER", 58, -35)
        else
            f:SetPoint("CENTER", SubVentanaBody2, "CENTER", 58, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="ArmRight", textoLabel="Brazo Derecho:", comando="arm(right)",
    posicionFn=function(f)
        if SubVentanaPosture and SubVentanaPosture:IsShown() then
            f:SetPoint("CENTER", SubVentanaPosture, "CENTER", -52, -35)
        else
            f:SetPoint("CENTER", SubVentanaPosture, "CENTER", -52, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="BrazoMeca", textoLabel="Brazo Derecho:", comando="arm(right",
    posicionFn=function(f)
        if SubVentanaArmRight and SubVentanaArmRight:IsShown() then
            f:SetPoint("CENTER", SubVentanaArmRight, "CENTER", 0, -35)
        else
            f:SetPoint("CENTER", SubVentanaArmRight, "CENTER", 0, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="ArmLeft", textoLabel="Brazo Izquierdo:", comando="arm(left)",
    posicionFn=function(f)
        if SubVentanaBrazoMeca and SubVentanaBrazoMeca:IsShown() then
            f:SetPoint("CENTER", SubVentanaBrazoMeca, "CENTER", -8, -35)
        else
            f:SetPoint("CENTER", SubVentanaBrazoMeca, "CENTER", -8, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="LegRight", textoLabel="Pierna Derecha:", comando="leg(right)",
    posicionFn=function(f)
        if SubVentanaArmLeft and SubVentanaArmLeft:IsShown() then
            f:SetPoint("CENTER", SubVentanaArmLeft, "CENTER", 7, -35)
        else
            f:SetPoint("CENTER", SubVentanaArmLeft, "CENTER", 7, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="LegLeft", textoLabel="Pierna Izquierda:", comando="leg(left)",
    posicionFn=function(f)
        if SubVentanaLegRight and SubVentanaLegRight:IsShown() then
            f:SetPoint("CENTER", SubVentanaLegRight, "CENTER", -8, -35)
        else
            f:SetPoint("CENTER", SubVentanaLegRight, "CENTER", -8, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Ribs", textoLabel="Costillas:", comando="ribs",
    posicionFn=function(f)
        if SubVentanaLegLeft and SubVentanaLegLeft:IsShown() then
            f:SetPoint("CENTER", SubVentanaLegLeft, "CENTER", 56, -35)
        else
            f:SetPoint("CENTER", SubVentanaLegLeft, "CENTER", 56, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Spine", textoLabel="Columna:", comando="spine",
    posicionFn=function(f)
        if SubVentanaRibs and SubVentanaRibs:IsShown() then
            f:SetPoint("CENTER", SubVentanaRibs, "CENTER", -2, -35)
        else
            f:SetPoint("CENTER", SubVentanaRibs, "CENTER", -2, 0)
        end
    end
})




-- nomuerto
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Skintype", textoLabel="Tipo de Piel:", comando="skintype",
    posicionFn=function(f)
        if SubVentanaSpine and SubVentanaSpine:IsShown() then
            f:SetPoint("CENTER", SubVentanaSpine, "CENTER", -22, -35)
        else
            f:SetPoint("CENTER", SubVentanaSpine, "CENTER", -22, 0)
        end
    end
})

-- enano
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Garment", textoLabel="Vestimenta:", comando="garment",
    posicionFn=function(f)
        if SubVentanaSkintype and SubVentanaSkintype:IsShown() then
            f:SetPoint("CENTER", SubVentanaSkintype, "CENTER", 3, -35)
        else
            f:SetPoint("CENTER", SubVentanaSkintype, "CENTER", 3, 0)
        end
    end
})

-- huargen
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Bodyfur", textoLabel="Pelaje:", comando="bodyfur",
    posicionFn=function(f)
        if SubVentanaGarment and SubVentanaGarment:IsShown() then
            f:SetPoint("CENTER", SubVentanaGarment, "CENTER", 35, -35)
        else
            f:SetPoint("CENTER", SubVentanaGarment, "CENTER", 35, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Claws", textoLabel="Garras:", comando="claws",
    posicionFn=function(f)
        if SubVentanaBodyfur and SubVentanaBodyfur:IsShown() then
            f:SetPoint("CENTER", SubVentanaBodyfur, "CENTER", -2, -35)
        else
            f:SetPoint("CENTER", SubVentanaBodyfur, "CENTER", -2, 0)
        end
    end
})

-- draenei
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Tail", textoLabel="Cola:", comando="tail",
    posicionFn=function(f)
        if SubVentanaClaws and SubVentanaClaws:IsShown() then
            f:SetPoint("CENTER", SubVentanaClaws, "CENTER", 14, -35)
        else
            f:SetPoint("CENTER", SubVentanaClaws, "CENTER", 14, 0)
        end
    end
})

-- highmountain
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Taildecoration", textoLabel="Decoración de Cola:", comando="taildecoration",
    posicionFn=function(f)
        if SubVentanaTail and SubVentanaTail:IsShown() then
            f:SetPoint("CENTER", SubVentanaTail, "CENTER", -108, -35)
        else
            f:SetPoint("CENTER", SubVentanaTail, "CENTER", -108, 0)
        end
    end
})

-- draenei
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Trims", textoLabel="Adornos:", comando="trims",
    posicionFn=function(f)
        if SubVentanaTaildecoration and SubVentanaTaildecoration:IsShown() then
            f:SetPoint("CENTER", SubVentanaTaildecoration, "CENTER", 79, -35)
        else
            f:SetPoint("CENTER", SubVentanaTaildecoration, "CENTER", 79, 0)
        end
    end
})

-- troll
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Bandages", textoLabel="Vendajes:", comando="bandages",
    posicionFn=function(f)
        if SubVentanaTrims and SubVentanaTrims:IsShown() then
            f:SetPoint("CENTER", SubVentanaTrims, "CENTER", -2, -35)
        else
            f:SetPoint("CENTER", SubVentanaTrims, "CENTER", -2, 0)
        end
    end
})

-- vulpera
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Pattern", textoLabel="Patrón del Pelaje:", comando="pattern",
    posicionFn=function(f)
        if SubVentanaBandages and SubVentanaBandages:IsShown() then
            f:SetPoint("CENTER", SubVentanaBandages, "CENTER", -57, -35)
        else
            f:SetPoint("CENTER", SubVentanaBandages, "CENTER", -57, 0)
        end
    end
})

NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Patterncolor", textoLabel="Color del Patrón:", comando="patterncolor",
    posicionFn=function(f)
        if SubVentanaPattern and SubVentanaPattern:IsShown() then
            f:SetPoint("CENTER", SubVentanaPattern, "CENTER", 5, -35)
        else
            f:SetPoint("CENTER", SubVentanaPattern, "CENTER", 5, 0)
        end
    end
})

-- orcos maghar
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Grime", textoLabel="Sombreado:", comando="grime",
    posicionFn=function(f)
        if SubVentanaPatterncolor and SubVentanaPatterncolor:IsShown() then
            f:SetPoint("CENTER", SubVentanaPatterncolor, "CENTER", 35, -35)
        else
            f:SetPoint("CENTER", SubVentanaPatterncolor, "CENTER", 35, 0)
        end
    end
})

-- nocheterna
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Luminoushands", textoLabel="Manos Luminosas:", comando="luminoushands",
    posicionFn=function(f)
        if SubVentanaGrime and SubVentanaGrime:IsShown() then
            f:SetPoint("CENTER", SubVentanaGrime, "CENTER", -49, -35)
        else
            f:SetPoint("CENTER", SubVentanaGrime, "CENTER", -49, 0)
        end
    end
})







-- facetattoo enano
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Facetattoo", textoLabel="Tatuaje Facial:", comando="facetattoo",
    posicionFn=function(f)
        if SubVentanaLuminoushands and SubVentanaLuminoushands:IsShown() then
            f:SetPoint("CENTER", SubVentanaLuminoushands, "CENTER", 35, -35)
        else
            f:SetPoint("CENTER", SubVentanaLuminoushands, "CENTER", 35, 0)
        end
    end
})

-- facerune forjado
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Facerune", textoLabel="Runa Facial:", comando="facerune",
    posicionFn=function(f)
        if SubVentanaFacetattoo and SubVentanaFacetattoo:IsShown() then
            f:SetPoint("CENTER", SubVentanaFacetattoo, "CENTER", 15, -35)
        else
            f:SetPoint("CENTER", SubVentanaFacetattoo, "CENTER", 15, 0)
        end
    end
})

-- facepaint highmountain
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Facepaint", textoLabel="Pintura Facial:", comando="facepaint",
    posicionFn=function(f)
        if SubVentanaFacerune and SubVentanaFacerune:IsShown() then
            f:SetPoint("CENTER", SubVentanaFacerune, "CENTER", -14, -35)
        else
            f:SetPoint("CENTER", SubVentanaFacerune, "CENTER", -14, 0)
        end
    end
})

-- facemarkings velfo
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Facemarkings", textoLabel="Marcas Faciales:", comando="facemarkings",
    posicionFn=function(f)
        if SubVentanaFacepaint and SubVentanaFacepaint:IsShown() then
            f:SetPoint("CENTER", SubVentanaFacepaint, "CENTER", -19, -35)
        else
            f:SetPoint("CENTER", SubVentanaFacepaint, "CENTER", -19, 0)
        end
    end
})

-- bodymarkings velfo
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Bodymarkings", textoLabel="Marcas Corporales:", comando="bodymarkings",
    posicionFn=function(f)
        if SubVentanaFacemarkings and SubVentanaFacemarkings:IsShown() then
            f:SetPoint("CENTER", SubVentanaFacemarkings, "CENTER", -22, -35)
        else
            f:SetPoint("CENTER", SubVentanaFacemarkings, "CENTER", -22, 0)
        end
    end
})

-- bodytattoo enano
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Bodytattoo", textoLabel="Tatuaje Corporal:", comando="bodytattoo",
    posicionFn=function(f)
        if SubVentanaBodymarkings and SubVentanaBodymarkings:IsShown() then
            f:SetPoint("CENTER", SubVentanaBodymarkings, "CENTER", 19, -35)
        else
            f:SetPoint("CENTER", SubVentanaBodymarkings, "CENTER", 19, 0)
        end
    end
})

-- bodypaint highmountain
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Bodypaint", textoLabel="Pintura Corporal:", comando="bodypaint",
    posicionFn=function(f)
        if SubVentanaBodytattoo and SubVentanaBodytattoo:IsShown() then
            f:SetPoint("CENTER", SubVentanaBodytattoo, "CENTER", 0, -35)
        else
            f:SetPoint("CENTER", SubVentanaBodytattoo, "CENTER", 0, 0)
        end
    end
})

-- bodyrune forjado
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Bodyrune", textoLabel="Runas Corporales:", comando="bodyrune",
    posicionFn=function(f)
        if SubVentanaBodypaint and SubVentanaBodypaint:IsShown() then
            f:SetPoint("CENTER", SubVentanaBodypaint, "CENTER", -10, -35)
        else
            f:SetPoint("CENTER", SubVentanaBodypaint, "CENTER", -10, 0)
        end
    end
})

-- tattoo enanoaliado
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Tattoo", textoLabel="Tatuaje:", comando="tattoo",
    posicionFn=function(f)
        if SubVentanaBodyrune and SubVentanaBodyrune:IsShown() then
            f:SetPoint("CENTER", SubVentanaBodyrune, "CENTER", 74, -35)
        else
            f:SetPoint("CENTER", SubVentanaBodyrune, "CENTER", 74, 0)
        end
    end
})

-- tattoostyle trol
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Tattoostyle", textoLabel="Estilo de Tatuaje:", comando="tattoostyle",
    posicionFn=function(f)
        if SubVentanaTattoo and SubVentanaTattoo:IsShown() then
            f:SetPoint("CENTER", SubVentanaTattoo, "CENTER", -62, -35)
        else
            f:SetPoint("CENTER", SubVentanaTattoo, "CENTER", -62, 0)
        end
    end
})

-- tattoocolor enano
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Tattoocolor", textoLabel="Color de Tatuaje:", comando="tattoocolor",
    posicionFn=function(f)
        if SubVentanaTattoostyle and SubVentanaTattoostyle:IsShown() then
            f:SetPoint("CENTER", SubVentanaTattoostyle, "CENTER", 1, -35)
        else
            f:SetPoint("CENTER", SubVentanaTattoostyle, "CENTER", 1, 0)
        end
    end
})

-- paintcolor mecagnomo
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Paintcolor", textoLabel="Color de Pintura:", comando="paintcolor",
    posicionFn=function(f)
        if SubVentanaTattoocolor and SubVentanaTattoocolor:IsShown() then
            f:SetPoint("CENTER", SubVentanaTattoocolor, "CENTER", 0, -35)
        else
            f:SetPoint("CENTER", SubVentanaTattoocolor, "CENTER", 0, 0)
        end
    end
})

-- bodypaintcolor highmountain
NPCTinkerCrearSubVentanaOpcionCuerpo({
    nombre="Bodypaintcolor", textoLabel="Color de Pintura:", comando="bodypaintcolor",
    posicionFn=function(f)
        if SubVentanaPaintcolor and SubVentanaPaintcolor:IsShown() then
            f:SetPoint("CENTER", SubVentanaPaintcolor, "CENTER", -1, -35)
        else
            f:SetPoint("CENTER", SubVentanaPaintcolor, "CENTER", -1, 0)
        end
    end
})




-- ===============================
-- EVENTOS GENERALES
-- ===============================

local FrameCuerpo = CreateFrame("Frame")
FrameCuerpo:RegisterEvent("ADDON_LOADED")
FrameCuerpo:RegisterEvent("CHAT_MSG_SYSTEM")

table.insert(NPCTinker_UIActualizadores, function()
    for _, datos in pairs(NPCTinkerOpcionesCuerpo) do
        if datos.actualizar then datos.actualizar() end
    end
end)

FrameCuerpo:SetScript("OnEvent", function(_, event)
    if event == "ADDON_LOADED" then
        for _, datos in pairs(NPCTinkerOpcionesCuerpo) do
            if datos.actualizar then datos.actualizar() end
        end
    else
        C_Timer.After(0.05, function()
            for _, datos in pairs(NPCTinkerOpcionesCuerpo) do
                if datos.actualizar then datos.actualizar() end
            end
        end)
    end
end)







-- ===============================
-- VENTANA OTRAS OPCIONES
-- ===============================

local VentanaOtrasOpciones = CreateFrame("Frame", "VentanaOtrasOpciones", SubventanaNPCEdit, "BackdropTemplate")
VentanaOtrasOpciones:SetSize(300, 350)
VentanaOtrasOpciones:SetPoint("TOP", SubventanaNPCEdit, "BOTTOM", 0, -55)
VentanaOtrasOpciones:SetBackdrop(nil)
VentanaOtrasOpciones:Hide()

-- Toggle con botón principal
BotonEditarNPCChat:HookScript("OnClick", function()
    if VentanaOtrasOpciones:IsShown() then
        VentanaOtrasOpciones:Hide()
    else
        VentanaOtrasOpciones:Show()
        ReposicionarBoton(VentanaOtrasOpciones)
    end
end)

-- Cerrar con otros botones
local function CerrarVentanaOtrasOpciones()
    VentanaOtrasOpciones:Hide()
end
for _, BotonCerrarVentana in ipairs({
    BotonEditarNPCRaza, BotonEditarNPCCabello,
    BotonEditarNPCAbalorios, BotonEditarNPCCuerpo, BotonEditarNPCCara
}) do
    BotonCerrarVentana:HookScript("OnClick", CerrarVentanaOtrasOpciones)
end






-- Casilla AutoActualizar en VentanaOtrasOpciones
local CasillaAutoActualizar = CreateFrame("CheckButton", "CasillaAutoActualizar_OtrasOpciones", VentanaOtrasOpciones, "ChatConfigCheckButtonTemplate")
CasillaAutoActualizar:SetPoint("TOPLEFT", VentanaOtrasOpciones, "TOPLEFT", 160, -15)
CasillaAutoActualizar:SetChecked(DetectarInfoNPC or false)
CasillaAutoActualizar.Text:SetText("Auto-actualizar")
CasillaAutoActualizar:SetScript("OnClick", function(self)
    DetectarInfoNPC = self:GetChecked()
end)

-- Icono de información al lado del texto
local InfoIcon = CreateFrame("Frame", nil, CasillaAutoActualizar)
InfoIcon:SetSize(35, 35)
InfoIcon:SetPoint("LEFT", CasillaAutoActualizar.Text, "RIGHT", 4, 0) -- pequeño espacio a la derecha del texto

local texture = InfoIcon:CreateTexture(nil, "ARTWORK")
texture:SetAllPoints()
texture:SetTexture("Interface\\COMMON\\help-i") -- Icono de info clásico de Blizzard

-- Tooltip al pasar el ratón por encima
InfoIcon:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("Si lo desactivas no se actualizarán automáticamente las opciones de cada raza al hacer click a un NPC. Tenerlo activado no afecta al rendimiento.", nil, nil, nil, nil, true)
    GameTooltip:Show()
end)

InfoIcon:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)

VentanaOtrasOpciones:HookScript("OnShow", function()
    CasillaAutoActualizar:SetChecked(DetectarInfoNPC or false)
end)





-- Botón Crear NPC
local BotonCrearNPC = CreateFrame("Button", "BotonCrearNPC", VentanaOtrasOpciones)
BotonCrearNPC:SetSize(162, 64)
BotonCrearNPC:SetPoint("TOPLEFT", CasillaAutoActualizar, "BOTTOMLEFT", -5, -1)

-- Textura normal
local texturaNormal = BotonCrearNPC:CreateTexture(nil, "BACKGROUND")
texturaNormal:SetAllPoints()
texturaNormal:SetTexture("Interface\\AddOns\\NPCTinker\\imagenes\\boton-n")

-- Textura highlight
BotonCrearNPC:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\boton-h")

-- Texto del botón
BotonCrearNPC.texto = BotonCrearNPC:CreateFontString(nil, "OVERLAY", "GameFontNormal")
BotonCrearNPC.texto:SetPoint("CENTER", BotonCrearNPC, "CENTER", 0, 0)
BotonCrearNPC.texto:SetText("Crear NPC")
BotonCrearNPC.texto:SetFont(BotonCrearNPC.texto:GetFont(), 12)

-- Acción al pulsar
BotonCrearNPC:SetScript("OnClick", function()
    SendChatMessage(".ph forge npc create", "SAY")
end)


-- Botón para borrar NPC
local BotonDelNPC = CreateFrame("Button", "BotonDelNPC", VentanaOtrasOpciones, "UIPanelButtonTemplate")
BotonDelNPC:SetSize(90, 23) -- tamaño especificado
BotonDelNPC:SetPoint("RIGHT", BotonCrearNPC, "LEFT", 0, 0) -- a la izquierda de BotonCrearNPC con un pequeño espacio
BotonDelNPC:SetText("Borrar NPC")
BotonDelNPC:SetNormalFontObject("GameFontNormal")
BotonDelNPC:SetHighlightFontObject("GameFontHighlight")

-- Acción al pulsar el botón
BotonDelNPC:SetScript("OnClick", function()
    SendChatMessage(".npc delete", "SAY")
end)





-- Casilla de texto para nombre del NPC
local CasillaTextoNameNPC = CreateFrame("EditBox", "CasillaTextoNameNPC", VentanaOtrasOpciones, "InputBoxTemplate")
CasillaTextoNameNPC:SetSize(140, 25)
CasillaTextoNameNPC:SetPoint("TOPLEFT", BotonCrearNPC, "BOTTOMLEFT", 14, -3) -- justo debajo del botón
CasillaTextoNameNPC:SetAutoFocus(false)
CasillaTextoNameNPC:SetText(npcName or "")  -- muestra npcName si existe, si no vacío
CasillaTextoNameNPC:SetMaxLetters(50)
CasillaTextoNameNPC:SetFontObject(ChatFontNormal)

-- Función para enviar el comando y actualizar npcName
local function EnviarNombreNPC()
    local nuevoNombre = CasillaTextoNameNPC:GetText():gsub("^%s*(.-)%s*$", "%1") -- recorta espacios
    if nuevoNombre ~= "" then
        npcName = nuevoNombre
        SendChatMessage(".ph forge npc name " .. npcName, "SAY")
    end
end

-- Ejecutar al pulsar Enter
CasillaTextoNameNPC:SetScript("OnEnterPressed", function(self)
    EnviarNombreNPC()
    self:ClearFocus()
end)



-- Texto a la izquierda de la casilla
local TextoCasillaName = VentanaOtrasOpciones:CreateFontString(nil, "OVERLAY", "GameFontNormal")
TextoCasillaName:SetPoint("RIGHT", CasillaTextoNameNPC, "LEFT", -10, 0)
TextoCasillaName:SetText("Nombre del NPC:")
TextoCasillaName:SetFont(TextoCasillaName:GetFont(), 13) 



-- Casilla de texto para Subname del NPC
local CasillaTextoSubnameNPC = CreateFrame("EditBox", "CasillaTextoSubnameNPC", VentanaOtrasOpciones, "InputBoxTemplate")
CasillaTextoSubnameNPC:SetSize(CasillaTextoNameNPC:GetWidth(), CasillaTextoNameNPC:GetHeight()) -- igual que Name
CasillaTextoSubnameNPC:SetPoint("TOPLEFT", CasillaTextoNameNPC, "BOTTOMLEFT", 0, -7) -- justo debajo de Name
CasillaTextoSubnameNPC:SetAutoFocus(false)
CasillaTextoSubnameNPC:SetText(npcSubname or "")  -- muestra npcSubname si existe, si no vacío
CasillaTextoSubnameNPC:SetMaxLetters(50)
CasillaTextoSubnameNPC:SetFontObject(ChatFontNormal)

-- Función para enviar el comando y actualizar npcSubname
local function EnviarSubnameNPC()
    local nuevoSubname = CasillaTextoSubnameNPC:GetText():gsub("^%s*(.-)%s*$", "%1") -- recorta espacios
    if nuevoSubname ~= "" then
        npcSubname = nuevoSubname
        SendChatMessage(".ph forge npc subname " .. npcSubname, "SAY")
    end
end

-- Ejecutar al pulsar Enter
CasillaTextoSubnameNPC:SetScript("OnEnterPressed", function(self)
    EnviarSubnameNPC()
    self:ClearFocus()
end)

-- Texto a la izquierda de la casilla Subname
local TextoCasillaSubname = VentanaOtrasOpciones:CreateFontString(nil, "OVERLAY", "GameFontNormal")
TextoCasillaSubname:SetPoint("RIGHT", CasillaTextoSubnameNPC, "LEFT", -10, 0)
TextoCasillaSubname:SetText("Título del NPC:")
TextoCasillaSubname:SetFont(TextoCasillaSubname:GetFont(), 13)














-- ============================
-- BOTONES DE ALINEACIÓN
-- ============================

local botonesAlineacion = {}

local nombres = {"Amigable", "Neutral", "Enemigo"}
local comandos = {".ph forge npc faction 1", ".ph forge npc faction 49", ".ph forge npc faction 65"}

for i=1,3 do
    local boton = CreateFrame("Button", "BotonAlineacion"..i, VentanaOtrasOpciones)
    boton:SetSize(90,64)
    boton:SetPoint("TOPLEFT", TextoCasillaSubname, "BOTTOMLEFT", (i-1)*87 + -11, -7) -- menos separación horizontal

    -- Textura normal y highlight
    boton.textura = boton:CreateTexture(nil,"BACKGROUND")
    boton.textura:SetAllPoints()
    boton.textura:SetTexture("Interface\\AddOns\\NPCTinker\\imagenes\\boton-n") -- normal

    boton:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\boton-h") -- highlight al pasar el ratón

    -- Texto encima del botón
    boton.texto = boton:CreateFontString(nil,"OVERLAY","GameFontNormal")
    boton.texto:SetPoint("CENTER", boton, "CENTER", 0, 0)
    boton.texto:SetText(nombres[i])
    boton.texto:SetFont(boton.texto:GetFont(), 12)

    -- Acción al pulsar
    boton:SetScript("OnClick", function()
        SendChatMessage(comandos[i], "SAY")
        -- Opcional: marcar visualmente cuál está activo
        for j, b in ipairs(botonesAlineacion) do
            if j==i then
                b.textura:SetVertexColor(0.5,1,0.5) -- activo, verde pálido
            else
                b.textura:SetVertexColor(1,1,1) -- inactivo, normal
            end
        end
    end)

    botonesAlineacion[i] = boton
end


-- ============================
-- BOTÓN NPC FLY
-- ============================

local BotonNPCFly = CreateFrame("Button", "BotonNPCFly", VentanaOtrasOpciones)
BotonNPCFly:SetSize(90,64)
BotonNPCFly:SetPoint("TOPLEFT", botonesAlineacion[1], "BOTTOMLEFT", 175, 25)

-- Textura normal y highlight
BotonNPCFly.textura = BotonNPCFly:CreateTexture(nil,"BACKGROUND")
BotonNPCFly.textura:SetAllPoints()
BotonNPCFly.textura:SetTexture("Interface\\AddOns\\NPCTinker\\imagenes\\boton-n") -- normal

BotonNPCFly:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\boton-h") -- highlight

-- Texto encima
BotonNPCFly.texto = BotonNPCFly:CreateFontString(nil,"OVERLAY","GameFontNormal")
BotonNPCFly.texto:SetPoint("CENTER", BotonNPCFly, "CENTER", 0, 0)
BotonNPCFly.texto:SetText("NPC Fly")
BotonNPCFly.texto:SetFont(BotonNPCFly.texto:GetFont(), 12)

-- Acción al pulsar
BotonNPCFly:SetScript("OnClick", function()
    SendChatMessage(".ph forge npc fly", "SAY")
end)













-- Sub-subventana Animaciones 1
local SubSubAnims1 = CreateFrame("Frame", "SubSubAnims1", SubventanaNPCAnims, "BackdropTemplate")
SubSubAnims1:SetSize(330, 175)
SubSubAnims1:SetPoint("TOP", SubventanaNPCAnims, "TOP", 0, -35)  -- 10 unidades más abajo
SubSubAnims1:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 8, right = 8, top = 8, bottom = 8 }
})
SubSubAnims1:Hide()

-- Texto a la izquierda del botón
local TextoEmotes = SubventanaNPCAnims:CreateFontString(nil, "OVERLAY", "GameFontNormal")
TextoEmotes:SetPoint("RIGHT", -48, 0)  -- a la izquierda del botón
TextoEmotes:SetPoint("CENTER", TextoEmotes:GetParent(), "CENTER", -90, 45) -- ajuste fino
TextoEmotes:SetText("Emotes Sociales:")
TextoEmotes:SetFont(TextoEmotes:GetFont(), 12)
TextoEmotes:SetJustifyH("RIGHT")

-- Botón toggle para SubSubAnims1
local BotonToggleEmotes = CreateFrame("Button", "BotonToggleEmotes", SubventanaNPCAnims)
BotonToggleEmotes:SetSize(32, 32)  -- tamaño del icono
BotonToggleEmotes:SetPoint("LEFT", TextoEmotes, "RIGHT", 5, 0)

-- Textura normal
BotonToggleEmotes.textura = BotonToggleEmotes:CreateTexture(nil, "BACKGROUND")
BotonToggleEmotes.textura:SetAllPoints()
BotonToggleEmotes.textura:SetTexture("Interface\\AddOns\\NPCTinker\\imagenes\\abajo-n")

-- Highlight
BotonToggleEmotes:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\abajo-h")

-- Toggle abrir/cerrar SubSubAnims1
BotonToggleEmotes:SetScript("OnClick", function()
    if SubSubAnims1:IsShown() then
        SubSubAnims1:Hide()
    else
        SubSubAnims1:Show()
    end
end)





-- ===============================
-- ========== BOTONES ANIMACIONES =========
-- ===============================

local ComandosBotones = {
    ".npc emote 1 repeat",  ".npc emote 5 repeat",  ".npc emote 11 repeat", ".npc emote 6 repeat",
    ".npc emote 21 repeat",  ".npc emote 273 repeat",  ".npc emote 274 repeat",  ".npc emote 18 repeat",
    ".npc emote 7 repeat",  ".npc emote 24 repeat", ".npc emote 3 repeat", ".npc emote 25 repeat",
    ".npc emote 431 repeat", ".npc emote 69 repeat", ".npc emote 14 repeat", ".npc emote 751 repeat",
    ".npc emote 641 repeat", ".npc emote 483 repeat", ".npc emote 10 repeat", ".npc emote 400 repeat"
}

local TextosBotones = {
    "Hablar", "Gritar", "Reír", "Confuso",
    "Aplaudir", "Asentir", "Negar", "Llorar",
    "Beber", "Tímido", "Saludar", "Señalar",
    "Miedo", "Fabricar", "Insulto", "Borracho",
    "Libro", "Mapa", "Bailar", "Bailar 2"
}

-- Función para mandar el comando por SAY
local function EnviarComando(texto)
    SendChatMessage(texto, "SAY")
end

-- Parámetros de layout
local botonAncho = 70
local botonAlto = 25
local iconSpacingX = 5
local iconSpacingY = 2
local startX = -1.5 * (botonAncho + iconSpacingX)  -- centra 4 columnas
local startY = -20

local filas = 6
local columnas = 4
local botonesAnim = {}
local contador = 1

for fila = 1, filas do
    for col = 1, columnas do
        if contador <= #ComandosBotones then
            local nombreBoton = "BotonAnim"..contador
            local boton = CreateFrame("Button", nombreBoton, SubSubAnims1, "UIPanelButtonTemplate")
            boton:SetSize(botonAncho, botonAlto)

            local offsetX = startX + (col-1)*(botonAncho + iconSpacingX)
            local offsetY = startY - (fila-1)*(botonAlto + iconSpacingY)
            boton:SetPoint("TOP", SubSubAnims1, "TOP", offsetX, offsetY)

            boton:SetText(TextosBotones[contador])

            local comando = ComandosBotones[contador]
            boton:SetScript("OnClick", function()
                EnviarComando(comando)
            end)

            botonesAnim[contador] = boton
            contador = contador + 1
        end
    end
end
























-- Sub-subventana Animaciones 2
local SubSubAnims2 = CreateFrame("Frame", "SubSubAnims2", SubventanaNPCAnims, "BackdropTemplate")
SubSubAnims2:SetSize(330, 200)
SubSubAnims2:SetPoint("TOP", BotonToggleEmotes, "BOTTOM", -138, -40) -- 10 por debajo del primer botón
SubSubAnims2:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 8, right = 8, top = 8, bottom = 8 }
})
SubSubAnims2:Hide()

-- Botón toggle para SubSubAnims2
local BotonToggleEmotes2 = CreateFrame("Button", "BotonToggleEmotes2", SubventanaNPCAnims)
BotonToggleEmotes2:SetSize(32, 32)
BotonToggleEmotes2:SetPoint("TOP", BotonToggleEmotes, "BOTTOM", 0, -10) -- posición inicial
BotonToggleEmotes2.textura = BotonToggleEmotes2:CreateTexture(nil, "BACKGROUND")
BotonToggleEmotes2.textura:SetAllPoints()
BotonToggleEmotes2.textura:SetTexture("Interface\\AddOns\\NPCTinker\\imagenes\\abajo-n")
BotonToggleEmotes2:SetHighlightTexture("Interface\\AddOns\\NPCTinker\\imagenes\\abajo-h")

-- Texto vinculado al botón
local TextoEmotes2 = BotonToggleEmotes2:CreateFontString(nil, "OVERLAY", "GameFontNormal")
TextoEmotes2:SetPoint("RIGHT", BotonToggleEmotes2, "LEFT", -5, 0)
TextoEmotes2:SetText("Emotes de Estado:")
TextoEmotes2:SetFont(TextoEmotes2:GetFont(), 12)
TextoEmotes2:SetJustifyH("RIGHT")

-- Toggle abrir/cerrar SubSubAnims2
BotonToggleEmotes2:SetScript("OnClick", function()
    if SubSubAnims2:IsShown() then
        SubSubAnims2:Hide()
    else
        SubSubAnims2:Show()
    end
end)
-- ===============================
-- ========== BOTONES ANIMACIONES 2 =========
-- ===============================

local ComandosBotones2 = {
    ".npc emote 455 repeat", ".npc emote 415 repeat", ".npc emote 424 repeat", ".npc emote 757 repeat",
    ".npc emote 714 repeat", ".npc emote 720 repeat", ".npc emote 886 repeat", ".npc emote 93 repeat",
	".npc emote 902 repeat", ".npc emote 592 repeat", ".npc emote 398 repeat", ".npc emote 433 repeat",
    ".npc emote 333 repeat", ".npc emote 214 repeat", ".npc emote 384 repeat", ".npc emote 617 repeat",
	".npc emote 376 repeat", ".npc emote 734 repeat", ".npc emote 436 repeat", ".npc emote 469 repeat",
    ".npc emote 379 repeat", ".npc emote 722 repeat", ".npc emote 173 repeat", ".npc emote 885 repeat"
}

local TextosBotones2 = {
    "Sentado", "Silla", "Montura", "Sentado 2",
    "Cintura", "Pared", "Barra", "Aturdido",
	"Dormir", "Muerto", "Arrodillado", "Sigilo",
	"Combate", "Rifle", "Apuntar", "Mago",
	"Arco Bajo", "Defensa", "Disparar", "Mago 2",
	"Pescar", "Fregar", "Picar", "Firme"
}

-- Función para mandar el comando por SAY (misma lógica que en el bloque 1)
local function EnviarComando2(texto)
    SendChatMessage(texto, "SAY")
end

local botonAncho2 = 70
local botonAlto2 = 25
local iconSpacingX2 = 5
local iconSpacingY2 = 2
local startX2 = -1.5 * (botonAncho2 + iconSpacingX2)
local startY2 = -20

local filas2 = 6
local columnas2 = 4
local botonesAnim2 = {}
local contador2 = 1

for fila = 1, filas2 do
    for col = 1, columnas2 do
        if contador2 <= #ComandosBotones2 then
            local nombreBoton = "BotonesAnim2_"..contador2
            local boton = CreateFrame("Button", nombreBoton, SubSubAnims2, "UIPanelButtonTemplate")
            boton:SetSize(botonAncho2, botonAlto2)

            local offsetX = startX2 + (col-1)*(botonAncho2 + iconSpacingX2)
            local offsetY = startY2 - (fila-1)*(botonAlto2 + iconSpacingY2)
            boton:SetPoint("TOP", SubSubAnims2, "TOP", offsetX, offsetY)

            boton:SetText(TextosBotones2[contador2])

            local comando = ComandosBotones2[contador2]
            boton:SetScript("OnClick", function()
                EnviarComando2(comando)
            end)

            botonesAnim2[contador2] = boton
            contador2 = contador2 + 1
        end
    end
end


-- ===============================
-- ========== SINCRONIZAR MOVIMIENTO CON BotonToggleEmotes =========
-- ===============================
-- Mover el botón 2 y su ventana cuando se desplaza el primer botón
local posOriginalY2 = select(2, BotonToggleEmotes2:GetPoint(2)) -- posición inicial relativa al primer botón

-- Hook para mover BotonToggleEmotes2 cuando se abre/cierra SubSubAnims1
local function ActualizarPosicionBoton2()
    if SubSubAnims1:IsShown() then
        BotonToggleEmotes2:SetPoint("TOP", BotonToggleEmotes, "BOTTOM", 0, -180)
        SubSubAnims2:SetPoint("TOP", BotonToggleEmotes, "BOTTOM", -138, -212)
    else
        BotonToggleEmotes2:SetPoint("TOP", BotonToggleEmotes, "BOTTOM", 0, -10)
        SubSubAnims2:SetPoint("TOP", BotonToggleEmotes, "BOTTOM", -138, -40)
    end
end

-- Llamar a la función dentro del toggle del primer botón
local oldScript = BotonToggleEmotes:GetScript("OnClick")
BotonToggleEmotes:SetScript("OnClick", function(...)
    oldScript(...)
    ActualizarPosicionBoton2()
end)


















-- Casilla de texto para Aura del NPC
local CasillaTextoNPCAura = CreateFrame("EditBox", "CasillaTextoNPCAura", SubventanaNPCAnims, "InputBoxTemplate")
CasillaTextoNPCAura:SetSize(80, 20) -- tamaño estándar
CasillaTextoNPCAura:SetPoint("TOPLEFT", SubventanaNPCAnims, "TOPRIGHT", -97, -90) -- posición inicial
CasillaTextoNPCAura:SetAutoFocus(false)
CasillaTextoNPCAura:SetNumeric(true) -- solo admite números
CasillaTextoNPCAura:SetMaxLetters(6) -- límite razonable para IDs de aura
CasillaTextoNPCAura:SetFontObject(ChatFontNormal)

-- Función para enviar el comando de aura
local function EnviarNPCAura()
    local auraID = CasillaTextoNPCAura:GetNumber() -- devuelve número
    if auraID and auraID > 0 then
        SendChatMessage(".npc set aura " .. auraID, "SAY")
    end
end

-- Función para actualizar la posición según las subventanas
local function ActualizarPosicionNPCAura()
    local offsetY = -90 -- posición base
    local anim1 = SubSubAnims1 and SubSubAnims1:IsShown()
    local anim2 = SubSubAnims2 and SubSubAnims2:IsShown()

    if anim1 and anim2 then
        offsetY = -465 -- ambos abiertos
    elseif anim1 then
        offsetY = -265 -- solo SubSubAnims1
    elseif anim2 then
        offsetY = -290 -- solo SubSubAnims2
    end

    CasillaTextoNPCAura:ClearAllPoints()
    CasillaTextoNPCAura:SetPoint("TOPLEFT", SubventanaNPCAnims, "TOPRIGHT", -97, offsetY)
end

-- Ejecutar al pulsar Enter
CasillaTextoNPCAura:SetScript("OnEnterPressed", function(self)
    EnviarNPCAura()
    self:ClearFocus()
end)

-- Texto a la izquierda de la casilla Aura
local TextoCasillaNPCAura = SubventanaNPCAnims:CreateFontString(nil, "OVERLAY", "GameFontNormal")
TextoCasillaNPCAura:SetPoint("RIGHT", CasillaTextoNPCAura, "LEFT", -10, 0)
TextoCasillaNPCAura:SetText("NPC Aura:")
TextoCasillaNPCAura:SetFont(TextoCasillaNPCAura:GetFont(), 13)

-- Hook para actualizar posición cuando cambien las subventanas
if SubSubAnims1 then
    SubSubAnims1:HookScript("OnShow", ActualizarPosicionNPCAura)
    SubSubAnims1:HookScript("OnHide", ActualizarPosicionNPCAura)
end
if SubSubAnims2 then
    SubSubAnims2:HookScript("OnShow", ActualizarPosicionNPCAura)
    SubSubAnims2:HookScript("OnHide", ActualizarPosicionNPCAura)
end






-- Botón para resetear animaciones
local BotonResetearAnims = CreateFrame("Button", "BotonResetearAnims", SubventanaNPCAnims, "UIPanelButtonTemplate")
BotonResetearAnims:SetSize(140, 25) -- tamaño del botón
BotonResetearAnims:SetPoint("RIGHT", TextoEmotes, "LEFT", -22, 0) -- a 15 a la izquierda de TextoEmotes
BotonResetearAnims:SetText("Resetear Animación")
BotonResetearAnims:SetNormalFontObject("GameFontNormal")
BotonResetearAnims:SetHighlightFontObject("GameFontHighlight")

-- Acción al pulsar el botón
BotonResetearAnims:SetScript("OnClick", function()
    SendChatMessage(".npc emote 0 repeat", "SAY")
end)


















-- Casilla de texto para QuestInvis (número del 1 al 9)
local QuestInvisCasillaTexto = CreateFrame("EditBox", "QuestInvisCasillaTexto", SubventanaNPCAnims, "InputBoxTemplate")
QuestInvisCasillaTexto:SetSize(30, 20) -- tamaño estándar
QuestInvisCasillaTexto:SetPoint("TOPLEFT", CasillaTextoNPCAura, "BOTTOMLEFT", 50, -10) -- 10 por debajo de Aura
QuestInvisCasillaTexto:SetAutoFocus(false)
QuestInvisCasillaTexto:SetNumeric(true) -- solo números
QuestInvisCasillaTexto:SetMaxLetters(1) -- solo 1 dígito
QuestInvisCasillaTexto:SetFontObject(ChatFontNormal)

-- Mapa de número a aura
local QuestInvisMap = {
    [1] = 49414,
    [2] = 49415,
    [3] = 60921,
    [4] = 82343,
    [5] = 80797,
    [6] = 82358,
    [7] = 85096,
    [8] = 78718,
    [9] = 84886,
}

-- Función para enviar el comando de QuestInvis según número
local function EnviarQuestInvis()
    local num = QuestInvisCasillaTexto:GetNumber()
    local auraID = QuestInvisMap[num]
    if auraID then
        SendChatMessage(".npc set aura " .. auraID, "SAY")
    else
        print("Introduce un número válido del 1 al 9")
    end
end

-- Ejecutar al pulsar Enter
QuestInvisCasillaTexto:SetScript("OnEnterPressed", function(self)
    EnviarQuestInvis()
    self:ClearFocus()
end)

-- Texto a la izquierda de la casilla QuestInvis
local TextoQuestInvis = SubventanaNPCAnims:CreateFontString(nil, "OVERLAY", "GameFontNormal")
TextoQuestInvis:SetPoint("RIGHT", QuestInvisCasillaTexto, "LEFT", -10, 0)
TextoQuestInvis:SetText("Aplicar 'Quest Invis' (1-9):")
TextoQuestInvis:SetFont(TextoQuestInvis:GetFont(), 13)

-- Botón Aplicar a la derecha de la casilla
local BotonAplicarQuestInvis = CreateFrame("Button", "BotonAplicarQuestInvis", SubventanaNPCAnims, "UIPanelButtonTemplate")
BotonAplicarQuestInvis:SetSize(60, 20)
BotonAplicarQuestInvis:SetPoint("LEFT", QuestInvisCasillaTexto, "RIGHT", 5, 0) -- a la derecha
BotonAplicarQuestInvis:SetText("Aplicar")
BotonAplicarQuestInvis:SetNormalFontObject("GameFontNormal")
BotonAplicarQuestInvis:SetHighlightFontObject("GameFontHighlight")

-- Acción al pulsar el botón
BotonAplicarQuestInvis:SetScript("OnClick", function()
    EnviarQuestInvis()
end)











-- Mapa de número a aura para VerQuestInvis
local VerQuestInvisMap = {
    [1] = 49416,
    [2] = 49417,
    [3] = 60922,
    [4] = 90161,
    [5] = 94566,
    [6] = 94567,
    [7] = 94568,
    [8] = 94569,
    [9] = 94570,
}

-- Botón Ver Quest Invis
local VerQuestInvis = CreateFrame("Button", "VerQuestInvis", SubventanaNPCAnims, "UIPanelButtonTemplate")
VerQuestInvis:SetSize(70, 25)
VerQuestInvis:SetPoint("RIGHT", QuestInvisCasillaTexto, "LEFT", -195, 0) -- a la izquierda de la casilla
VerQuestInvis:SetText("Detection")
VerQuestInvis:SetNormalFontObject("GameFontNormal")
VerQuestInvis:SetHighlightFontObject("GameFontHighlight")

-- Casilla de verificación para PH Aura
local CasillaPHAura = CreateFrame("CheckButton", "CasillaPHAura", SubventanaNPCAnims, "UICheckButtonTemplate")
CasillaPHAura:SetPoint("TOPLEFT", QuestInvisCasillaTexto, "BOTTOMLEFT", -267, -2) -- debajo de la casilla
CasillaPHAura:SetChecked(false) -- desmarcada por defecto

-- Texto a la derecha de la casilla
local TextoCasillaPHAura = SubventanaNPCAnims:CreateFontString(nil, "OVERLAY", "GameFontNormal")
TextoCasillaPHAura:SetPoint("LEFT", CasillaPHAura, "RIGHT", 5, 0)
TextoCasillaPHAura:SetText("¿Hacer PH Aura?")
TextoCasillaPHAura:SetFont(TextoCasillaPHAura:GetFont(), 12)

-- Función al pulsar el botón VerQuestInvis
VerQuestInvis:SetScript("OnClick", function()
    local num = QuestInvisCasillaTexto:GetNumber()
    local auraID = VerQuestInvisMap[num]
    if auraID then
        if CasillaPHAura:GetChecked() then
            SendChatMessage(".ph aura " .. auraID, "SAY")
        else
            SendChatMessage(".aura " .. auraID, "SAY")
        end
    else
        print("Introduce un número válido del 1 al 9")
    end
end)











-- Botón para aplicar Aura del NPC
local BotonAplicarNPCAura = CreateFrame("Button", "BotonAplicarNPCAura", SubventanaNPCAnims, "UIPanelButtonTemplate")
BotonAplicarNPCAura:SetSize(100, 25) -- mismo tamaño que BotonResetearAnims
BotonAplicarNPCAura:SetPoint("LEFT", CasillaTextoNPCAura, "RIGHT", -295, 0) -- al lado derecho de la casilla
BotonAplicarNPCAura:SetText("Quitar Aura")
BotonAplicarNPCAura:SetNormalFontObject("GameFontNormal")
BotonAplicarNPCAura:SetHighlightFontObject("GameFontHighlight")

-- Acción al pulsar el botón
BotonAplicarNPCAura:SetScript("OnClick", function()
    local auraID = CasillaTextoNPCAura:GetNumber()
    if auraID and auraID > 0 then
        SendChatMessage(".npc set unaura " .. auraID, "SAY")
    else
        print("Introduce un ID de aura válido")
    end
end)





-- Botón Quitar Quest Invis
local BotonQuitarQuestInvis = CreateFrame("Button", "BotonQuitarQuestInvis", SubventanaNPCAnims, "UIPanelButtonTemplate")
BotonQuitarQuestInvis:SetSize(110, 25)
BotonQuitarQuestInvis:SetPoint("LEFT", TextoCasillaPHAura, "RIGHT", -134, -25) -- a la derecha del texto de PH Aura
BotonQuitarQuestInvis:SetText("Quitar Detection")
BotonQuitarQuestInvis:SetNormalFontObject("GameFontNormal")
BotonQuitarQuestInvis:SetHighlightFontObject("GameFontHighlight")

-- Función al pulsar el botón
BotonQuitarQuestInvis:SetScript("OnClick", function()
    local num = QuestInvisCasillaTexto:GetNumber()
    local auraID = VerQuestInvisMap[num]
    if auraID then
        if CasillaPHAura:GetChecked() then
            SendChatMessage(".ph unaura " .. auraID, "SAY")
        else
            SendChatMessage(".unaura " .. auraID, "SAY")
        end
    else
        print("Introduce un número válido del 1 al 9")
    end
end)



-- Botón Quitar a la derecha de la casilla QuestInvis
local BotonQuitarQuestInvis = CreateFrame("Button", "BotonQuitarQuestInvis", SubventanaNPCAnims, "UIPanelButtonTemplate")
BotonQuitarQuestInvis:SetSize(60, 20)
BotonQuitarQuestInvis:SetPoint("LEFT", BotonAplicarQuestInvis, "RIGHT", 5, 0) -- a la derecha del botón Aplicar
BotonQuitarQuestInvis:SetText("Quitar")
BotonQuitarQuestInvis:SetNormalFontObject("GameFontNormal")
BotonQuitarQuestInvis:SetHighlightFontObject("GameFontHighlight")

-- Acción al pulsar el botón
BotonQuitarQuestInvis:SetScript("OnClick", function()
    local num = QuestInvisCasillaTexto:GetNumber()
    local auraID = QuestInvisMap[num]
    if auraID then
        SendChatMessage(".npc set unaura " .. auraID, "SAY")
    else
        print("Introduce un número válido del 1 al 9")
    end
end)




