-----------------------------------
-- Area: Feretory
--  NPC: Odyssean Passage
-- !pos TODO
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    print('update', csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    print('finish', csid, option)
end

return entity
