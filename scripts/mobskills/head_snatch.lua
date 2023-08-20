-----------------------------------
--  Head Snatch
--  Description: Grabs a single target's head.
--  Type: Physical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Melee
--  Notes: Only used by Gurfurlur the Menacing. Reduces HP to 10%.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local targetCurrentHP = target:getHP()
    local targetmaxHP = target:getMaxHP()
    local hpset = targetmaxHP * 0.10
    local dmg = 0

    if targetCurrentHP > hpset then
        dmg = targetCurrentHP - hpset
    end

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.NONE)
    return dmg
end

return mobskillObject
