-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Gaki
-- a Thief in Norg BCNM Fight
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setMagicCastingEnabled(false)
end

entity.onMobEngage = function(mob)
    mob:setMagicCastingEnabled(true) -- Gaki will not cast spells until engaged
end

return entity
