-----------------------------------
-- Area: Lebros Cavern (Troll Fugitives)
--  Mob: Broken Troll Soldier
-- Todo: make them spawn at 25-75% hp and stay
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    local maxHP = mob:getHP()
    local hpAdjust = math.random(25, 75)
    mob:setHP(maxHP * (hpAdjust / 100))
    mob:setMobMod(xi.mobMod.NO_REST, 1)
end

entity.onMobEngage = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    instance:setProgress(instance:getProgress() + 1)
end

return entity
