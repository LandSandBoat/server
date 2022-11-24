-----------------------------------
-- Meteorite
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")

-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, skill)
    local dint = pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local tp = pet:getTP()
    local dmgmod = 0

    if tp < 1500 then
        dmgmod = math.floor((8 / 256) * (tp / 100) + (896 / 256))
    else
        dmgmod = math.floor(((8 / 256) * (1500 / 100)) + ((4 / 256) * ((tp - 1500) / 100) + 896 / 256))
    end

    local damage = pet:getMainLvl() + 2 + (0.30 * pet:getStat(xi.mod.INT)) + (dint * 1.5)
    damage = xi.mobskills.mobMagicalMove(pet, target, skill, damage, xi.magic.ele.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    damage = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, xi.magic.ele.LIGHT)
    damage = xi.summon.avatarFinalAdjustments(damage, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:updateEnmityFromDamage(pet, damage)
    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return damage
end

return abilityObject
