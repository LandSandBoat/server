-----------------------------------
-- Double Slap M=6, 2 (still guessing here)
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
    local numhits = 2
    local accmod = 1
    local dmgmod = 3.66
    local dmgmodsubsequent = 3.66
    local wSC = (pet:getStat(xi.mod.CHR) * 0.30)

    local totaldamage = 0
    local damage = xi.summon.avatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, dmgmodsubsequent, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3, wSC)
    totaldamage = xi.summon.avatarFinalAdjustments(damage.dmg, pet, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.HTH)
    target:updateEnmityFromDamage(pet, totaldamage)

    return totaldamage
end

return abilityObject
