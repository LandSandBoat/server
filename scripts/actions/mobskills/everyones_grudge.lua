-----------------------------------
--  Everyones Grudge
--
--  Notes: Invokes collective hatred to spite a single target.
--   Damage done is 5x the amount of tonberries you have killed! For NM's using this it is 50 x damage.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:isNM() then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power   = 5
    local realDmg = power * target:getCharVar('EVERYONES_GRUDGE_KILLS') -- Damage is 5 times the amount you have killed

    if target:getID() > 100000 then
        realDmg = power * math.random(30, 100)
    elseif mob:isNM() then
        realDmg = realDmg * 10 -- sets the multiplier to 50 for NM's
    end

    target:takeDamage(realDmg, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)

    return realDmg
end

return mobskillObject
