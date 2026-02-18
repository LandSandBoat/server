-----------------------------------
-- Flaming Crush
-- Family: Ifrit (Player Pet)
-- Notes: Hybrid skill
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    -- TODO: Hybrid formula incomplete. Will need to be reworked once physical skills are converted to use param system.

    local physicalDamage  = xi.summon.avatarPhysicalMove(pet, target, petskill, 2, 1, 6, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1, 1)
    local magicDamage     = 0

    local damage = xi.summon.avatarFinalAdjustments(physicalDamage, pet, petskill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, 1)

    -- TODO: We should probably have a unified function for hybrid mechanics that can be used for mobskills and weaponskills.

    if physicalDamage.hitslanded > 0 then
        local dINT = utils.clamp(pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT), -65, 999)

        magicDamage = math.floor(damage / 2 + dINT)

        -- Multipliers.
        local nullifyDamage         = xi.spells.damage.calculateNullification(target, xi.element.FIRE, true, false)
        local absorbDamage          = xi.spells.damage.calculateAbsorption(target, xi.element.FIRE, true)
        local sdt                   = 1
        local resist                = 1
        local magicDamageAdjustment = 1
        local dayAndWeather         = 1
        local magicBonusDiff        = 1

        -- Acc Bonus
        local petAccBonus = xi.mobskills.calculatePetMagicAccuracyBonus(pet, target, xi.element.FIRE)

        -- Note: Elemental absorb mechanics such as Liement are calculated BEFORE resist/damage adjustments (such as shell/magic bursts).
        if absorbDamage > 0 then
            sdt                   = xi.combat.damage.magicalElementSDT(target, xi.element.FIRE)
            resist                = xi.combat.magicHitRate.calculateResistRate(pet, target, 0, 0, 0, xi.element.FIRE, xi.mod.INT, 0, petAccBonus)
            magicDamageAdjustment = xi.combat.damage.calculateDamageAdjustment(target, false, true, false, false)
        end

        dayAndWeather   = xi.spells.damage.calculateDayAndWeather(pet, xi.element.FIRE, false)
        magicBonusDiff  = xi.spells.damage.calculateMagicBonusDiff(pet, target, 0, 0, xi.element.FIRE, 0)

        -- Calculate final damage.
        magicDamage = math.floor(magicDamage * sdt)
        magicDamage = math.floor(magicDamage * resist)
        magicDamage = math.floor(magicDamage * dayAndWeather)
        magicDamage = math.floor(magicDamage * magicBonusDiff)
        magicDamage = math.floor(magicDamage * magicDamageAdjustment)
        magicDamage = math.floor(magicDamage * absorbDamage)
        magicDamage = math.floor(magicDamage * nullifyDamage)
    end

    -- Damage check filters shadow chip damage for now.
    if damage > 0 then
        target:takeDamage(damage, pet, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
        target:takeDamage(magicDamage, pet, xi.attackType.MAGICAL, xi.damageType.FIRE)
        target:updateEnmityFromDamage(pet, damage + magicDamage)
    end

    return damage + magicDamage
end

return abilityObject
