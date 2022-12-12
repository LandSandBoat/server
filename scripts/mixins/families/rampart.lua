require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

-- AnimationSub for Ramparts
-- 0 = door closed
-- 1 = door open

g_mixins.families.rampart = function(rampartMob)
    rampartMob:addListener("SPAWN", "RAMPART_SPAWN", function(mob)
        mob:setLocalVar("swapTime", os.time())
    end)

    rampartMob:addListener("TICK", "RAMPART_TICK", function(mob)
        local swapTime = mob:getLocalVar("swapTime")

        if swapTime > 0 and os.time() > swapTime then
            local animationSub = mob:getAnimationSub()

            if animationSub == 0 then
                mob:setAnimationSub(1)
                mob:setLocalVar("swapTime", os.time() + 30)

            elseif animationSub == 1 then
                mob:setAnimationSub(0)
                mob:setLocalVar("swapTime", os.time() + 30)
            end
        end
    end)
end

return g_mixins.families.rampart
