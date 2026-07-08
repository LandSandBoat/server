-----------------------------------
-- Area: Wajaom Woodlands
--  NPC: Watisa
-- Type: Chocobo Renter
-- !pos -201 -11 93 51
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventSucceed = 9
local eventFail    = 10

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
