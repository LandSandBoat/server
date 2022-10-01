-----------------------------------
-- Area: Full Moon Fountain
--  Mob: Ace of Cups
-- Windurst Mission 9-2
-----------------------------------
local global = require("scripts/zones/Full_Moon_Fountain/Globals")
local ID = require("scripts/zones/Full_Moon_Fountain/IDs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    global.tryPhaseChange(player)
end

entity.onEventFinish = function(player, csid, option)
    global.phaseEventFinish(player, csid)
end

return entity
