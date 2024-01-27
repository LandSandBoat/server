-----------------------------------
-- Somnolence
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    local dmg = 10 + pet:getMainLvl() * 2
    local resist = xi.mobskills.applyPlayerResistance(pet, -1, target, 0, xi.skill.ELEMENTAL_MAGIC, xi.element.DARK)
    local duration = 120

    dmg = dmg * resist
    dmg = xi.mobskills.mobAddBonuses(pet, target, dmg, xi.element.DARK)

    -- TODO: spell is nil here
    --dmg = finalMagicAdjustments(pet, target, spell, dmg)

    if resist < 0.15 then  --the gravity effect from this ability is more likely to land than Tail Whip
        resist = 0
    end

    duration = duration * resist

    if duration > 0 and not target:hasStatusEffect(xi.effect.WEIGHT) then
        target:addStatusEffect(xi.effect.WEIGHT, 50, 0, duration)
    end

    return dmg
end

return abilityObject
