-----------------------------------
-- Damage Spell Utilities
-- Used for spells that deal direct damage. (Black, White, Dark and Ninjutsu)
-----------------------------------
require("scripts/globals/magic_utils/parameters")

require("scripts/globals/spell_data")
require("scripts/globals/jobpoints")
require("scripts/globals/magicburst")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------
xi = xi or {}
xi.magic_utils = xi.magic_utils or {}
xi.magic_utils.spell_damage = xi.magic_utils.spell_damage or {}
-----------------------------------
-- File structure:
-- 2 Tables.
-- 12 INDEPENDENT functions. Close them for better readability.
-- 1 FINAL function. Uses all 12 previous functions in succession and order.

-----------------------------------
-- Tables
-----------------------------------
-- Structure:       function = { Fire,                         Ice,                         Air,                           Earth,                         Thunder,                           Water,                          Light,                      Dark                      },
xi.magic.dayStrong           = { xi.day.FIRESDAY,              xi.day.ICEDAY,               xi.day.WINDSDAY,               xi.day.EARTHSDAY,              xi.day.LIGHTNINGDAY,               xi.day.WATERSDAY,               xi.day.LIGHTSDAY,           xi.day.DARKSDAY           }
xi.magic.singleWeatherStrong = { xi.weather.HOT_SPELL,         xi.weather.SNOW,             xi.weather.WIND,               xi.weather.DUST_STORM,         xi.weather.THUNDER,                xi.weather.RAIN,                xi.weather.AURORAS,         xi.weather.GLOOM          }
xi.magic.doubleWeatherStrong = { xi.weather.HEAT_WAVE,         xi.weather.BLIZZARDS,        xi.weather.GALES,              xi.weather.SAND_STORM,         xi.weather.THUNDERSTORMS,          xi.weather.SQUALL,              xi.weather.STELLAR_GLARE,   xi.weather.DARKNESS       }
xi.magic.resistMod           = { xi.mod.FIRERES,               xi.mod.ICERES,               xi.mod.WINDRES,                xi.mod.EARTHRES,               xi.mod.THUNDERRES,                 xi.mod.WATERRES,                xi.mod.LIGHTRES,            xi.mod.DARKRES            }
xi.magic.defenseMod          = { xi.mod.FIREDEF,               xi.mod.ICEDEF,               xi.mod.WINDDEF,                xi.mod.EARTHDEF,               xi.mod.THUNDERDEF,                 xi.mod.WATERDEF,                xi.mod.LIGHTDEF,            xi.mod.DARKDEF            }
xi.magic.absorbMod           = { xi.mod.FIRE_ABSORB,           xi.mod.ICE_ABSORB,           xi.mod.WIND_ABSORB,            xi.mod.EARTH_ABSORB,           xi.mod.LTNG_ABSORB,                xi.mod.WATER_ABSORB,            xi.mod.LIGHT_ABSORB,        xi.mod.DARK_ABSORB        }
xi.magic.barSpell            = { xi.effect.BARFIRE,            xi.effect.BARBLIZZARD,       xi.effect.BARAERO,             xi.effect.BARSTONE,            xi.effect.BARTHUNDER,              xi.effect.BARWATER              }
xi.magic.dayWeak             = { xi.day.WATERSDAY,             xi.day.FIRESDAY,             xi.day.ICEDAY,                 xi.day.WINDSDAY,               xi.day.EARTHSDAY,                  xi.day.LIGHTNINGDAY,            xi.day.DARKSDAY,            xi.day.LIGHTSDAY          }
xi.magic.singleWeatherWeak   = { xi.weather.RAIN,              xi.weather.HOT_SPELL,        xi.weather.SNOW,               xi.weather.WIND,               xi.weather.DUST_STORM,             xi.weather.THUNDER,             xi.weather.GLOOM,           xi.weather.AURORAS        }
xi.magic.doubleWeatherWeak   = { xi.weather.SQUALL,            xi.weather.HEAT_WAVE,        xi.weather.BLIZZARDS,          xi.weather.GALES,              xi.weather.SAND_STORM,             xi.weather.THUNDERSTORMS,       xi.weather.DARKNESS,        xi.weather.STELLAR_GLARE  }
local elementalObi           = { xi.mod.FORCE_FIRE_DWBONUS,    xi.mod.FORCE_ICE_DWBONUS,    xi.mod.FORCE_WIND_DWBONUS,     xi.mod.FORCE_EARTH_DWBONUS,    xi.mod.FORCE_LIGHTNING_DWBONUS,    xi.mod.FORCE_WATER_DWBONUS,     xi.mod.FORCE_LIGHT_DWBONUS, xi.mod.FORCE_DARK_DWBONUS }
local spellAcc               = { xi.mod.FIREACC,               xi.mod.ICEACC,               xi.mod.WINDACC,                xi.mod.EARTHACC,               xi.mod.THUNDERACC,                 xi.mod.WATERACC,                xi.mod.LIGHTACC,            xi.mod.DARKACC            }
local strongAffinityDmg      = { xi.mod.FIRE_AFFINITY_DMG,     xi.mod.ICE_AFFINITY_DMG,     xi.mod.WIND_AFFINITY_DMG,      xi.mod.EARTH_AFFINITY_DMG,     xi.mod.THUNDER_AFFINITY_DMG,       xi.mod.WATER_AFFINITY_DMG,      xi.mod.LIGHT_AFFINITY_DMG,  xi.mod.DARK_AFFINITY_DMG  }
local strongAffinityAcc      = { xi.mod.FIRE_AFFINITY_ACC,     xi.mod.ICE_AFFINITY_ACC,     xi.mod.WIND_AFFINITY_ACC,      xi.mod.EARTH_AFFINITY_ACC,     xi.mod.THUNDER_AFFINITY_ACC,       xi.mod.WATER_AFFINITY_ACC,      xi.mod.LIGHT_AFFINITY_ACC,  xi.mod.DARK_AFFINITY_ACC  }
local nullMod                = { xi.mod.FIRE_NULL,             xi.mod.ICE_NULL,             xi.mod.WIND_NULL,              xi.mod.EARTH_NULL,             xi.mod.LTNG_NULL,                  xi.mod.WATER_NULL,              xi.mod.LIGHT_NULL,          xi.mod.DARK_NULL          }
local blmMerit               = { xi.merit.FIRE_MAGIC_POTENCY,  xi.merit.ICE_MAGIC_POTENCY,  xi.merit.WIND_MAGIC_POTENCY,   xi.merit.EARTH_MAGIC_POTENCY,  xi.merit.LIGHTNING_MAGIC_POTENCY,  xi.merit.WATER_MAGIC_POTENCY    }
local rdmMerit               = { xi.merit.FIRE_MAGIC_ACCURACY, xi.merit.ICE_MAGIC_ACCURACY, xi.merit.WIND_MAGIC_ACCURACY,  xi.merit.EARTH_MAGIC_ACCURACY, xi.merit.LIGHTNING_MAGIC_ACCURACY, xi.merit.WATER_MAGIC_ACCURACY   }

-- Table variables.
local table = xi.magic_utils.parameters.damageParams
local stat  = 1
local vNPC  = 2
local mNPC  = 3
local vPC   = 4
local I     = 5
local M0    = 6

-----------------------------------
-- Basic Functions
-----------------------------------
xi.magic_utils.spell_damage.calculateBaseDamage = function(caster, target, spell, spellId, skillType, statDiff)
    local spellDamage          = 0 -- The variable we want to calculate
    local baseSpellDamage      = 0 -- (V) In Wiki.
    local baseSpellDamageBonus = 0 -- (mDMG) In Wiki. Get from equipment, status, etc...
    local statDiffBonus        = 0 -- statDiff x apropiate multipliers.

    -- Spell Damage = baseSpellDamage + statDiffBonus + baseSpellDamageBonus

    -----------------------------------
    -- STEP 1: baseSpellDamage (V)
    -----------------------------------
    if caster:isPC() then
        baseSpellDamage = table[spellId][vPC] -- vPC
    else
        baseSpellDamage = table[spellId][vNPC] -- vNPC
    end

    -----------------------------------
    -- STEP 2: statDiffBonus (statDiff * M)
    -----------------------------------
    -- Black spell.
    if skillType == xi.skill.ELEMENTAL_MAGIC then
        if caster:isPC() then
            local spellMultiplier0   = table[spellId][M0] -- (M) In wiki.
            local spellMultiplier50  = table[spellId][M0 + 1] -- (M) In wiki.
            local spellMultiplier100 = table[spellId][M0 + 2] -- (M) In wiki.
            local spellMultiplier200 = table[spellId][M0 + 3] -- (M) In wiki.
            local spellMultiplier300 = table[spellId][M0 + 4] -- (M) In wiki.
            local spellMultiplier400 = table[spellId][M0 + 5] -- (M) In wiki.
            local spellMultiplier500 = table[spellId][M0 + 6] -- (M) In wiki.

            -- Ugly, but better than 7 more values in spells table.
            if statDiff < 50 then
                statDiffBonus = math.floor(statDiff * spellMultiplier0)
            elseif statDiff < 100 and statDiff >= 50 then
                statDiffBonus = math.floor(50 * spellMultiplier0) + math.floor((statDiff - 50) * spellMultiplier50)
            elseif statDiff < 200 and statDiff >= 100 then
                statDiffBonus = math.floor(50 * spellMultiplier0) + math.floor(50 * spellMultiplier50) + math.floor((statDiff - 100) * spellMultiplier100)
            elseif statDiff < 300 and statDiff >= 200 then
                statDiffBonus = math.floor(50 * spellMultiplier0) + math.floor(50 * spellMultiplier50) + math.floor(100 * spellMultiplier100) + math.floor((statDiff - 200) * spellMultiplier200)
            elseif statDiff < 400 and statDiff >= 300 then
                statDiffBonus = math.floor(50 * spellMultiplier0) + math.floor(50 * spellMultiplier50) + math.floor(100 * spellMultiplier100) + math.floor(100 * spellMultiplier200)
                statDiffBonus = statDiffBonus + math.floor((statDiff - 300) * spellMultiplier300)
            elseif statDiff < 500 and statDiff >= 400 then
                statDiffBonus = math.floor(50 * spellMultiplier0) + math.floor(50 * spellMultiplier50) + math.floor(100 * spellMultiplier100) + math.floor(100 * spellMultiplier200)
                statDiffBonus = statDiffBonus + math.floor(100 * spellMultiplier300) + math.floor((statDiff - 400) * spellMultiplier400)
            else -- It's over 500!
                statDiffBonus = math.floor(50 * spellMultiplier0) + math.floor(50 * spellMultiplier50) + math.floor(100 * spellMultiplier100) + math.floor(100 * spellMultiplier200)
                statDiffBonus = statDiffBonus + math.floor(100 * spellMultiplier300) + math.floor(100 * spellMultiplier400) + math.floor((statDiff - 500) * spellMultiplier500)
            end
        end

    -- Divine magic and Non-Player Elemental magic. TODO: Investigate "inflection point" (I) and its relation with the terms "soft cap" and "hard cap"
    elseif skillType == xi.skill.DIVINE_MAGIC or
        (skillType == xi.skill.ELEMENTAL_MAGIC and not caster:isPC())
    then
        local spellMultiplier = table[spellId][mNPC] -- M
        local inflexionPoint  = table[spellId][I] -- I
        if statDiff <= 0 then
            statDiffBonus = statDiff
        elseif statDiff > 0 and statDiff <= inflexionPoint then
            statDiffBonus = math.floor(statDiff * spellMultiplier)
        else
            statDiffBonus = math.floor(inflexionPoint * spellMultiplier) + math.floor((statDiff - inflexionPoint) * spellMultiplier / 2)
        end

    -- Ninjutsu.
    elseif skillType == xi.skill.NINJUTSU then
        statDiffBonus = math.floor(statDiff * table[spellId][mNPC])
    end

    -----------------------------------
    -- STEP 3: baseSpellDamageBonus (mDMG)
    -----------------------------------
    if caster:isPC() then
        -- BLM Job Point: Manafont Elemental Magic Damage +3
        if caster:hasStatusEffect(xi.effect.MANAFONT) then
            baseSpellDamageBonus = baseSpellDamageBonus + caster:getJobPointLevel(xi.jp.MANAFONT_EFFECT) * 3
        end
        -- BLM Job Point: With Manawell mDMG +1
        if caster:hasStatusEffect(xi.effect.MANAWELL) then
            baseSpellDamageBonus = baseSpellDamageBonus + caster:getJobPointLevel(xi.jp.MANAWELL_EFFECT)
            caster:delStatusEffectSilent(xi.effect.MANAWELL)
        end
        -- BLM Job Point: Magic Damage Bonus
        if caster:getMainJob() == xi.job.BLM then
            baseSpellDamageBonus = baseSpellDamageBonus + caster:getJobPointLevel(xi.jp.MAGIC_DMG_BONUS)
        end
        -- NIN Job Point: Elemental Ninjitsu Effect
        if skillType == xi.skill.NINJUTSU then
            baseSpellDamageBonus = baseSpellDamageBonus + caster:getJobPointLevel(xi.jp.ELEM_NINJITSU_EFFECT) * 2
        end
    end

    -- TODO: Add baseSpellDamageBonus from equipment and other possible sources.
    -- TODO: Find out if that modifier exists and wich one is it.

    -----------------------------------
    -- STEP 4: Spell Damage
    -----------------------------------
    spellDamage = baseSpellDamage + baseSpellDamageBonus + statDiffBonus

    -- No negative base damage value allowed.
    if spellDamage < 0 then
        spellDamage = 0
    end

    return spellDamage
end

-- Calculate: Multiple Target Damage Reduction (MTDR)
xi.magic_utils.spell_damage.calculateMTDR = function(caster, target, spell)
    local MTDR    = 1 -- The variable we want to calculate.
    local targets = spell:getTotalTargets()

    if targets > 1 then
        if targets > 1 and targets < 10 then
            MTDR = 0.9 - 0.05 * targets
        else
            MTDR = 0.4
        end
    end

    return MTDR
end

xi.magic_utils.spell_damage.calculateEleStaffBonus = function(caster, spell, spellElement)
    local eleStaffBonus = caster:getMod(strongAffinityDmg[spellElement])

    if eleStaffBonus > 0 then
        eleStaffBonus = 1 + eleStaffBonus * 0.05
    else
        eleStaffBonus = 1
    end

    return eleStaffBonus
end

xi.magic_utils.spell_damage.calculateMagianAffinity = function(caster, spell) -- TODO: IMPLEMENT MAGIAN TRIALS AFFINITY SYSTEM, wich could be as simple as introducing a new modifier. Out of the scope of this rewrite, for now
    local magianAffinity = 1

    -- TODO: Code Magian Trials affinity.
    -- TODO: ADD (becouse it's additive) bonuses from atmas. Also, im pretty sure current affinity mod isn't the ACTUAL "affinity" mod as understood in wikis.

    return magianAffinity
end

xi.magic_utils.spell_damage.calculateSDT = function(caster, target, spell) -- TODO: IMPLEMENT SDT SYSTEM, wich we dont have implemented. Out of the scope of this rewrite, for now
    local SDT = 1 -- The variable we want to calculate

    -- SDT (Species/Specific Damage Taken) is a stat/mod present in mobs and players that applies a % to specific damage types.
    -- Think of it as an extension (or the actual base) of elemental resistances in past FF games.

    -- SDT under 50% applies a flat 1/2, wich was for a long time confused with an additional resist tier, wich, in reality, its an independent multiplier.
    -- This is understandable, becouse in a way, it is effectively a whole tier, but recent testing with skillchains/magic bursts after resist was removed from them, proved this.
    -- SDT affects magic burst damage, but never in a "negative" way.
    -- https://www.bg-wiki.com/ffxi/Resist for some SDT info.

    return SDT
end

-- This function is used to calculate Resist tiers. The resist tiers work differently for enfeebles (wich affect duration, not potency) than for nukes.
-- This is for nukes damage only. If an spell happens to do both damage and apply an status effect, they are calcualted separately.
xi.magic_utils.spell_damage.calculateResist = function(caster, target, spell, skillType, spellElement, statDiff)
    local resist        = 1 -- The variable we want to calculate
    local casterJob     = caster:getMainJob()
    local casterWeather = caster:getWeather()
    local spellGroup    = spell:getSpellGroup()

    local magicAcc      = caster:getMod(xi.mod.MACC) + caster:getILvlMacc()
    local magicEva      = 0
    local magicHitRate  = 0

    -- Magic Bursts of the correct element do not get resisted. SDT isn't involved here.
    local skillchainTier, skillchainCount = FormMagicBurst(spellElement, target)

    -- Function flow:
    -- Step 1: We calculate caster magic Accuracy. Substeps categorized. Magic accuracy has no effect on potency.
    -- Step 2: We calculate target magic Evasion.
    -- Step 3: We calculate magic Hit Rate.
    -- Step 4: We calculate resist tiers based off magic hit rate.

    -- Get Caster Magic accuracy, Target Magic Evasion and with both, Magic Hit Rate
    if not target:hasStatusEffect(xi.effect.MAGIC_SHIELD, 0) then -- If target has magic shield up, magicHitRate = 0
        -----------------------------------
        -- STEP 1: Get Caster Magic Accuracy.
        -----------------------------------
        -- Get the base magicAcc (just skill + skill mod (79 + skillID = ModID))
        if skillType ~= 0 then
            magicAcc = magicAcc + caster:getSkillLevel(skillType)
        else
            -- for mob skills / additional effects which don't have a skill
            magicAcc = magicAcc + utils.getSkillLvl(1, caster:getMainLvl())
        end

        local resMod = 0 -- Some spells may possibly be non elemental, but have status effects.
        if spellElement ~= xi.magic.ele.NONE then
            resMod = target:getMod(xi.magic.resistMod[spellElement])

            -- Add acc for elemental affinity accuracy and element specific accuracy
            local affinityBonus = caster:getMod(strongAffinityAcc[spellElement]) * 10
            local elementBonus  = caster:getMod(spellAcc[spellElement])
            magicAcc = magicAcc + affinityBonus + elementBonus
        end

        -- Get dStat Magic Accuracy. NOTE: Ninjutsu does not get this bonus/penalty.
        if not skillType == xi.skill.NINJUTSU then
            if statDiff > 10 then
                magicAcc = magicAcc + 10 + (statDiff - 10) / 2
            else
                magicAcc = magicAcc + statDiff
            end
        end

        -----------------------------------
        -- magicAcc from status effects.
        -----------------------------------
        -- Altruism
        if caster:hasStatusEffect(xi.effect.ALTRUISM) and spellGroup == xi.magic.spellGroup.WHITE then
            magicAcc = magicAcc + caster:getStatusEffect(xi.effect.ALTRUISM):getPower()
        end
        -- Focalization
        if caster:hasStatusEffect(xi.effect.FOCALIZATION) and spellGroup == xi.magic.spellGroup.BLACK then
            magicAcc = magicAcc + caster:getStatusEffect(xi.effect.FOCALIZATION):getPower()
        end
        --Add acc for klimaform
        if spellElement > 0 and
           caster:hasStatusEffect(xi.effect.KLIMAFORM) and
           (casterWeather == xi.magic.singleWeatherStrong[spellElement] or casterWeather == xi.magic.doubleWeatherStrong[spellElement])
        then
            magicAcc = magicAcc + 15
        end
        -- Dark Seal
        if casterJob == xi.job.DRK and skillType == xi.skill.DARK_MAGIC and caster:hasStatusEffect(xi.effect.DARK_SEAL) then
            magicAcc = magicAcc + 256 -- Need citation. 256 seems OP
        end

        -- Add acc for skillchains
        if skillchainCount > 0 then
            magicAcc = magicAcc + 25
        end

        -----------------------------------
        -- magicAcc from Job Points.
        -----------------------------------
        -- WHM Job Points
        if casterJob == xi.job.WHM then
            magicAcc = magicAcc + caster:getJobPointLevel(xi.jp.WHM_MAGIC_ACC_BONUS)
        -- BLM Job Points
        elseif casterJob == xi.job.BLM then
            magicAcc = magicAcc + caster:getJobPointLevel(xi.jp.BLM_MAGIC_ACC_BONUS)
        -- RDM Job Points
        elseif casterJob == xi.job.RDM then
            -- RDM Job Point: During saboteur, Enfeebling MACC +2
            if skillType == xi.skill.ENFEEBLING_MAGIC and caster:hasStatusEffect(xi.effect.SABOTEUR) then
                magicAcc = magicAcc + (caster:getJobPointLevel(xi.jp.SABOTEUR_EFFECT)) * 2
            end
            -- RDM Job Point: Magic Accuracy Bonus, All MACC + 1
            magicAcc = magicAcc + caster:getJobPointLevel(xi.jp.RDM_MAGIC_ACC_BONUS)
        -- NIN Job Points
        elseif casterJob == xi.job.NIN then
            -- NIN Job Point: Ninjitsu Accuracy Bonus
            if skillType == xi.skill.NINJUTSU then
                magicAcc = magicAcc + caster:getJobPointLevel(xi.jp.NINJITSU_ACC_BONUS)
            end
        -- SCH Job Points
        elseif casterJob == xi.job.SCH then
            if (spellGroup == xi.magic.spellGroup.WHITE and caster:hasStatusEffect(xi.effect.PARSIMONY)) or
                (spellGroup == xi.magic.spellGroup.BLACK and caster:hasStatusEffect(xi.effect.PENURY))
            then
                magicAcc = magicAcc + caster:getJobPointLevel(xi.jp.STRATEGEM_EFFECT_I)
            end
        end

        -----------------------------------
        -- magicAcc from Merits.
        -----------------------------------
        -- BLM Merits
        if casterJob == xi.job.BLM and skillType == xi.skill.ELEMENTAL_MAGIC then
            magicAcc = magicAcc + caster:getMerit(xi.merit.ELEMENTAL_MAGIC_ACCURACY)
        -- RDM Merits
        elseif casterJob == xi.job.RDM then
            -- Category 1
            if spellElement >= xi.magic.element.FIRE and spellElement <= xi.magic.element.WATER then
                magicAcc = magicAcc + caster:getMerit(rdmMerit[spellElement])
            end
            -- Category 2
            magicAcc = magicAcc + caster:getMerit(xi.merit.MAGIC_ACCURACY)
        -- NIN Merits
        elseif casterJob == xi.job.NIN and skillType == xi.skill.NINJUTSU then
            magicAcc = magicAcc + caster:getMerit(xi.merit.NIN_MAGIC_ACCURACY)
        -- BLU Merits
        elseif casterJob == xi.job.BLU and skillType == xi.skill.BLUE_MAGIC then
            magicAcc = magicAcc + caster:getMerit(xi.merit.MAGICAL_ACCURACY)
        end

        -----------------------------------
        -- magicAcc from Food.
        -----------------------------------
        local maccFood = magicAcc * (caster:getMod(xi.mod.FOOD_MACCP) / 100)
        magicAcc = magicAcc + utils.clamp(maccFood, 0, caster:getMod(xi.mod.FOOD_MACC_CAP))

        -----------------------------------
        -- Apply level correction.
        -----------------------------------
        local levelDiff =  utils.clamp(caster:getMainLvl() - target:getMainLvl(), -5, 5)
        magicAcc = magicAcc + levelDiff * 3

        -----------------------------------
        -- STEP 2: Get target magic evasion
        -- Base magic evasion (base magic evasion plus resistances(players), plus elemental defense(mobs)
        -----------------------------------
        magicEva = target:getMod(xi.mod.MEVA) + resMod

        -----------------------------------
        -- STEP 3: Get Magic Hit Rate
        -- https://www.bg-wiki.com/ffxi/Magic_Hit_Rate
        -----------------------------------
        local magicAccDiff = magicAcc - magicEva

        if magicAccDiff < 0 then
            magicHitRate = utils.clamp(50 + math.floor(magicAccDiff / 2), 5, 95)
        else
            magicHitRate = utils.clamp(50 + magicAccDiff, 5, 95)
        end
    end

    -----------------------------------
    -- STEP 4: Get Resist Tier
    -----------------------------------
    if skillchainCount == 0 then -- Magic bursts do not get resisted.
        local resistTier = 0
        local randomVar  = 0

        for i = 3, 1, -1 do
            randomVar = math.random(1, 100)
            if randomVar > magicHitRate then
                resistTier = resistTier + 1
            end
        end

        if resistTier == 0 then     -- Unresisted
            resist = 1.0
        elseif resistTier == 1 then -- (1/2)
            resist = 0.5
        elseif resistTier == 2 then -- (1/4)
            resist = 0.25
        elseif resistTier == 3 then -- (1/8)
            resist = 0.125
        end
    else
        resist = 1.0
    end

    return resist
end

xi.magic_utils.spell_damage.calculateIfMagicBurst = function(caster, target, spell, spellElement)
    local magicBurst                      = 1 -- The variable we want to calculate
    local skillchainTier, skillchainCount = FormMagicBurst(spellElement, target) -- External function. Not present in magic.lua.

    if skillchainCount > 0 then
        magicBurst = 1.25 + (0.1 * skillchainCount) -- Here we add SDT DAMAGE bonus for magic bursts aswell, once SDT is implemented. https://www.bg-wiki.com/ffxi/Resist#SDT_and_Magic_Bursting
    end

    return magicBurst
end

xi.magic_utils.spell_damage.calculateIfMagicBurstBonus = function(caster, target, spell, spellId, spellElement)
    local magicBurstBonus                 = 1.0 -- The variable we want to calculate
    local modBurst                        = 1.0
    local ancientMagicBurstBonus          = 0
    local skillchainTier, skillchainCount = FormMagicBurst(spellElement, target) -- External function. Not present in magic.lua.

    if spellId >= 204 and spellId <= 215 then -- If spell is Ancient Magic
        ancientMagicBurstBonus = caster:getMerit(xi.merit.ANCIENT_MAGIC_BURST_DMG) / 100
    end

    -- MBB = 1.0 + Gear + Atma/Atmacite + AMII Merits + others -- This Caps at 1.4
    -- MBB = MBB + trait

    if spell:getSpellGroup() == 3 and not caster:hasStatusEffect(xi.effect.BURST_AFFINITY) then
        return magicBurstBonus
    end

    -- Obtain multiplier from gear, atma and job traits -- Job traits should be done separately
    modBurst = modBurst + (caster:getMod(xi.mod.MAG_BURST_BONUS) / 100) + ancientMagicBurstBonus

    -- Apply Innin bonus
    if caster:isBehind(target) and caster:hasStatusEffect(xi.effect.INNIN) then
        modBurst = modBurst + (caster:getMerit(xi.merit.INNIN_EFFECT) / 100)
    end

    -- BLM Job Point: Magic Burst Damage
    modBurst = modBurst + (caster:getJobPointLevel(xi.jp.MAGIC_BURST_DMG_BONUS) / 100)

    -- Cap bonuses from first multiplier at 40% or 1.4
    if modBurst > 1.4 then
        modBurst = 1.4
    end

    -- TODO: BLM job trait has to be separate from gear trait, since the job trait is NOT capped. At least, cap is not known.
    -- Magic Burst Damage I is found in gear. caps at 40% with innin, AM2 and such
    -- Magic Burst Damage II is found in other gear and BLM job traits pertain to this one OR to a third, separate one. neither has known cap

    if skillchainCount > 0 then
        magicBurstBonus = modBurst -- + modBurstTrait once investigated. Probably needs to be divided by 100
    end

    return magicBurstBonus
end

xi.magic_utils.spell_damage.calculateDayAndWeather = function(caster, target, spell, spellId, spellElement)
    local dayAndWeather  = 1 -- The variable we want to calculate
    local weather        = caster:getWeather()
    local dayElement     = VanadielDayElement()
    local isHelixSpell   = false -- TODO: I'm not sure thats the correct way to handle helixes. This is how we handle it and im not gonna change it for now.

    -- See if its a Helix type spell
    if spellId >= 278 and spellId <= 285 then
        isHelixSpell = true
    end

    -- Calculate Weather bonus
    if weather == xi.magic.singleWeatherStrong[spellElement] then
        if caster:getMod(xi.mod.IRIDESCENCE) >= 1 then
            if math.random() < 0.33 or caster:getMod(elementalObi[spellElement]) >= 1 or isHelixSpell then
                dayAndWeather = dayAndWeather + 0.10
            end
        end

        if math.random() < 0.33 or caster:getMod(elementalObi[spellElement]) >= 1 or isHelixSpell then
            dayAndWeather = dayAndWeather + 0.10
        end

    elseif weather == xi.magic.singleWeatherWeak[spellElement] then
        if math.random() < 0.33 or caster:getMod(elementalObi[spellElement]) >= 1 or isHelixSpell then
            dayAndWeather = dayAndWeather - 0.10
        end

    elseif weather == xi.magic.doubleWeatherStrong[spellElement] then
        if caster:getMod(xi.mod.IRIDESCENCE) >= 1 then
            if math.random() < 0.33 or caster:getMod(elementalObi[spellElement]) >= 1 or isHelixSpell then
                dayAndWeather = dayAndWeather + 0.10
            end
        end

        if math.random() < 0.33 or caster:getMod(elementalObi[spellElement]) >= 1 or isHelixSpell then
            dayAndWeather = dayAndWeather + 0.25
        end

    elseif weather == xi.magic.doubleWeatherWeak[spellElement] then
        if math.random() < 0.33 or caster:getMod(elementalObi[spellElement]) >= 1 or isHelixSpell then
            dayAndWeather = dayAndWeather - 0.25
        end
    end

    -- Calculate day bonus
    if dayElement == spellElement then
        dayAndWeather = dayAndWeather + caster:getMod(xi.mod.DAY_NUKE_BONUS) / 100 -- sorc. tonban(+1)/zodiac ring
        if math.random() < 0.33 or caster:getMod(elementalObi[spellElement]) >= 1 or isHelixSpell then
            dayAndWeather = dayAndWeather + 0.10
        end
    elseif dayElement == xi.magic.elementDescendant[spellElement] then
        if math.random() < 0.33 or caster:getMod(elementalObi[spellElement]) >= 1 or isHelixSpell then
            dayAndWeather = dayAndWeather - 0.10
        end
    end

    -- Cap bonuses from both day and weather
    if dayAndWeather > 1.4 then
        dayAndWeather = 1.4
    end

    return dayAndWeather
end

xi.magic_utils.spell_damage.calculateMagicBonusDiff = function(caster, target, spell, spellId, skillType, spellElement)
    local magicBonusDiff = 1 -- The variable we want to calculate
    local casterJob      = caster:getMainJob()
    local mab            = caster:getMod(xi.mod.MATT)
    local mabCrit        = caster:getMod(xi.mod.MAGIC_CRITHITRATE)
    local mDefBarBonus   = 0

    -- Drain/Aspir (II) Exception
    -- if spellId >= 245 and spellId <= 248 then
    --     magicBonusDiff = 1 + caster:getMod(xi.mod.ENH_DRAIN_ASPIR) / 100

    --     if spellId == 247 or spellId == 248 then
    --         magicBonusDiff = magicBonusDiff + caster:getMerit(xi.merit.ASPIR_ABSORPTION_AMOUNT) / 100
    --     end

    --     return magicBonusDiff
    -- end

    -- Ninja spell bonuses
    if skillType == xi.skill.NINJUTSU then
        -- Ninja Category 2 merits.
        mab = mab + caster:getMerit(xi.merit.NIN_MAGIC_BONUS)
        -- Ninja Category 1 merits
        if spellId >= 320 and spellId <= 322 then     -- Katon series.
            mab = mab + caster:getMerit(xi.merit.KATON_EFFECT)
        elseif spellId >= 323 and spellId <= 325 then -- Hyoton series.
            mab = mab + caster:getMerit(xi.merit.HYOTON_EFFECT)
        elseif spellId >= 326 and spellId <= 328 then -- Huton series.
            mab = mab + caster:getMerit(xi.merit.HUTON_EFFECT)
        elseif spellId >= 329 and spellId <= 331 then -- Doton series.
            mab = mab + caster:getMerit(xi.merit.DOTON_EFFECT)
        elseif spellId >= 332 and spellId <= 334 then -- Raiton series.
            mab = mab + caster:getMerit(xi.merit.RAITON_EFFECT)
        elseif spellId >= 335 and spellId <= 337 then -- Suiton series.
            mab = mab + caster:getMerit(xi.merit.SUITON_EFFECT)
        end
    end

    if math.random(1, 100) < mabCrit then
        mab = mab + 10 + caster:getMod(xi.mod.MAGIC_CRIT_DMG_INCREASE)
    end

    -- Bar Spells bonuses
    if spellElement >= xi.magic.element.FIRE and spellElement <= xi.magic.element.WATER then
        mab = mab + caster:getMerit(blmMerit[spellElement])
        if target:hasStatusEffect(xi.magic.barSpell[spellElement]) then -- bar- spell magic defense bonus
            mDefBarBonus = target:getStatusEffect(xi.magic.barSpell[spellElement]):getSubPower()
        end
    end

    -- Job Point MAB
    if casterJob == xi.job.RDM then
        mab = mab + caster:getJobPointLevel(xi.jp.RDM_MAGIC_ATK_BONUS)
    elseif casterJob == xi.job.GEO then
        mab = mab + caster:getJobPointLevel(xi.jp.GEO_MAGIC_ATK_BONUS)
    end

    -- Ancient Magic I and II MAB
    if spellId > 203 and spellId < 216 then -- If spell is Ancient Magic
        mab = mab + caster:getMerit(xi.merit.ANCIENT_MAGIC_ATK_BONUS)
    end

    magicBonusDiff = (100 + mab) / (100 + target:getMod(xi.mod.MDEF) + mDefBarBonus)

    if magicBonusDiff < 0 then
        magicBonusDiff = 0
    end

    return magicBonusDiff
end

-- Calculate: Target Magic Damage Adjustment (TMDA) Refered normaly in gear as "Magic Damage Taken -%"
xi.magic_utils.spell_damage.calculateTMDA = function(caster, target, spell, spellElement)
    local TMDA = 1 -- The variable we want to calculate

    if spellElement > 0 then
        TMDA = utils.clamp(1 - (target:getMod(xi.magic.defenseMod[spellElement]) / 256), 0, 2)
    end

    return TMDA
end

xi.magic_utils.spell_damage.calculateEbullienceMultiplier = function(caster, target, spell)
    local ebullienceMultiplier = 1

    if caster:hasStatusEffect(xi.effect.EBULLIENCE) then
        ebullienceMultiplier = 1.2 + caster:getMod(xi.mod.EBULLIENCE_AMOUNT) / 100
        caster:delStatusEffectSilent(xi.effect.EBULLIENCE)
    end

    return ebullienceMultiplier
end

xi.magic_utils.spell_damage.calculateSkillTypeMultiplier = function(caster, target, spell, skillType)
    local skillTypeMultiplier = 1

    if skillType == xi.skill.ELEMENTAL_MAGIC then
        skillTypeMultiplier = ELEMENTAL_POWER
    elseif skillType == xi.skill.DARK_MAGIC then
        skillTypeMultiplier = DARK_POWER
    elseif skillType == xi.skill.NINJUTSU then
        skillTypeMultiplier = NINJUTSU_POWER
    elseif skillType == xi.skill.DIVINE_MAGIC then
        skillTypeMultiplier = DIVINE_POWER
    end

    return skillTypeMultiplier
end

xi.magic_utils.spell_damage.calculateNinSkillBonus = function(caster, target, spell, spellId, skillType)
    local ninSkillBonus = 1

    if skillType == xi.skill.NINJUTSU and caster:getMainJob() == xi.job.NIN then
        if spellId % 3 == 2 then     -- ichi nuke spell ids are 320, 323, 326, 329, 332, and 335
            ninSkillBonus = 100 + math.floor((caster:getSkillLevel(xi.skill.NINJUTSU) - 50) / 2)
        elseif spellId % 3 == 0 then -- ni nuke spell ids are 1 more than their corresponding ichi spell
            ninSkillBonus = 100 + math.floor((caster:getSkillLevel(xi.skill.NINJUTSU) - 125) / 2)
        else                               -- san nuke spell, also has ids 1 more than their corresponding ni spell
            ninSkillBonus = 100 + math.floor((caster:getSkillLevel(xi.skill.NINJUTSU) - 275) / 2)
        end
        ninSkillBonus = utils.clamp(ninSkillBonus / 100, 1, 2) -- bonus caps at +100%, and does not go negative
    end

    return ninSkillBonus
end

xi.magic_utils.spell_damage.calculateNinFutaeBonus = function(caster, target, spell, skillType)
    local ninFutaeBonus = 1

    if skillType == xi.skill.NINJUTSU and caster:hasStatusEffect(xi.effect.FUTAE) then
        ninFutaeBonus = (150  + caster:getJobPointLevel(xi.jp.FUTAE_EFFECT) * 5) / 100
        caster:delStatusEffect(xi.effect.FUTAE)
    end

    return ninFutaeBonus
end

xi.magic_utils.spell_damage.calculateUndeadDivinePenalty = function(caster, target, spell, skillType)
    local undeadDivinePenalty = 1

    if target:isUndead() and skillType == xi.skill.DIVINE_MAGIC then
        undeadDivinePenalty = 1.5
    end

    return undeadDivinePenalty
end

xi.magic_utils.spell_damage.calculateNukeAbsorbOrNullify = function(caster, target, spell, spellElement)
    local nukeAbsorbOrNullify = 1

    -- Calculate chance for spell absortion.
    if math.random(1, 100) < (target:getMod(xi.magic.absorbMod[spellElement]) + 1) then
        nukeAbsorbOrNullify = -1
    end
    -- Calculate chance for spell nullification.
    if math.random(1, 100) < (target:getMod(nullMod[spellElement]) + 1) then
        nukeAbsorbOrNullify = 0
    end

    return nukeAbsorbOrNullify
end

-----------------------------------
-- Spell Helper Function
-----------------------------------
xi.magic_utils.spell_damage.useDamageSpell = function(caster, target, spell)
    local finalDamage  = 0 -- The variable we want to calculate

    -- Get Tabled Variables.
    local spellId      = spell:getID()
    local skillType    = spell:getSkillType()
    local spellElement = spell:getElement()
    local statDiff     = caster:getStat(table[spellId][stat]) - target:getStat(table[spellId][stat])

    -- Variables/steps to calculate finalDamage.
    local spellDamage          = xi.magic_utils.spell_damage.calculateBaseDamage(caster, target, spell, spellId, skillType, statDiff)
    local MTDR                 = xi.magic_utils.spell_damage.calculateMTDR(caster, target, spell)
    local eleStaffBonus        = xi.magic_utils.spell_damage.calculateEleStaffBonus(caster, spell, spellElement)
    local magianAffinity       = xi.magic_utils.spell_damage.calculateMagianAffinity(caster, spell)
    local SDT                  = xi.magic_utils.spell_damage.calculateSDT(caster, target, spell)
    local resist               = xi.magic_utils.spell_damage.calculateResist(caster, target,  spell, skillType, spellElement, statDiff)
    local magicBurst           = xi.magic_utils.spell_damage.calculateIfMagicBurst(caster, target,  spell, spellElement)
    local magicBurstBonus      = xi.magic_utils.spell_damage.calculateIfMagicBurstBonus(caster, target, spell, spellId, spellElement)
    local dayAndWeather        = xi.magic_utils.spell_damage.calculateDayAndWeather(caster, target, spell, spellId, spellElement)
    local magicBonusDiff       = xi.magic_utils.spell_damage.calculateMagicBonusDiff(caster, target, spell, spellId, skillType, spellElement)
    local TMDA                 = xi.magic_utils.spell_damage.calculateTMDA(caster, target, spell, spellElement)
    local ebullienceMultiplier = xi.magic_utils.spell_damage.calculateEbullienceMultiplier(caster, target, spell)
    local skillTypeMultiplier  = xi.magic_utils.spell_damage.calculateSkillTypeMultiplier(caster, target, spell, skillType)
    local ninSkillBonus        = xi.magic_utils.spell_damage.calculateNinSkillBonus(caster, target, spell, spellId, skillType)
    local ninFutaeBonus        = xi.magic_utils.spell_damage.calculateNinFutaeBonus(caster, target, spell, skillType)
    local undeadDivinePenalty  = xi.magic_utils.spell_damage.calculateUndeadDivinePenalty(caster, target, spell, skillType)
    local nukeAbsorbOrNullify  = xi.magic_utils.spell_damage.calculateNukeAbsorbOrNullify(caster, target, spell, spellElement)

    -- Calculate finalDamage. It MUST be floored after EACH multiplication.
    finalDamage = math.floor(spellDamage * MTDR)
    finalDamage = math.floor(finalDamage * eleStaffBonus)
    finalDamage = math.floor(finalDamage * magianAffinity)
    finalDamage = math.floor(finalDamage * SDT)
    finalDamage = math.floor(finalDamage * resist)
    finalDamage = math.floor(finalDamage * magicBurst)
    finalDamage = math.floor(finalDamage * magicBurstBonus)
    finalDamage = math.floor(finalDamage * dayAndWeather)
    finalDamage = math.floor(finalDamage * magicBonusDiff)
    finalDamage = math.floor(finalDamage * TMDA)
    finalDamage = math.floor(finalDamage * ebullienceMultiplier)
    finalDamage = math.floor(finalDamage * skillTypeMultiplier)
    finalDamage = math.floor(finalDamage * ninSkillBonus)
    finalDamage = math.floor(finalDamage * ninFutaeBonus)
    finalDamage = math.floor(finalDamage * undeadDivinePenalty)
    finalDamage = math.floor(finalDamage * nukeAbsorbOrNullify)

    -- Handled in core (battleutils.cpp) Seems to do something relating to nullify and absorb damage...
    -- Leaving it here for now, since it was originally there.
    finalDamage = target:magicDmgTaken(finalDamage)

    -- Handle Phalanx
    if finalDamage > 0 then
        finalDamage = utils.clamp(finalDamage - target:getMod(xi.mod.PHALANX), 0, 99999)
    end

    -- Handle Stoneskin
    if finalDamage > 0 then
        finalDamage = utils.clamp(utils.stoneskin(target, finalDamage), -99999, 99999)
    end

    -- Handle Magic Absorb
    if finalDamage < 0 then
        finalDamage = target:addHP(-finalDamage)
        spell:setMsg(xi.msg.basic.MAGIC_RECOVERS_HP)

    -- Handle final adjustments. Most are located in core. TODO: Decide if we want core handling this.
    else
        -- Handle Bind break and... TP?
        target:takeSpellDamage(caster, spell, finalDamage, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL + spellElement)

        -- Handle Afflatus Mysery.
        target:handleAfflatusMiseryDamage(finalDamage)

        -- Handle Enmity.
        target:updateEnmityFromDamage(caster, finalDamage)

        -- Only add TP if the target is a mob and if the spell actually does damage.
        if target:getObjType() ~= xi.objType.PC and finalDamage > 0 then
            target:addTP(100)
        end

        -- Add "Magic Burst!" message
        if magicBurst > 1 then
            spell:setMsg(spell:getMagicBurstMessage())
            caster:triggerRoeEvent(xi.roe.triggers.magicBurst)
        end
    end

    return finalDamage
end
