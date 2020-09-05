-----------------------------------
-- Area: Walk Of Echoes
--  NPC: Veridical Conflux
-- !pos -414 14 -60 182
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(1004)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 1004 and option == 0) then
        player:setPos(238, -8, -248, 0, 137)
    end
end
