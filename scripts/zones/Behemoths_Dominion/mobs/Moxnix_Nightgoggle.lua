-----------------------------------
-- Area: Behemoth's Dominion
--   NM: Moxnix Nightgoggle
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 167)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 11)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 11)
    mob:setMod(xi.mod.STORETP, 200)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
