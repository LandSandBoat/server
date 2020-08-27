-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Renten-Tonten
-- Type: Standard NPC
-- !pos 133.840 -6.75 173.305 94
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(421)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
