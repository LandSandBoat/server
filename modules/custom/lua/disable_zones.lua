-----------------------------------
-- Set if you want new players to get a linkshell
-----------------------------------
require("modules/module_utils")
require("scripts/globals/zone")
-----------------------------------
local m = Module:new("disable_zones")

local disableZone =
{
    "Attohwa_Chasm",
    "Bibiki_Bay",
    "Carpenters_Landing",
    "Psoxja"
    "Uleguerand_Range"
}

for _, zones in pairs(disableZone) do
    m:addOverride(string.format("xi.zones.%s.Zone.onZoneIn", zones), function(player, prevZone)
		local cs = -1
		player:timer(4000, function(playerArg)
			player:setPos(0,0,0,0, player:getPreviousZone())
		end)
		return cs
    end)
end

return m