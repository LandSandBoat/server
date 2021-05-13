-----------------------------------
-- Area: Lebros Cavern (Troll Fugitives)
--  Mob: Troll Fugitive
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addStatusEffect(xi.effect.NO_REST, 1, 0, 0)
end

entity.onMobSpawn = function(mob)
    local MaxHP = mob:getHP()
    local bonus = math.random(2, 6)

    mob:setHP(MaxHP / (8 / bonus))
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    local instance = mob:getInstance()
    local firstCall = isKiller or noKiller

    if firstCall then
        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
