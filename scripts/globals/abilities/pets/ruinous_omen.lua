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
require("scripts/globals/mobskills")
require("scripts/globals/summon")
---------------------------------------------
local abilityobject = {}

abilityobject.onAbilityCheck = function(player, target, ability)
    local level = player:getMainLvl() * 2

    if player:getMP() < level then
        return 87, 0
    end

    xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityobject.onPetAbility = function(target, pet, skill, summoner)
    local targetHP = target:getHP()

    -- Target HPP decrease is small, and even lower against HNMs
    -- For now: Estimate 10-30% for regular mobs, with 25 as the average
    local hppMin = 1.0
    local hppMax = 20.0

    if target:isNM() then
        hppMin = 1.0
        hppMax = 10.0
    end

    local damageMax = targetHP * hppMax / 100
    local damageMin = targetHP * hppMin / 100
    local damage = damageMin + math.random(0, (damageMax - damageMin) / 2) + math.random(0, (damageMax - damageMin) / 2)
    damage = utils.clamp(damage, damageMin, damageMax)

    local params = {}
    params.ftp000 = 1 params.ftp150 = 1 params.ftp300 = 1
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.element = xi.magic.ele.DARK
    params.includemab = true -- This does include magic bonuses
    params.maccBonus = xi.summon.getSummoningSkillOverCap(pet)
    params.omen = damage
    params.damageSpell = true

    local damageTable = xi.summon.avatarMagicSkill(pet, target, skill, params)

    summoner:setMP(0)
    local totaldamage = xi.summon.avatarFinalAdjustments(damageTable.dmg, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(totaldamage, pet, xi.attackType.MAGICAL, xi.damageType.DARK)

    xi.magic.handleSMNBurstMsg(pet, target, skill, params.element, xi.msg.basic.PET_MAGIC_BURST)

    return totaldamage
end

return abilityobject
