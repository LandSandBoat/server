-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Tomb Bat
-- Note: Place holder Crypt Ghost
-----------------------------------
local ID = zones[xi.zone.KING_RANPERRES_TOMB]
-----------------------------------
local entity = {}

local cryptPHTable =
{
    [ID.mob.CRYPT_GHOST - 3] = ID.mob.CRYPT_GHOST,
    [ID.mob.CRYPT_GHOST - 2] = ID.mob.CRYPT_GHOST,
    [ID.mob.CRYPT_GHOST - 1] = ID.mob.CRYPT_GHOST,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, cryptPHTable, 5, 3600) -- 1 hour
end

return entity
