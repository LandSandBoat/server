-----------------------------------
-- Summer Breeze
--
-- Description: AoE Erase xi.effect. (If nothing to Erase, it instead gains Regain.)
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local erase = mob:eraseStatusEffect()

    if (erase ~= xi.effect.NONE) then
        skill:setMsg(xi.msg.basic.SKILL_ERASE)
        return erase
    else
        skill:setMsg(MobBuffMove(mob, xi.effect.REGAIN, 10, 3, 60))
        return xi.effect.REGAIN
    end
end

return mobskill_object
