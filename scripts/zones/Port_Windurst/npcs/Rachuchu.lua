-----------------------------------
-- Area: Port Windurst
--  NPC: Rachuchu
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/magic")
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)
    npcUtil.castingAnimation(npc, xi.magic.spellGroup.WHITE, 10.5)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(234)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
