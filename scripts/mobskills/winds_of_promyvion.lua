-----------------------------------
--  Geist Wall
--
--  Description: Party memory erase.
--  Type: Enfeebling
--  Notes: Removes one detrimental magic effect for party members within area of effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dispel = target:eraseStatusEffect()

    if dispel == xi.effect.NONE then
        -- no effect
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        skill:setMsg(xi.msg.basic.SKILL_ERASE)
    end

    return dispel
end

return mobskillObject
