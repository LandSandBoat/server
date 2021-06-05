-----------------------------------
-- Area: Full Moon Fountain
--  NPC: Moon Spiral
-- Involved in Quests: The Moonlit Path
-- !pos -302 9 -260 170
-----------------------------------
require("scripts/globals/bcnm")
require("scripts/globals/quests")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    EventTriggerBCNM(player, npc)
end

entity.onEventUpdate = function(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option)
    EventFinishBCNM(player, csid, option)
end

return entity
