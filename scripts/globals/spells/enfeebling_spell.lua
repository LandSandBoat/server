-----------------------------------
-- Enfeebling Spell Utilities
-- Used for spells that deal negative status effects upon targets.
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
    EFFECT_ID      = 1,
    STAT_USED      = 2,
    BASE_POTENCY   = 3,
    BASE_TICK      = 4,
    BASE_DURATION  = 5,
    RESIST_STAGES  = 6,
    MESSAGE_OFFSET = 7,
    SABOTEUR       = 8,
    BONUS_MACC     = 9,
}

local pTable =
{   --                                  1                             2          3      4    5         6       7    8          9
    --                  [Spell ID ] = { Effect,                       Stat-Used, pBase, DoT, Duration, Resist, msg, pSaboteur, mAcc },
    -- Black Magic
    [xi.magic.spell.BIND          ] = { xi.effect.BIND,               xi.mod.INT,    0,   0,       60,      2,   0, false,       0 },
    [xi.magic.spell.BINDGA        ] = { xi.effect.BIND,               xi.mod.INT,    0,   0,       60,      2,   0, false,       0 },
    [xi.magic.spell.BLIND         ] = { xi.effect.BLINDNESS,          xi.mod.INT,    0,   0,      180,      2,   0, true,        0 },
    [xi.magic.spell.BLIND_II      ] = { xi.effect.BLINDNESS,          xi.mod.INT,    0,   0,      180,      2,   0, true,        0 },
    [xi.magic.spell.BLINDGA       ] = { xi.effect.BLINDNESS,          xi.mod.INT,    0,   0,      180,      2,   0, true,        0 },
    [xi.magic.spell.BREAK         ] = { xi.effect.PETRIFICATION,      xi.mod.INT,    1,   0,       30,      2,   0, false,       0 },
    [xi.magic.spell.BREAKGA       ] = { xi.effect.PETRIFICATION,      xi.mod.INT,    1,   0,       30,      2,   0, false,       0 },
    [xi.magic.spell.BURN          ] = { xi.effect.BURN,               xi.mod.INT,    0,   3,       90,      3,   1, true,        0 },
    [xi.magic.spell.CHOKE         ] = { xi.effect.CHOKE,              xi.mod.INT,    0,   3,       90,      3,   1, true,        0 },
    [xi.magic.spell.CURSE         ] = { xi.effect.CURSE_I,            xi.mod.INT,   50,   0,      300,      2,   0, false,       0 },
    [xi.magic.spell.DISPEL        ] = { xi.effect.NONE,               xi.mod.INT,    0,   0,        0,      4,   0, false,     175 },
    [xi.magic.spell.DISPELGA      ] = { xi.effect.NONE,               xi.mod.INT,    0,   0,        0,      4,   0, false,       0 },
    [xi.magic.spell.DISTRACT      ] = { xi.effect.EVASION_DOWN,       xi.mod.MND,    0,   0,      120,      2,   0, true,      150 },
    [xi.magic.spell.DISTRACT_II   ] = { xi.effect.EVASION_DOWN,       xi.mod.MND,    0,   0,      120,      2,   0, true,      150 },
    [xi.magic.spell.DISTRACT_III  ] = { xi.effect.EVASION_DOWN,       xi.mod.MND,    0,   0,      120,      2,   0, true,      150 },
    [xi.magic.spell.DROWN         ] = { xi.effect.DROWN,              xi.mod.INT,    0,   3,       90,      3,   1, true,        0 },
    [xi.magic.spell.FRAZZLE       ] = { xi.effect.MAGIC_EVASION_DOWN, xi.mod.MND,    0,   0,      120,      2,   0, true,      150 },
    [xi.magic.spell.FRAZZLE_II    ] = { xi.effect.MAGIC_EVASION_DOWN, xi.mod.MND,    0,   0,      120,      2,   0, true,      150 },
    [xi.magic.spell.FRAZZLE_III   ] = { xi.effect.MAGIC_EVASION_DOWN, xi.mod.MND,    0,   0,      120,      2,   0, true,      150 },
    [xi.magic.spell.FROST         ] = { xi.effect.FROST,              xi.mod.INT,    0,   3,       90,      3,   1, true,        0 },
    [xi.magic.spell.GRAVITY       ] = { xi.effect.WEIGHT,             xi.mod.INT,   26,   0,      120,      2,   0, true,        0 },
    [xi.magic.spell.GRAVITY_II    ] = { xi.effect.WEIGHT,             xi.mod.INT,   32,   0,      180,      2,   0, true,        0 },
    [xi.magic.spell.GRAVIGA       ] = { xi.effect.WEIGHT,             xi.mod.INT,   50,   0,      120,      2,   0, true,        0 },
    [xi.magic.spell.POISON        ] = { xi.effect.POISON,             xi.mod.INT,    0,   3,       90,      2,   0, true,        0 },
    [xi.magic.spell.POISON_II     ] = { xi.effect.POISON,             xi.mod.INT,    0,   3,      120,      2,   0, true,       30 },
    [xi.magic.spell.POISON_III    ] = { xi.effect.POISON,             xi.mod.INT,    0,   3,      150,      2,   0, true,        0 },
    [xi.magic.spell.POISONGA      ] = { xi.effect.POISON,             xi.mod.INT,    0,   3,       90,      2,   0, true,        0 },
    [xi.magic.spell.POISONGA_II   ] = { xi.effect.POISON,             xi.mod.INT,    0,   3,      120,      2,   0, true,        0 },
    [xi.magic.spell.POISONGA_III  ] = { xi.effect.POISON,             xi.mod.INT,    0,   3,      150,      2,   0, true,        0 },
    [xi.magic.spell.RASP          ] = { xi.effect.RASP,               xi.mod.INT,    0,   3,       90,      3,   1, true,        0 },
    [xi.magic.spell.SHOCK         ] = { xi.effect.SHOCK,              xi.mod.INT,    0,   3,       90,      3,   1, true,        0 },
    [xi.magic.spell.SLEEP         ] = { xi.effect.SLEEP_I,            xi.mod.INT,    1,   0,       60,      2,   0, false,       0 },
    [xi.magic.spell.SLEEP_II      ] = { xi.effect.SLEEP_I,            xi.mod.INT,    2,   0,       90,      2,   0, false,       0 },
    [xi.magic.spell.SLEEPGA       ] = { xi.effect.SLEEP_I,            xi.mod.INT,    1,   0,       60,      2,   0, false,       0 },
    [xi.magic.spell.SLEEPGA_II    ] = { xi.effect.SLEEP_I,            xi.mod.INT,    2,   0,       90,      2,   0, false,       0 },
    [xi.magic.spell.STUN          ] = { xi.effect.STUN,               xi.mod.INT,    1,   0,        5,      4,   0, false,     200 },
    [xi.magic.spell.VIRUS         ] = { xi.effect.PLAGUE,             xi.mod.INT,    5,   3,       60,      2,   0, false,       0 },

    -- Black magic Helixes
    [xi.magic.spell.GEOHELIX      ] = { xi.effect.HELIX,              xi.mod.INT,    0,  10,       30,      0,   0, false,       0 },
    [xi.magic.spell.GEOHELIX_II   ] = { xi.effect.HELIX,              xi.mod.INT,    0,  10,       30,      0,   0, false,       0 },
    [xi.magic.spell.HYDROHELIX    ] = { xi.effect.HELIX,              xi.mod.INT,    0,  10,       30,      0,   0, false,       0 },
    [xi.magic.spell.HYDROHELIX_II ] = { xi.effect.HELIX,              xi.mod.INT,    0,  10,       30,      0,   0, false,       0 },
    [xi.magic.spell.ANEMOHELIX    ] = { xi.effect.HELIX,              xi.mod.INT,    0,  10,       30,      0,   0, false,       0 },
    [xi.magic.spell.ANEMOHELIX_II ] = { xi.effect.HELIX,              xi.mod.INT,    0,  10,       30,      0,   0, false,       0 },
    [xi.magic.spell.PYROHELIX     ] = { xi.effect.HELIX,              xi.mod.INT,    0,  10,       30,      0,   0, false,       0 },
    [xi.magic.spell.PYROHELIX_II  ] = { xi.effect.HELIX,              xi.mod.INT,    0,  10,       30,      0,   0, false,       0 },
    [xi.magic.spell.CRYOHELIX     ] = { xi.effect.HELIX,              xi.mod.INT,    0,  10,       30,      0,   0, false,       0 },
    [xi.magic.spell.CRYOHELIX_II  ] = { xi.effect.HELIX,              xi.mod.INT,    0,  10,       30,      0,   0, false,       0 },
    [xi.magic.spell.IONOHELIX     ] = { xi.effect.HELIX,              xi.mod.INT,    0,  10,       30,      0,   0, false,       0 },
    [xi.magic.spell.IONOHELIX_II  ] = { xi.effect.HELIX,              xi.mod.INT,    0,  10,       30,      0,   0, false,       0 },
    [xi.magic.spell.NOCTOHELIX    ] = { xi.effect.HELIX,              xi.mod.INT,    0,  10,       30,      0,   0, false,       0 },
    [xi.magic.spell.NOCTOHELIX_II ] = { xi.effect.HELIX,              xi.mod.INT,    0,  10,       30,      0,   0, false,       0 },
    [xi.magic.spell.LUMINOHELIX   ] = { xi.effect.HELIX,              xi.mod.INT,    0,  10,       30,      0,   0, false,       0 },
    [xi.magic.spell.LUMINOHELIX_II] = { xi.effect.HELIX,              xi.mod.INT,    0,  10,       30,      0,   0, false,       0 },

    -- White Magic
    [xi.magic.spell.ADDLE         ] = { xi.effect.ADDLE,              xi.mod.MND,   30,   0,      180,      2,   0, true,        0 },
    [xi.magic.spell.FLASH         ] = { xi.effect.FLASH,              xi.mod.MND,  300,   0,       12,      4,   0, true,      200 },
    [xi.magic.spell.INUNDATION    ] = { xi.effect.INUNDATION,         xi.mod.MND,    1,   0,      300,      5,   0, false,       0 },
    [xi.magic.spell.PARALYZE      ] = { xi.effect.PARALYSIS,          xi.mod.MND,    0,   0,      120,      2,   0, true,      -10 },
    [xi.magic.spell.PARALYZE_II   ] = { xi.effect.PARALYSIS,          xi.mod.MND,    0,   0,      120,      2,   0, true,        0 },
    [xi.magic.spell.PARALYGA      ] = { xi.effect.PARALYSIS,          xi.mod.MND,    0,   0,      120,      2,   0, true,        0 },
    [xi.magic.spell.REPOSE        ] = { xi.effect.SLEEP_I,            xi.mod.MND,    2,   0,       90,      2,   1, false,       0 },
    [xi.magic.spell.SILENCE       ] = { xi.effect.SILENCE,            xi.mod.MND,    1,   0,      120,      2,   0, false,       0 },
    [xi.magic.spell.SILENCEGA     ] = { xi.effect.SILENCE,            xi.mod.MND,    1,   0,      120,      2,   0, false,       0 },
    [xi.magic.spell.SLOW          ] = { xi.effect.SLOW,               xi.mod.MND,    0,   0,      180,      2,   0, true,       10 },
    [xi.magic.spell.SLOW_II       ] = { xi.effect.SLOW,               xi.mod.MND,    0,   0,      180,      2,   0, true,       10 },
    [xi.magic.spell.SLOWGA        ] = { xi.effect.SLOW,               xi.mod.MND,    0,   0,      180,      2,   0, true,        0 },

    -- Ninjutsu
    [xi.magic.spell.AISHA_ICHI    ] = { xi.effect.ATTACK_DOWN,        xi.mod.INT,   15,   0,      120,      4,   1, false,       0 },
    [xi.magic.spell.DOKUMORI_ICHI ] = { xi.effect.POISON,             xi.mod.INT,    3,   3,       60,      2,   0, false,       0 },
    [xi.magic.spell.DOKUMORI_NI   ] = { xi.effect.POISON,             xi.mod.INT,   10,   3,      120,      2,   0, false,       0 },
    [xi.magic.spell.DOKUMORI_SAN  ] = { xi.effect.POISON,             xi.mod.INT,   20,   3,      360,      2,   0, false,       0 },
    [xi.magic.spell.HOJO_ICHI     ] = { xi.effect.SLOW,               xi.mod.INT, 1465,   0,      180,      2,   0, false,       0 },
    [xi.magic.spell.HOJO_NI       ] = { xi.effect.SLOW,               xi.mod.INT, 1953,   0,      300,      2,   0, false,       0 },
    [xi.magic.spell.HOJO_SAN      ] = { xi.effect.SLOW,               xi.mod.INT, 2930,   0,      420,      2,   0, false,       0 },
    [xi.magic.spell.JUBAKU_ICHI   ] = { xi.effect.PARALYSIS,          xi.mod.INT,   20,   0,      180,      2,   1, false,       0 },
    [xi.magic.spell.JUBAKU_NI     ] = { xi.effect.PARALYSIS,          xi.mod.INT,   30,   0,      300,      2,   1, false,       0 },
    [xi.magic.spell.JUBAKU_SAN    ] = { xi.effect.PARALYSIS,          xi.mod.INT,   35,   0,      420,      2,   1, false,       0 },
    [xi.magic.spell.KURAYAMI_ICHI ] = { xi.effect.BLINDNESS,          xi.mod.INT,   20,   0,      180,      2,   0, false,       0 },
    [xi.magic.spell.KURAYAMI_NI   ] = { xi.effect.BLINDNESS,          xi.mod.INT,   30,   0,      300,      2,   0, false,       0 },
    [xi.magic.spell.KURAYAMI_SAN  ] = { xi.effect.BLINDNESS,          xi.mod.INT,   40,   0,      420,      2,   0, false,       0 },
    [xi.magic.spell.YURIN_ICHI    ] = { xi.effect.INHIBIT_TP,         xi.mod.INT,   10,   0,      180,      3,   1, false,       0 },
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

    potency = potency + caster:getMerit(xi.merit.ELEMENTAL_DEBUFF_EFFECT) -- TODO: Add BLM Toban gear effect (potency) here.

    return potency
end

-- Calculate potency.
xi.spells.enfeebling.calculatePotency = function(caster, target, spellId, spellEffect, skillType, statUsed)
    local potency    = pTable[spellId][column.BASE_POTENCY]
    local statDiff   = caster:getStat(statUsed) - target:getStat(statUsed)
    local skillLevel = caster:getSkillLevel(skillType)

    -- Calculate base potency for spells.
    switch (spellEffect) : caseof
    {
        [xi.effect.BLINDNESS] = function()
            statDiff = caster:getStat(statUsed) - target:getStat(xi.mod.MND)

            if spellId == xi.magic.spell.BLIND_II then
                potency = utils.clamp(statDiff * 0.375 + 49, 19, 94) -- Values from JP wiki: http://wiki.ffo.jp/html/3449.html
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
                potency = utils.clamp(statDiff / 4 + 24, 14, 34) -- Values from JP wiki: https://wiki.ffo.jp/html/3453.html
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
                potency = utils.clamp(statDiff * 226 / 15 + 2780, 1650, 3910) -- https://wiki.ffo.jp/html/3454.html
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

    ---@cast potency integer
    potency = math.floor(potency)

    -- Apply Saboteur Effect when applicable.
    local applySaboteur = pTable[spellId][column.SABOTEUR]

    if
        applySaboteur and
        caster:hasStatusEffect(xi.effect.SABOTEUR) and
        skillType == xi.skill.ENFEEBLING_MAGIC
    then
        if target:isNM() then
            potency = math.floor(potency * (1.3 + caster:getMod(xi.mod.ENHANCES_SABOTEUR)))
        else
            potency = math.floor(potency * (2 + caster:getMod(xi.mod.ENHANCES_SABOTEUR)))
        end
    end

    -- General Enfeebling potency modifier.
    potency = math.floor(potency * (1 + caster:getMod(xi.mod.ENF_MAG_POTENCY) / 100))

    return potency
end

-- Calculate duration before resist
xi.spells.enfeebling.calculateDuration = function(caster, target, spellId, spellEffect, skillType)
    local duration = pTable[spellId][column.BASE_DURATION] -- Get base duration.

    -- BIND spells have a special random duration the follows a normal distribution with mean=30 and std=12
    if spellEffect == xi.effect.BIND then
        -- Use the Box-Muller transform to change uniform dist sample to the normal dist sample
        local z0 = math.sqrt(-2 * math.log(math.random())) * math.cos(2 * math.pi * math.random())

        ---@cast duration integer
        duration = utils.clamp(math.floor(30 + z0 * 12), 1, duration)
    end

    -- Additions to base duration.
    if
        spellEffect == xi.effect.BURN or
        spellEffect == xi.effect.CHOKE or
        spellEffect == xi.effect.DROWN or
        spellEffect == xi.effect.FROST or
        spellEffect == xi.effect.RASP or
        spellEffect == xi.effect.SHOCK
    then
        duration = duration + caster:getMerit(xi.merit.ELEMENTAL_DEBUFF_DURATION) -- TODO: Add BLM Toban gear effect (duration) here.

    elseif spellEffect == xi.effect.HELIX then
        local casterLevel = caster:getMainLvl()

        if casterLevel >= 60 then
            duration = duration + 60
        elseif casterLevel >= 40 then
            duration = duration + 30
        end

        if caster:hasStatusEffect(xi.effect.DARK_ARTS) then
            duration = duration + 3 * caster:getJobPointLevel(xi.jp.DARK_ARTS_EFFECT)
        end

        duration = duration + caster:getMod(xi.mod.HELIX_DURATION)
    end

    if skillType == xi.skill.ENFEEBLING_MAGIC then
        if caster:hasStatusEffect(xi.effect.SABOTEUR) then
            if target:isNM() then
                duration = duration * 1.25
            else
                duration = duration * 2
            end
        end

        -- After Saboteur according to bg-wiki
        if caster:getMainJob() == xi.job.RDM then
            -- RDM Merit: Enfeebling Magic Duration
            duration = duration + caster:getMerit(xi.merit.ENFEEBLING_MAGIC_DURATION)

            -- RDM Job Point: Enfeebling Magic Duration
            duration = duration + caster:getJobPointLevel(xi.jp.ENFEEBLE_DURATION)

            -- RDM Job Point: Stymie effect
            if caster:hasStatusEffect(xi.effect.STYMIE) then
                duration = duration + caster:getJobPointLevel(xi.jp.STYMIE_EFFECT)
            end
        end
    end

    ---@cast duration integer
    return math.floor(duration)
end

-- Main function, called by spell scripts
xi.spells.enfeebling.useEnfeeblingSpell = function(caster, target, spell)
    local spellId      = spell:getID()
    local spellElement = spell:getElement()
    local spellEffect  = pTable[spellId][column.EFFECT_ID]

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
    -- STEP 2: Calculate resist tiers.
    ------------------------------
    local skillType    = spell:getSkillType()
    local spellGroup   = spell:getSpellGroup()
    local statUsed     = pTable[spellId][column.STAT_USED]
    local resistStages = pTable[spellId][column.RESIST_STAGES]
    local message      = pTable[spellId][column.MESSAGE_OFFSET]
    local bonusMacc    = pTable[spellId][column.BONUS_MACC]
    local resistRate   = xi.combat.magicHitRate.calculateResistRate(caster, target, spellGroup, skillType, 0, spellElement, statUsed, spellEffect, bonusMacc)

    if spellEffect ~= xi.effect.NONE then
        -- Stymie
        if
            skillType == xi.skill.ENFEEBLING_MAGIC and
            caster:hasStatusEffect(xi.effect.STYMIE)
        then
            resistRate = 1

        -- Fealty
        elseif target:hasStatusEffect(xi.effect.FEALTY) then
            resistRate = 0
        end
    end

    ------------------------------
    -- STEP 3: Check if spell resists and Immunobreak.
    ------------------------------
    if resistRate <= 1 / (2 ^ resistStages) then
        -- Attempt immunobreak. Fetch resistance rank modifier.
        local resistRank          = 0
        local immunobreakModifier = xi.combat.statusEffect.getAssociatedImmunobreakModifier(spellEffect)
        local rankModifier        = target:getMod(immunobreakModifier)

        if spellElement ~= xi.element.NONE then
            resistRank = target:getMod(xi.combat.element.getElementalResistanceRankModifier(spellElement))
        end

        if
            xi.settings.main.ENABLE_IMMUNOBREAK and
            caster:isPC() and
            target:isMob() and
            immunobreakModifier > 0 and                -- Only certain effects can be immunobroken.
            skillType == xi.skill.ENFEEBLING_MAGIC and -- Only Enfeebling magic can immunobreak.
            (resistRank - rankModifier) > 4            -- Only mobs with a resistance rank of 5+ (50% EEM) can be immunobroken.
        then
            local immunobreakRandom = math.random(1, 100)
            local immunobreakChance = 16 / (1 + rankModifier) + caster:getMerit(xi.merit.IMMUNOBREAK_CHANCE)

            -- We successfully trigger Immunobreak. Change target modifier and set correct message.
            if immunobreakRandom <= immunobreakChance then
                target:setMod(immunobreakModifier, rankModifier + 1) -- TODO: Add equipment modifier (x2) here.

                spell:setModifier(xi.msg.actionModifier.IMMUNOBREAK)
            end
        end

        -- We still resited.
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)

        return spellEffect
    end

    ------------------------------
    -- STEP 4: Calculate Duration, Potency, Tick and Sub-Potency (additional effects)
    ------------------------------
    local potency    = xi.spells.enfeebling.calculatePotency(caster, target, spellId, spellEffect, skillType, statUsed)
    local subpotency = 0
    local duration   = math.floor(xi.spells.enfeebling.calculateDuration(caster, target, spellId, spellEffect, skillType) * resistRate)
    local tick       = pTable[spellId][column.BASE_TICK]

    ------------------------------
    -- STEP 5: Exceptions.
    ------------------------------
    -- Bind: Dependant on target speed.
    -- Bind: Duration floor of 5 seconds.
    if spellEffect == xi.effect.BIND then
        potency = target:getSpeed()
        duration = utils.clamp(duration, 5, 60)

    -- TODO: This is unnecesary, but, for now, we will comply with core.
    elseif spellEffect == xi.effect.SLEEP_I then
        subpotency = spellElement

    -- Addle: Has sub-effect.
    elseif spellEffect == xi.effect.ADDLE then
        subpotency = 20 + utils.clamp(math.floor((caster:getStat(statUsed) - target:getStat(statUsed)) / 5), 0, 20)

    -- Break: Player petrification sucks.
    elseif spellEffect == xi.effect.PETRIFICATION then
        if caster:isPC() then
            subpotency = 1
        end

    -- Dispel: It's special in that it has no real effect.
    elseif spellEffect == xi.effect.NONE then
        spellEffect = target:dispelStatusEffect()

        if spellEffect == xi.effect.NONE then
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        else
            spell:setMsg(xi.msg.basic.MAGIC_ERASE)
        end

        return spellEffect
    end

    ------------------------------
    -- STEP 6: Final Operations.
    ------------------------------
    if target:addStatusEffect(spellEffect, potency, tick, duration, 0, subpotency) then
        -- Delete Stymie effect
        if
            skillType == xi.skill.ENFEEBLING_MAGIC and
            caster:hasStatusEffect(xi.effect.STYMIE)
        then
            caster:delStatusEffect(xi.effect.STYMIE)
        end

        -- Add "Magic Burst!" message
        local _, skillchainCount = xi.magicburst.formMagicBurst(spellElement, target) -- External function. Not present in magic.lua.

        if skillchainCount > 0 then
            spell:setMsg(xi.msg.basic.MAGIC_BURST_ENFEEB_IS - message * 3)
            caster:triggerRoeEvent(xi.roeTrigger.MAGIC_BURST)
        else
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS + message)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return spellEffect
end
