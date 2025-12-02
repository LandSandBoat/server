-----------------------------------
-- Tail Whip M=5
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local numhits     = 1
    local accmod      = 1
    local dmgmod      = 5
    local damage      = xi.summon.avatarPhysicalMove(pet, target, petskill, numhits, accmod, dmgmod, 0, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    local totaldamage = xi.summon.avatarFinalAdjustments(damage.dmg, pet, petskill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, numhits)
    local duration    = 120
    local resistRate  = xi.combat.magicHitRate.calculateResistRate(pet, target, 0, 0, 0, xi.element.NONE, xi.mod.INT, xi.effect.WEIGHT, 0)

    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    target:updateEnmityFromDamage(pet, totaldamage)

    if resistRate < 0.25 then
        resistRate = 0
    end

    duration = math.floor(duration * resistRate)

    if
        duration > 0 and
        xi.summon.avatarPhysicalHit(petskill, totaldamage) and
        not target:hasStatusEffect(xi.effect.WEIGHT)
    then
        target:addStatusEffect(xi.effect.WEIGHT, 50, 0, duration)
    end

    return totaldamage
end

return abilityObject
