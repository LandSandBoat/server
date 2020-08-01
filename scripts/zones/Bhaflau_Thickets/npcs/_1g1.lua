-----------------------------------
-- Area: Bhaflau Thickets
-- Door: Heavy Iron Gate
-- !pos -180 -10 -758 52
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getZPos() > -761) then
        player:startEvent(106)
    else
        player:startEvent(107)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
