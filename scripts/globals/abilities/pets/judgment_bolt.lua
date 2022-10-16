-----------------------------------
-- Judgment Bolt
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
require("scripts/globals/magic")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    local level = player:getMainLvl() * 2

    if player:getMP() < level then
       return 87, 0
    end

    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill, master)
    local dINT = math.floor(pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))

    local damage = pet:getMainLvl() + 2 + (0.30 * pet:getStat(xi.mod.INT)) + (dINT * 1.5)
    damage = xi.mobskills.mobMagicalMove(pet, target, skill, damage, xi.magic.ele.LIGHTNING, 9, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    damage = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, xi.magic.ele.LIGHTNING)
    damage = xi.summon.avatarFinalAdjustments(damage, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, 1)

    master:setMP(0)
    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    target:updateEnmityFromDamage(pet, damage)

    return damage
end

return abilityObject
