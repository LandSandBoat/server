-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Undead Crab
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()

    instance:setProgress(instance:getProgress() + 1)
end

return entity
