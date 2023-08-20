-----------------------------------
-- Abrasive Tantara
--
-- Description: Inflicts amnesia in an area of effect
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 10' as well as single target outside of 10'
-- Notes: Doesn't use this if its horn is broken.  It is possible for Abrasive Tantara to miss. - See discussion
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 1 and mob:getFamily() == 165 then -- Imps without horn
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power    = 1
    local duration = 60

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AMNESIA, power, 0, duration))

    return xi.effect.AMNESIA
end

return mobskillObject
