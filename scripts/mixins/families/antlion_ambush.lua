-----------------------------------
-- Antlion family mixin (For antlions that return underground)
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function hide(mob)
    mob:hideName(true)
    mob:setUntargetable(true)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)
    mob:setAnimationSub(4)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    -- mob:setStatus(xi.status.INVISIBLE) -- TODO: Implement once packet 0x00E is rewritten.
end

g_mixins.families.antlion_ambush = function(antlion)
    antlion:addListener('PRESPAWN', 'ANTLION_AMBUSH_PRESPAWN', function(mob)
        hide(mob)
    end)

    antlion:addListener('ENGAGE', 'ANTLION_AMBUSH_ENGAGE', function(mob, target)
        -- mob:setStatus(xi.status.UPDATE)
        -- Ignore distance. A skipped ambush leaves the mob underground for life.
        mob:useMobAbility(xi.mobSkill.PIT_AMBUSH_1, target, nil, true)
    end)

    antlion:addListener('WEAPONSKILL_STATE_EXIT', 'ANTLION_AMBUSH_FINISH', function(mob, skillId, wasExecuted)
        if skillId == xi.mobSkill.PIT_AMBUSH_1 then
            mob:hideName(false)
            mob:setUntargetable(false)
            mob:setAutoAttackEnabled(true)
            mob:setMagicCastingEnabled(true)
            mob:setAnimationSub(5)
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        end
    end)

    antlion:addListener('DISENGAGE', 'ANTLION_AMBUSH_DISENGAGE', function(mob)
        hide(mob)
    end)
end

return g_mixins.families.antlion_ambush
