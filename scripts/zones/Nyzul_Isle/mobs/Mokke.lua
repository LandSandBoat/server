-----------------------------------
--  MOB: Mokke
-- Area: Nyzul Isle
-- Info: Enemy Leader, Only uses Abrasive Tantara
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/nyzul")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addListener("CRITICAL_TAKE", "IMP_CRITICAL_TAKE", function(mob)
        if math.random(100) <= 20 and mob:AnimationSub() == 4 then
            mob:AnimationSub(5)
            -- Reacquire horn after 5 to 60 seconds
            mob:timer(math.random(5000, 60000), function(mob)
                if mob:isAlive() then mob:AnimationSub(4) end
            end)
        end
    end)
    mob:setMod(xi.mod.MOVE, 64)
    mob:AnimationSub(4)
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
    end
end

return entity
