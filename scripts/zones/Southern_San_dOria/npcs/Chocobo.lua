-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Chocobo
-- Chocobo
-----------------------------------
function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- player:startEvent(601)
    -- player:startEvent(820) --crazy hang
    -- player:startEvent(821) --crazy hang
    -- player:startEvent(600)
    -- player:startEvent(599)
    -- player:startEvent(862) -- cool choco debug menu
    -- player:startEvent(819)
    player:startEvent(818)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- printf("OPTION:", option)
end
