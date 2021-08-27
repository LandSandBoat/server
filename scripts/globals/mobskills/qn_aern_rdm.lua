-----------------------------------
-- Chainspell
-- Meant for Qn'aern (RDM) with Ix'Aern encounter
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if (mob:getPool() == 3269 and mob:getHPP() <= 70) then
        return 0
    else
        return 1
    end
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.CHAINSPELL
    MobBuffMove(mob, typeEffect, 1, 0, 60)

    skill:setMsg(xi.msg.basic.USES)
    return typeEffect
end

return mobskill_object
