-----------------------------------
-- Poison Nails  M=3? guess
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.5

    local damage = xi.summon.avatarPhysicalMove(pet, target, petskill, numhits, accmod, dmgmod, 0, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    local totaldamage = xi.summon.avatarFinalAdjustments(damage.dmg, pet, petskill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, numhits)

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    target:updateEnmityFromDamage(pet, totaldamage)

    if
        xi.summon.avatarPhysicalHit(petskill, totaldamage) and
        not target:hasStatusEffect(xi.effect.POISON)
    then
        target:addStatusEffect(xi.effect.POISON, 1, 3, 60)
    end

    return totaldamage
end

return abilityObject
