-----------------------------------
-- Area: Feretory
--  NPC: Odyssean Passage
-- !pos TODO
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(5, 0, 0, 0, 0, 1, 0, 0, 0)
end

entity.onEventUpdate = function(player, csid, option, npc)
    print('update', csid, option)
    player:updateEvent(0, 0, 0, 0, 1, 0, 0, 0)
end

entity.onEventFinish = function(player, csid, option, npc)
    print('finish', csid, option)
    -- Option 1: Leave & Teleport to last city zone
    -- Option 529: Teleport to Al'Taieu
end

return entity
