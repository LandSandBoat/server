-----------------------------------
-- CatsEyeXI Jail
-----------------------------------
require("scripts/globals/npc_util")
require("modules/module_utils")

local jail = Module:new("Jail_Update")

jail:addOverride("xi.zones.Mordion_Gaol.Zone.onZoneIn", function(player, prevZone)
    local cs = -1

    if player:getCharVar("inJail") > 0 then
        player:jail()
    end

    if player:isDead() then
        player:setAnimation(0)
    	player:addHP(player:getMaxHP())
    	player:addMP(player:getMaxMP())
    end

    return cs
end)

return jail