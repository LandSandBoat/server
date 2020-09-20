-----------------------------------
-- Area: Abyssea - Uleguerand
--  NPC: Cavernous Maw
-- !pos -246.000, -40.600, -520.000 253
-- Notes: Teleports Players to Xarcabard
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(200)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 200 and option == 1 then
        player:setPos(269, -7, -75, 192, 112)
    end
end
