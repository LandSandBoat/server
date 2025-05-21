-----------------------------------
-- Area: Pashhow Marshlands [S]
--  NPC: Milloure
-- Type: Chocobo Renter
-- !pos 336.765 24.416 -124.592 90
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventSucceed = 103
local eventFail    = 104

entity.onTrigger = function(player, npc)
    xi.chocobo.renterOnTrigger(player, npc, eventSucceed, eventFail)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.chocobo.renterOnEventFinish(player, csid, option, eventSucceed)
end

return entity
