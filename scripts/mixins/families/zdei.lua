require("scripts/globals/mixins")
require("scripts/globals/utils")

-- Animation Sub 0 Pot Form
-- Animation Sub 1 Pot Form (reverse eye position)
-- Animation Sub 2 Bar Form
-- Animation Sub 3 Ring Form

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.zdei = function(mob)
    mob:addListener("SPAWN", "ZDEI_SPAWN", function(mobArg)
        mob:setAnimationSub(0)
    end)

    mob:addListener("ENGAGE", "ZDEI_ENGAGE", function(mobArg, target)
        mob:setAnimationSub(1)
        mob:setLocalVar("changeTime", os.time() + math.random(15, 30))
    end)

    mob:addListener("DISENGAGE", "ZDEI_DISENGAGE", function(mobArg)
        mob:setAnimationSub(0)
        mob:setLocalVar("changeTime", 0)
    end)

    mob:addListener("COMBAT_TICK", "ZDEI_CTICK", function(mobArg)
        local changeTime = mob:getLocalVar("changeTime")
        local now = os.time()

        -- Change to a new mode if time has expired and not currently charging optic induration
        if
            now >= changeTime and
            mob:getCurrentAction() == xi.act.ATTACK and
            mob:getLocalVar("chargeCount") == 0
        then
            if mob:getAnimationSub() <= 1 then
                mob:setAnimationSub(math.random(2, 3))
                mob:setLocalVar("changeTime", now + math.random(45, 60))
            else
                mob:setAnimationSub(1)
                mob:setLocalVar("changeTime", now + math.random(15, 30))
            end
        end
    end)
end

return g_mixins.families.zdei
