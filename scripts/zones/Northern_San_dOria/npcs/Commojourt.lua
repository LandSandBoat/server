-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Commojourt
-- Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local rand = math.random(1, 2)

    if (rand == 1) then
        player:startEvent(653)
    else
        player:startEvent(657)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
