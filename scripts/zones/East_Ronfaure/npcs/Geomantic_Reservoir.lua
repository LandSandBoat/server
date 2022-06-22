-----------------------------------
-- Area: East Ronfaure
-- NPC: Geomantic Reservoir
-- Unlocks Geo-Poison
-- !pos 378.875 -39.304 58.313
-----------------------------------
local ID = require("scripts/zones/East_Ronfaure/IDs")
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasSpell(769) then -- Player has Indi-Poison
        player:startEvent(15000, 277, 3, 380619, -39102, 53620, 163, 539943, 0)
    else
        player:PrintToPlayer("You are assaulted by an uncanny sensation.", 0xD)
    end    
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 15000 then
        player:addSpell(799) -- TODO: This is not accurate, retail will display message "Player learns Geo-Poison!", with the spell name in green.
        -- However, I could not locate the correct message type for this.
    end
end

return entity
