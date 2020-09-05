-----------------------------------
-- Area: Abdhaljs Isle-Purgonorgo
--  NPC: Pursuivant
-- Type: Warp
-- !pos 516.223 -3.038 545.258 44
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(3)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 3 and option == 1 then
        player:setPos(-0.135, 0.000, 22.880, 105, 244)
    end
end
