-----------------------------------
-- Area: Beadeaux [S]
--   NM: Ba'Tho Mercifulheart
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.BEADEAUX_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -93.112, y = -3.500, z =  179.625 }
}

entity.phList =
{
    [ID.mob.BATHO_MERCIFULHEART - 1] = ID.mob.BATHO_MERCIFULHEART,
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
