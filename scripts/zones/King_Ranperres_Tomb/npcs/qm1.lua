-----------------------------------
-- Area: King Ranperre's Tomb
--  NPC: ??? (qm1)
-- Notes: Used to teleport down the stairs
-- !pos -81 -1 -97 190
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(10)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- TODO: Missing teleport-animation. Might be a core issue as to why it wont display.
    if csid == 10 and option == 100 then
        player:setPos(-81.5, 7.297, -127.919, 71)
    end
end

return entity
