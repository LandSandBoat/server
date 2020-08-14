-----------------------------------
-- Area: Zeruhn Mines
--  NPC: Lasthenes
-- Notes: Opens Gate
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getXPos() > -79.5 then
        player:startEvent(180)
    else
        player:startEvent(181)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
