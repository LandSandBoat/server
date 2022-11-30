-----------------------------------
--  MOB: Mokka
-- Area: Nyzul Isle
-- Info: Enemy Leader, Only uses Deafening Tantara
-----------------------------------
require('scripts/globals/status')
require('scripts/globals/nyzul')
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addListener("CRITICAL_TAKE", "IMP_CRITICAL_TAKE", function(impMob)
        if math.random(100) <= 20 and impMob:getAnimationSub() == 4 then
            impMob:setAnimationSub(5)
            -- Reacquire horn after 5 to 60 seconds
            impMob:timer(math.random(5000, 60000), function(hornLessmob)
                if hornLessmob:isAlive() then
                    hornLessmob:setAnimationSub(4)
                end
            end)
        end
    end)

    mob:setMod(xi.mod.MOVE, 64)
    mob:setAnimationSub(4)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
    end
end

return entity
