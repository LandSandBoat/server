-----------------------------------
-- Area : Sacrificial Chamber
-- Mob  : Qull the Fallstopper
-- BCNM : Amphibian Assault
-- Job  : Monk
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 4)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 4)
end

return entity
