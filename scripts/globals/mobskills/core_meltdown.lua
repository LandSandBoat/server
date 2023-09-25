-----------------------------------
-- Core Meltdown (Ghrah)
-- Reactor core fails and self-destructs, damaging any nearby targets.
-- Note: Very rare, estimated 5% chance
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        return 1
    elseif mob:getAnimationSub() ~= 0 then -- form check
        return 1
    elseif math.random(1, 100) >= 5 then -- here's the 95% chance to not blow up
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1

    -- TODO: The damage type should be based off of the Ghrah's element
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * math.random(7, 15), xi.magic.ele.NONE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    mob:setHP(0)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)
    return dmg
end

return mobskillObject
