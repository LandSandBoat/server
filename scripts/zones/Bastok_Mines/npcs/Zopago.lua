-----------------------------------
-- Area: Bastok Mines
--  NPC: Zopago
-- Type: VCS Chocobo Trainer
-- !pos 51.706 -0.126 -109.065 234
-----------------------------------
-- Auto-Script: Requires Verification
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

--    player:startEvent(514) -- event that follows egg trading
end

entity.onTrigger = function(player, npc)

    player:startEvent(508)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
