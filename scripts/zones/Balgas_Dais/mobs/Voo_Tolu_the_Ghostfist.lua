-----------------------------------
-- Area : Balga's Dais
-- Mob  : Voo Tolu the Ghostfist
-- BCNM : Divine Punishers
-- Job  : MNK
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 4)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 4)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
