-----------------------------------
-- Area: Fort Ghelsba
--   NM: Hundredscar Hajwaj
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.FORT_GHELSBA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  1.000, y = -28.000, z = -52.000 }
}

entity.phList =
{
    [ID.mob.HUNDREDSCAR_HAJWAJ - 5] = ID.mob.HUNDREDSCAR_HAJWAJ,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 172)
end

return entity
