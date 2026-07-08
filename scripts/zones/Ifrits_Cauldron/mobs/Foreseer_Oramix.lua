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

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMobMod(xi.mobMod.GIL_MIN, 6000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 6000)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 9)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 10)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 10)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 399)
end

return entity
