-----------------------------------
-- Area: Metalworks
--  NPC: Mighty Fist
-- !pos -47 2 -30 237
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local randMessage = math.random(0, 1)

    if randMessage == 1 then
        player:startEvent(560)
    else
        player:startEvent(561)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
