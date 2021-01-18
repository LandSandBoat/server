-----------------------------------
-- Area: Lebros Cavern (Troll Fugitives)
--  Mob: Broken Troll Soldier
-- Todo: make them spawn at 25-75% hp and stay
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    local MaxHP = mob:getHP()
    local bonus = math.random(2, 6)
    mob:setHP(MaxHP / (8/(bonus)))
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end

return entity
