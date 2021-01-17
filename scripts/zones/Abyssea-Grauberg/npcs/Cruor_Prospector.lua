-----------------------------------
-- Area: Abyssea - Grauberg
--  NPC: Cruor Prospector
-- Type: Cruor NPC
-- !pos -528 26 -782 254
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local cruor = player:getCurrency("cruor")
    local demilune = tpz.abyssea.getDemiluneAbyssite(player)
    player:startEvent(2002, cruor, demilune)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
