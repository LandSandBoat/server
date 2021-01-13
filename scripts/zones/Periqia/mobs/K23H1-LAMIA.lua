-----------------------------------
-- Area: Periqia (Shades of Vengeance)
--  Mob: K23H1-LAMIA
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    local progress = math.random(1, 4)
    instance:setProgress(instance:getProgress() + progress)
end

return entity
