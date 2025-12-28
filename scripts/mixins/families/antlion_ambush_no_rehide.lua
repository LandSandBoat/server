-----------------------------------
-- Antlion family mixin (For antlions that don't return underground)
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.antlion_ambush_no_rehide = function(antlion)
    antlion:addListener('PRESPAWN', 'ANTLION_AMBUSH_PRESPAWN', function(mob)
        mob:hideName(true)
        mob:setUntargetable(true)
        mob:setAutoAttackEnabled(false)
        mob:setAnimationSub(0)
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        -- mob:setStatus(xi.status.INVISIBLE) -- TODO: Implement once packet 0x00E is rewritten.
    end)

    antlion:addListener('ENGAGE', 'ANTLION_AMBUSH_ENGAGE', function(mob, target)
        if mob:getLocalVar('[Ambush]Done') == 0 then
            -- mob:setStatus(xi.status.UPDATE)
            mob:useMobAbility(xi.mobSkill.PIT_AMBUSH_1)
        end
    end)

    -- Ensures an interupted pit ambush doesn't let the mob stay hidden underground
    antlion:addListener('WEAPONSKILL_STATE_EXIT', 'ANTLION_AMBUSH_FINISH', function(mob, skillId)
        if skillId == xi.mobSkill.PIT_AMBUSH_1 then
            mob:hideName(false)
            mob:setUntargetable(false)
            mob:setAutoAttackEnabled(true)
            mob:setAnimationSub(1, false)
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
            mob:setLocalVar('[Ambush]Done', 1)
        end
    end)
end

return g_mixins.families.antlion_ambush_no_rehide
