-----------------------------------
-- Summer Breeze
--
-- Description: AoE Erase tpz.effect. (If nothing to Erase, it instead gains Regain.)
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local erase = mob:eraseStatusEffect()

    if (erase ~= tpz.effect.NONE) then
        skill:setMsg(tpz.msg.basic.SKILL_ERASE)
        return erase
    else
        skill:setMsg(MobBuffMove(mob, tpz.effect.REGAIN, 10, 3, 60))
        return tpz.effect.REGAIN
    end
end

return mobskill_object
