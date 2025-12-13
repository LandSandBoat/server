-----------------------------------
-- Area : Qu'Bia Arena
-- Mob  : Nephiyl Pinnacletosser
-- BCNM : Demolition Squad
-- Job  : Ranger
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 8)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 4)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

return entity
