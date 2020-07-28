-----------------------------------
-- Area: Toraimarai Canal
--  NPC: Transporter
-- Involved In Windurst Mission 7-1
-- !pos 182 11 -60 169
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(71)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 71 and option == 1 then
        player:setPos(0, 0, -22, 192, 242)
    end
end
