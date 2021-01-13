-----------------------------------
-- Area: Mamool Ja Training Grounds (Preemptive Strike)
--  Mob: Mamool Ja Executioner
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end

return entity
