-----------------------------------
-- Area: Feretory
--  NPC: Maccus
-- !pos TODO
-----------------------------------
require('scripts/globals/monstrosity')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(9, 285, 2, 2, 0, 0, 0, 0, 0)
end

entity.onEventUpdate = function(player, csid, option, npc)
    print('update', csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    print('finish', csid, option)
end

return entity
