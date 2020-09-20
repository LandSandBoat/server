-----------------------------------
-- Area: Windurst Woods
--  NPC: Pulonono
-- Type: VCS Chocobo Trainer
-- !pos 130.124 -6.35 -119.341 241
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(741)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
