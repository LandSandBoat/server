-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  NPC: Particle Gate
-- !pos 1 0.1 -320 34
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.A_FATE_DECIDED  and player:getCharVar("PromathiaStatus") == 0) then
        player:startEvent(2)
    else
        player:startEvent(56)
    end
    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 2) then
        player:setCharVar("PromathiaStatus", 1)
    end
end
