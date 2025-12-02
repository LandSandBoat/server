-----------------------------------
-- Area: RoMaeve
--   NM: Rogue Receptacle
--  WOTG Nov 2009 NM: Immune to Bind, Sleep, Gravity. Uses only 1 TP move.
-----------------------------------
local ID = zones[xi.zone.ROMAEVE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.ROGUE_RECEPTACLE - 4] = ID.mob.ROGUE_RECEPTACLE,
    [ID.mob.ROGUE_RECEPTACLE - 1] = ID.mob.ROGUE_RECEPTACLE,
}

entity.spawnPoints =
{
    { x =  219.800, y = -3.200, z = -41.220 },
    { x = -307.000, y =  2.000, z = 216.000 },
    { x = -299.000, y =  0.000, z = 192.000 },
    { x = -334.000, y =  3.000, z = 182.000 },
    { x = -301.000, y =  0.000, z = 166.000 },
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.STORETP, 20)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENLIGHT, { chance = 100 })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 328)
end

return entity
