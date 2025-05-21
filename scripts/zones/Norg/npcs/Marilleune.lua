-----------------------------------
-- Area: Norg
--  NPC: Marilleune
-- Type: Chocobo Renter
-- !pos -11.309 -0.749 -51.162 252
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventSucceed = 131
local eventFail    = 132

entity.onTrade = function(player, npc, trade)
    xi.chocobo.renterOnTrade(player, npc, trade, eventSucceed, eventFail)
end

entity.onTrigger = function(player, npc)
    xi.chocobo.renterOnTrigger(player, npc, eventSucceed, eventFail)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.chocobo.renterOnEventFinish(player, csid, option, eventSucceed)
end

return entity
