-----------------------------------
-- Searing Light
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

    local level = pet:getMainLvl()
    local damage = 26 + (level * 6)
    damage = damage + (dINT * 1.5)
    damage = xi.mobskills.mobMagicalMove(pet, target, skill, damage, xi.magic.ele.LIGHT, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    damage = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, xi.magic.ele.LIGHT)
    damage = xi.summon.avatarFinalAdjustments(damage, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, 1)

    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    target:updateEnmityFromDamage(pet, damage)
    master:setMP(0)

    return damage
end

return abilityObject
