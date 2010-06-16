
do return end

local LibButtonFacade = LibStub("LibButtonFacade", true)
if not LibButtonFacade then return end

local db

local dummyFunction = function() return end
local methods = { "ClearAllPoints", "GetFrameLevel", "GetTextColor","Hide", "SetBlendMode", "SetDrawLayer", "SetFrameLevel", "SetHeight", "SetParent", "SetPoint", "SetTexCoord", "SetTextColor", "SetTexture", "SetVertexColor", "SetWidth", "Show" }
local layers = { "AutoCast", "AutoCastable", "Checked", "Cooldown", "Count", "Disabled", "Flash", "Highlight", "HotKey", "Name", "Pushed" } --, "Border" }

local function SkinButton(f)
	print("Skinning button for " .. f:GetParent():GetName() .. "...")

	if PhanxBorder then
		f.icon:SetTexCoord(0, 1, 0, 1)
		if f.BorderTextures then
			for i, tex in ipairs(f.BorderTextures) do
				tex:SetTexture(nil)
				tex:Hide()
			end
			f.BorderTextures = nil
		end
		if f.ShadowTextures then
			for i, tex in ipairs(f.ShadowTextures) do
				tex:SetTexture(nil)
				tex:Hide()
			end
			f.ShadowTextures = nil
		end
		f.SetBorderSize = nil
	elseif f.border then
		f.border:SetTexture(nil)
		f.border:Hide()
		f.border = nil
	end
	if f.SetBorderColor then
		f.SetBorderColor = function(f, r, g, b)
			LibButtonFacade:SetBorderColor(f, r, g, b)
		end
	end

	f.GetName = function() return "" end

	f.buttonData = { Icon = f.icon }

	for i, layer in ipairs(layers) do
		f.buttonData[layer] = { }
		for i, method in ipairs(methods) do
			f.buttonData[layer][method] = dummyFunction
		end
	end

	LibButtonFacade:Group("PhanxBuffs"):AddButton(f, f.buttonData)

	if f == PhanxTempEnchantFrame then
		for i = 1, #buttons do
			LibButtonFacade:SetBorderColor(buttons[i], 180 / 255, 76 / 255, 1)
		end
	end

	local oSetWidth = button.SetWidth
	button.SetWidth = function(button, width)
		oSetWidth(button, width)
		LibButtonFacade:Group("PhanxBuffs"):Skin(db.skin.skin, db.skin.gloss, db.skin.backdrop, db.skin.colors)
	end
end

local function SkinFrame(frame)
	print("Skinning frame " .. frame:GetName() .. "...")
	local buttons = frame.buttons

	for i = 1, #buttons do
		SkinButton(buttons[i])
	end

	local oldmetatable = getmetatable(buttons).__index
	setmetatable(buttons, { __index = function(t, i)
		local f = oldmetatable(t, i)
		SkinButton(f)
		return f
	end })
end

hooksecurefunc(PhanxTempEnchantFrame, "Load", function(self)
	print("Initializing skin support...")

	db = PhanxBuffsDB

	local defaultSkin = {
		skin = "Blizzard",
		gloss = false,
		backdrop = true,
		colors = { },
	}
	if not db.skin then db.skin = { } end
	for k, v in pairs(defaultSkin) do
		if type(db.skin[k]) ~= type(v) then
			db.skin[k] = v
		end
	end

	function self:LibButtonFacade_SkinChanged(skin, gloss, backdrop, _, _, colors)
		print(string.format("New skin: %s, Gloss: %s, Backdrop: %s", skin, tostring(gloss), tostring(backdrop)))

		db.skin.skin = skin
		db.skin.gloss = gloss
		db.skin.backdrop = backdrop
		db.skin.colors = colors

		for i = 1, #PhanxTempEnchantFrame.buttons do
			LibButtonFacade:SetBorderColor(PhanxTempEnchantFrame.buttons[i], 180 / 255, 76 / 255, 1)
		end

		PhanxBuffFrame:UpdateBuffs()
		PhanxDebuffFrame:UpdateDebuffs()
		PhanxTempEnchantFrame:UpdateTempEnchants()
	end

	LibButtonFacade:RegisterSkinCallback("PhanxBuffs", self.LibButtonFacade_SkinChanged, self)

	LibButtonFacade:Group("PhanxBuffs"):Skin(db.skin.skin, db.skin.gloss, db.skin.backdrop, db.skin.colors)

	SkinFrame(PhanxBuffFrame)
	SkinFrame(PhanxDebuffFrame)
	SkinFrame(PhanxTempEnchantFrame)
end)
