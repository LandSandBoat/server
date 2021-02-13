-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Meuneille
-- Type: Chocobo Renter
-- !pos -12.3 1.4 -98 230
-----------------------------------
require("scripts/globals/chocobo")
-----------------------------------
local entity = {}

local eventSucceed = 601
local eventFail    = 604

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
