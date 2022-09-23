-----------------------------------
-- Area: Jugner Forest
--   NM: Cernunnos
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest/IDs")
mixins = {require("scripts/mixins/job_special")} -- TODO: Is this right?
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:setLocalVar("CERNUNNOS_DEFEATED", 1)
end

return entity
