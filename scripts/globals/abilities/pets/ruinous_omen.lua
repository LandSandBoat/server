---------------------------------------------------
-- Ruinous Omen (Summoner Player version)
-- Used by:  Diabolos
-- Deals damage equal to a random percentage of HP to enemies within area of effect
-- https://ffxiclopedia.fandom.com/wiki/Ruinous_Omen
-- Prime Avatar seems to do an unresisted ~66% HP reduction from players' current HP (not max HP)
-- RO by design cannot KO a target, but can significantly reduce its HP
-- Version used by player summoners seems capped at ~2% except against Behemoths
-- https://www.bluegartr.com/threads/108197-Random-Facts-Thread-Abilities?p=6003851&viewfull=1#post6003851
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
require("scripts/globals/summon")
---------------------------------------------
local abilityobject = {}

abilityobject.onAbilityCheck = function(player, target, ability)
    local level = player:getMainLvl() * 2

    if(player:getMP() < level) then
        return 87, 0
    end

    xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityobject.onPetAbility = function(target, pet, skill)
    -- INT based: get the dINT
    local dINT = math.floor(pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))
    local targetHP = target:getHP()
    -- local dmgmod = 1
    local ratio = 2

    -- Scale the dINT modifier a bit
    if dINT > 12 then
        ratio = 4
    elseif dINT > 6 then
        ratio = 3
    end

    -- Target HPP decrease is small, and even lower against HNMs
    -- For now: Estimate 10-30% for regular mobs, with 25 as the average
    local hppMin = 1.0
    local hppMax = 20.0

    if target:isNM() then
        hppMin = 0.1
        hppMax = 5.0
    end

    local damageMax = targetHP * hppMax / 100
    local damageMin = targetHP * hppMin / 100
    local damage = damageMin + math.random(0, (damageMax - damageMin) / 2) + math.random(0, (damageMax - damageMin) / 2)

    damage = damage * (1 + ((dINT / ratio) / 100))  -- A wild estimate appears!  It's super ineffective!

    -- hpp and damage do not correlate, but we can use the system to scale damage numbers
    -- damage = xi.mobskills.mobMagicalMove(pet, target, skill, damage, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus, 0)
    -- damage = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, xi.magic.ele.DARK)
    -- damage = xi.summon.avatarFinalAdjustments(damage, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.magicalTpBonus.NO_EFFECT)

    -- Clamp the HPP reduction to the min/max HP values
    damage = utils.clamp(damage, damageMin, damageMax)
    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.DARK)
    target:updateEnmityFromDamage(pet, damage)

    -- Reset master MP
    pet:getMaster():setMP(0)

    return damage
end

return abilityobject
