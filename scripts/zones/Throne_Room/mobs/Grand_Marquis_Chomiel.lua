-----------------------------------
-- Area : Throne Room
-- Mob  : Grand Marquis Chomiel
-- BCNM : Kindred Spirits
-- Job  : Warrior
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 6)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 7)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

return entity
