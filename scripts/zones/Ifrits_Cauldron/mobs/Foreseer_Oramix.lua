-----------------------------------
-- Area: Ifrit's Cauldron
--   NM: Foreseer Oramix
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.IFRITS_CAULDRON]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -111.470, y =  3.764, z =  141.784 }
}

entity.phList =
{
    [ID.mob.FORESEER_ORAMIX - 7] = ID.mob.FORESEER_ORAMIX,
    [ID.mob.FORESEER_ORAMIX + 4] = ID.mob.FORESEER_ORAMIX,
    [ID.mob.FORESEER_ORAMIX + 7] = ID.mob.FORESEER_ORAMIX,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 399)
end

return entity
