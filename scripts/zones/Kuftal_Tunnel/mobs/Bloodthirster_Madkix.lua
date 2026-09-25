-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Bloodthirster Madkix
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.BLOODTHIRSTER_MADKIX - 1] = ID.mob.BLOODTHIRSTER_MADKIX, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)

    mob:setMobMod(xi.mobMod.GIL_MIN, 6000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 6000)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.ACC, 350)  -- Has very high accuracy even against base level 99 evasion
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 9)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 9)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 10)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 421)
end

return entity
