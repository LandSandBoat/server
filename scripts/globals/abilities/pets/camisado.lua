-----------------------------------
-- Camisado M=3.5 (Pet version)
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
require("scripts/globals/summon")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3.5

    local damage = xi.summon.avatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.summon.avatarFinalAdjustments(damage.dmg, pet, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.magicalTpBonus.NO_EFFECT)

    target:takeDamage(damage, pet, xi.attackType.PHYSICAL, xi.damageType.BLUNT)

    return damage
end

return abilityObject
