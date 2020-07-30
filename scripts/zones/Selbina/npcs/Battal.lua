-----------------------------------
-- Area: Selbina
--  NPC: Battal
-- Type: Event Scene Replayer
-- !pos -17.429 -11.604 25.966 248
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(1102)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
