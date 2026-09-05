-- Description: Handles the inflation of the Cockatrice neck sack.
-- Behavior: Cockatrices change which abilities they can use depending on their animation sub.
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.cockatrice_ziz = xi.mix.cockatrice_ziz or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

xi.mix.cockatrice_ziz.onMobMobskillChoose = function(mob, target)
    local sackSize   = mob:getAnimationSub()
    local isSilenced = mob:hasStatusEffect(xi.effect.SILENCE)

    if
        sackSize == 2 and
        not isSilenced
    then
        return xi.mobSkill.SOUND_BLAST
    end

    local skillList =
    {
        xi.mobSkill.BALEFUL_GAZE_COCKATRICE,
        xi.mobSkill.HAMMER_BEAK,
        xi.mobSkill.POISON_PICK,
    }

    if not isSilenced then
        table.insert(skillList, xi.mobSkill.SOUND_VACUUM_COCKATRICE)
    end

    if
        sackSize == 0 and
        not isSilenced
    then
        table.insert(skillList, xi.mobSkill.SOUND_BLAST)
    end

    return skillList[math.randomInt(1, #skillList)]
end

xi.mix.cockatrice_ziz.onMobWeaponSkill = function(mob, target, skill)
    if skill and skill:getID() == xi.mobSkill.SOUND_BLAST then
        mob:setAnimationSub(0)
    end
end

g_mixins.families.cockatrice_ziz = function(cockatriceMob)
    cockatriceMob:addListener('WEAPONSKILL_STATE_EXIT', 'COCKATRICE_ABILITY', function(mobArg, skillId, wasExecuted)
        if not skillId or not wasExecuted then
            return
        end

        if skillId == xi.mobSkill.SOUND_VACUUM_COCKATRICE then
            mobArg:setAnimationSub(2)
        else
            mobArg:setAnimationSub(1)
        end
    end)

    cockatriceMob:addListener('EFFECT_GAIN', 'SILENCE_EFFECT_GAIN', function(mobArg, effect)
        if effect:getEffectType() == xi.effect.SILENCE then
            mobArg:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
        end
    end)

    cockatriceMob:addListener('EFFECT_LOSE', 'SILENCE_EFFECT_LOSE', function(mobArg, effect)
        if effect:getEffectType() == xi.effect.SILENCE then
            mobArg:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 100)
        end
    end)
end

return g_mixins.families.cockatrice_ziz
