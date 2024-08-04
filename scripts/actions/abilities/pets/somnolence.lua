-----------------------------------
-- Somnolence
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    -- Damage
    local damage = 10 + pet:getMainLvl() * 2

    damage = xi.mobskills.mobMagicalMove(pet, target, petskill, damage.dmg, xi.element.FIRE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    damage = xi.mobskills.mobAddBonuses(pet, target, damage, xi.element.DARK, petskill)
    damage = xi.summon.avatarFinalAdjustments(damage, pet, petskill, target, xi.attackType.MAGICAL, xi.damageType.DARK, 1)

    -- Effect
    if not target:hasStatusEffect(xi.effect.WEIGHT) then
        local resist = xi.mobskills.applyPlayerResistance(pet, -1, target, 0, xi.skill.ELEMENTAL_MAGIC, xi.element.DARK)

        if resist >= 0.15 then
            target:addStatusEffect(xi.effect.WEIGHT, 50, 0, 120 * resist)
        end
    end

    return damage
end

return abilityObject
