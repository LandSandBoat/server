-----------------------------------
-- Intimidate
-- Inflicts slow on targets in a fan-shaped area of effect.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 2500
    if skill:getID() == 1864 then -- Nightmare Makara - 12s Haste recast w/o slow.  20s w/.  Overwrites Haste
        power = 6600
    end

    if target:hasStatusEffect(xi.effect.HASTE) and skill:getID() ~= 1864 then
        -- Does this really belong here?  Shouldnt the effect power handle this?
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return
    else
        skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.SLOW, power, 0, 120))
    end

    return xi.effect.SLOW
end

return mobskillObject
