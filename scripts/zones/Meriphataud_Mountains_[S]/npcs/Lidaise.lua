-----------------------------------
-- Area: Meriphataud Mountains [S]
--  NPC: Lidaise
-- Type: Chocobo Renter
-- !pos 312.021 -10.921 28.494 97
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventSucceed = 106
local eventFail    = 107

entity.onTrigger = function(player, npc)
    xi.rentalChocobo.renterOnTrigger(player, npc, eventSucceed, eventFail)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.rentalChocobo.renterOnEventFinish(player, csid, option, eventSucceed)
end

return entity
