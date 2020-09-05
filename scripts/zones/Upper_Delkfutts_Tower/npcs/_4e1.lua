-----------------------------------
-- Area: Upper Delkfutt's Tower
--  NPC: Door
-- !pos 315 16 20 158
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(2)
    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 2 and option == 1 then
        player:setPos(524, 16, 20, 0, 184)    -- to Lower Delkfutt's Tower
    end
end
