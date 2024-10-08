-----------------------------------
--  Head Snatch
--  Description: Grabs a single target's head.
--  Type: Physical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Melee
--  Notes: Only used by Gurfurlur the Menacing. Reduces HP to 10%.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = math.max(0, target:getHP() - (target:getMaxHP() * 0.10))

    target:takeDamage(damage, mob, xi.attackType.PHYSICAL, xi.damageType.NONE)
    return damage
end

return mobskillObject
