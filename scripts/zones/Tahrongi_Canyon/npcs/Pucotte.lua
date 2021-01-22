-----------------------------------
-- Area: Tahrongi Canyon
--  NPC: Pucotte
-- Type: Chocobo Renter
-- !pos 101.591 39.999 360.898 117
-----------------------------------
require("scripts/globals/chocobo")
-----------------------------------
local entity = {}

local eventSucceed = 910
local eventFail    = 911

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    tpz.chocobo.renterOnTrigger(player, eventSucceed, eventFail)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    tpz.chocobo.renterOnEventFinish(player, csid, option, eventSucceed)
end

return entity
