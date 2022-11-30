-----------------------------------
-- Area: Grauberg [S]
--   NM: Migratory Hippogryph
-- Note: Spawned for quest "The Unfinished Waltz"
-----------------------------------
require('scripts/globals/status')
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
