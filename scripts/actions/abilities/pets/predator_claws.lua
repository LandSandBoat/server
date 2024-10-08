-----------------------------------
-- Predator Claws M=10 subsequent hits M=2
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    local numhits = 3
    local accmod = 1
    local dmgmod = 10
    local dmgmodsubsequent = 2

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local damage = xi.summon.avatarPhysicalMove(pet, target, petskill, numhits, accmod, dmgmod, dmgmodsubsequent, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    local totaldamage = xi.summon.avatarFinalAdjustments(damage.dmg, pet, petskill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    target:updateEnmityFromDamage(pet, totaldamage)
    return totaldamage
end

return abilityObject
