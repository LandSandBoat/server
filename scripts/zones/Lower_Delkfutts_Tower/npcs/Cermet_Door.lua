-----------------------------------
-- Area: Lower Delkfutt's Tower
--  NPC: Cermet Door
-- Notes: Leads to Upper Delkfutt's Tower.
-- !pos 524 16 20 184
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(20) -- missing walk-through animation, but it's the best I could find.
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 20 and option == 1 then
        player:setPos(313, 16, 20, 128, 158) -- to Upper Delkfutt's Tower
    end
end

return entity
