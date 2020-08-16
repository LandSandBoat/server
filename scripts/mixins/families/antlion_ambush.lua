-- Antlion family mixin (for ones that ambush)

require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.antlion_ambush = function(mob)
    mob:addListener("SPAWN", "ANTLION_AMBUSH_SPAWN", function(mob)
        mob:hideName(true)
        mob:untargetable(true)
        mob:AnimationSub(0)
        mob:wait(2000)
    end)
    mob:addListener("ENGAGE", "ANTLION_AMBUSH_ENGAGE", function(mob, target)
        mob:useMobAbility(278) -- Pit Ambush
        mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
    end)
    mob:addListener("DISENGAGE", "ANTLION_AMBUSH_DISENGAGE", function(mob)
        mob:hideName(true)
        mob:untargetable(true)
        mob:AnimationSub(0)
        mob:wait(2000)
    end)
end

return g_mixins.families.antlion_ambush
