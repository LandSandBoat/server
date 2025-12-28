-----------------------------------
-- Area: Western Altepa Desert
--   NM: Calchas
--  WOTG Nov 2009 NM: Immune to Bind, Sleep, Gravity. Uses only 1 TP move.
-----------------------------------
local ID = zones[xi.zone.WESTERN_ALTEPA_DESERT]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -419.100, y = -1.440, z = -293.200 },
    { x = -411.475, y = -1.169, z = -316.227 },
    { x = -442.700, y = -8.000, z = -317.073 },
    { x = -441.010, y =  0.000, z = -278.406 },
    { x = -403.524, y = -0.067, z = -275.723 }
}

entity.phList =
{
    [ID.mob.CALCHAS - 2] = ID.mob.CALCHAS,
}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:setMod(xi.mod.STORETP, 80)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 415)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
