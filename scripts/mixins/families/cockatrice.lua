-- Description: Handles the inflation of the Cockatrice neck sack.
-- Behavior: Cockatrices change which abilities they can use depending on their animation sub.
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.cockatrice = xi.mix.cockatrice or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

xi.mix.cockatrice.onMobMobskillChoose = function(mob, target)
    local sackSize = mob:getAnimationSub()

    if sackSize == 2 then
        return xi.mobSkill.SOUND_BLAST
    end

    local skillList =
    {
        xi.mobSkill.BALEFUL_GAZE_COCKATRICE,
        xi.mobSkill.HAMMER_BEAK,
        xi.mobSkill.POISON_PICK,
        xi.mobSkill.SOUND_VACUUM_COCKATRICE,
    }

    if sackSize == 0 then
        table.insert(skillList, xi.mobSkill.SOUND_BLAST)
    end

    return skillList[math.randomInt(1, #skillList)]
end

xi.mix.cockatrice.onMobWeaponSkill = function(mob, target, skill)
    if skill and skill:getID() == xi.mobSkill.SOUND_BLAST then
        mob:setAnimationSub(0)
    end
end

g_mixins.families.cockatrice = function(cockatriceMob)
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
end

return g_mixins.families.cockatrice
