-----------------------------------
-- Area: Davoi
--   NM: Dirtyhanded Gochakzuk
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 10)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 10)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 10)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
