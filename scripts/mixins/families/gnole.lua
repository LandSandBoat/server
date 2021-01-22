-- Gnole family mixin

require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.gnole = function(mob)
    mob:addListener("SPAWN", "GNOLE_SPAWN", function(mob)
        mob:setLocalVar("transformTime", os.time())
    end)

    mob:addListener("ROAM_TICK", "GNOLE_ROAM", function(mob)
        attemptTransform(mob, 300)
    end)

    mob:addListener("COMBAT_TICK", "GNOLE_COMBAT", function(mob)
        attemptTransform(mob, 60)
    end)
end

function attemptTransform(mob, timeThreshold)
    local transformTime = mob:getLocalVar("transformTime")
    local currentTime = os.time()
    if currentTime - transformTime >= timeThreshold then
        local animSub = mob:getAnimationSub()
        animSub = (animSub + 1) % 2
        mob:setAnimationSub(animSub)
        mob:setLocalVar("transformTime", currentTime)
    end
end

return g_mixins.families.gnole
