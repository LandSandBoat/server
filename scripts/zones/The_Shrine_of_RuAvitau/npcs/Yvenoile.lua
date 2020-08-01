-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  NPC: Yve'noile
-- Type: Quest Giver
-- !pos 0.001 -1 0.001 178
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(53)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
