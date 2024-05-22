-----------------------------------
-- Flaming Crush M=10, 2, 2? (STILL don't know)
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    local numhits = 3
    local accmod = 1
    local dmgmod = 10
    local dmgmodsubsequent = 1

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local damage = xi.summon.avatarPhysicalMove(pet, target, petskill, numhits, accmod, dmgmod, dmgmodsubsequent, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    --get resist multiplier (1x if no resist)
    local resist = xi.mobskills.applyPlayerResistance(pet, -1, target, pet:getStat(xi.mod.INT)-target:getStat(xi.mod.INT), xi.skill.ELEMENTAL_MAGIC, xi.element.FIRE)
    --get the resisted damage
    damage.dmg = damage.dmg * resist
    --add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    damage.dmg = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, xi.element.FIRE, petskill)
    local totaldamage = xi.summon.avatarFinalAdjustments(damage.dmg, pet, petskill, target, xi.attackType.PHYSICAL, xi.damageType.FIRE, numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.FIRE)
    target:updateEnmityFromDamage(pet, totaldamage)

    return totaldamage
end

return abilityObject
