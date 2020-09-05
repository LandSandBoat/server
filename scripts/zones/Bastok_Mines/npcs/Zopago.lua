-----------------------------------
-- Area: Bastok Mines
--   NPC: Zopago
-- Type: VCS Chocobo Trainer
-- !pos 51.706 -0.126 -109.065 234
--
-- Auto-Script: Requires Verification
-----------------------------------

function onTrade(player, npc, trade)

--    player:startEvent(514) -- event that follows egg trading
end

function onTrigger(player, npc)

    player:startEvent(508)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
