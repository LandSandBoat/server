-----------------------------------
-- Burning Strike M = 6?
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")
require("scripts/globals/magic")
require("scripts/globals/monstertpmoves")

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
    --get resist multiplier (1x if no resist)
    local resist = applyPlayerResistance(pet, -1, target, pet:getStat(xi.mod.INT)-target:getStat(xi.mod.INT), xi.skill.ELEMENTAL_MAGIC, xi.magic.ele.FIRE)
    --get the resisted damage
    damage.dmg = damage.dmg*resist
    --add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    damage.dmg = mobAddBonuses(pet, nil, target, damage.dmg, 1)
    totaldamage = AvatarFinalAdjustments(damage.dmg, pet, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    target:updateEnmityFromDamage(pet, totaldamage)

    return totaldamage
end

return ability_object
