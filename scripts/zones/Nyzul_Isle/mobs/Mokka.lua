-----------------------------------
--  MOB: Mokka
-- Area: Nyzul Isle
-- Info: Enemy Leader, Only uses Deafening Tantara
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils/nyzul")
-----------------------------------

function onMobSpawn(mob)
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

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.spawnChest(mob, player)
        nyzul.enemyLeaderKill(mob)
    end
end
