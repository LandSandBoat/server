-----------------------------------
-- Area: Abyssea - Grauberg
--  NPC: Cavernous Maw
-- !pos -564.000, 30.300, -760.000 254
-- Teleports Players to North Gustaberg
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
        player:setPos(-71, 0.001, 601, 126, 106)
    end
end
