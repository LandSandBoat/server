-----------------------------------
-- Area : Waughroon Shrine
-- Mob  : Yo'Bhu Hideousmask
-- BCNM : Grimshell Shocktroopers
-- Job  : Warrior
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 4)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 4)
end

return entity
