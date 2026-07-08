-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Gaki
-- a Thief in Norg BCNM Fight
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMagicCastingEnabled(false)
end

entity.onMobEngage = function(mob)
    mob:setMagicCastingEnabled(true) -- This will prevent Gaki from using blaze spikes before the fight starts
end

return entity
