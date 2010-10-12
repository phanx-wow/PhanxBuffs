--[[--------------------------------------------------------------------
	PhanxBuffs
	Replaces default player buff, debuff, and temporary enchant frames.
	by Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info16874-PhanxBuffs.html
	http://wow.curse.com/downloads/wow-addons/details/phanxbuffs.aspx
	Copyright © 2010 Phanx. See README for license terms.
----------------------------------------------------------------------]]

local LibButtonFacade, LibButtonFacade_VERSION = LibStub("LibButtonFacade", true)
if not LibButtonFacade or LibButtonFacade_VERSION < 30305 then return end

local done
local _, ns = ...

hooksecurefunc(PhanxTempEnchantFrame, "Load", function(self)
	-- print("Initializing skin support...")
	if done then return end

	local db = PhanxBuffsDB
	if db.noButtonFacade then return end

	local defaultSkin = {
		skin = "Blizzard",
		gloss = 0,
		backdrop = true,
		colors = { },
	}
	if not db.skin then db.skin = { } end
	for k, v in pairs(defaultSkin) do
		if type(db.skin[k]) ~= type(v) then
			db.skin[k] = v
		end
	end

	local buttonDataLayers = { "AutoCast", "AutoCastable", "Backdrop", "Checked", "Cooldown", "Count", "Disabled", "Flash", "Highlight", "HotKey", "Name", "Pushed" }

	local function SkinButton(f)
		-- print("Skinning button in frame " .. f:GetParent():GetName() .. "...")

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

		f.buttonData = { Icon = f.icon }
		for i, layer in ipairs(buttonDataLayers) do
			f.buttonData[layer] = false
		end

		if f:GetParent() == PhanxBuffFrame then
			f.buttonData.Border = false
		else
			f.border = f.border or f:CreateTexture()
			f.buttonData.Border = f.border
		end

		if f.SetBorderColor then
			f.SetBorderColor = function(f, r, g, b, a)
				if a and a > 0 then
					f.border:SetVertexColor(r, g, b, a)
				else
					f.border:SetVertexColor(1, 1, 1, 0)
				end
			end
		end

		LibButtonFacade:Group("PhanxBuffs"):AddButton(f, f.buttonData)

		if f:GetParent() == PhanxTempEnchantFrame then
			-- print("Recoloring temp enchant button")
			f.border:SetVertexColor(0.46, 0.18, 0.67, 1)
		end
	end

	local function SkinFrame(frame)
		-- print("Skinning frame " .. frame:GetName() .. "...")
		local buttons = frame.buttons

		for i, button in ipairs(buttons) do
			-- print("Skinning button " .. i .. " in frame " .. frame:GetName() .. "...")
			SkinButton(button)
		end

		local oldmetatable = getmetatable(buttons).__index
		setmetatable(buttons, { __index = function(t, i)
			local f = oldmetatable(t, i)
			-- print("Creating skinned button in frame " .. f:GetParent():GetName() .. "...")
			SkinButton(f)
			return f
		end })
	end

	local function OnSkinChanged(_, skin, gloss, backdrop, _, _, colors)
		-- print(string.format("New skin: %s, Gloss: %s, Backdrop: %s", skin, tostring(gloss), tostring(backdrop)))

		db.skin.skin = skin
		db.skin.gloss = gloss
		db.skin.backdrop = backdrop
		db.skin.colors = colors

		for i = 1, #PhanxTempEnchantFrame.buttons do
			-- print("Recoloring temp enchant button", i)
			PhanxTempEnchantFrame.buttons[i].border:SetVertexColor(0.46, 0.18, 0.67, 1)
		end

		PhanxBuffFrame:Update()
		PhanxDebuffFrame:Update()
		PhanxTempEnchantFrame:Update()
	end

	LibButtonFacade:RegisterSkinCallback("PhanxBuffs", OnSkinChanged)

	LibButtonFacade:Group("PhanxBuffs"):Skin(db.skin.skin, db.skin.gloss, db.skin.backdrop, db.skin.colors)

	SkinFrame(PhanxBuffFrame)
	SkinFrame(PhanxDebuffFrame)
	SkinFrame(PhanxTempEnchantFrame)

	local hookedOptionsPanel
	ns.optionsPanel:HookScript("OnShow", function(panel)
		if hookedOptionsPanel then return end

		local L = ns.L
		for i = 1, panel:GetNumChildren() do
			local child = select(i, panel:GetChildren())
			if type(child) == "table" and child.OnValueChanged and (child.desc == L["Set the size of each buff icon."] or child.desc == L["Set the size of each debuff icon."]) then
				local OnValueChanged = child.OnValueChanged
				child.OnValueChanged = function(...)
					OnValueChanged(...)
					LibButtonFacade:Group("PhanxBuffs"):ReSkin()
					-- print("Reskinned PhanxBuffs because buff/debuff size changed.")
				end
			end
		end

		hookedOptionsPanel = true
	end)

	done = true
end)