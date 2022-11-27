-----------------------------------
-- Area: Ru'Aun 2.0
--   NM: Byakko Pet
-----------------------------------
local ID = require("scripts/zones/Escha_RuAun/IDs")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob, target)
    mob:setDropID(0)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
