-----------------------------------
-- Area: Lufaise Meadows
--   NM: Flockbock
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/rage")}
-----------------------------------
local entity = {}

-- Confirm spawn positions

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.MOVE, 10)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 1 hour rage
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 442)
end

return entity
