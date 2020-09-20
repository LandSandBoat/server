-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: _1e9 (Gate: The Pit)
-- !pos 80 -1.949 -107.94
-- Used to enter "The Colosseum" zone.
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(133)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 133 and option == 1 then
        player:setPos(-600, 0, 40, 254, 71)
    end
end
