-----------------------------------
-- Mind Purge
-- Description: Dispels all buffs from a single target, including food.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Dispels shadows
-- Range: Single target
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dispel =  target:dispelAllStatusEffect(bit.bor(xi.effectFlag.DISPELABLE, xi.effectFlag.FOOD))
    local msg -- to be set later

    if dispel == 0 then
        msg = xi.msg.basic.SKILL_NO_EFFECT -- no effect
    else
        msg = xi.msg.basic.DISAPPEAR_NUM
    end

    skill:setMsg(msg)

    return dispel
end

return mobskillObject
