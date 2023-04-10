-----------------------------------
-- Area: Bhaflau Thickets
--  NPC: Postern (door _1g0)
-- Shortcut back into Aht Urgan Whitegate, North Harbor
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(502)
    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 502 and option == 1 then
        player:setPos(-37, 1, 56, 0, 50)
    end
end

return entity
