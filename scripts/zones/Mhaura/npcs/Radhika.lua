-----------------------------------
-- Area: Mhaura
--  NPC: Radhika
-- Type: Standard NPC
-- !pos 34.124 -8.999 39.629 249
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getZPos() >= 39) then
        player:startEvent(229)
    else
        player:startEvent(222)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
