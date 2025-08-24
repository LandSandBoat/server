-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Crypt Ghost
-----------------------------------
local ID = zones[xi.zone.KING_RANPERRES_TOMB]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.CRYPT_GHOST - 3] = ID.mob.CRYPT_GHOST,
    [ID.mob.CRYPT_GHOST - 2] = ID.mob.CRYPT_GHOST,
    [ID.mob.CRYPT_GHOST - 1] = ID.mob.CRYPT_GHOST,
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
