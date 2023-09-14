-----------------------------------
-- Area: Al'Taieu
-- NM: Jailer of Prudence_2
-- Dummy file required for module functionality
-- AnimationSubs: 0 - Normal, 3 - Mouth Open
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDespawn = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
