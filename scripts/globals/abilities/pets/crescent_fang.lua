-----------------------------------
-- Moonlit Charge M=6
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/summon")

-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onPetAbility = function(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 6

    local totaldamage = 0
    local damage = AvatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, 0, TP_NO_EFFECT, 1, 2, 3)
    totaldamage = AvatarFinalAdjustments(damage.dmg, pet, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, numhits)

    if (damage.hitslanded > 0) then
        target:addStatusEffect(xi.effect.PARALYSIS, 22.5, 0, 90)
    end

    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    target:updateEnmityFromDamage(pet, totaldamage)

    return totaldamage
end

return ability_object
