-----------------------------------
-- Area: Western Adoulin
--  NPC: Phileem
-- Type: Standard NPC
-- !pos -20 0 -105 256
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Standard dialogue
    player:startEvent(537)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
