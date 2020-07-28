---------------------------------------------
--  Megaflare
--  Family: Bahamut
--  Description: Deals heavy Fire damage to enemies within a fan-shaped area.
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range:
--  Notes: Used by Bahamut every 10% of its HP (except at 10%), but can use at will when under 10%.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local mobhp = mob:getHPP()

    if (mobhp <= 10 and mob:getLocalVar("GigaFlare") ~= 0) then -- make sure Gigaflare has happened first - don't want a random Megaflare to block it.
        mob:setLocalVar("MegaFlareQueue", 1) -- set up Megaflare for being called by the script again.
    end

    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local MegaFlareQueue = mob:getLocalVar("MegaFlareQueue") - 1 -- decrement the amount of queued Megaflares.
    mob:setLocalVar("MegaFlareQueue", MegaFlareQueue)
    mob:setLocalVar("FlareWait", 0) -- reset the variables for Megaflare.
    mob:setLocalVar("tauntShown", 0)
    mob:SetMobAbilityEnabled(true) -- re-enable the other actions on success
    mob:SetMagicCastingEnabled(true)
    mob:SetAutoAttackEnabled(true)
    if (bit.band(mob:getBehaviour(), tpz.behavior.NO_TURN) == 0) then -- re-enable noturn
        mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    end

    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*10, tpz.magic.ele.FIRE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    return dmg
end
