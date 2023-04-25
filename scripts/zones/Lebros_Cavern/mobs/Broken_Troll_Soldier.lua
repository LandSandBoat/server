-----------------------------------
-- Area: Lebros Cavern (Troll Fugitives)
--  Mob: Broken Troll Soldier
-- Todo: make them spawn at 25-75% hp and stay
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/assault")
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    local maxHP = mob:getHP()
    local bonus = math.random(2, 6)
    mob:setHP(maxHP / (8 / bonus))
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.assault.progressInstance(mob, 1)
end

return entity
