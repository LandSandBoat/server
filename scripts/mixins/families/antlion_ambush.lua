-- Antlion family mixin (for ones that ambush)

require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.antlion_ambush = function(antlionAmbushMob)
    antlionAmbushMob:addListener("SPAWN", "ANTLION_AMBUSH_SPAWN", function(mob)
        mob:hideName(true)
        mob:setUntargetable(true)
        if mob:getZoneID() ~= xi.zone.DYNAMIS_TAVNAZIA then
            mob:setAnimationSub(0)
            mob:wait(2000)
        end
    end)

    antlionAmbushMob:addListener("ENGAGE", "ANTLION_AMBUSH_ENGAGE", function(mob, target)
        local ability = 278 -- Pit Ambush
        if mob:getZoneID() == xi.zone.DYNAMIS_TAVNAZIA then
            ability = 1844 -- Enhanced Pit Ambush for DYNAMIS_TAVNAZIA
        end

        mob:useMobAbility(ability) -- Pit Ambush
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        mob:timer(2000, function(ant)
            ant:hideName(false)
            ant:setUntargetable(false)
            ant:setAnimationSub(1)
        end)
    end)

    antlionAmbushMob:addListener("DISENGAGE", "ANTLION_AMBUSH_DISENGAGE", function(mob)
        mob:hideName(true)
        mob:setUntargetable(true)
        mob:setAnimationSub(0)
        mob:wait(2000)
        mob:timer(2000, function(ant)
            local spawn = ant:getSpawnPos()
            ant:setPos(spawn.x, spawn.y, spawn.z, spawn.rot)
        end)
    end)
end

return g_mixins.families.antlion_ambush
