-----------------------------------
-- Nether Blast (Pet Version)
-- M = 5
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
require("scripts/globals/magic")
require("scripts/globals/summon")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    local damage = (5 * pet:getMainLvl()) + 10 -- https://ffxiclopedia.fandom.com/wiki/Nether_Blast | http://wiki.ffo.jp/html/4045.html
    local dmgmod = 1
    local ignoreres = true
    local element = xi.magic.ele.DARK
    local dmgtype = xi.damageType.DARK
    local shadows = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    local tpbonus = xi.mobskills.magicalTpBonus.NO_EFFECT

    damage = xi.mobskills.mobMagicalMove(pet, target, skill, damage, element, dmgmod, tpbonus, shadows, ignoreres)
    damage = xi.summon.avatarFinalAdjustments(damage.dmg, pet, skill, target, xi.attackType.MAGICAL, dmgtype, 1)
    target:takeDamage(damage, pet, xi.attackType.MAGICAL, dmgtype)
    target:updateEnmityFromDamage(pet, damage)

    return damage
end

return abilityObject
