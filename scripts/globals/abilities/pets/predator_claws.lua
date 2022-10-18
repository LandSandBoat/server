-----------------------------------
-- Predator Claws M=10 subsequent hits M=2
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 10
    local dmgmodsubsequent = 3
    local wSC = (pet:getStat(xi.mod.DEX) * 0.30)

    local damage = xi.summon.avatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, dmgmodsubsequent, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3, wSC)
    damage = xi.summon.avatarFinalAdjustments(damage.dmg, pet, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, numhits)

    target:takeDamage(damage, pet, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    return damage
end

return abilityObject
