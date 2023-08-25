-----------------------------------
-- Burning Strike M = 6?
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 6

    local damage = xi.summon.avatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, 0, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    --get resist multiplier (1x if no resist)
    local resist = xi.mobskills.applyPlayerResistance(pet, -1, target, pet:getStat(xi.mod.INT)-target:getStat(xi.mod.INT), xi.skill.ELEMENTAL_MAGIC, xi.element.FIRE)
    --get the resisted damage
    damage.dmg = damage.dmg * resist
    --add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    damage.dmg = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, 1)
    local totaldamage = xi.summon.avatarFinalAdjustments(damage.dmg, pet, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    target:updateEnmityFromDamage(pet, totaldamage)

    return totaldamage
end

return abilityObject
