-----------------------------------
-- Area: Feretory
--  NPC: Aengus
-- !pos TODO
-----------------------------------
require('scripts/globals/monstrosity')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(13, 0, 0, 2, 0, 2, 90, 0, 0)
end

entity.onEventUpdate = function(player, csid, option, npc)
    print('update', csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    print('finish', csid, option)
    if csid == 13 and option == 1 then
        -- Selected: Enter Belligerency
    end
end

return entity
