-----------------------------------
-- Area: Windurst Woods
--  NPC: Rokor-Makor
-- !pos 21 -4 -157 241
-- TODO: Event logic, values
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- if xi.settings.main.ENABLE_CHRISTMAS == 1 then
    --     player:startEvent(838)
    -- end
end

entity.onEventUpdate = function(player, csid, option)
    -- if csid == 838 and option == 1048576 then
    --     player:updateEvent(838, player:getGil(), option)
    -- elseif csid == 838 and option == 2097152 then
    --     player:delGil(10)
    --     player:updateEvent(838, 1, 0)
    -- elseif csid == 838 and option == 4264210 then
    --     print("here")
    --     player:updateEvent(838, 1, 2, 4369)
    -- end
end

entity.onEventFinish = function(player, csid, option)
end

return entity
