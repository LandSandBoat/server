-----------------------------------
-- Area: Mamool Ja Training Grounds (Preemptive Strike)
--  Mob: Mamool Ja Executioner (BLU/WHM/NIN)
-----------------------------------
mixins = {require("scripts/mixins/weapon_break")}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    if mob:getMainJob() ~= xi.job.WHM then
        mob:setLocalVar("BreakChance", 0) -- Only whm mobs have weapons to break
    end
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    local firstCall = isKiller or noKiller
    if firstCall then
        local instance = mob:getInstance()
        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
