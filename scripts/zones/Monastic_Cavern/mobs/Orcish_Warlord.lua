-----------------------------------
-- Area: Monastic Cavern
--   NM: Orcish Warlord
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.LEDGE_AGGRO, 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
