---------------------------------------------
--  Teraflare
--  Family: Bahamut
--  Description: Deals massive Fire damage to enemies within a fan-shaped area.
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range:
--  Notes: Used by Bahamut when at 10% of its HP, and can use anytime afterwards at will.
---------------------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getHPP() <= 10 then
        mob:setLocalVar("TeraFlare", 0)
        mob:setMobAbilityEnabled(false) -- disable mobskills/spells until Teraflare is used successfully (don't want to delay it/queue Megaflare)
        mob:setMagicCastingEnabled(false)
        mob:setAutoAttackEnabled(false)
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:setLocalVar("TeraFlare", 1) -- When set to 1 the script won't call it.
    mob:setLocalVar("tauntShown", 0)
    mob:setMobAbilityEnabled(true) -- enable the spells/other mobskills again
    mob:setMagicCastingEnabled(true)
    mob:setAutoAttackEnabled(true)
    if bit.band(mob:getBehaviour(), xi.behavior.NO_TURN) == 0 then -- re-enable noturn
        mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    end

    local dStatMult = 1.5
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, 20 * mob:getMainLvl(), xi.magic.ele.FIRE, nil, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, nil, nil, nil, dStatMult)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    return dmg
end

return mobskillObject
