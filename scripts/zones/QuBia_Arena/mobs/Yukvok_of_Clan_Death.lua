-----------------------------------
-- Area: QuBia_Arena
--  Mob: Yukvok of Clan Death
-- Mission 9-2 SANDO
-----------------------------------
local global = require('scripts/zones/QuBia_Arena/Globals')
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    global.tryPhaseChange(player)
end

entity.onEventFinish = function(player, csid, option, npc)
    global.phaseEventFinish(player, csid)
end

return entity
