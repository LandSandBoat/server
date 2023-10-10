-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Jaded Jody
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SLEEPRES, 75)
    mob:setSpeed(60)
end

entity.onMobFight = function(mob, target)
    local spawn = mob:getSpawnPos()

    if mob:checkDistance(spawn.x, spawn.y, spawn.z) < 40 then
        mob:setMod(xi.mod.REGEN, 150) -- Exact regen value needs confirmation
    else
        mob:setMod(xi.mod.REGEN, 0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 448)
end

return entity
