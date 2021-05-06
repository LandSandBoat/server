-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Assai Nybaem
-- Type: NPC Voidwalker
-- !pos -32 0 -76 243
-----------------------------------
require("scripts/globals/voidwalker")

local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.voidwalker.npcOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    xi.voidwalker.npcOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.voidwalker.npcOnEventFinish(player, csid, option)
end

return entity
