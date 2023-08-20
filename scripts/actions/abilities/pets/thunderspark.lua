-----------------------------------
-- Thunderspark M=whatever
-----------------------------------
require("scripts/globals/summon")
require("scripts/globals/magic")
require("scripts/globals/mobskills")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local dmgmodsubsequent = 1 -- ??

    local totaldamage = 0
    local damage = xi.summon.avatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, dmgmodsubsequent, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    --get resist multiplier (1x if no resist)
    local resist = xi.mobskills.applyPlayerResistance(pet, -1, target, pet:getStat(xi.mod.INT)-target:getStat(xi.mod.INT), xi.skill.ELEMENTAL_MAGIC, xi.magic.ele.THUNDER)
    --get the resisted damage
    damage.dmg = damage.dmg * resist
    --add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    damage.dmg = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, 1)

    local tp = pet:getTP()
    if tp < 1000 then
        tp = 1000
    end

    damage.dmg = damage.dmg * tp / 1000
    totaldamage = xi.summon.avatarFinalAdjustments(damage.dmg, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, numhits)
    target:addStatusEffect(xi.effect.PARALYSIS, 15, 0, 60)
    target:takeDamage(totaldamage, pet, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    target:updateEnmityFromDamage(pet, totaldamage)

    return totaldamage
end

return abilityObject
