-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Lotine
-- Type: Standard Info NPC
-- !pos -137.504 11.999 171.090 231
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local rand = math.random(1, 2)
    if (rand == 1) then
        player:startEvent(652)
    else
        player:startEvent(656)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
