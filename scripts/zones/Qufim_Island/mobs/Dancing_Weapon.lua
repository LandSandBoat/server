-----------------------------------
-- Area: Qufim Island
--  Mob: Dancing Weapon
-- Note: PH for Trickster Kinetix
-----------------------------------
local ID = zones[xi.zone.QUFIM_ISLAND]
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.TRICKSTER_KINETIX_PH, 5, 3600) -- 1 hour
end

return entity
