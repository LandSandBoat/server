-----------------------------------
-- Hypnogenesis
-- AOE damage large % hp cut  https://youtu.be/Bvp-T3_U7xA?t=31
-- Assuming magical darkness
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- Deals a large percent of hp dmg, can be resisted (rarely), and cannot kill
    local percent = math.random(90, 100)
    local damage = math.max(0, target:getHP() - target:getHP() * (percent / 100))
    local dmg = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    -- only allow a maximum of % damage even if modifiers would increase the damage
    dmg = math.min(damage, dmg)

    if dmg >= target:getHP() then
        dmg = target:getHP() - 1
    end

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end

return mobskillObject
