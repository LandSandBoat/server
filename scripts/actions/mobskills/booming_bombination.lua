-----------------------------------
--  Booming Bombination
--  Description: Deals damage. Additional effect: "Plague", "Def. Down", "M. Def. Down".
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: Aoe
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 10
    local duration = math.random(60, 180)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, power, 0, duration)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, power, 0, duration)

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_DEF_DOWN, power, 0, duration))

    return xi.effect.MAGIC_DEF_DOWN
end

return mobskillObject
