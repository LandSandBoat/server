-----------------------------------
--  Gigaflare
--  Family: Bahamut
--  Description: Deals massive Fire damage to enemies within a fan-shaped area.
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range:
--  Notes: Used by Bahamut when at 10% of its HP, and can use anytime afterwards at will.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local mobhp = mob:getHPP()

    if mob:getID() == 16896156 and mobhp <= 10 then -- set up Gigaflare for being called by the script again.
        mob:setLocalVar("GigaFlare", 0)
        mob:setMobAbilityEnabled(false) -- disable mobskills/spells until Gigaflare is used successfully (don't want to delay it/queue Megaflare)
        mob:setMagicCastingEnabled(false)
    elseif mob:getID() == 16896157 and mob:getLocalVar("TeraFlare") ~= 0 then -- make sure Teraflare has happened first - don't want a random Gigaflare to block it.
        mob:setLocalVar("GigaFlareQueue", 1) -- set up Gigaflare for being called by the script again.
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if mob:getID() == 16896156 then -- BV1 Bahamut
        mob:setLocalVar("tauntShown", 0)
        mob:setMobAbilityEnabled(true) -- enable the spells/other mobskills again
        mob:setMagicCastingEnabled(true)
        mob:setAutoAttackEnabled(true)
        if mob:getBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN)) == 0 then -- re-enable noturn
            mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
        end
    elseif mob:getID() == 16896157 then -- BV2 Bahamut
        local gigaFlareCount = mob:getLocalVar("gigaFlareCount")
        mob:setLocalVar("gigaFlareCount", gigaFlareCount + 1)
        mob:setLocalVar("FlareWait", 0) -- reset the variables for Xflare.
        mob:setLocalVar("tauntShown", 0)
        mob:setMobAbilityEnabled(true) -- re-enable the other actions on success
        mob:setMagicCastingEnabled(true)
        mob:setAutoAttackEnabled(true)
        if mob:getBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN)) == 0 then -- re-enable noturn
            mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
        end
    end

    local dStatMult = 1.5
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, 14 * mob:getMainLvl(), xi.magic.ele.FIRE, nil, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, nil, nil, nil, dStatMult)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end

return mobskillObject
