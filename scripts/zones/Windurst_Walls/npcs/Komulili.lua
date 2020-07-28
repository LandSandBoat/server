-----------------------------------
-- Area: Windurst Walls
--  NPC: Komulili
-- Warps players to Port Windurst
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
        player:setPos(-111.919, -8.75, 92.093, 62, 240) -- {R}
    end
end
