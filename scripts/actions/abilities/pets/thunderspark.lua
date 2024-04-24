-----------------------------------
-- Thunderspark M=whatever
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local dmgmodsubsequent = 1 -- ??

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local damage = xi.summon.avatarPhysicalMove(pet, target, petskill, numhits, accmod, dmgmod, dmgmodsubsequent, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    --get resist multiplier (1x if no resist)
    local resist = xi.mobskills.applyPlayerResistance(pet, -1, target, pet:getStat(xi.mod.INT)-target:getStat(xi.mod.INT), xi.skill.ELEMENTAL_MAGIC, xi.element.THUNDER)
    --get the resisted damage
    damage.dmg = damage.dmg * resist
    --add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    damage.dmg = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, xi.element.THUNDER, petskill)

    local tp = pet:getTP()
    if tp < 1000 then
        tp = 1000
    end

    damage.dmg = damage.dmg * tp / 1000
    local totaldamage = xi.summon.avatarFinalAdjustments(damage.dmg, pet, petskill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, numhits)
    target:addStatusEffect(xi.effect.PARALYSIS, 15, 0, 60)
    target:takeDamage(totaldamage, pet, xi.attackType.MAGICAL, xi.damageType.THUNDER)
    target:updateEnmityFromDamage(pet, totaldamage)

    return totaldamage
end

return abilityObject
