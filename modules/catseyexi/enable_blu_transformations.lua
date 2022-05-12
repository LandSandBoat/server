-----------------------------------
-- CatsEyeXI Custom NPCs
-----------------------------------
require("scripts/globals/npc_util")

local m = Module:new("enable_blu_transformations")

m:addOverride("xi.zones.Alzadaal_Undersea_Ruins.npcs.blank_transformations.onTrigger", function(player, npc)
    local ID = require("scripts/zones/Alzadaal_Undersea_Ruins/IDs")
    local transformationsProgress = player:getCharVar("TransformationsProgress")
    -- TRANSFORMATIONS
    if transformationsProgress == 4 then
        -- TODO: Nepionic Soulflayer disabled until its skill list is fully implemented
        player:startEvent(4)
        -- player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    elseif transformationsProgress == 5 then
        player:startEvent(5)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end)

return m 