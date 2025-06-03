-----------------------------------
-- Area: Rabao
--  NPC: Guinavie
-- Type: Chocobo Vendor
-- !pos 6.666 -0.515 -77.944 247
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventSucceed = 79
local eventFail    = 80

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
