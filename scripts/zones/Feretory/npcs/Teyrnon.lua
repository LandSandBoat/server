-----------------------------------
-- Area: Feretory
--  NPC: Teyrnon
-- !pos TODO
-----------------------------------
require('scripts/globals/monstrosity')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(7, 0, 0, 0, 0, 0, 0, 0, 0)
end

entity.onEventUpdate = function(player, csid, option, npc)
    print('update', csid, option)
    if csid == 7 and option == 0 then -- Monsters Menu
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
    elseif csid == 7 and option == 1 then -- Instinct menu
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    print('finish', csid, option)
    -- Support Menu:
    -- option    3: Dedication 1
    -- option  259: Dedication 2
    -- option  515: Regen
    -- option  771: Refresh
    -- option 1027: Protect
    -- option 1283: Shell
    -- option 1539: Haste
end

return entity
