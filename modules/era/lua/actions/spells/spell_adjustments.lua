-----------------------------------
-- Module: Spell Adjustments (Rhapsodies of Vana'diel Era)
-- Desc: Reverts spell changes introduced during the RoV era
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('rov_spell_adjustments', xi.pre(xi.expansion.ROV))

-----------------------------------
-- Enfeebling Magic
-----------------------------------

-- Dia family: Revert defense down values.
-- Source: https://forum.square-enix.com/ffxi/threads/55263-April.-3-2019-%28JST%29-Version-Update
local function castEraDia(caster, target, spell, tier, dotPower, duration, defenseDown)
    local damage = xi.spells.damage.useDamageSpell(caster, target, spell)

    -- Check for Bio.
    local bio = target:getStatusEffect(xi.effect.BIO)
    if
        not bio or
        (bio and bio:getTier() < tier)
    then
        target:delStatusEffect(xi.effect.BIO)
        local power = dotPower + caster:getMod(xi.mod.DIA_DOT)

        target:addStatusEffect(xi.effect.DIA, { power = power, duration = duration, origin = caster, tick = 3, subPower = defenseDown, tier = tier })
    end

    return damage
end

m:addOverride('xi.actions.spells.white.dia.onSpellCast', function(caster, target, spell)
    return castEraDia(caster, target, spell, 1, 1, 60, 5)
end)

m:addOverride('xi.actions.spells.white.dia_ii.onSpellCast', function(caster, target, spell)
    return castEraDia(caster, target, spell, 3, 2, 120, 10)
end)

m:addOverride('xi.actions.spells.white.dia_iii.onSpellCast', function(caster, target, spell)
    return castEraDia(caster, target, spell, 5, 3, 180, 15)
end)

m:addOverride('xi.actions.spells.white.diaga.onSpellCast', function(caster, target, spell)
    return castEraDia(caster, target, spell, 1, 1, 60, 5)
end)

-----------------------------------
-- Dark Magic
-----------------------------------

-- Bio family: Revert attack down values.
-- Source: https://forum.square-enix.com/ffxi/threads/55263-April.-3-2019-%28JST%29-Version-Update
local function calculateBioPower(caster, tier)
    local skillLevel = caster:getSkillLevel(xi.skill.DARK_MAGIC)

    if tier == 2 then
        return utils.clamp(math.ceil(skillLevel / 40), 1, 3)
    elseif tier == 4 then
        return utils.clamp(math.floor((skillLevel + 29) / 40), 3, 8)
    end

    local power = 0
    if skillLevel > 291 then
        power = 13 + math.floor((skillLevel - 291) / 27) -- 13 + 1 every 27 skill levels.
    elseif skillLevel > 246 then
        power = 9 + math.floor((skillLevel - 246) / 11) -- 9 + 1 every 11 skill levels.
    else
        power = 5 + math.floor((skillLevel - 106) / 35) -- 5 + 1 every 35 skill levels.
    end

    return utils.clamp(power, 5, 17)
end

local function castEraBio(caster, target, spell, tier, duration, attackDown)
    local damage = xi.spells.damage.useDamageSpell(caster, target, spell)

    -- Check for Dia.
    local dia = target:getStatusEffect(xi.effect.DIA)
    if
        not dia or
        (dia and dia:getTier() < tier)
    then
        target:delStatusEffect(xi.effect.DIA)
        local power = calculateBioPower(caster, tier)

        target:addStatusEffect(xi.effect.BIO, { power = power, duration = duration, origin = caster, tick = 3, subPower = attackDown, tier = tier })
    end

    return damage
end

m:addOverride('xi.actions.spells.black.bio.onSpellCast', function(caster, target, spell)
    return castEraBio(caster, target, spell, 2, 60, 5)
end)

m:addOverride('xi.actions.spells.black.bio_ii.onSpellCast', function(caster, target, spell)
    return castEraBio(caster, target, spell, 4, 120, 10)
end)

m:addOverride('xi.actions.spells.black.bio_iii.onSpellCast', function(caster, target, spell)
    return castEraBio(caster, target, spell, 6, 180, 15)
end)

-- Dread Spikes: Revert duration from 3 minutes to 1 minute.
-- Source: https://forum.square-enix.com/ffxi/threads/48564-Sep-16-2015-%28JST%29-Version-Update
m:addOverride('xi.effects.dread_spikes.onEffectGain', function(target, effect)
    super(target, effect)
    effect:setDuration(60000)
end)

-- Absorb-STAT: Revert to a fixed 90s duration with a decaying tick.
-- Source: http://forum.square-enix.com/ffxi/threads/46531-Mar-26-2015-%28JST%29-Version-Update
local absorbStatOverrides =
{
    { path = 'xi.actions.spells.black.absorb-str.onSpellCast', boostEffect = xi.effect.STR_BOOST,      downEffect = xi.effect.STR_DOWN      },
    { path = 'xi.actions.spells.black.absorb-dex.onSpellCast', boostEffect = xi.effect.DEX_BOOST,      downEffect = xi.effect.DEX_DOWN      },
    { path = 'xi.actions.spells.black.absorb-vit.onSpellCast', boostEffect = xi.effect.VIT_BOOST,      downEffect = xi.effect.VIT_DOWN      },
    { path = 'xi.actions.spells.black.absorb-agi.onSpellCast', boostEffect = xi.effect.AGI_BOOST,      downEffect = xi.effect.AGI_DOWN      },
    { path = 'xi.actions.spells.black.absorb-int.onSpellCast', boostEffect = xi.effect.INT_BOOST,      downEffect = xi.effect.INT_DOWN      },
    { path = 'xi.actions.spells.black.absorb-mnd.onSpellCast', boostEffect = xi.effect.MND_BOOST,      downEffect = xi.effect.MND_DOWN      },
    { path = 'xi.actions.spells.black.absorb-chr.onSpellCast', boostEffect = xi.effect.CHR_BOOST,      downEffect = xi.effect.CHR_DOWN      },
    { path = 'xi.actions.spells.black.absorb-acc.onSpellCast', boostEffect = xi.effect.ACCURACY_BOOST, downEffect = xi.effect.ACCURACY_DOWN },
}

for _, entry in ipairs(absorbStatOverrides) do
    m:addOverride(entry.path, function(caster, target, spell)
        local previousBoost      = caster:getStatusEffect(entry.boostEffect)
        local previousBoostStart = previousBoost and previousBoost:getStartTime() or nil
        local previousDown       = target:getStatusEffect(entry.downEffect)
        local previousDownStart  = previousDown and previousDown:getStartTime() or nil

        local result = super(caster, target, spell)

        local boost = caster:getStatusEffect(entry.boostEffect)
        if boost and boost:getStartTime() ~= previousBoostStart then
            boost:setDuration(90000)
            boost:setTick(10000)
        end

        local down = target:getStatusEffect(entry.downEffect)
        if down and down:getStartTime() ~= previousDownStart then
            down:setDuration(90000)
            down:setTick(10000)
        end

        return result
    end)
end

-- Drain II: Revert Max HP Boost duration from 3 minutes to 1 minute.
-- Source: https://forum.square-enix.com/ffxi/threads/48564-Sep-16-2015-%28JST%29-Version-Update
m:addOverride('xi.actions.spells.black.drain_ii.onSpellCast', function(caster, target, spell)
    local previousBoost    = caster:getStatusEffect(xi.effect.MAX_HP_BOOST)
    local previousSubPower = previousBoost and previousBoost:getSubPower() or 0

    local result = super(caster, target, spell)

    local currentBoost = caster:getStatusEffect(xi.effect.MAX_HP_BOOST)
    if
        currentBoost and
        currentBoost:getSubPower() > previousSubPower
    then
        currentBoost:setDuration(60000)
    end

    return result
end)
