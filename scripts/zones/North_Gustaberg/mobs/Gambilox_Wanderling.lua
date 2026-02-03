-----------------------------------
-- Area: North Gustaberg
--  Mob: Gambilox Wanderling
-- Quest NM - "As Thick as Thieves"
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 50)
    mob:setMod(xi.mod.STORETP, 200) -- 4 hits to 1k tp with 240 delay

    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 9)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 9)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
