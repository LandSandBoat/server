-----------------------------------
-- Area: Feretory
--  NPC: Suibhne
-- !pos TODO
-----------------------------------
require('scripts/globals/monstrosity')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(11, 1, 1, 0, 0, 0, 0, 0, 0)
end

entity.onEventUpdate = function(player, csid, option, npc)
    print('update', csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    print('finish', csid, option)
    -- Answers:
    -- 1) 4. Teyrnon
    -- 2) 3. Suibhne
    -- 3) 1. Aengus
    if csid == 11 and option == 2 then
        -- Quiz failed
    elseif csid == 11 and option == 6029313 then
        -- Quiz succeeded
        -- TODO: Unlock Bee (MON)
    end
end

return entity
