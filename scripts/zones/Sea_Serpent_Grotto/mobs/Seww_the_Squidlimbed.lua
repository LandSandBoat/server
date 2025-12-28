-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Seww the Squidlimbed
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  245.000, y =  11.000, z =  61.000 }
}

entity.phList =
{
    [ID.mob.SEWW_THE_SQUIDLIMBED - 3] = ID.mob.SEWW_THE_SQUIDLIMBED, -- 232.828 9.860 63.214
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 374)
    xi.magian.onMobDeath(mob, player, optParams, set{ 219, 647, 713, 944 })
end

return entity
