-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Arvilauge
-- Optional Involvement in Quest: A Squire's Test II
-- !pos -11 1 -94 230
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, 11076)--temp dialog
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
