-----------------------------------
-- Area: Windurst Woods
--  NPC: Pattsu-Yabittsu
-- Warps players to Windurst Waters
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(411)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if option == 1 then
        player:setPos(-2.203, -1.5, 103.226, 196, 238) -- Retail packet capped
    end
end

return entity
