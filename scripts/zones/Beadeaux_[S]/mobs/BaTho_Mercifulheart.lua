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

entity.phList =
{
    [ID.mob.BATHO_MERCIFULHEART - 1] = ID.mob.BATHO_MERCIFULHEART,
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
