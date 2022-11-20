-----------------------------------
--  Gigaflare
--  Family: Bahamut
--  Description: Deals massive Fire damage to enemies within a fan-shaped area.
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range:
--  Notes: Used by Bahamut when at 10% of its HP, and can use anytime afterwards at will.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local mobhp = mob:getHPP()

    if mobhp <= 10 then -- set up Gigaflare for being called by the script again.
        mob:setLocalVar("GigaFlare", 0)
        mob:setMobAbilityEnabled(false) -- disable mobskills/spells until Gigaflare is used successfully (don't want to delay it/queue Megaflare)
        mob:setMagicCastingEnabled(false)
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:setLocalVar("GigaFlare", 1) -- When set to 1 the script won't call it.
    mob:setLocalVar("tauntShown", 0)
    mob:setMobAbilityEnabled(true) -- enable the spells/other mobskills again
    mob:setMagicCastingEnabled(true)
    if bit.band(mob:getBehaviour(), xi.behavior.NO_TURN) == 0 then -- re-enable noturn
        mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    end

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 15, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end

return mobskillObject
