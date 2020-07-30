-----------------------------------
-- Area: Abyssea Altepa
--  NPC: Cavernous Maw
-- !pos 444.000 -0.500 320.000 218
-- Notes Teleports Players to South Gustaberg
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
        player:setPos(343, 0, -679, 199, 107)
    end
end
