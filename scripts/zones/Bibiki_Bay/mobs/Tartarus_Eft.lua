-----------------------------------
-- Area: Bibiki Bay
--  Mob: Tartarus Eft
-- Note: PH for Splacknuck
-----------------------------------
local ID = require("scripts/zones/Bibiki_Bay/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.SPLACKNUCK_PH, 10, 3600) -- 1 hour
end

return entity
