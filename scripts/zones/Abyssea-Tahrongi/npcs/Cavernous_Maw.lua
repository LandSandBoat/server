-----------------------------------
-- Area: Abyssea - Tahrongi
--  NPC: Cavernous Maw
-- !pos -31.000, 47.000, -681.000 45
-- Teleports Players to Tahrongi Canyon
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
        player:setPos(-28, 46, -680, 76, 117)
    end
end
