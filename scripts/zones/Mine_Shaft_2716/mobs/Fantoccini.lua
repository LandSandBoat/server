---@type TMobEntity
local entity = {}
-----------------------------------
local ID = zones[xi.zone.MINE_SHAFT_2716]
-----------------------------------
-- TODO : More complete / accurate spell lists - accurate weaponskill lists.
-- TODO : Accurate Double-Up Logic for Corsair
-----------------------------------

local jobTable =
{
    [xi.job.WAR] =
    {
        modelId    = 1209,
        hp         = 3750,
        delay      = 240,
        skillList  =
        {
            xi.mobSkill.RAGING_AXE,
            xi.mobSkill.SMASH_AXE,
            xi.mobSkill.GALE_AXE,
            xi.mobSkill.AVALANCHE_AXE,
            xi.mobSkill.SPINNING_AXE,
            xi.mobSkill.RAMPAGE_1,
        },
        jobAbility = { xi.mobSkill.WARCRY },
        twoHour    = xi.mobSkill.MIGHTY_STRIKES_1,
        isPetJob   = false,
        logicType  = 1,
    },

    [xi.job.MNK] =
    {
        modelId    = 1210,
        hp         = 5000,
        delay      = 420,
        skillList  =
        {
            xi.mobSkill.COMBO_1,
            xi.mobSkill.SHOULDER_TACKLE_1,
            xi.mobSkill.ONE_INCH_PUNCH_1,
            xi.mobSkill.BACKHAND_BLOW_1,
            xi.mobSkill.RAGING_FISTS_1,
            xi.mobSkill.SPINNING_ATTACK_1,
            xi.mobSkill.HOWLING_FIST_1,
        },
        jobAbility = { xi.mobSkill.COUNTERSTANCE_4 },
        twoHour    = xi.mobSkill.HUNDRED_FISTS_1,
        isPetJob   = false,
        logicType  = 1,
    },

    [xi.job.WHM] =
    {
        modelId   = 1214,
        hp        = 2750,
        delay     = 240,
        skillList =
        {
            xi.mobSkill.SHINING_STRIKE_1,
            xi.mobSkill.BRAINSHAKER_1,
            xi.mobSkill.SERAPH_STRIKE_1,
            xi.mobSkill.SKULLBREAKER_1,
            xi.mobSkill.TRUE_STRIKE_1,
        },
        spellList =
        {
            xi.magic.spell.PROTECT_III,
            xi.magic.spell.SHELL_III,
            xi.magic.spell.CURE_IV,
            xi.magic.spell.DIA_II,
            xi.magic.spell.HOLY,
            xi.magic.spell.SLOW,
            xi.magic.spell.PARALYZE,
        },
        twoHour   = xi.mobSkill.BENEDICTION_1,
        isPetJob  = false,
        logicType = 2,
    },

    [xi.job.BLM] =
    {
        modelId   = 1215,
        hp        = 4000,
        delay     = 240,
        skillList =
        {
            xi.mobSkill.SHINING_STRIKE_1,
            xi.mobSkill.BRAINSHAKER_1,
            xi.mobSkill.SERAPH_STRIKE_1,
            xi.mobSkill.SKULLBREAKER_1,
            xi.mobSkill.TRUE_STRIKE_1,
        },
        spellList =
        {
            xi.magic.spell.FIRAGA_II,
            xi.magic.spell.FLARE,
            xi.magic.spell.AERO_III,
            xi.magic.spell.TORNADO,
            xi.magic.spell.WATER_III,
            xi.magic.spell.BLIZZAGA_II,
        },
        twoHour   = xi.mobSkill.MANAFONT_1,
        isPetJob  = false,
        logicType = 2,
    },

    [xi.job.RDM] =
    {
        modelId   = 1216,
        hp        = 3500,
        delay     = 240,
        skillList =
        {
            xi.mobSkill.FAST_BLADE_1,
            xi.mobSkill.BURNING_BLADE_1,
            xi.mobSkill.RED_LOTUS_BLADE_1,
            xi.mobSkill.FLAT_BLADE_1,
            xi.mobSkill.SHINING_BLADE_1,
            xi.mobSkill.SERAPH_BLADE_1,
            xi.mobSkill.CIRCLE_BLADE_1,
            xi.mobSkill.SPIRITS_WITHIN_1,
        },
        spellList =
        {
            xi.magic.spell.THUNDER_II,
            xi.magic.spell.SHOCK_SPIKES,
            xi.magic.spell.PROTECT_III,
            xi.magic.spell.SHELL_III,
            xi.magic.spell.CURE_IV,
            xi.magic.spell.DIA_II,
            xi.magic.spell.ENTHUNDER,
            xi.magic.spell.SLOW,
            xi.magic.spell.PARALYZE,
            xi.magic.spell.SILENCE,
        },
        twoHour   = xi.mobSkill.CHAINSPELL_1,
        isPetJob  = false,
        logicType = 2,
    },

    [xi.job.THF] =
    {
        modelId    = 1218,
        hp         = 2750,
        delay      = 240,
        skillList  =
        {
            xi.mobSkill.WASP_STING_1,
            xi.mobSkill.VIPER_BITE,
            xi.mobSkill.SHADOWSTITCH,
            xi.mobSkill.GUST_SLASH,
            xi.mobSkill.CYCLONE,
            xi.mobSkill.DANCING_EDGE,
        },
        jobAbility = { xi.mobSkill.STEAL },
        twoHour    = xi.mobSkill.PERFECT_DODGE_1,
        isPetJob   = false,
        logicType  = 1,
    },

    [xi.job.PLD] =
    {
        modelId     = 1219,
        hp          = 2750,
        delay       = 240,
        shieldBlock = true,
        skillList   =
        {
            xi.mobSkill.FAST_BLADE_1,
            xi.mobSkill.BURNING_BLADE_1,
            xi.mobSkill.RED_LOTUS_BLADE_1,
            xi.mobSkill.FLAT_BLADE_1,
            xi.mobSkill.SHINING_BLADE_1,
            xi.mobSkill.SERAPH_BLADE_1,
            xi.mobSkill.CIRCLE_BLADE_1,
            xi.mobSkill.SPIRITS_WITHIN_1,
            xi.mobSkill.VORPAL_BLADE_1,
        },
        spellList  =
        {
            xi.magic.spell.FLASH
        },
        jobAbility  = { xi.mobSkill.SHIELD_BASH_1 },
        twoHour     = xi.mobSkill.INVINCIBLE_1,
        isPetJob    = false,
        logicType   = 3,
    },

    [xi.job.DRK] =
    {
        modelId    = 1220,
        hp         = 3250,
        delay      = 580,
        baseDmg    = 150,
        skillList  =
        {
            xi.mobSkill.SLICE,
            xi.mobSkill.DARK_HARVEST,
            xi.mobSkill.SHADOW_OF_DEATH,
            xi.mobSkill.NIGHTMARE_SCYTHE,
            xi.mobSkill.SPINNING_SCYTHE_1,
            xi.mobSkill.VORPAL_SCYTHE,
            xi.mobSkill.GUILLOTINE_1,
        },
        jobAbility = { xi.mobSkill.WEAPON_BASH },
        twoHour    = xi.mobSkill.BLOOD_WEAPON_1,
        isPetJob   = false,
        logicType  = 1,
    },

    [xi.job.BST] =
    {
        modelId    = 1224,
        hp         = 3750,
        delay      = 240,
        skillList  =
        {
            xi.mobSkill.RAGING_AXE,
            xi.mobSkill.SMASH_AXE,
            xi.mobSkill.GALE_AXE,
            xi.mobSkill.AVALANCHE_AXE,
            xi.mobSkill.SPINNING_AXE,
            xi.mobSkill.RAMPAGE_1,
        },
        jobAbility = { xi.mobSkill.SIC },
        twoHour    = xi.mobSkill.FAMILIAR_1,
        isPetJob   = true,
        logicType  = 4,

        pet =
        {
            offset = 1,
            name   = 'Fantoccini_Monster',
            params =
            {
                callPetJob   = xi.job.BST,
                inactiveTime = 3000,
                superLink    = true,
                dieWithOwner = true,
                maxSpawns    = 1,
            },
        },
    },

    [xi.job.BRD] =
    {
        modelId   = 1227,
        hp        = 3000,
        delay     = 240,
        skillList =
        {
            xi.mobSkill.WASP_STING_1,
            xi.mobSkill.GUST_SLASH,
            xi.mobSkill.SHADOWSTITCH,
            xi.mobSkill.VIPER_BITE,
            xi.mobSkill.CYCLONE,
        },
        spellList =
        {
            xi.magic.spell.ARMYS_PAEON_IV,
            xi.magic.spell.CARNAGE_ELEGY,
            xi.magic.spell.DRAGONFOE_MAMBO,
            xi.magic.spell.FOE_REQUIEM_V,
            xi.magic.spell.KNIGHTS_MINNE_III,
            xi.magic.spell.VALOR_MINUET_III,
            xi.magic.spell.VICTORY_MARCH,
        },
        twoHour   = xi.mobSkill.SOUL_VOICE_1,
        isPetJob  = false,
        logicType = 2,
    },

    [xi.job.RNG] =
    {
        modelId      = 1228,
        hp           = 4500,
        delay        = 240,
        rangedAttack = 14,
        skillList    =
        {
            xi.mobSkill.FLAMING_ARROW,
            xi.mobSkill.PIERCING_ARROW,
            xi.mobSkill.DULLING_ARROW,
            xi.mobSkill.SIDEWINDER_1,
        },
        jobAbility   = { xi.mobSkill.BARRAGE },
        twoHour      = xi.mobSkill.EAGLE_EYE_SHOT_HUMANOID,
        isPetJob     = false,
        logicType    = 1,
    },

    [xi.job.SAM] =
    {
        modelId    = 1229,
        hp         = 3750,
        delay      = 580,
        baseDmg    = 150,
        skillList  =
        {
            xi.mobSkill.TACHI_ENPI,
            xi.mobSkill.TACHI_HOBAKU,
            xi.mobSkill.TACHI_GOTEN_1,
            xi.mobSkill.TACHI_KAGERO,
            xi.mobSkill.TACHI_JINPU,
            xi.mobSkill.TACHI_KOKI,
            xi.mobSkill.TACHI_YUKIKAZE_1,
        },
        jobAbility = { xi.mobSkill.MEDITATE },
        twoHour    = xi.mobSkill.MEIKYO_SHISUI_1,
        isPetJob   = false,
        logicType  = 1,
    },

    [xi.job.NIN] =
    {
        modelId   = 1232,
        hp        = 3750,
        delay     = 280,
        dualWield = true,
        skillList =
        {
            xi.mobSkill.BLADE_RIN,
            xi.mobSkill.BLADE_RETSU,
            xi.mobSkill.BLADE_TEKI,
            xi.mobSkill.BLADE_TO,
            xi.mobSkill.BLADE_CHI,
            xi.mobSkill.BLADE_EI,
            xi.mobSkill.BLADE_JIN,
        },
        spellList =
        {
            xi.magic.spell.KATON_NI,
            xi.magic.spell.HYOTON_NI,
            xi.magic.spell.HUTON_NI,
            xi.magic.spell.DOTON_NI,
            xi.magic.spell.RAITON_NI,
            xi.magic.spell.SUITON_NI,
            xi.magic.spell.UTSUSEMI_NI,
            xi.magic.spell.JUBAKU_ICHI,
            xi.magic.spell.HOJO_NI,
            xi.magic.spell.KURAYAMI_NI,
            xi.magic.spell.DOKUMORI_ICHI,
        },
        twoHour   = xi.mobSkill.MIJIN_GAKURE_1,
        isPetJob  = false,
        logicType = 2,
    },

    [xi.job.DRG] =
    {
        modelId    = 1234,
        hp         = 3750,
        delay      = 580,
        baseDmg    = 150,
        skillList  =
        {
            xi.mobSkill.DOUBLE_THRUST,
            xi.mobSkill.THUNDER_THRUST,
            xi.mobSkill.RAIDEN_THRUST_1,
            xi.mobSkill.LEG_SWEEP,
            xi.mobSkill.PENTA_THRUST,
            xi.mobSkill.VORPAL_THRUST,
            xi.mobSkill.SKEWER,
        },
        jobAbility = { xi.mobSkill.JUMP_1 },
        twoHour    = xi.mobSkill.CALL_WYVERN_1,
        isPetJob   = true, -- Wyvern only summoned via two-hour ability.
        logicType  = 1,

        pet =
        {
            offset = 2,
            name   = 'Fantoccini_Wyvern',
            params =
            {
                callPetJob   = xi.job.DRG,
                superLink    = true,
                dieWithOwner = true,
                maxSpawns    = 1,
            },
        },
    },

    [xi.job.SMN] =
    {
        modelId    = 1235,
        hp         = 3250,
        delay      = 480,
        skillList  =
        {
            xi.mobSkill.HEAVY_SWING,
            xi.mobSkill.ROCK_CRUSHER,
            xi.mobSkill.EARTH_CRUSHER,
            xi.mobSkill.STARBURST,
            xi.mobSkill.SUNBURST,
            xi.mobSkill.SHELL_CRUSHER,
            xi.mobSkill.FULL_SWING,
        },
        jobAbility = { xi.mobSkill.BLOOD_PACT },
        twoHour    = xi.mobSkill.ASTRAL_FLOW_1,
        isPetJob   = true,
        logicType  = 4,

        pet =
        {
            offset = 3,
            name   = 'Fantoccini_Avatar',
            params =
            {
                callPetJob   = xi.job.SMN,
                inactiveTime = 3000,
                superLink    = true,
                dieWithOwner = true,
                maxSpawns    = 1,
            },
        },
    },

    [xi.job.BLU] =
    {
        modelId   = 1396,
        hp        = 3250,
        delay     = 240,
        skillList =
        {
            xi.mobSkill.FAST_BLADE_1,
            xi.mobSkill.BURNING_BLADE_1,
            xi.mobSkill.RED_LOTUS_BLADE_1,
            xi.mobSkill.FLAT_BLADE_1,
            xi.mobSkill.SHINING_BLADE_1,
            xi.mobSkill.SERAPH_BLADE_1,
            xi.mobSkill.CIRCLE_BLADE_1,
            xi.mobSkill.SPIRITS_WITHIN_1,
            xi.mobSkill.VORPAL_BLADE_1,
        },
        twoHour   = xi.mobSkill.AZURE_LORE,
        isPetJob  = false,
        logicType = 2,
    },

    [xi.job.COR] =
    {
        modelId      = 1397,
        hp           = 3750,
        delay        = 240,
        rangedAttack = 14,
        skillList    =
        {
            xi.mobSkill.HOT_SHOT_1,
            xi.mobSkill.SPLIT_SHOT_1,
            xi.mobSkill.SNIPER_SHOT_1,
            xi.mobSkill.SLUG_SHOT_1,
        },
        jobAbility =
        {
            xi.ja.FIGHTERS_ROLL,
            xi.ja.ROGUES_ROLL,
            xi.ja.GALLANTS_ROLL,
            xi.ja.CHAOS_ROLL,
            xi.ja.HUNTERS_ROLL,
            xi.ja.NINJA_ROLL,
        },
        twoHour      = xi.mobSkill.WILD_CARD,
        isPetJob     = false,
        logicType    = 5,
    },

    [xi.job.PUP] =
    {
        modelId    = 1398,
        hp         = 3500,
        delay      = 420,
        skillList  =
        {
            xi.mobSkill.COMBO_1,
            xi.mobSkill.SHOULDER_TACKLE_1,
            xi.mobSkill.ONE_INCH_PUNCH_1,
            xi.mobSkill.BACKHAND_BLOW_1,
            xi.mobSkill.RAGING_FISTS_1,
        },
        jobAbility =
        {
            xi.mobSkill.FIRE_MANEUVER,
            xi.mobSkill.ICE_MANEUVER,
            xi.mobSkill.WIND_MANEUVER,
            xi.mobSkill.EARTH_MANEUVER,
            xi.mobSkill.THUNDER_MANEUVER,
            xi.mobSkill.WATER_MANEUVER,
        },
        twoHour    = xi.mobSkill.OVERDRIVE,
        isPetJob   = true,
        logicType  = 4,
        pet =
        {
            offset = 4,
            name   = 'Fantoccini_Automaton',
            params =
            {
                callPetJob   = xi.job.PUP,
                inactiveTime = 3000,
                superLink    = true,
                dieWithOwner = true,
                maxSpawns    = 1,
            },
        },
    },
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 15)
end

entity.onMobSpawn = function(mob)
    local battlefield = mob:getBattlefield()

    if not battlefield then
        return
    end

    local initiatorJob = battlefield:getLocalVar('initiatorJob')
    local jobInfo      = jobTable[initiatorJob]

    if not jobInfo then
        return
    end

    mob:setLocalVar('initiatorJob', initiatorJob) -- Store as local variable so battlefield only needs to be fetched on spawn.
    mob:changeJob(initiatorJob)
    mob:setDelay(jobInfo.delay)
    mob:setModelId(jobInfo.modelId)
    mob:setMobAbilityEnabled(false)
    mob:setMagicCastingEnabled(false)
    mob:setAutoAttackEnabled(true)
    mob:setRangedAttackEnabled(false)

    mob:setMobMod(xi.mobMod.CAN_PARRY, 1)
    mob:setMobMod(xi.mobMod.DUAL_WIELD, jobInfo.dualWield and 1 or 0)
    mob:setMobMod(xi.mobMod.CAN_SHIELD_BLOCK, jobInfo.shieldBlock and 1 or 0)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, jobInfo.baseDmg or 100)

    if
        initiatorJob == xi.job.RNG or
        initiatorJob == xi.job.COR
    then
        mob:setRangedAttackEnabled(true)
        mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 0)
    end

    mob:setMaxHP(jobInfo.hp or mob:getMaxHP())
    mob:setHP(mob:getMaxHP() + 50)

    mob:setLocalVar('diceRoll', 0)

    -----------------------------------
    --- If pet job, set pet parameters.
    -----------------------------------
    if jobInfo.isPetJob then
        mob:setLocalVar('petSummonTime', 0)
        local petData = jobInfo.pet
        xi.pet.setMobPet(mob, petData.offset, petData.name)

        if initiatorJob == xi.job.SMN then
            mob:setMobMod(xi.mobMod.ASTRAL_PET_OFFSET, petData.offset)
        end
    end

    -----------------------------------
    -- If BLM, RDM, BLU allow free-casting while 2-hour ability is active.
    -- If SAM, allow free weaponskill usage after Meikyo Shisui is used.
    -----------------------------------
    if
        initiatorJob == xi.job.BLM or
        initiatorJob == xi.job.RDM or
        initiatorJob == xi.job.BLU or
        initiatorJob == xi.job.BRD or
        initiatorJob == xi.job.SAM
    then
        mob:addListener('EFFECT_GAIN', 'TWO_HOUR_EFFECT_GAIN', function(mobArg, effect)
            local effectType = effect:getEffectType()

            if
                effectType == xi.effect.MANAFONT or
                effectType == xi.effect.CHAINSPELL or
                effectType == xi.effect.AZURE_LORE or
                effectType == xi.effect.SOUL_VOICE
            then
                mobArg:setMagicCastingEnabled(true)
                if
                    initiatorJob == xi.job.BLM or
                    initiatorJob == xi.job.RDM or
                    initiatorJob == xi.job.BLU
                then
                    mobArg:setMobMod(xi.mobMod.MAGIC_COOL, 0)
                end
            end

            if effectType == xi.effect.MEIKYO_SHISUI then
                mobArg:setMobAbilityEnabled(true)
            end
        end)

        mob:addListener('EFFECT_LOSE', 'TWO_HOUR_EFFECT_LOSE', function(mobArg, effect)
            local effectType = effect:getEffectType()

            if
                effectType == xi.effect.MANAFONT or
                effectType == xi.effect.CHAINSPELL or
                effectType == xi.effect.AZURE_LORE or
                effectType == xi.effect.SOUL_VOICE
            then
                mobArg:setMagicCastingEnabled(false)
                mobArg:setMobMod(xi.mobMod.MAGIC_COOL, 15)
            end

            if effectType == xi.effect.MEIKYO_SHISUI then
                mobArg:setMobAbilityEnabled(false)
            end
        end)
    end
end

-----------------------------------
-- Main Combat Loop - Checks for Dice Rolls and executes appropriate actions - also handles pet summoning logic for pet jobs.
-----------------------------------
entity.onMobFight = function(mob, target)
    local initiatorJob = mob:getLocalVar('initiatorJob')
    local jobInfo      = jobTable[initiatorJob]

    if not jobInfo then
        return
    end

    local logicType  = jobInfo.logicType

    if not logicType then
        return
    end

    local diceRoll   = mob:getLocalVar('diceRoll')
    local jobAbility = jobInfo.jobAbility

    if diceRoll == 8 then
        mob:setMobAbilityEnabled(true)
    end

    switch(logicType): caseof
    {
        -----------------------------------
        -- Logic Type 1 : WAR, MNK, DRK, SAM, DRG, RNG
        -----------------------------------
        [1] = function()
            if diceRoll == 7 then
                if #jobAbility > 0 then
                    mob:useMobAbility(jobAbility[math.random(1, #jobAbility)])
                end

            elseif diceRoll == 14 then
                if initiatorJob == xi.job.DRG then
                    local petData = jobInfo.pet
                    local petId   = mob:getID() + petData.offset
                    local pet     = GetMobByID(petId)

                    if pet and pet:isAlive() then
                        return
                    end

                    xi.mob.callPets(mob, petId, petData.params)
                else
                    mob:useMobAbility(jobInfo.twoHour)
                end
            end
        end,

        -----------------------------------
        -- Logic Type 2 : WHM, BLM, RDM, BRD, NIN, BLU
        -----------------------------------
        [2] = function()
            if diceRoll == 7 then
                mob:setMagicCastingEnabled(true)
            elseif diceRoll == 14 then
                mob:useMobAbility(jobInfo.twoHour)
            end
        end,

        -----------------------------------
        -- Logic Type 3 : PLD
        -----------------------------------
        [3] = function()
            if diceRoll == 7 then
                if math.random(0, 1) == 0 then
                    mob:useMobAbility(jobAbility[math.random(1, #jobAbility)])
                else
                    mob:setMagicCastingEnabled(true)
                end

            elseif diceRoll == 14 then
                mob:useMobAbility(jobInfo.twoHour)
            end
        end,

        -----------------------------------
        -- Logic Type 4 : BST, SMN, PUP
        -----------------------------------
        [4] = function()
            local petData     = jobInfo.pet
            local petId       = mob:getID() + petData.offset
            local pet         = GetMobByID(petId)
            local currentTime = GetSystemTime()

            if not pet then
                return
            end

            if diceRoll == 7 then
                if #jobAbility > 0 and pet:isAlive() then
                    mob:useMobAbility(jobAbility[math.random(1, #jobAbility)])
                    pet:setLocalVar('jobAbilityUsed', 1) -- Used for Sic, Blood Pact & Maneuvers.
                end
            elseif diceRoll == 14 then
                mob:useMobAbility(jobInfo.twoHour)
                if initiatorJob == xi.job.SMN then
                    pet:setLocalVar('twoHourUsed', 1) -- Used for Astal Flow.
                end
            end

            -- If pet is alive, return.
            if pet:isAlive() then
                return
            end

            -- If it's time to resummon our pet, summon it.
            if currentTime >= mob:getLocalVar('petSummonTime') then
                xi.mob.callPets(mob, petId, petData.params)
            end
        end,

        -----------------------------------
        -- Logic Type 5 : COR
        -----------------------------------
        [5] = function()
            if diceRoll == 7 then
                mob:useJobAbility(jobAbility[math.random(1, #jobAbility)], mob)
                -- TODO: Don't use a timer, add actual double up logic. Double ups each roll once.
                mob:timer(4000, function(mobArg)
                    mobArg:useJobAbility(xi.ja.DOUBLE_UP, mobArg)
                end)
            elseif diceRoll == 14 then
                mob:useMobAbility(jobInfo.twoHour)
            end
        end,
    }

    if diceRoll ~= 0 then
        mob:setLocalVar('diceRoll', 0)
    end
end

-----------------------------------
-- When mob:setMobAbilityEnabled is (true) - pull from associated job weapon skills.
-----------------------------------
entity.onMobMobskillChoose = function(mob, target, skillId)
    local initiatorJob = mob:getLocalVar('initiatorJob')
    local jobInfo      = jobTable[initiatorJob]

    local skillList = jobInfo.skillList

    return skillList[math.random(1, #skillList)]
end

-----------------------------------
-- If Meditate or Wild Card was used, enable weaponskill usage, and reset ability enabled to false after any weaponskill executed.
-----------------------------------
entity.onMobWeaponSkill = function(mob, target, skill, action)
    local skillUsed = skill:getID()

    if
        skillUsed == xi.mobSkill.MEDITATE or
        skillUsed == xi.mobSkill.WILD_CARD
    then
        mob:setMobAbilityEnabled(true)
    end

    if
        skillUsed ~= xi.mobSkill.RANGED_ATTACK_1 and
        skillUsed ~= xi.mobSkill.MEDITATE and
        skillUsed ~= xi.mobSkill.WILD_CARD and
        not mob:hasStatusEffect(xi.effect.MEIKYO_SHISUI)
    then
        mob:setMobAbilityEnabled(false) -- Disables weaponskill use after 1 weaponskill unless effected by Meikyo Shisui.
    end
end

-----------------------------------
-- Spellcasting Logic
-----------------------------------
entity.onMobSpellChoose = function(mob, target, spellId)
    local initiatorJob = mob:getLocalVar('initiatorJob')
    local jobInfo      = jobTable[initiatorJob]

     -- If not under the effects of a two-hour ability, turn off spell casting. (Lets this spell pass)
    if
        not mob:hasStatusEffect(xi.effect.MANAFONT) and
        not mob:hasStatusEffect(xi.effect.CHAINSPELL) and
        not mob:hasStatusEffect(xi.effect.AZURE_LORE) and
        not mob:hasStatusEffect(xi.effect.SOUL_VOICE)
    then
        mob:setMagicCastingEnabled(false)
    end

    -- if initiator job is BLU, populate spell list with players set Blue Magic + Frypan
    if initiatorJob == xi.job.BLU then
        local player = mob:getBattlefield():getPlayers()[1]

        if not player then
            return
        end

        local blueMageSpellList = player:getSetBlueSpells()

        table.insert(blueMageSpellList, xi.magic.spell.FRYPAN)

        return blueMageSpellList[math.random(1, #blueMageSpellList)]
    -- If initiator job is any other caster, return a random spell from their spell list.
    else
        return jobInfo.spellList[math.random(1, #jobInfo.spellList)]
    end
end

-----------------------------------
-- On Death, despawn Moblin Fantoccini and play flavor text.
-----------------------------------
entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local moblinFantoccini = GetMobByID(mob:getID() - 2)
        if moblinFantoccini and moblinFantoccini:isAlive() then
            moblinFantoccini:messageText(moblinFantoccini, ID.text.HO_HO + 8) -- No-no, no-no! Papa bought me that, you know!
            mob:timer(1000, function(mobArg)
                moblinFantoccini:messageText(moblinFantoccini, ID.text.HO_HO + 9) -- No-no, no-no! Not how it's 'sposed to go!
                DespawnMob(mob:getID() - 2)
            end)
        end
    end
end

entity.onMobDespawn = function(mob)
    mob:removeListener('TWO_HOUR_EFFECT_GAIN')
    mob:removeListener('TWO_HOUR_EFFECT_LOSE')
end

return entity
