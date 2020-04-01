-----------------------------------
-- Area: Palborough Mines
--  NPC: Old Toolbox
-- Continues Quest: The Eleventh's Hour (100%)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(14)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 14 then
        player:setPos(-73, 0, 60, 1, 172)
    end
end
