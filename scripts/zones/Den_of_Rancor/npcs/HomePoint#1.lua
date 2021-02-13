-----------------------------------
-- Area: Den_of_Rancor
--  NPC: HomePoint#1
-- !pos -80 46 62 160
-----------------------------------
require("scripts/globals/homepoint")
-----------------------------------
local entity = {}

local hpEvent = 8700
local hpIndex = 57

entity.onTrigger = function(player, npc)
    tpz.homepoint.onTrigger(player, hpEvent, hpIndex)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.homepoint.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    tpz.homepoint.onEventFinish(player, csid, option, hpEvent)
end

return entity
