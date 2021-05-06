-----------------------------------
-- Area: Port Windurst
--  NPC: Mojo-Pojo
-- Type: Standard NPC
-- !pos -108.041 -4.25 109.545 240
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/magic")
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)
    npcUtil.castingAnimation(npc, xi.magic.spellGroup.BLACK, 14)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(229)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
