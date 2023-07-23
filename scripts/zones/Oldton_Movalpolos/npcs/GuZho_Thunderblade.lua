-----------------------------------
-- Area: Oldton Movalpolos
--  NPC: Gu'Zho Thunderblade
-- Type: NPC Quest
-- !pos -316.427 7.124 -260.868 11
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(60)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
