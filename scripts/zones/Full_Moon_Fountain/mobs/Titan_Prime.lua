-----------------------------------
-- Area: Full Moon Fountain
-- Mob: Titan Prime
-- Quest: Waking the Beast
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, isKiller)
    local phase = mob:getBattlefield():getLocalvar("phase")
end

return entity
