-----------------------------------
-- Area: Xarcabard
--   NM: Barbaric Weapon
--  WOTG Nov 2009 NM: Immune to Bind, Sleep, Gravity. Uses only 1 TP move.
-----------------------------------
local ID = zones[xi.zone.XARCABARD]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  57.000, y = -21.108, z = -24.000 },
    { x =  49.105, y = -17.595, z =  -6.877 },
    { x =  65.671, y = -19.058, z = -12.348 },
    { x =  82.766, y = -15.533, z = -27.294 },
    { x =  61.546, y = -21.743, z = -30.531 }
}

entity.phList =
{
    [ID.mob.BARBARIC_WEAPON - 1] = ID.mob.BARBARIC_WEAPON,
}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:setMod(xi.mod.STORETP, 80)
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    -- Gains Dread Spikes effect when using Whirl of Rage TP move
    if skill:getID() == 514 then
        mob:addStatusEffect(xi.effect.DREAD_SPIKES, { power = 10, duration = 180, origin = mob, icon = 0, subPower = 310, tier = 1, silent = true })
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 318)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
