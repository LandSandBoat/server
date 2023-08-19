-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Tomb Bat
-- Note: Place holder Crypt Ghost
-----------------------------------
local ID = zones[xi.zone.KING_RANPERRES_TOMB]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.CRYPT_GHOST_PH, 5, 3600) -- 1 hour
end

return entity
