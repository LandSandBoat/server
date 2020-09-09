-----------------------------------
-- Area: Lebros Cavern (Troll Fugitives)
--  Mob: Broken Troll Soldier
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
-- Todo  make them spawn at 25-75% hp and stay
function onMobEngaged(mob, target)
    local MaxHP = mob:getHP()
    local bonus = math.random(2, 6)
    mob:setHP(MaxHP / (8/(bonus)))
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end
