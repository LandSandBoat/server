-----------------------------------
-- Area: Full Moon Fountain
--  Mob: Ace of Batons
-- Windurst Mission 9-2
-----------------------------------
local global = require('scripts/zones/Full_Moon_Fountain/Globals')
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    global.tryPhaseChange(player)
end

entity.onEventFinish = function(player, csid, option, npc)
    global.phaseEventFinish(player, csid)
end

return entity
