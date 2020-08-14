-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Collione
--  General Info NPC
-- !pos 10 2 -66 230
-------------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(859)
-- player:startEvent(854)  --chocobo dig game
-- player:startEvent(856)  -- play the chocobo game
-- player:startEvent(857)  -- rules for choc game
-- player:startEvent(858)  -- cant give more greens
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
