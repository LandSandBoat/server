-----------------------------------
-- Area: Jugner Forest
--   NM: Cernunnos
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST]
mixins = { require("scripts/mixins/job_special") } -- TODO: Is this right?
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:setLocalVar("cernunnosDefeated", 1)
end

return entity
