-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Alfred
-- !pos 94 1 -58 80
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(314)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 200 and option == 1) then
        player:setPos(94, -62, 266, 40, 81)
    end

end
