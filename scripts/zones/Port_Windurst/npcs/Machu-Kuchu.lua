-----------------------------------
-- Area: Port Windurst
-- Machu-Kuchu
-- Warps players to Windurst Walls
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(338)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (option == 1) then
        player:setPos(65.534, -7.5, -49.935, 59, 239) -- Retail packet capped
    end
end
