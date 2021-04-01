-----------------------------------
-- Energy_Screen
--
-- Description: Invincible

-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    local phase = mob:getLocalVar("battlePhase")
    if (phase >= 3) then
        if mob:getLocalVar("nuclearWaste") == 0 and mob:getLocalVar("citadelBuster") == 0 then
            return 0
        end
    end
    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.PHYSICAL_SHIELD

    skill:setMsg(MobBuffMove(mob, typeEffect, 1, 0, 60))
    return typeEffect
end
return mobskill_object
