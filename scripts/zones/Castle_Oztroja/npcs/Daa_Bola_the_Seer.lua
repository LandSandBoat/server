-----------------------------------
-- Area: Castle Oztroja
--  NPC: Daa Bola the Seer
-- Type: Quest NPC
-- !pos -157.978 -18.179 193.458 151
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(86)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
