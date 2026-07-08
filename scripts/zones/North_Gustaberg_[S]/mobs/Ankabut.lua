-----------------------------------
-- Area: North Gustaberg [S]
--   NM: Ankabut
-----------------------------------
local ID = zones[xi.zone.NORTH_GUSTABERG_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  678.599, y = -10.219, z =  532.811 }
}

entity.phList =
{
    [ID.mob.ANKABUT - 4] = ID.mob.ANKABUT, -- 656.399 -11.580 507.091
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 500)
    xi.magian.onMobDeath(mob, player, optParams, set{ 220, 648, 714, 945 })
end

return entity
