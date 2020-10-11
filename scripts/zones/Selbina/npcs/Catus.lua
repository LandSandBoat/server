-----------------------------------
-- Area: Selbina
--  NPC: Catus
-- Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getZPos() < -28.750 then
        player:startEvent(220)
    else
        player:startEvent(229)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
