-----------------------------------
--  Leafstorm
--
--  Description: Deals wind damage within area of effect.
--  Type: Magical Wind
--
-- Notes: When used by Cernunnos, Cemetery Cherry, and leafless Jidra: Leafstorm dispels all positive status effects (including food) and gives a Slow effect equivalent to Slow I.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if
        mob:getName() == "Cernunnos" or
        mob:getPool() == 671 or
        mob:getPool() == 1346
    then
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 128, 3, 120)

        local count = target:dispelAllStatusEffect(bit.bor(xi.effectFlag.DISPELABLE, xi.effectFlag.FOOD))
        if count == 0 then
            skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        else
            skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
        end

    end

    local ftp100 = 1
    local ftp200 = 1.5
    local ftp300 = 2

    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        ftp100 = 5
        ftp200 = 5
        ftp300 = 5
    end
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WIND, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, ftp100, ftp200, ftp300)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end

return mobskillObject
