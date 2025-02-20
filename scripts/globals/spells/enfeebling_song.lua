-----------------------------------
-- Enfeebling Song Utilities
-- Used for songs that deal negative status effects upon targets.
-----------------------------------
require('scripts/globals/combat/element_tables')
require('scripts/globals/combat/magic_hit_rate')
require('scripts/globals/combat/status_effect_tables')
require('scripts/globals/jobpoints')
require('scripts/globals/magicburst')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.spells = xi.spells or {}
xi.spells.enfeebling = xi.spells.enfeebling or {}
-----------------------------------
local column =
{
    SONG_EFFECT     = 1,
    SONG_POWER_BASE = 2,
    SONG_POWER_CAP  = 3,
    SONG_DURATION   = 4,
    SONG_MODIFIER   = 5,
}

local pTable =
{
    -- [Spell ID                         ] = { Effect,             Base,  Cap, Dur, Modifier               },
    -- Requiem: https://www.bg-wiki.com/ffxi/Category:Requiem
    [xi.magic.spell.FOE_REQUIEM          ] = { xi.effect.REQUIEM,     1,  300,  60, xi.mod.REQUIEM_EFFECT  },
    [xi.magic.spell.FOE_REQUIEM_II       ] = { xi.effect.REQUIEM,     2,  300,  60, xi.mod.REQUIEM_EFFECT  },
    [xi.magic.spell.FOE_REQUIEM_III      ] = { xi.effect.REQUIEM,     3,  300,  90, xi.mod.REQUIEM_EFFECT  },
    [xi.magic.spell.FOE_REQUIEM_IV       ] = { xi.effect.REQUIEM,     4,  300,  90, xi.mod.REQUIEM_EFFECT  },
    [xi.magic.spell.FOE_REQUIEM_V        ] = { xi.effect.REQUIEM,     5,  300,  90, xi.mod.REQUIEM_EFFECT  },
    [xi.magic.spell.FOE_REQUIEM_VI       ] = { xi.effect.REQUIEM,     6,  300, 120, xi.mod.REQUIEM_EFFECT  },
    [xi.magic.spell.FOE_REQUIEM_VII      ] = { xi.effect.REQUIEM,     8,  300, 120, xi.mod.REQUIEM_EFFECT  },
    -- Lullaby: https://www.bg-wiki.com/ffxi/Category:Lullaby
    [xi.magic.spell.FOE_LULLABY          ] = { xi.effect.SLEEP_I,     1,    1,  30, xi.mod.LULLABY_EFFECT  },
    [xi.magic.spell.FOE_LULLABY_II       ] = { xi.effect.SLEEP_I,     1,    1,  60, xi.mod.LULLABY_EFFECT  },
    [xi.magic.spell.HORDE_LULLABY        ] = { xi.effect.SLEEP_I,     1,    1,  30, xi.mod.LULLABY_EFFECT  },
    [xi.magic.spell.HORDE_LULLABY_II     ] = { xi.effect.SLEEP_I,     1,    1,  60, xi.mod.LULLABY_EFFECT  },
    -- Finale: https://www.bg-wiki.com/ffxi/Category:Finale
    [xi.magic.spell.MAGIC_FINALE         ] = { xi.effect.NONE,        1,    1,   0, xi.mod.FINALE_EFFECT   },
    -- Elegy: https://www.bg-wiki.com/ffxi/Category:Elegy
    [xi.magic.spell.BATTLEFIELD_ELEGY    ] = { xi.effect.ELEGY,    2500, 5000, 120, xi.mod.ELEGY_EFFECT    },
    [xi.magic.spell.CARNAGE_ELEGY        ] = { xi.effect.ELEGY,    5000, 5000, 180, xi.mod.ELEGY_EFFECT    },
    -- Threnody: https://www.bg-wiki.com/ffxi/Category:Threnody
    [xi.magic.spell.FIRE_THRENODY        ] = { xi.effect.THRENODY,   50,   95,  60, xi.mod.THRENODY_EFFECT },
    [xi.magic.spell.ICE_THRENODY         ] = { xi.effect.THRENODY,   50,   95,  60, xi.mod.THRENODY_EFFECT },
    [xi.magic.spell.WIND_THRENODY        ] = { xi.effect.THRENODY,   50,   95,  60, xi.mod.THRENODY_EFFECT },
    [xi.magic.spell.EARTH_THRENODY       ] = { xi.effect.THRENODY,   50,   95,  60, xi.mod.THRENODY_EFFECT },
    [xi.magic.spell.LIGHTNING_THRENODY   ] = { xi.effect.THRENODY,   50,   95,  60, xi.mod.THRENODY_EFFECT },
    [xi.magic.spell.WATER_THRENODY       ] = { xi.effect.THRENODY,   50,   95,  60, xi.mod.THRENODY_EFFECT },
    [xi.magic.spell.LIGHT_THRENODY       ] = { xi.effect.THRENODY,   50,   95,  60, xi.mod.THRENODY_EFFECT },
    [xi.magic.spell.DARK_THRENODY        ] = { xi.effect.THRENODY,   50,   95,  60, xi.mod.THRENODY_EFFECT },
    [xi.magic.spell.FIRE_THRENODY_II     ] = { xi.effect.THRENODY,  160,  205,  90, xi.mod.THRENODY_EFFECT },
    [xi.magic.spell.ICE_THRENODY_II      ] = { xi.effect.THRENODY,  160,  205,  90, xi.mod.THRENODY_EFFECT },
    [xi.magic.spell.WIND_THRENODY_II     ] = { xi.effect.THRENODY,  160,  205,  90, xi.mod.THRENODY_EFFECT },
    [xi.magic.spell.EARTH_THRENODY_II    ] = { xi.effect.THRENODY,  160,  205,  90, xi.mod.THRENODY_EFFECT },
    [xi.magic.spell.LIGHTNING_THRENODY_II] = { xi.effect.THRENODY,  160,  205,  90, xi.mod.THRENODY_EFFECT },
    [xi.magic.spell.WATER_THRENODY_II    ] = { xi.effect.THRENODY,  160,  205,  90, xi.mod.THRENODY_EFFECT },
    [xi.magic.spell.LIGHT_THRENODY_II    ] = { xi.effect.THRENODY,  160,  205,  90, xi.mod.THRENODY_EFFECT },
    [xi.magic.spell.DARK_THRENODY_II     ] = { xi.effect.THRENODY,  160,  205,  90, xi.mod.THRENODY_EFFECT },
    -- Virelai: https://www.bg-wiki.com/ffxi/Category:Virelai
    [xi.magic.spell.MAIDENS_VIRELAI      ] = { xi.effect.CHARM_I,     0,    0,  30, xi.mod.VIRELAI_EFFECT  },
    -- Nocturne: https://www.bg-wiki.com/ffxi/Category:Nocturne
    [xi.magic.spell.PINING_NOCTURNE      ] = { xi.effect.NOCTURNE,   15,   25, 120, 0                      },
}

-----------------------------------
-- Calculates song power.
-----------------------------------
xi.spells.enfeebling.calculateSongPower = function(caster, spellEffect, basePower, gearBoost)
    local power = basePower

    if spellEffect == xi.effect.REQUIEM then
        power = power + utils.clamp(gearBoost - 1, 0, 20) + caster:getJobPointLevel(xi.jp.REQUIEM_EFFECT) * 3
    elseif spellEffect == xi.effect.ELEGY then
        power = power + gearBoost * 6375 / 256 -- Simplified numbers of: 25.5 * 10000/1024
    elseif spellEffect == xi.effect.THRENODY then
        power = power + gearBoost * 5
    elseif spellEffect == xi.effect.NOCTURNE then
        power = power + gearBoost * 1.5
    end

    -- Apply Soul Voice or Marcato if appropriate.
    local effectTable =
    set{
        xi.effect.ELEGY,
        xi.effect.NOCTURNE,
        xi.effect.REQUIEM,
        xi.effect.THRENODY
    }

    if effectTable[spellEffect] then
        if caster:hasStatusEffect(xi.effect.SOUL_VOICE) then
            power = power * 2
        elseif caster:hasStatusEffect(xi.effect.MARCATO) then
            power = power * 1.5
        end
    end

    return power
end

-----------------------------------
-- Calculates song duration.
-----------------------------------
xi.spells.enfeebling.calculateSongDuration = function(caster, spellEffect, baseDuration, gearBoost)
    -- Duration boost of 10% per level of Song+ and All_Song+ gear plus song duration gear.
    local duration = baseDuration

    -- Lullaby gets a duration boost from job points of 1 second per level.
    if spellEffect == xi.effect.SLEEP_I then
        duration = duration + gearBoost * baseDuration / 10 + caster:getJobPointLevel(xi.jp.LULLABY_DURATION)
    end

    -- Virelai is not affected by song duration bonus or BRD gifts.
    if spellEffect ~= xi.effect.CHARM_I then
        duration = math.floor(duration * (1 + caster:getMod(xi.mod.SONG_DURATION_BONUS) / 100))
    else
        duration = duration + gearBoost * 3
    end

    -- Duration from status effects.
    if caster:hasStatusEffect(xi.effect.CLARION_CALL) then
        duration = duration + caster:getJobPointLevel(xi.jp.CLARION_CALL_EFFECT) * 2
    end

    if caster:hasStatusEffect(xi.effect.TENUTO) then
        duration = duration + caster:getJobPointLevel(xi.jp.TENUTO_EFFECT) * 2
    end

    if
        caster:hasStatusEffect(xi.effect.TROUBADOUR) and
        spellEffect ~= xi.effect.CHARM_I
    then
        duration = math.floor(duration * 2)
    end

    return duration
end

-----------------------------------
-- Casts an enfeebling song.
-----------------------------------
xi.spells.enfeebling.useEnfeeblingSong = function(caster, target, spell)
    local spellId      = spell:getID()
    local spellElement = spell:getElement()
    local spellEffect  = pTable[spellId][column.SONG_EFFECT]

    ------------------------------
    -- STEP 1: Check spell nullification.
    ------------------------------
    if xi.combat.statusEffect.isTargetImmune(target, spellEffect, spellElement) then
        spell:setMsg(xi.msg.basic.MAGIC_COMPLETE_RESIST)
        return spellEffect
    end

    -- Check trait nullification trigger.
    if xi.combat.statusEffect.isTargetResistant(caster, target, spellEffect) then
        spell:setModifier(xi.msg.actionModifier.RESIST)
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        return spellEffect
    end

    -- Target already has an status effect that nullifies current.
    if xi.combat.statusEffect.isEffectNullified(target, spellEffect) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return spellEffect
    end

    ------------------------------
    -- STEP 2: Check if spell resists.
    ------------------------------
    -- Check the amount of Song+ and All_Song+ gear.
    local gearBoost = caster:getMod(pTable[spellId][column.SONG_MODIFIER]) + caster:getMod(xi.mod.ALL_SONGS_EFFECT)

    -- Finale has innate +175 to magic accuracy.
    local bonusMagicAcc = 0
    if spellEffect == xi.effect.NONE then
        bonusMagicAcc = 175 + gearBoost * 5
    end

    local resistRate = xi.combat.magicHitRate.calculateResistRate(caster, target, xi.magic.spellGroup.SONG, xi.skill.SINGING, 0, spellElement, xi.mod.CHR, spellEffect, bonusMagicAcc)
    if
        resistRate <= 0.25 or
        (spellEffect == xi.effect.CHARM_I and
        target:isMob() and
        target:getMobMod(xi.mobMod.CHARMABLE) <= 0)
    then
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        return spellEffect
    end

    ------------------------------
    -- STEP 3: Calculate power, tick, duration and subEffect.
    ------------------------------
    local power     = xi.spells.enfeebling.calculateSongPower(caster, spellEffect, pTable[spellId][column.SONG_POWER_BASE], gearBoost) or 0
    local tick      = spellEffect == xi.effect.REQUIEM and 3 or 0
    local duration  = xi.spells.enfeebling.calculateSongDuration(caster, spellEffect, pTable[spellId][column.SONG_DURATION], gearBoost) or 0
    local subEffect = spellEffect == xi.effect.THRENODY and xi.combat.element.getElementalMEVAModifier(spellElement) or 0

    -- FClamp and floor.
    power    = math.floor(utils.clamp(power, 0, pTable[spellId][column.SONG_POWER_CAP]))
    duration = math.floor(duration * resistRate)

    ------------------------------
    -- STEP 4: Special cases.
    ------------------------------
    -- Finale doesn't apply a debuff. Quit early.
    if spellEffect == xi.effect.NONE then
        -- TODO: This is actually message 342 which doesn't exist currently. The wording is identical.
        spell:setMsg(xi.msg.basic.MAGIC_ERASE)
        local dispelledEffect = target:dispelStatusEffect()
        if dispelledEffect == xi.effect.NONE then
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end

        return dispelledEffect

    -- Virelai applies a charm. Quit early.
    elseif spellEffect == xi.effect.CHARM_I then
        target:addStatusEffect(xi.effect.CHARM_I, 0, 0, duration)
        caster:charm(target)
        if caster:isPC() then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB)
        else
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        end

        return spellEffect
    end

    ------------------------------
    -- STEP 5: Attempt to apply the status effect. Check for magic burst.
    ------------------------------
    if target:addStatusEffect(spellEffect, power, tick, duration, 0, subEffect) then
        local _, skillchainCount = xi.magicburst.formMagicBurst(spellElement, target)
        if skillchainCount > 0 then
            spell:setMsg(xi.msg.basic.MAGIC_BURST_ENFEEB)
            caster:triggerRoeEvent(xi.roeTrigger.MAGIC_BURST)
        else
            -- Lullaby has a different application message than the rest of the song debuffs.
            if spellEffect == xi.effect.SLEEP_I then
                spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
            else
                spell:setMsg(xi.msg.basic.MAGIC_ENFEEB)
            end
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return spellEffect
end
