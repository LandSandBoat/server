-- Chigoe family mixin

require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.chigoe = function(chigoeMob)
    chigoeMob:addListener("SPAWN", "CHIGOE_SPAWN", function(mob)
        mob:hideName(true)
        mob:setUntargetable(true)
    end)

    chigoeMob:addListener("ENGAGE", "CHIGOE_ENGAGE", function(mob, target)
        mob:hideName(false)
        mob:setUntargetable(false)
    end)

    chigoeMob:addListener("DISENGAGE", "CHIGOE_DISENGAGE", function(mob, target)
        mob:hideName(true)
        mob:setUntargetable(true)
    end)
end

return g_mixins.families.chigoe
