-----------------------------------
-- Area: QuBia_Arena
--  Mob: Yukvok of Clan Death
-- Mission 9-2 San d'Oria
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 10)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 10)
end

return entity
