-----------------------------------
-- Enfeebling Spell Utilities
-- Used for spells that deal negative status effects upon targets.
-----------------------------------
require("scripts/globals/damage/magic_hit_rate")
require("scripts/globals/jobpoints")
require("scripts/globals/magicburst")
require("scripts/globals/msg")
require("scripts/globals/spell_data")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------
xi = xi or {}
xi.spells = xi.spells or {}
xi.spells.enfeebling = xi.spells.enfeebling or {}
-----------------------------------

local s = xi.magic.spell
local e = xi.effect
local m = xi.mod

local pTable =
{   --                    1                     2          3              4               5      6    7         8       9           10         11
    --    [Spell ID ] = { Effect,               Stat-Used, Resist-Mod,    MEVA-Mod,       pBase, DoT, Duration, Resist, msg, pSaboteur, pResist },
    [s.BIND         ] = { e.BIND,               m.INT,     m.BINDRES,     m.BIND_MEVA,        0,   0,       60,      2,   0, false,     false   },
    [s.BINDGA       ] = { e.BIND,               m.INT,     m.BINDRES,     m.BIND_MEVA,        0,   0,       60,      2,   0, false,     false   },
    [s.BLIND        ] = { e.BLINDNESS,          m.INT,     m.BLINDRES,    m.BLIND_MEVA,       0,   0,      180,      2,   0, true,      false   },
    [s.BLIND_II     ] = { e.BLINDNESS,          m.INT,     m.BLINDRES,    m.BLIND_MEVA,       0,   0,      180,      2,   0, true,      false   },
    [s.BLINDGA      ] = { e.BLINDNESS,          m.INT,     m.BLINDRES,    m.BLIND_MEVA,       0,   0,      180,      2,   0, true,      false   },
    [s.BREAK        ] = { e.PETRIFICATION,      m.INT,     m.PETRIFYRES,  m.PETRIFY_MEVA,     1,   0,       30,      2,   0, false,     false   },
    [s.BREAKGA      ] = { e.PETRIFICATION,      m.INT,     m.PETRIFYRES,  m.PETRIFY_MEVA,     1,   0,       30,      2,   0, false,     false   },
    [s.BURN         ] = { e.BURN,               m.INT,     0,             0,                  0,   3,       90,      4,   1, true,      false   },
    [s.CHOKE        ] = { e.CHOKE,              m.INT,     0,             0,                  0,   3,       90,      4,   1, true,      false   },
    [s.CURSE        ] = { e.CURSE_I,            m.INT,     m.CURSERES,    m.CURSE_MEVA,      50,   0,      300,      2,   0, false,     false   },
    [s.DISPEL       ] = { e.NONE,               m.INT,     0,             0,                  0,   0,        0,      4,   0, false,     false   },
    [s.DISPELGA     ] = { e.NONE,               m.INT,     0,             0,                  0,   0,        0,      4,   0, false,     false   },
    [s.DISTRACT     ] = { e.EVASION_DOWN,       m.MND,     0,             0,                  0,   0,      120,      2,   0, true,      true    },
    [s.DISTRACT_II  ] = { e.EVASION_DOWN,       m.MND,     0,             0,                  0,   0,      120,      2,   0, true,      true    },
    [s.DISTRACT_III ] = { e.EVASION_DOWN,       m.MND,     0,             0,                  0,   0,      120,      2,   0, true,      true    },
    [s.DROWN        ] = { e.DROWN,              m.INT,     0,             0,                  0,   3,       90,      4,   1, true,      false   },
    [s.FLASH        ] = { e.FLASH,              m.MND,     m.BLINDRES,    m.BLIND_MEVA,     300,   0,       12,      4,   0, true,      false   },
    [s.FRAZZLE      ] = { e.MAGIC_EVASION_DOWN, m.MND,     0,             0,                  0,   0,      120,      2,   0, true,      true    },
    [s.FRAZZLE_II   ] = { e.MAGIC_EVASION_DOWN, m.MND,     0,             0,                  0,   0,      120,      2,   0, true,      true    },
    [s.FRAZZLE_III  ] = { e.MAGIC_EVASION_DOWN, m.MND,     0,             0,                  0,   0,      120,      2,   0, true,      true    },
    [s.FROST        ] = { e.FROST,              m.INT,     0,             0,                  0,   3,       90,      4,   1, true,      false   },
    [s.GRAVITY      ] = { e.WEIGHT,             m.INT,     m.GRAVITYRES,  m.GRAVITY_MEVA,    26,   0,      120,      2,   0, true,      false   },
    [s.GRAVITY_II   ] = { e.WEIGHT,             m.INT,     m.GRAVITYRES,  m.GRAVITY_MEVA,    32,   0,      180,      2,   0, true,      false   },
    [s.GRAVIGA      ] = { e.WEIGHT,             m.INT,     m.GRAVITYRES,  m.GRAVITY_MEVA,    50,   0,      120,      2,   0, true,      false   },
    [s.INUNDATION   ] = { e.INUNDATION,         m.MND,     0,             0,                  1,   0,      300,      5,   0, false,     false   },
    [s.PARALYZE     ] = { e.PARALYSIS,          m.MND,     m.PARALYZERES, m.PARALYZE_MEVA,    0,   0,      120,      2,   0, true,      true    },
    [s.PARALYZE_II  ] = { e.PARALYSIS,          m.MND,     m.PARALYZERES, m.PARALYZE_MEVA,    0,   0,      120,      2,   0, true,      true    },
    [s.PARALYGA     ] = { e.PARALYSIS,          m.MND,     m.PARALYZERES, m.PARALYZE_MEVA,    0,   0,      120,      2,   0, true,      true    },
    [s.POISON       ] = { e.POISON,             m.INT,     m.POISONRES,   m.POISON_MEVA,      0,   3,       90,      2,   0, true,      false   },
    [s.POISON_II    ] = { e.POISON,             m.INT,     m.POISONRES,   m.POISON_MEVA,      0,   3,      120,      2,   0, true,      false   },
    [s.POISON_III   ] = { e.POISON,             m.INT,     m.POISONRES,   m.POISON_MEVA,      0,   3,      150,      2,   0, true,      false   },
    [s.POISONGA     ] = { e.POISON,             m.INT,     m.POISONRES,   m.POISON_MEVA,      0,   3,       90,      2,   0, true,      false   },
    [s.POISONGA_II  ] = { e.POISON,             m.INT,     m.POISONRES,   m.POISON_MEVA,      0,   3,      120,      2,   0, true,      false   },
    [s.POISONGA_III ] = { e.POISON,             m.INT,     m.POISONRES,   m.POISON_MEVA,      0,   3,      150,      2,   0, true,      false   },
    [s.RASP         ] = { e.RASP,               m.INT,     0,             0,                  0,   3,       90,      4,   1, true,      false   },
    [s.REPOSE       ] = { e.SLEEP_II,           m.MND,     m.SLEEPERES,   m.SLEEP_MEVA,       2,   0,       90,      2,   1, false,     false   },
    [s.SHOCK        ] = { e.SHOCK,              m.INT,     0,             0,                  0,   3,       90,      4,   1, true,      false   },
    [s.SILENCE      ] = { e.SILENCE,            m.MND,     m.SILENCERES,  m.SILENCE_MEVA,     1,   0,      120,      2,   0, false,     false   },
    [s.SILENCEGA    ] = { e.SILENCE,            m.MND,     m.SILENCERES,  m.SILENCE_MEVA,     1,   0,      120,      2,   0, false,     false   },
    [s.SLEEP        ] = { e.SLEEP_I,            m.INT,     m.SLEEPERES,   m.SLEEP_MEVA,       1,   0,       60,      2,   0, false,     false   },
    [s.SLEEP_II     ] = { e.SLEEP_II,           m.INT,     m.SLEEPERES,   m.SLEEP_MEVA,       2,   0,       90,      2,   0, false,     false   },
    [s.SLEEPGA      ] = { e.SLEEP_I,            m.INT,     m.SLEEPERES,   m.SLEEP_MEVA,       1,   0,       60,      2,   0, false,     false   },
    [s.SLEEPGA_II   ] = { e.SLEEP_II,           m.INT,     m.SLEEPERES,   m.SLEEP_MEVA,       2,   0,       90,      2,   0, false,     false   },
    [s.SLOW         ] = { e.SLOW,               m.MND,     m.SLOWRES,     m.SLOW_MEVA,        0,   0,      180,      2,   0, true,      true    },
    [s.SLOW_II      ] = { e.SLOW,               m.MND,     m.SLOWRES,     m.SLOW_MEVA,        0,   0,      180,      2,   0, true,      true    },
    [s.SLOWGA       ] = { e.SLOW,               m.MND,     m.SLOWRES,     m.SLOW_MEVA,        0,   0,      180,      2,   0, true,      true    },
    [s.STUN         ] = { e.STUN,               m.INT,     m.STUNRES,     m.STUN_MEVA,        1,   0,        5,      4,   0, false,     false   },
    [s.VIRUS        ] = { e.PLAGUE,             m.INT,     m.VIRUSRES,    m.VIRUS_MEVA,       5,   3,       60,      2,   0, false,     false   },

    -- Ninjutsu
    [s.AISHA_ICHI   ] = { e.ATTACK_DOWN,        m.INT,     0,             0,                 15,   0,      120,      4,   1, false,     false   },
    [s.DOKUMORI_ICHI] = { e.POISON,             m.INT,     m.POISONRES,   m.POISON_MEVA,      3,   3,       60,      2,   0, false,     false   },
    [s.DOKUMORI_NI  ] = { e.POISON,             m.INT,     m.POISONRES,   m.POISON_MEVA,     10,   3,      120,      2,   0, false,     false   },
    [s.DOKUMORI_SAN ] = { e.POISON,             m.INT,     m.POISONRES,   m.POISON_MEVA,     20,   3,      360,      2,   0, false,     false   },
    [s.HOJO_ICHI    ] = { e.SLOW,               m.INT,     m.SLOWRES,     m.SLOW_MEVA,     1465,   0,      180,      2,   0, false,     false   },
    [s.HOJO_NI      ] = { e.SLOW,               m.INT,     m.SLOWRES,     m.SLOW_MEVA,     1953,   0,      300,      2,   0, false,     false   },
    [s.HOJO_SAN     ] = { e.SLOW,               m.INT,     m.SLOWRES,     m.SLOW_MEVA,     2930,   0,      420,      2,   0, false,     false   },
    [s.JUBAKU_ICHI  ] = { e.PARALYSIS,          m.INT,     m.PARALYZERES, m.PARALYZE_MEVA,   20,   0,      180,      2,   1, false,     false   },
    [s.JUBAKU_NI    ] = { e.PARALYSIS,          m.INT,     m.PARALYZERES, m.PARALYZE_MEVA,   30,   0,      300,      2,   1, false,     false   },
    [s.JUBAKU_SAN   ] = { e.PARALYSIS,          m.INT,     m.PARALYZERES, m.PARALYZE_MEVA,   35,   0,      420,      2,   1, false,     false   },
    [s.KURAYAMI_ICHI] = { e.BLINDNESS,          m.INT,     m.BLINDRES,    m.BLIND_MEVA,      20,   0,      180,      2,   0, false,     false   },
    [s.KURAYAMI_NI  ] = { e.BLINDNESS,          m.INT,     m.BLINDRES,    m.BLIND_MEVA,      30,   0,      300,      2,   0, false,     false   },
    [s.KURAYAMI_SAN ] = { e.BLINDNESS,          m.INT,     m.BLINDRES,    m.BLIND_MEVA,      40,   0,      420,      2,   0, false,     false   },
    [s.YURIN_ICHI   ] = { e.INHIBIT_TP,         m.INT,     0,             0,                 10,   0,      180,      3,   1, false,     false   },
}

local elementalDebuffTable =
{
    -- effect = Nullified by, Nullifies
    [e.BURN ] = { e.DROWN, e.FROST },
    [e.CHOKE] = { e.FROST, e.RASP  },
    [e.DROWN] = { e.SHOCK, e.BURN  },
    [e.FROST] = { e.BURN,  e.CHOKE },
    [e.RASP ] = { e.CHOKE, e.SHOCK },
    [e.SHOCK] = { e.RASP,  e.DROWN },
}

local function getElementalDebuffPotency(caster, statUsed)
    local potency    = 1
    local casterStat = caster:getStat(statUsed)

    if casterStat > 150 then
        potency = potency + 4
    elseif casterStat > 100 then
        potency = potency + 3
    elseif casterStat > 70 then
        potency = potency + 2
    elseif casterStat > 40 then
        potency = potency + 1
    end

    return potency
end

-- Determine if target mob is immune to a status effect.
xi.spells.enfeebling.checkInnateImmunity = function(target, spellEffect)
    local immunityTable =
    {
        [xi.effect.SLEEP      ] = {     1 },
        [xi.effect.SLEEP_II   ] = {     1 },
        [xi.effect.WEIGHT     ] = {     2 },
        [xi.effect.BIND       ] = {     4 },
        [xi.effect.STUN       ] = {     8 },
        [xi.effect.SILENCE    ] = {    16 },
        [xi.effect.PARALYSIS  ] = {    32 },
        [xi.effect.BLIND      ] = {    64 },
        [xi.effect.SLOW       ] = {   128 },
        [xi.effect.POISON     ] = {   256 },
        [xi.effect.ELEGY      ] = {   512 },
        [xi.effect.REQUIEM    ] = {  1024 },
        [xi.effect.LIGHT_SLEEP] = {  2048 },
        [xi.effect.DARK_SLEEP ] = {  4096 },
        [xi.effect.ASPIR      ] = {  8192 },
        [xi.effect.TERROR     ] = { 16384 },
    }

    if target:hasImmunity(immunityTable[spellEffect][1]) then
        return true
    end

    return false
end

-- Calculates if target has resistance traits or gear mods that can nullify effects.
xi.spells.enfeebling.checkTraitTrigger = function(caster, target, spellId)
    local specificModPower = target:getMod(pTable[spellId][3])
    local globalModPower   = target:getMod(xi.mod.STATUSRES)
    local totalPower       = specificModPower + globalModPower

    if totalPower > 0 then
        local roll = math.random(1, 100)
        totalPower = totalPower + 5

        if caster:isNM() then
            totalPower = totalPower / 2
        end

        if roll <= totalPower then
            return true
        end
    end

    return false
end

xi.spells.enfeebling.calculatePotency = function(caster, target, spellId, spellEffect, skillType, statUsed)
    local potency    = pTable[spellId][5]
    local statDiff   = caster:getStat(statUsed) - target:getStat(statUsed)
    local skillLevel = caster:getSkillLevel(skillType)

    -- Calculate base potency for spells.
    switch (spellEffect) : caseof
    {
        [xi.effect.BLIND] = function()
            statDiff = caster:getStat(statUsed) - target:getStat(xi.mod.MND)

            if spellId == xi.magic.spell.BLIND_II then
                potency = utils.clamp(statDiff * 0.375 + 49, 15, 90) -- Values from JP wiki: http://wiki.ffo.jp/html/3449.html
            else
                potency = utils.clamp(statDiff * 0.225 + 23, 5, 50)  -- Values from JP wiki: http://wiki.ffo.jp/html/834.html
            end
        end,

        [xi.effect.EVASION_DOWN] = function()
            if spellId == xi.magic.spell.DISTRACT then
                potency = utils.clamp(skillLevel / 5, 0, 25) + utils.clamp(statDiff / 5, 0, 10)
            elseif spellId == xi.magic.spell.DISTRACT_II then
                potency = utils.clamp(skillLevel * 4 / 35, 0, 40) + utils.clamp(statDiff / 5, 0, 10)
            else
                potency = utils.clamp(skillLevel / 5, 0, 120) + utils.clamp(statDiff / 5, 0, 10)
            end
        end,

        [xi.effect.MAGIC_EVASION_DOWN] = function()
            if spellId == xi.magic.spell.FRAZZLE then
                potency = utils.clamp(skillLevel / 5, 0, 25) + utils.clamp(statDiff / 5, 0, 10)
            elseif spellId == xi.magic.spell.FRAZZLE_II then
                potency = utils.clamp(skillLevel * 4 / 35, 0, 40) + utils.clamp(statDiff / 5, 0, 10)
            else
                potency = utils.clamp(skillLevel / 5, 0, 120) + utils.clamp(statDiff / 5, 0, 10)
            end
        end,

        [xi.effect.PARALYSIS] = function()
            if spellId == xi.magic.spell.PARALYZE_II then
                potency = utils.clamp(statDiff / 4 + 20, 10, 30)
            else
                potency = utils.clamp(statDiff / 4 + 15, 5, 25)
            end
        end,

        [xi.effect.POISON] = function()
            if
                spellId == xi.magic.spell.POISON or
                spellId == xi.magic.spell.POISONGA
            then
                potency = math.max(skillLevel / 25, 1)
                if skillLevel > 400 then
                    potency = math.min((skillLevel - 225) / 5, 55) -- Cap is 55 hp/tick.
                end
            elseif
                spellId == xi.magic.spell.POISON_II or
                spellId == xi.magic.spell.POISONGA_II
            then
                potency = math.max(skillLevel / 20, 4)
                if skillLevel > 400 then
                    potency = skillLevel * 49 / 183 - 55 -- No cap can be reached yet
                end
            else
                potency = skillLevel / 10 + 1
            end
        end,

        [xi.effect.SLOW] = function()
            if spellId == xi.magic.spell.SLOW_II then
                potency = utils.clamp(statDiff * 226 / 15 + 2380, 1250, 3510)
            else
                potency = utils.clamp(statDiff * 73 / 5 + 1825, 730, 2920)
            end
        end,

        [xi.effect.BURN] = function()
            potency = getElementalDebuffPotency(caster, statUsed)
        end,

        [xi.effect.CHOKE] = function()
            potency = getElementalDebuffPotency(caster, statUsed)
        end,

        [xi.effect.DROWN] = function()
            potency = getElementalDebuffPotency(caster, statUsed)
        end,

        [xi.effect.FROST] = function()
            potency = getElementalDebuffPotency(caster, statUsed)
        end,

        [xi.effect.RASP] = function()
            potency = getElementalDebuffPotency(caster, statUsed)
        end,

        [xi.effect.SHOCK] = function()
            potency = getElementalDebuffPotency(caster, statUsed)
        end,
    }

    potency = math.floor(potency)

    -- Apply Saboteur Effect when aplicable.
    if
        caster:hasStatusEffect(xi.effect.SABOTEUR) and
        skillType == xi.skill.ENFEEBLING_MAGIC
    then
        if target:isNM() then
            potency = potency * (1.3 + caster:getMod(xi.mod.ENHANCES_SABOTEUR))
        else
            potency = potency * (2 + caster:getMod(xi.mod.ENHANCES_SABOTEUR))
        end
    end

    return math.floor(potency)
end

xi.spells.enfeebling.calculateDuration = function(caster, target, spellId)
    local duration = pTable[spellId][7]

    if caster:hasStatusEffect(xi.effect.SABOTEUR) then
        if target:isNM() then
            duration = duration * 1.25
        else
            duration = duration * 2
        end
    end

    -- After Saboteur according to bg-wiki
    if
        caster:getMainJob() == xi.job.RDM and
        skillType == xi.skill.ENFEEBLING_MAGIC
    then
        -- RDM Merit: Enfeebling Magic Duration
        duration = duration + caster:getMerit(xi.merit.ENFEEBLING_MAGIC_DURATION)

        -- RDM Job Point: Enfeebling Magic Duration
        duration = duration + caster:getJobPointLevel(xi.jp.ENFEEBLE_DURATION)

        -- RDM Job Point: Stymie effect
        if caster:hasStatusEffect(xi.effect.STYMIE) then
            duration = duration + caster:getJobPointLevel(xi.jp.STYMIE_EFFECT)
        end
    end

    return math.floor(duration)
end

xi.spells.enfeebling.useEnfeeblingSpell = function(caster, target, spell)
    local spellId        = spell:getID()
    local spellEffect    = pTable[spellId][1]

    ------------------------------
    -- STEP 1: Check spell nullification.
    ------------------------------
    -- Check innate immunity
    if target:isMob() then
        local isInmune = xi.spells.enfeebling.checkInnateImmunity(target, spellEffect)

        if isInmune then
            spell:setMsg(xi.msg.basic.MAGIC_RESIST_2) -- TODO: Confirm correct message.

            return spellEffect
        end
    end

    -- Check trait nullification trigger.
    local traitTrigger = xi.spells.enfeebling.calculateTraitTrigger(caster, target, spellId)

    if traitTrigger then
        -- TODO: Change action modifier so Resist! appears.
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)

        return spellEffect
    end

    ------------------------------
    -- STEP 2: Calculate resist tiers.
    ------------------------------
    local skillType    = spell:getSkillType()
    local spellElement = spell:getElement()
    local statUsed     = pTable[spellId][2]
    local mEvaMod      = pTable[spellId][4]
    local resistStages = pTable[spellId][8]
    local message      = pTable[spellId][9]

    -- Magic Hit Rate calculations.
    local magicAcc     = xi.damage.magicHitRate.calculateCasterMagicAccuracy(caster, target, spell, skillType, spellElement, statUsed)
    local magicEva     = xi.damage.magicHitRate.calculateTargetMagicEvasion(caster, target, spellElement, true, mEvaMod)
    local magicHitRate = xi.damage.magicHitRate.calculateMagicHitRate(magicAcc, magicEva)

    -- Calculate individualy resist rates for potency and duration.
    local resistDuration = xi.damage.magicHitRate.calculateResistRate(magicHitRate, resistStages)
    local resistPotency  = 1

    -- Check if potency is affected by resist rate.
    if pTable[spellId][11] then
        resistPotency  = xi.damage.magicHitRate.calculateResistRate(magicHitRate, resistStages)
    end

    ------------------------------
    -- STEP 3: Check if spell resists.
    ------------------------------
    if spellEffect ~= xi.effect.NONE then
        -- Stymie
        if
            skillType == xi.skill.ENFEEBLING_MAGIC and
            caster:hasStatusEffect(xi.effect.STYMIE)
        then
            resistDuration = 1
            resistPotency  = 1

        -- Fealty
        elseif target:hasStatusEffect(xi.effect.FEALTY) then
            resistDuration = 0
            resistPotency  = 0
        end
    end

    if resistDuration <= 1 / (2 ^ resistStages) then
        -- spell:setModifier(xi.actionModifier.RESIST)
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)

        return spellEffect
    end

    ------------------------------
    -- STEP 4: Calculate Duration, Potency and Tick.
    ------------------------------
    -- Calculate Duration.
    local duration = xi.spells.enfeebling.calculateDuration(caster, target, spellId)
    duration       = math.floor(duration * resistDuration)

    -- Calculate potency.
    local potency = xi.spells.enfeebling.calculatePotency(caster, target, spellId, spellEffect, skillType, statUsed)
    potency       = math.floor(potency * resistPotency)

    -- Set tick (Poison, etc...)
    local tick = pTable[spellId][6]

    ------------------------------
    -- STEP 5: Exceptions.
    ------------------------------
    -- Bind
    if spellEffect == xi.effect.BIND then
        potency = target:getSpeed()
    end

    -- Dispel
    if spellEffect == xi.effect.NONE then
        spellEffect = target:dispelStatusEffect()

        if spellEffect == xi.effect.NONE then
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        else
            spell:setMsg(xi.msg.basic.MAGIC_ERASE)
        end

        return spellEffect
    end

    -- Elemental DoTs
    if
        spellEffect == xi.effect.BURN or
        spellEffect == xi.effect.CHOKE or
        spellEffect == xi.effect.DROWN or
        spellEffect == xi.effect.FROST or
        spellEffect == xi.effect.RASP or
        spellEffect == xi.effect.SHOCK
    then
        if target:hasStatusEffect(elementalDebuffTable[spellEffect][1]) then
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)

            return spellEffect
        end

        target:delStatusEffect(elementalDebuffTable[spellEffect][2])
        duration = duration + caster:getMerit(xi.merit.ELEMENTAL_DEBUFF_DURATION)
        potency  = potency + caster:getMerit(xi.merit.ELEMENTAL_DEBUFF_EFFECT) / 2
    end

    ------------------------------
    -- STEP 6: Final Operations.
    ------------------------------
    if target:addStatusEffect(spellEffect, potency, tick, duration) then
        -- Delete Stymie effect
        if
            skillType == xi.skill.ENFEEBLING_MAGIC and
            caster:hasStatusEffect(xi.effect.STYMIE)
        then
            caster:delStatusEffect(xi.effect.STYMIE)
        end

        -- Add "Magic Burst!" message
        local _, skillchainCount = FormMagicBurst(spellElement, target) -- External function. Not present in magic.lua.

        if skillchainCount > 0 then
            spell:setMsg(spell:getMagicBurstMessage())
            caster:triggerRoeEvent(xi.roe.triggers.magicBurst)
        else
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS + message)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return spellEffect
end
