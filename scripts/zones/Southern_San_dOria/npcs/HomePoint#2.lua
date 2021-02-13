-----------------------------------
-- Area: Southern San dOria
--  NPC: HomePoint#2
-- !pos 45 2 -35 230
-----------------------------------
require("scripts/globals/homepoint")
-----------------------------------
local entity = {}

local hpEvent = 8701
local hpIndex = 1

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
