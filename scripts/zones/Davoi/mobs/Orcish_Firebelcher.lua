-----------------------------------
-- Area: Davoi
--  Mob: Orcish Firebelcher
-- Note: PH for Poisonhand Gnadgad
-----------------------------------
local ID = require("scripts/zones/Davoi/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.POISONHAND_GNADGAD_PH, 10, 3600) -- 1 hour
end

return entity
