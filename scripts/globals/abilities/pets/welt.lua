-----------------------------------
-- Welt
-----------------------------------
require("scripts/globals/job_utils/summoner")

-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

-- http://wiki.ffo.jp/html/37926.html
ability_object.onPetAbility = function(target, pet, petskill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3.0

    local totaldamage = 0

    xi.job_utils.onUseBloodPact(pet:getMaster(), pet, target, petskill)

    local damage = xi.summon.avatarPhysicalMove(pet, target, petskill, numhits, accmod, dmgmod, 0, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)

    totaldamage = xi.summon.avatarFinalAdjustments(damage.dmg, pet, petskill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, numhits)

    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    target:updateEnmityFromDamage(pet, totaldamage)

    return totaldamage
end

return ability_object
