-----------------------------------
-- Tortoise Song
-- Description: Removes all status effects in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 20' radial
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local count = target:dispelAllStatusEffect(bit.bor(xi.effectFlag.SONG, xi.effectFlag.ROLL))

    if count == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    else
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
    end

    return count
end

return mobskillObject
