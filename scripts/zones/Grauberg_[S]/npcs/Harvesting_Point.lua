-----------------------------------
-- Area: Grauberg [S]
--  NPC: Harvesting Point
-----------------------------------
require("scripts/globals/helm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    tpz.helm.onTrade(player, npc, trade, tpz.helm.type.HARVESTING, 901)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.HARVESTING_IS_POSSIBLE_HERE, 1020)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
