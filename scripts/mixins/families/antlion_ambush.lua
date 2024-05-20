-- Antlion family mixin (for ones that ambush)

require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.antlion_ambush = function(antlionAmbushMob)
    local pitAmbush = 278

    antlionAmbushMob:addListener('SPAWN', 'ANTLION_AMBUSH_SPAWN', function(mob)
        mob:hideName(true)
        mob:setUntargetable(true)
        mob:setAnimationSub(0)
        mob:wait(2000)
    end)

    antlionAmbushMob:addListener('ENGAGE', 'ANTLION_AMBUSH_ENGAGE', function(mob, target)
        mob:useMobAbility(pitAmbush)
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    end)

    -- Ensures an interupted pit ambush doesn't let the mob stay hidden underground
    antlionAmbushMob:addListener('WEAPONSKILL_STATE_EXIT', 'ANTLION_AMBUSH_FINISH', function(mob, skillID)
        if skillID == pitAmbush then
            -- ensure name doesn't show up until mobskill completes
            mob:setAnimationSub(1)
            mob:hideName(false)
            mob:setUntargetable(false)
        end
    end)

    antlionAmbushMob:addListener('DISENGAGE', 'ANTLION_AMBUSH_DISENGAGE', function(mob)
        mob:hideName(true)
        mob:setUntargetable(true)
        mob:setAnimationSub(0)
        mob:wait(2000)
    end)
end

return g_mixins.families.antlion_ambush
