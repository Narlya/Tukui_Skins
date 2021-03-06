if not (IsAddOnLoaded("Tukui") or IsAddOnLoaded("AsphyxiaUI") or IsAddOnLoaded("DuffedUI")) then return end
local AS = unpack(select(2,...))

function AS:Ace3Options()
	local Ace3OptionsPanel = IsAddOnLoaded("Enhanced_Config") and Enhanced_Config[1] or nil
	local function GenerateOptionTable(skinName,order)
		local data = AS.Skins[skinName]
		local addon = data.addon
		local text = data.buttonText or addon
		local options = {
			type = 'toggle',
			name = text,
			desc = "Enable/Disable this skin.",
			order = order,
			disabled = function() if addon then return not IsAddOnLoaded(addon) else return false end end,
		}
		return options
	end

	local function pairsByKeys (t, f)
		local a = {}
		for n in pairs(t) do table.insert(a, n) end
		table.sort(a, f)
		local i = 0
		local iter = function()
			i = i + 1
			if a[i] == nil then return nil
				else return a[i], t[a[i]]
			end
		end
		return iter
	end
	Ace3OptionsPanel.Options.args.skins = {
		order = 100,
		type = 'group',
		name = 'Skins',
		args = {},
	}
	Ace3OptionsPanel.Options.args.skins.args.skins = {
		order = 1000,
		type = 'group',
		name = AS.Title..' |cFFFFFFFFby|r |cFFFF7D0AAzilroka|r |cFFFFFFFF- Version:|r |cff1784d1'..AS.Version,
		get = function(info) return UISkinOptions[ info[#info] ] end,
		set = function(info, value) UISkinOptions[ info[#info] ] = value end,
		guiInline = true,
		args = {
			misc = {
				type = 'group',
				name = 'Misc Options',
				order = 500,
				args = {
					DBMSkinHalf = {
						type = 'toggle',
						name = 'DBM Half-bar Skin',
						desc = "Enable/Disable this skin.",
						order = 1,
						disabled = function() return not (IsAddOnLoaded("DBM-Core") and UISkinOptions['DBMSkin']) end
					},
					RecountBackdrop = {
						type = 'toggle',
						name = 'Recount Backdrop',
						desc = "Enable/Disable this skin.",
						order = 2,
						disabled = function() return not (IsAddOnLoaded("Recount") and UISkinOptions["RecountSkin"]) end,
					},
					SkadaBackdrop = {
						type = 'toggle',
						name = 'Skada Backdrop',
						desc = "Enable/Disable this skin.",
						order = 3,
						disabled = function() return not (IsAddOnLoaded("Skada") and UISkinOptions["SkadaSkin"]) end,
					},
					SkadaBelowTop = {
						type = 'toggle',
						name = 'Skada Below Chat Tabs',
						desc = "Enable/Disable this option.",
						order = 4,
						disabled = function() return not (IsAddOnLoaded("Skada") and UISkinOptions["SkadaSkin"]) end,
					},
					SkadaTwoThirds = {
						type = 'toggle',
						name = 'Skada 1/3 | 2/3 Option',
						desc = "Enable/Disable this option.",
						order = 5,
						disabled = function() return not (IsAddOnLoaded("Skada") and UISkinOptions["SkadaSkin"]) end,
					},
				}
			},
			embed = {
				order = 1000,
				type = 'group',
				name = 'Embed Settings',
				get = function(info) return UISkinOptions[ info[#info] ] end,
				set = function(info,value) UISkinOptions[ info[#info] ] = value end,
				args = {
					desc = {
						type = 'description',
						name = 'Settings to control Embedded AddOns:\n\nAvailable Embeds: alDamageMeter | Omen | Skada | Recount | TinyDPS',
						order = 1
					},
					EmbedLeft = {
						type = 'input',
						width = 'full',
						name = 'Embed for Left Chat Panel',
						desc = 'Available Embeds: alDamageMeter | Omen | Skada | Recount | TinyDPS',
						order = 2
					},
					EmbedRight = {
						type = 'input',
						width = 'full',
						name = 'Embed to Right Chat Panel',
						desc = 'Available Embeds: alDamageMeter | Omen | Skada | Recount | TinyDPS',
						order = 3
					},
					EmbedOoC = {
						type = 'toggle',
						name = 'Hide while out of combat',
						desc = "Enable/Disable this skin.",
						order = 10,
					},
					EmbedSexyCooldown = {
						type = 'toggle',
						name = 'Attach SexyCD to action bar',
						desc = "Enable/Disable this skin.",
						order = 11,
						disabled = function() return not IsAddOnLoaded("SexyCooldown2") end,
					},
					EmbedCoolLine = {
						type = 'toggle',
						name = 'Attach CoolLine to action bar',
						desc = "Enable/Disable this skin.",
						order = 12,
						disabled = function() return not IsAddOnLoaded("CoolLine") end,
					},
				}
			}
		}
	}

	local order = 2
	for skinName,_ in pairsByKeys(AS.Skins) do
		if skinName ~= "MiscFixes" then
			Ace3OptionsPanel.Options.args.skins.args.skins.args[skinName] = GenerateOptionTable(skinName,order)
			order = order + 1
		end
	end
end