-----------------------------------
-- Everyone's Rancor
--
-- Notes: Invokes rancor to spite a single target.
-- Damage is 50x the amount of Tonberries slain.
-- Only used by certain NMs, generally only once
-- and when they have reached a certain percentage
-- of HP (usually 25%).
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:isNM() and
        mob:getHP() / mob:getMaxHP() <= 0.25 and
        mob:getLocalVar('everyonesRancorUsed') == 0
    then
        mob:setLocalVar('everyonesRancorUsed', 1)
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local realDmg = 50 * target:getCharVar('EVERYONES_GRUDGE_KILLS')

    if target:getID() > 100000 then
        realDmg = 50 * math.random(50, 100)
    end

    target:takeDamage(realDmg, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)

    return realDmg
end

return mobskillObject
