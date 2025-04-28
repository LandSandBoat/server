-----------------------------------
--  Gigaflare
--  Family: Bahamut
--  Description: Deals massive Fire damage to enemies within a fan-shaped area.
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range:
--  Notes: Used by Bahamut when at 10% HP
--  Notes: Used by BahamutV2 when at 60%, 50%, 40%, 30%, and 20% HP
--  Notes: No evidence that either Bahamut can use it at will
--  Notes: See (Bv1 https://youtu.be/da2ox_Wu374?t=5002 and Bv2 https://youtu.be/5uoWLnYtQGM)
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_B01]
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if mob:getID() == ID.mob.BAHAMUT then -- BV1 Bahamut
        -- When set to 1 the script won't call it.
        mob:setLocalVar('GigaFlare', 1) 
    elseif mob:getID() == ID.mob.BAHAMUTV2 then -- BV2 Bahamut
        mob:setLocalVar('GigaFlareQueue', mob:getLocalVar('GigaFlareQueue') - 1)
    end

    mob:setLocalVar('FlareWait', 0)
    mob:setLocalVar('tauntShown', 0)

    -- re-enable the other actions on success
    mob:setMobAbilityEnabled(true)

    if bit.band(mob:getBehavior(), xi.behavior.NO_TURN) == 0 then -- re-enable noturn
        mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    end

    local damage = mob:getMainLvl() * 15

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    return damage
end

return mobskillObject
