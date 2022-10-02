-----------------------------------
-- Area: Mine Shaft 2716
-- Mob: Fantoccini Avatar
-- ENM: Pulling the Strings
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- Mob is untargetable without this. TODO: Figure out why
    mob:setUntargetable(false)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
