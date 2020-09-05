-----------------------------------
-- Area: Port Jeuno
--  NPC: Door: Arivals (from Windurst)
-- Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    player:startEvent(55)
    return 1

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
