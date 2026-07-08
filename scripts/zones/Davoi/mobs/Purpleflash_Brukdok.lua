-----------------------------------
-- Area: Davoi
--  NM: Purpleflash Brukdok
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 10)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 10)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 11)
end

return entity
