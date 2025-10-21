-----------------------------------
-- Vulcanian Impact
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local targetHP  = target:getHP()
    local targetHPP = math.floor(target:getMaxHP() / 10)
    local dmg       = 0

    if targetHP >= targetHPP then
        dmg = targetHP - targetHPP
    end

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE, { breakBind = false })
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 30)

    return dmg
end

return mobskillObject
