-----------------------------------
-- Area: Al'Taieu
--  Mob: Qn'xzomit
-- Note: Pet for JOJ
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- Sets a timer to self destruct betwen 25 - 35 seconds after being damaged
    mob:addListener("TAKE_DAMAGE", "QNXZOMIT_JOL_TAKE_DAMAGE", function(xzomit, amount)
        if amount > 0 and xzomit:getLocalVar("control") == 0 then
            mob:setLocalVar("control", 1)
            xzomit:timer((30 + math.random(-5, 5)) * 1000, function(xzomitArg)
                xzomitArg:useMobAbility(731) -- Mijin Gakure
                xzomitArg:timer(1000, function(xzomitTimer)
                    xzomitArg:setHP(0)
                end)
            end)
        end
    end)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:addStatusEffectEx(xi.effect.FLEE, 0, 100, 0, 60)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
