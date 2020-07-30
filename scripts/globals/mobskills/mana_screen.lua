---------------------------------------------
-- Mana_Screen
--
-- Description: Magic Shield

---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local phase = mob:getLocalVar("battlePhase")
    if (phase >= 3) then
        if mob:getLocalVar("nuclearWaste") == 0 and mob:getLocalVar("citadelBuster") == 0 then
            return 0
        end
    end
    return 1
end


function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.MAGIC_SHIELD

    skill:setMsg(MobBuffMove(mob, typeEffect, 1, 0, 60))
    return typeEffect
end