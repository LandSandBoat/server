-----------------------------------
-- Area: Rabao
--  NPC: Guinavie
-- Type: Chocobo Vendor
-- !pos 6.666 -0.515 -77.944 247
-----------------------------------
local entity = {}

local eventSucceed = 79
local eventFail    = 80

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
