-----------------------------------
-- Area: Quicksand Caves
--   NM: Triarius IV-XIV
-- Pops in Bastok mission 8-1 "The Chains that Bind Us"
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobDisengage = function(mob)
    DespawnMob(mob:getID(), 120)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
