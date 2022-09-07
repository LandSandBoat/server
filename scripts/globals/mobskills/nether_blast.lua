-----------------------------------
-- Ranged Attack
-- Deals a ranged attack to a single target.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    -- Ranged attack only used when target is out of range
    if (mob:checkDistance(target) > 2) then
        return 0
    else
        return 1
    end
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmg_v = mob:getMainLvl() * 5 + 10 or 50 -- http://wiki.ffo.jp/html/4045.html
    -- int (( Diabolos ' LV x 5 + 10) x Diabolos ' magic attack power / Opponent's magic defense power )
    local dmgmod = 1

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, dmg_v, xi.magic.element.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end

return mobskill_object
