-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Atiza
-- Admits players to the dock in Aht Urhgan
-- !pos 5.195 -1 98.966 50
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(223, player:getGil(), 100)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 223 and option == 333 then
        player:delGil(100)
    end
end
