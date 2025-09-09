-----------------------------------
-- Area: Provenance
--  HNM: Provenance Watcher
-----------------------------------
---@type TMobEntity
require("scripts/globals/magic")

local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobFight = function(mob, target)
    if mob:getHP() < 75000 then
        if mob:hasStatusEffect(xi.effect.SILENCE) then
            mob:delStatusEffect(xi.effect.SILENCE)
            mob:useMobAbility(436)
            target:printToPlayer("Hahaha.. you think you can win?", xi.msg.channel.SYSTEM_3)
            mob:castSpell(367)
        end
    end

    if mob:getHP() < 10000 then
        mob:setHP(100000)
        target:printToPlayer("You think you can defeat me!?", xi.msg.channel.SYSTEM_3)
    end
end

entity.onMobDeath = function(mob, killer)
end

return entity