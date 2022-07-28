-----------------------------------
--  Leafstorm
--
--  Description: Deals wind damage within area of effect.
--  Type: Magical Wind
--
-- Notes: When used by Cernunnos: Leafstorm dispels all positive status effects (including food) and gives a Slow effect equivalent to Slow I.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    if mob:getName() == "Cernunnos" then
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 128, 3, 120)

        local count = target:dispelAllStatusEffect(bit.bor(xi.effectFlag.SONG, xi.effectFlag.ROLL))
        if count == 0 then
            skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        else
            skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
        end

        return count
    else
        local dmgmod = 1
        local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg()*math.random(4, 5), xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
        return dmg
    end
end

return mobskill_object
