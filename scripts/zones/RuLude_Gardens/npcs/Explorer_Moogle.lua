-----------------------------------
-- Area: Ru'Lude Gardens
--   NPC: Explorer Moogle
-- Type: Mog Tablet
-- !pos 1.000 -1 0.000 243
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(10114)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
