-----------------------------------
-- Area: Abyssea - La Theine
--  NPC: Cavernous Maw
-- !pos -480.009, 0.000, 799.927 132
-- Teleports Players to La Theine Plateau
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(200)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 200 and option == 1 then
        player:setPos(-562, 0.001, 640, 26, 102)
    end
end
