-----------------------------------
-- Area: Beadeaux [S]
--   NM: Ea'Tho Cruelheart
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.BEADEAUX_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.EATHO_CRUELHEART - 1] = ID.mob.EATHO_CRUELHEART,
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
