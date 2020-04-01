-----------------------------------
-- Area: Heavens Tower
--  NPC: Gamimi
-- Type: GOLD WORLD PASS ARBITER
-- !pos 4 0.1 32 242
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(10000) -- , 0, 0, 0, 0, 0, -1, 2)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
