-----------------------------------
-- Area: Selbina
--  NPC: Lucia
-- !pos 30.552 -2.558 -30.023 248
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getZPos() > -28.750 then
        player:startEvent(221, player:getGil(), 100)
    else
        player:startEvent(235)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 221 and player:getZPos() < -28.750 then
        player:delGil(100)
    end
end
