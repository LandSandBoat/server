-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Go'Bha Slaughterer
-- BCNM mob in Bastok mission 7-2.
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
