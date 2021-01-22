require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

-- AnimationSub for Qutrub
-- 0 = main weapon out, sub weapon sheathed
-- 1 = main weapon broken, sub weapon sheathed
-- 2 = main weapon broken, sub weapon out
-- 3 = both weapons broken

g_mixins.families.qutrub = function(mob)

    -- set default 10% chance to break weapon on critical hit taken
    -- this can be overridden in onMobSpawn

    mob:addListener("SPAWN", "QUTRUB_SPAWN", function(mob)
        mob:setLocalVar("qutrubBreakChance", 10)
    end)

    -- when a qutrub's weapon has been broken it will switch between using its second

    mob:addListener("COMBAT_TICK", "QUTRUB_COMBAT_TICK", function(mob)
        local swapTime = mob:getLocalVar("swapTime")

        if swapTime > 0 and os.time() > swapTime then
            local animationSub = mob:getAnimationSub()

            if animationSub == 1 then
                mob:setAnimationSub(2)
                mob:setLocalVar("swapTime", os.time() + 60)

            elseif animationSub == 2 then
                mob:setAnimationSub(1)
                mob:setLocalVar("swapTime", os.time() + 60)
            end
        end
    end)

    -- chance to break weapon when taking a critical hit

    mob:addListener("CRITICAL_TAKE", "QUTRUB_CRITICAL_TAKE", function(mob)
        if math.random(100) <= mob:getLocalVar("qutrubBreakChance") then
            local animationSub = mob:getAnimationSub()

            -- break first weapon
            if animationSub == 0 then
                mob:setAnimationSub(1)
                mob:setLocalVar("swapTime", os.time() + 60)

            -- break second weapon
            elseif animationSub == 2 then
                mob:setAnimationSub(3)
                mob:setLocalVar("swapTime", 0)
            end
        end

    end)

end

return g_mixins.families.qutrub
