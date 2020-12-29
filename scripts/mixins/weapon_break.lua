require("scripts/globals/mixins")

g_mixins = g_mixins or {}

-- AnimationSub
-- 0 = main weapon out
-- 1 = main weapon broken
-- Lamia, Trolls, Mammols

g_mixins.weapon_break = function(mob)

    -- set default 10% chance to break weapon on critical hit taken
    -- this can be overridden in onMobSpawn

    mob:addListener("SPAWN", "WEAPON_BREAK", function(mob)
        mob:setLocalVar("BreakChance", 10)
    end)

    -- chance to break weapon when taking a critical hit

    mob:addListener("CRITICAL_TAKE", "BREAK_CRITICAL_TAKE", function(mob)
        if math.random(100) <= mob:getLocalVar("BreakChance") then
            local animationSub = mob:getAnimationSub()

            -- break weapon
            if animationSub == 0 then
                mob:setAnimationSub(1)
            end
        end

    end)

end

return g_mixins.weapon_break
