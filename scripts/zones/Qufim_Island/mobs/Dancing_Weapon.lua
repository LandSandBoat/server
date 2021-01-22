-----------------------------------
-- Area: Qufim Island
--  Mob: Dancing Weapon
-- Note: PH for Trickster Kinetix
-----------------------------------
local ID = require("scripts/zones/Qufim_Island/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.TRICKSTER_KINETIX_PH, 5, 3600) -- 1 hour
end

return entity
