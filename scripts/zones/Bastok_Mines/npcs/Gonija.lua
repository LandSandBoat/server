-----------------------------------
-- Area: Bastok Mines
--   NPC: Gonija
-- Type: Chocobo Breeder
-- !pos 28 0 -105 234
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(534)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
