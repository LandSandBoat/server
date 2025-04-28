-----------------------------------
--  Teraflare
--  Family: Bahamut
--  Description: Deals massive Fire damage to enemies within a fan-shaped area.
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range:
--  Notes: Used by BahamutV2 when at 10% HP
--  Notes: BahamutV2 can use multiple times when under 10%
--  Notes: (see https://youtu.be/5uoWLnYtQGM?t=1600 and https://youtu.be/YHBfqLpGsp0?t=1491 / https://youtu.be/YHBfqLpGsp0?t=1556)
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:setLocalVar('FlareWait', 0)
    mob:setLocalVar('tauntShown', 0)
    -- Track the last time used Teraflare so can repeat every 20 seconds
    mob:setLocalVar('lastTeraFlareTime', os.time())

    mob:setMobAbilityEnabled(true) -- enable the spells/other mobskills again

    if bit.band(mob:getBehavior(), xi.behavior.NO_TURN) == 0 then -- re-enable noturn
        mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    end

    local damage = mob:getMainLvl() * 20

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    return damage
end

return mobskillObject
