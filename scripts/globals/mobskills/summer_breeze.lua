-----------------------------------
-- Summer Breeze
--
-- Description: AoE Erase xi.effect. (If nothing to Erase, it instead gains Regain.)
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local erase = mob:eraseStatusEffect()

    if erase ~= xi.effect.NONE then
        skill:setMsg(xi.msg.basic.SKILL_ERASE)
        return erase
    else
        skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.REGAIN, 10, 3, 60))
        return xi.effect.REGAIN
    end
end

return mobskillObject
