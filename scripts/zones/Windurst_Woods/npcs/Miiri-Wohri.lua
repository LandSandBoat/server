-----------------------------------
-- Area: Windurst Woods
--  NPC: Miiri-Wohri
-- Type: Standard NPC
-- !pos 106.766 -6 -30.492 241
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(111)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
