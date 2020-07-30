---------------------------------------------------
-- Thunderspark M=whatever
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")
require("scripts/globals/magic")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local dmgmodsubsequent = 1 -- ??

    local totaldamage = 0
    local damage = AvatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, dmgmodsubsequent, TP_NO_EFFECT, 1, 2, 3)
    --get resist multiplier (1x if no resist)
    local resist = applyPlayerResistance(pet, -1, target, pet:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT), tpz.skill.ELEMENTAL_MAGIC, tpz.magic.ele.THUNDER)
    --get the resisted damage
    damage.dmg = damage.dmg*resist
    --add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    damage.dmg = mobAddBonuses(pet, spell, target, damage.dmg, 1)
    local tp = skill:getTP()
    if tp < 1000 then
        tp = 1000
    end
    damage.dmg = damage.dmg * tp / 1000
    totaldamage = AvatarFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHTNING, numhits)
    target:addStatusEffect(tpz.effect.PARALYSIS, 15, 0, 60)
    target:takeDamage(totaldamage, pet, tpz.attackType.MAGICAL, tpz.damageType.LIGHTNING)
    target:updateEnmityFromDamage(pet, totaldamage)

    return totaldamage
end
