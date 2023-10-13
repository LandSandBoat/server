-----------------------------------
-- Area: Mamook
--  NPC: Mahogany Door (Warp to Jade Sepulcher)
-- !pos -300 17.8 -362
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Exact event call needs confirmation
    player:startEvent(220)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- Exact destination needs confirmation
    player:setPos(300, -0.853, -177.745, 60, 67) -- Warp to Jade Sepulcher
end

return entity
