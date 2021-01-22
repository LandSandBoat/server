require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.imp = function(mob)

    -- 20% chance to break horn on critical hit
    mob:addListener("CRITICAL_TAKE", "IMP_CRITICAL_TAKE", function(mob)
        if math.random(100) < 20 and mob:getAnimationSub() == 0 then
            mob:setAnimationSub(1)
        end
    end)

end

return g_mixins.families.imp
