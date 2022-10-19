-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Undead Crab
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()

    instance:setProgress(instance:getProgress() + 1)
end

return entity
