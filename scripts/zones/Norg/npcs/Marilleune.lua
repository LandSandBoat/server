-----------------------------------
-- Area: Norg
--  NPC: Marilleune
-- Type: Chocobo Renter
-- !pos -11.309 -0.749 -51.162 252
-----------------------------------
local entity = {}

local eventSucceed = 131
local eventFail    = 132

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.chocobo.renterOnTrigger(player, eventSucceed, eventFail)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.chocobo.renterOnEventFinish(player, csid, option, eventSucceed)
end

return entity
