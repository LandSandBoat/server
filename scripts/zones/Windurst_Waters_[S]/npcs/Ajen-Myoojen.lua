-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Ajen-Myoojen
-- Type: Standard NPC
-- !pos -44.542 -5.999 238.996 94
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
        player:setPos(320, -4, -46, 192, 95)
    end
end
