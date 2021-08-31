-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Emoussine
-- Type: Chocobo Renter
-- !pos -12.3 1.4 -98 230
-----------------------------------
require("scripts/globals/chocobo")
-----------------------------------
local entity = {}

local eventSucceed = 600
local eventFail    = 603

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.chocobo.renterOnTrigger(player, eventSucceed, eventFail)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.chocobo.renterOnEventFinish(player, csid, option, eventSucceed)
end

return entity
