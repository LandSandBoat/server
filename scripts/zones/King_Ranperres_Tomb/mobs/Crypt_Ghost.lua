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
    [ID.mob.CRYPT_GHOST - 1] = ID.mob.CRYPT_GHOST, -- Confirmed on retail
}

return entity
