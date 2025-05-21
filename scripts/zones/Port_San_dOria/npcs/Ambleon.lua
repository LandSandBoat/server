-----------------------------------
-- Area: Port San d'Oria
--  NPC: Ambleon
-- Type: NPC World Pass Dealer
-- !pos 71.622 -17 -137.134 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Currently selecting option 1 will result in a hard lock of the player requiring them to force quit the client.
    -- This likely needs special handling in the core.
    -- player:startEvent(710)
end

return entity
