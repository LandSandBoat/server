-----------------------------------
-- Ability: Warcry
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

function OnMobSkillCheck(target, mob, skill)
    return 0
end

function OnMobWeaponSkill(target, mob, skill)
    local power = 25
    local duration = 180

    local typeEffect = tpz.effect.WARCRY
    skill:setMsg(MobBuffMove(mob, typeEffect, power, 0, duration))

    return typeEffect
end



return mobskill_object
