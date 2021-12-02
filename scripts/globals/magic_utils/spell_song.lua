-----------------------------------
-- Song Utilities
-----------------------------------
require("scripts/globals/magic_utils/parameters")
require("scripts/globals/spell_data")
require("scripts/globals/jobpoints")
-- require("scripts/globals/magicburst")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
-- require("scripts/settings/main")
-----------------------------------
xi = xi or {}
xi.magic_utils = xi.magic_utils or {}
xi.magic_utils.spell_song = xi.magic_utils.spell_song or {}
-----------------------------------
-- File structure:
-- 4 Basic Functions called by the 2 main Functions in this file. 2 for Enhancing Songs, 2 for Enfeebling Songs.
-- 2 Main Functions called Externally by Spell Cripts. Each calls 2 basic functions.

-- Table variables.
local enhancingTable  = xi.magic_utils.parameters.enhancingSong
local enfeeblingTable = xi.magic_utils.parameters.enfeeblingSong

-- Enhancing Song Potency function. (1/2)
xi.magic_utils.spell_song.calculateEnhancingPower = function(caster, target, spell, spellId, tier, songEffect, instrumentBoost, soulVoicePower)
    local power       = enhancingTable[spellId][7] -- The variable we want to calculate.
    local meritEffect = enhancingTable[spellId][5]
    local jpEffect    = enhancingTable[spellId][6]
    local skillCap    = enhancingTable[spellId][8]
    local potencyCap  = enhancingTable[spellId][9]
    local multiplier  = enhancingTable[spellId][10]
    local divisor     = enhancingTable[spellId][11]

    local singingLvl  = caster:getSkillLevel(xi.skill.SINGING) + caster:getWeaponSkillLevel(xi.slot.RANGED)

    -- Get Potency bonuses from Singing Skill and Instrument Skill. TODO: Investigate JP-Wiki. Most of this makes no sense.
    -- NOTE: Tier 1 Etudes.
    if songEffect == xi.effect.ETUDE and tier == 1 then
        if singingLvl >= 182 and singingLvl < 236 then
            power = power + 1
        elseif singingLvl >= 236 and singingLvl < 289 then
            power = power + 2
        elseif singingLvl >= 289 and singingLvl < 343 then
            power = power + 3
        elseif singingLvl >= 343 and singingLvl < 397 then
            power = power + 4
        elseif singingLvl >= 397 and singingLvl < 450 then
            power = power + 5
        elseif singingLvl >= 450 then
            power = power + 6
        end
    -- NOTE: Tier 2 Etudes.
    elseif songEffect == xi.effect.ETUDE and tier == 2 then
        if singingLvl >= 417 and singingLvl < 446 then
            power = power + 1
        elseif singingLvl >= 446 and singingLvl < 475 then
            power = power + 2
        elseif singingLvl >= 475 then
            power = power + 3
        end
    -- Other songs.
    else
        if singingLvl > skillCap then
            -- NOTE: Paeon
            if divisor == 0 then
                if skillCap > 0 then
                    power = power + 1
                end
            -- NOTE: Aubade, Capriccio, Gavotte, Madrigal, March, Minne, Minuet, Operetta, Pastoral, Prelude, Round.
            elseif not divisor == 0 then
                power = power + math.floor((singingLvl - skillCap) / divisor)
            end
        end
        -- NOTE: Ballad, Hymnus, Mazurka
    end

    -- Apply Cap to power. (Applied before Merits, Job-Points and Status-Effects)
    if power > potencyCap and then
        power = potencyCap
    end

    -- instrumentBoost (All Songs +X, SONG_NAME +X)
    power = power + math.floor(instrumentBoost * multiplier)

    -- Additional Potency from Merits
    if not meritEffect == 0 then
        power = power + caster:getMerit(meritEffect)
    end

    -- Additional Potency from Job Points
    if not jpEffect == 0 then
        power = power + caster:getJobPointLevel(jpEffect)
    end

    -- Additional Potency from Status Effects
    if soulVoicePower == true then -- Soul Voice/Macarato affects Power.
        if caster:hasStatusEffect(xi.effect.SOUL_VOICE) then
            power = math.floor(power * 2)
        elseif caster:hasStatusEffect(xi.effect.MARCATO) then
            power = math.floor(power * 1.5)
        end
    end

    return power
end

-- Enhancing Song Duration function. (2/2)
xi.magic_utils.spell_song.calculateEnhancingDuration = function(caster, target, spell, instrumentBoost, soulVoicePower)
    local duration = 120 -- The variable we want to calculate.

    -- Additional duration from "Song Bonus" (from instruments) and "Duration Bonus" Modifier
    duration = math.floor(duration * ((instrumentBoost * 0.1) + (caster:getMod(xi.mod.SONG_DURATION_BONUS) / 100) + 1))

    -- Additional duration from Job points.
    if caster:hasStatusEffect(xi.effect.CLARION_CALL) then
        duration = duration + caster:getJobPointLevel(xi.jp.CLARION_CALL_EFFECT) * 2
    end

    if caster:hasStatusEffect(xi.effect.MARCATO) then
        duration = duration + caster:getJobPointLevel(xi.jp.MARCATO_EFFECT)
        caster:delStatusEffect(xi.effect.MARCATO)
    end

    if caster:hasStatusEffect(xi.effect.TENUTO) then
        duration = duration + caster:getJobPointLevel(xi.jp.TENUTO_EFFECT) * 2
    end

    -- Additional duration from Status Effects.
    if soulVoicePower == false then -- Soul Voice/Macarato doesn't affect potency, so it affects Duration.
        if caster:hasStatusEffect(xi.effect.SOUL_VOICE) then
            duration = math.floor(duration * 2)
        elseif caster:hasStatusEffect(xi.effect.MARCATO) then
            duration = math.floor(duration * 1.5)
        end
    end

    if caster:hasStatusEffect(xi.effect.TROUBADOUR) then
        duration = math.floor(duration * 2)
    end

    -- Finish
    return duration
end

-- Enfeebling Song Potency function. (1/2)
xi.magic_utils.spell_song.calculateEnfeeblingPower = function(caster, target, spell)
end

-- Enfeebling Song Duration function. (2/2)
xi.magic_utils.spell_song.calculateEnfeeblingDuration = function(caster, target, spell)
end

-- Main function for Enhancing Songs.
xi.magic_utils.spell_song.useEnhancingSong = function(caster, target, spell)
    local spellId         = spell:getID()
    local paramFour       = 0

    -- Get Variables from Parameters Table.
    local tier            = enhancingTable[spellId][1]
    local songEffect      = enhancingTable[spellId][2]
    local subEffect       = enhancingTable[spellId][3]
    local instrumentBoost = caster:getMod(enhancingTable[spellId][4]) + caster:getMod(xi.mod.ALL_SONGS_EFFECT)
    local soulVoicePower  = enhancingTable[spellId][12]

    -- Calculate Song Pottency, Duration and SubEffect.
    local power    = xi.magic_utils.spell_song.calculateEnhancingPower(caster, target, spell, spellId, tier, songEffect, instrumentBoost, soulVoicePower)
    local duration = xi.magic_utils.spell_song.calculateEnhancingDuration(caster, target, spell, instrumentBoost, soulVoicePower)

    -- EXCEPTION: Tier 2 Ettudes Fourth Parameter.
    if spellEffect == xi.effect.ETUDE and tier == 2 then
        paramFour = 10
    end

    -- EXCEPTION: March Songs effect conversion.
    if songEffect == xi.effect.MARCH then
        power = (power * 1024) / 10000
    end

    -- Handle Status Effects.
    if caster:hasStatusEffect(xi.effect.MARCATO) then
        caster:delStatusEffect(xi.effect.MARCATO)
    end

    -- Change message when higher effect already in place.
    if not target:addBardSong(caster, songEffect, power, paramFour, duration, caster:getID(), subEffect, tier) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return songEffect
end

-- Main function for Enfeebling Songs.
xi.magic_utils.spell_song.useEnfeeblingSong = function(caster, target, spell)
    -- local power    = xi.magic_utils.spell_song.calculateEnfeeblingPower()
    -- local duration = xi.magic_utils.spell_song.calculateEnfeeblingDuration()
end
