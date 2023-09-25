-----------------------------------
-- Area: Port Windurst
--  NPC: Satata
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/magic")
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)
    npcUtil.castingAnimation(npc, xi.magic.spellGroup.BLACK, 12)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(235)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
