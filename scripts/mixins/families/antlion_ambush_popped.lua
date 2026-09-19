-----------------------------------
-- Antlion family mixin (For popped antlion NMs. They come up once and are never hidden)
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.antlion_ambush_popped = function(antlion)
    antlion:addListener('PRESPAWN', 'ANTLION_AMBUSH_PRESPAWN', function(mob)
        mob:setAutoAttackEnabled(false)
        mob:setMagicCastingEnabled(false)
        mob:setAnimationSub(4)
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    end)

    antlion:addListener('ENGAGE', 'ANTLION_AMBUSH_ENGAGE', function(mob, target)
        if mob:getLocalVar('[Ambush]Done') == 0 then
            -- mob:setStatus(xi.status.UPDATE)
            -- Ignore distance. A skipped ambush leaves the mob underground for life.
            mob:useMobAbility(xi.mobSkill.PIT_AMBUSH_1, target, nil, true)
        end
    end)

    -- Ensures an interupted pit ambush doesn't let the mob stay hidden underground
    antlion:addListener('WEAPONSKILL_STATE_EXIT', 'ANTLION_AMBUSH_FINISH', function(mob, skillId, wasExecuted)
        if skillId == xi.mobSkill.PIT_AMBUSH_1 then
            mob:setAutoAttackEnabled(true)
            mob:setMagicCastingEnabled(true)
            mob:setAnimationSub(5)
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
            mob:setLocalVar('[Ambush]Done', 1)
        end
    end)
end

return g_mixins.families.antlion_ambush_popped
