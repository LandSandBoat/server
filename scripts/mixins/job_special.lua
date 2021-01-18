--[[ -----------------------------
Mobs that use job special abilities.

If required by a mob script, mob will use its main job's special sometime under 60 HPP.

This can be modified by calling tpz.mix.jobSpecial.config(mob, params) from within onMobSpawn.

params is a table that can contain the following keys:
    between    : Number of seconds betwen using any specials. Only matters if mob has multiple specials.
    chance     : Percent chance that a mob will use a special at all during engagement. (0 to 100)
    delay      : Grace period at start of fight, during which a mob not use any special, regardless of HPP. Min-clamped at 2 to avoid insta-flow. (2 to any)
    specials   : Table of job specials, with each entry a table that can contain the following keys:
      id       : the job ability ID (see tpz.jobSpecialAbility definition in scripts/globals/status.lua). Required.
      cooldown : cooldown in seconds for this special. Optional. Default 7200.
      duration : duration in seconds for specials that apply a status effect for a non-standard number of seconds.  Optional.  No default. (1 to any)
      hpp      : mob must be below this HP percent to use this special.  Optional.  Default random 40 to 60. (0 to 100)
      begCode  : callback function before the mob uses its special.
      endCode  : callback function after the mob uses its special.

Examples:

-- mob has a 50% chance to use its special, and if it does it will wait at least a minute (note: it must still be below its default HPP trigger)
tpz.mix.jobSpecial.config(mob, {
    chance = 50,
    delay  = 60,
})

-- mob will use its special at the start of fight (100 HPP), and every 60 seconds thereafter.
tpz.mix.jobSpecial.config(mob, {
    specials =
    {
        {id = tpz.jsa.MEIKYO_SHISUI, cooldown = 60, hpp = 100},
    },
})

-- mob will use Mighty Strikes immediately, but the effect will only last 10 seconds
tpz.mix.jobSpecial.config(mob, {
    specials =
    {
        {id = tpz.jsa.MIGHTY_STRIKES, duration = 10, hpp = 100},
    },
})

-- mob can use both Manafont and Chainspell (once each, unless you wait two hours for the cooldown to reset.)
-- Manafont will only be used under 75% HP.  Chainspell will only be used under 25% HP.
-- 30 seconds must elapse between the two specials, no matter how fast you take it down to 25% HP.
-- There's a 50% chance it will not use a special at all.
tpz.mix.jobSpecial.config(mob, {
    between = 30,
    chance = 50,
    specials =
    {
        {id = tpz.jsa.MANAFONT, hpp = 75},
        {id = tpz.jsa.CHAINSPELL, hpp = 25},
    },
})

-- every 20 seconds the mob will pick one of its three specials, which are always ready (no cooldown, and 100% HPP trigger), and use it.
tpz.mix.jobSpecial.config(mob, {
    between = 20,
    specials =
    {
        {id = tpz.jsa.MANAFONT, cooldown = 0, hpp = 100},
        {id = tpz.jsa.CHAINSPELL, cooldown = 0, hpp = 100},
        {id = tpz.jsa.BENEDICTION, cooldown = 0, hpp = 100},
    },
})

-- mob will use Perfect Dodge at 30% HP. before and after its use, it will make a sassy remark.
tpz.mix.jobSpecial.config(mob, {
    specials =
    {
        {
            id = tpz.jsa.PERFECT_DODGE,
            hpp = 30,
            begCode = function(mob)
                mob:messageText(mob, ID.text.HOW_CAN_YOU_EXPECT_TO_KILL_ME)
            end,
            endCode = function(mob)
                mob:messageText(mob, ID.text.WHEN_YOU_CANT_EVEN_HIT_ME)
            end,
        },
    },
})
---------------------------------------------------------------- --]]
require("scripts/globals/mixins")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------

tpz = tpz or {}
tpz.mix = tpz.mix or {}
tpz.mix.jobSpecial = tpz.mix.jobSpecial or {}

g_mixins = g_mixins or {}

local job2hr = {
    [tpz.job.WAR] = tpz.jsa.MIGHTY_STRIKES,
    [tpz.job.MNK] = tpz.jsa.HUNDRED_FISTS,
    [tpz.job.WHM] = tpz.jsa.BENEDICTION,
    [tpz.job.BLM] = tpz.jsa.MANAFONT,
    [tpz.job.RDM] = tpz.jsa.CHAINSPELL,
    [tpz.job.THF] = tpz.jsa.PERFECT_DODGE,
    [tpz.job.PLD] = tpz.jsa.INVINCIBLE,
    [tpz.job.DRK] = tpz.jsa.BLOOD_WEAPON,
    [tpz.job.BST] = tpz.jsa.FAMILIAR,
    [tpz.job.BRD] = tpz.jsa.SOUL_VOICE,
    [tpz.job.SAM] = tpz.jsa.MEIKYO_SHISUI,
    [tpz.job.NIN] = tpz.jsa.MIJIN_GAKURE,
    [tpz.job.DRG] = tpz.jsa.CALL_WYVERN,
    [tpz.job.SMN] = tpz.jsa.ASTRAL_FLOW,
    [tpz.job.BLU] = tpz.jsa.AZURE_LORE,

-- following abilities are not yet defined on tpz.jsa:
--  [tpz.job.COR] = tpz.jsa.WILD_CARD,
--  [tpz.job.PUP] = tpz.jsa.OVERDRIVE,
--  [tpz.job.DNC] = tpz.jsa.TRANCE,
--  [tpz.job.SCH] = tpz.jsa.TABULA_RASA,
--  [tpz.job.GEO] = tpz.jsa.BOLSTER,
--  [tpz.job.RUN] = tpz.jsa.ELEMENTAL_SFORZO,
}

-- eagle eye shot ability IDs by mob family
local familyEES =
{
    [  3] = tpz.jsa.EES_AERN,    -- Aern
    [ 25] = tpz.jsa.EES_ANTICA,  -- Antica
    [115] = tpz.jsa.EES_SHADE,   -- Fomor
    [126] = tpz.jsa.EES_GIGA,    -- Gigas
    [127] = tpz.jsa.EES_GIGA,    -- Gigas
    [128] = tpz.jsa.EES_GIGA,    -- Gigas
    [129] = tpz.jsa.EES_GIGA,    -- Gigas
    [130] = tpz.jsa.EES_GIGA,    -- Gigas
    [133] = tpz.jsa.EES_GOBLIN,  -- Goblin
    [169] = tpz.jsa.EES_KINDRED, -- Kindred
    [171] = tpz.jsa.EES_LAMIA,   -- Lamiae
    [182] = tpz.jsa.EES_MERROW,  -- Merrow
    [184] = tpz.jsa.EES_GOBLIN,  -- Moblin
    [189] = tpz.jsa.EES_ORC,     -- Orc
    [200] = tpz.jsa.EES_QUADAV,  -- Quadav
    [201] = tpz.jsa.EES_QUADAV,  -- Quadav
    [202] = tpz.jsa.EES_QUADAV,  -- Quadav
    [221] = tpz.jsa.EES_SHADE,   -- Shadow
    [222] = tpz.jsa.EES_SHADE,   -- Shadow
    [223] = tpz.jsa.EES_SHADE,   -- Shadow
    [246] = tpz.jsa.EES_TROLL,   -- Troll
    [270] = tpz.jsa.EES_YAGUDO,  -- Yagudo
    [327] = tpz.jsa.EES_GOBLIN,  -- Goblin
    [328] = tpz.jsa.EES_GIGA,    -- Gigas
    [334] = tpz.jsa.EES_ORC,     -- OrcNM
    [335] = tpz.jsa.EES_MAAT,    -- Maat
    [337] = tpz.jsa.EES_QUADAV,  -- QuadavNM
    [358] = tpz.jsa.EES_KINDRED, -- Kindred
    [359] = tpz.jsa.EES_SHADE,   -- Fomor
    [360] = tpz.jsa.EES_YAGUDO,  -- YagudoNM
    [373] = tpz.jsa.EES_GOBLIN,  -- Goblin_Armored
}

local effectByAbility =
{
    [tpz.jsa.MIGHTY_STRIKES] = tpz.effect.MIGHTY_STRIKES,
    [tpz.jsa.HUNDRED_FISTS]  = tpz.effect.HUNDRED_FISTS,
    [tpz.jsa.MANAFONT]       = tpz.effect.MANAFONT,
    [tpz.jsa.CHAINSPELL]     = tpz.effect.CHAINSPELL,
    [tpz.jsa.PERFECT_DODGE]  = tpz.effect.PERFECT_DODGE,
    [tpz.jsa.INVINCIBLE]     = tpz.effect.INVINCIBLE,
    [tpz.jsa.BLOOD_WEAPON]   = tpz.effect.BLOOD_WEAPON,
    [tpz.jsa.SOUL_VOICE]     = tpz.effect.SOUL_VOICE,
    [tpz.jsa.AZURE_LORE]     = tpz.effect.AZURE_LORE,

-- following abilities are not yet defined on tpz.jsa, and/or do not have effect luas:
-- [tpz.jsa.OVERDRIVE]        = tpz.effect.OVERDRIVE,
-- [tpz.jsa.TRANCE]           = tpz.effect.TRANCE,
-- [tpz.jsa.TABULA_RASA]      = tpz.effect.TABULA_RASA,
-- [tpz.jsa.BOLSTER]          = tpz.effect.BOLSTER,
-- [tpz.jsa.ELEMENTAL_SFORZO] = tpz.effect.ELEMENTAL_SFORZO,
}

tpz.mix.jobSpecial.config = function(mob, params)
    if params.between and type(params.between) == "number" then
        mob:setLocalVar("[jobSpecial]between", utils.clamp(params.between, 0))
    end

    if params.chance and type(params.chance) == "number" then
        mob:setLocalVar("[jobSpecial]chance", utils.clamp(params.chance, 0, 100))
    end

    if params.delay and type(params.delay) == "number" then
        mob:setLocalVar("[jobSpecial]delayInitial", utils.clamp(params.delay, 2))
    end

    if params.specials and type(params.specials) == "table" then
        local specials = params.specials
        local i = 0

        for _, v in pairs(specials) do
            if v.id and type(v.id) == "number" then
                i = i + 1
                mob:setLocalVar("[jobSpecial]ability_" .. i, v.id)

                if v.cooldown and type(v.cooldown) == "number" then
                    mob:setLocalVar("[jobSpecial]between_" .. i, utils.clamp(v.cooldown, 0))
                else
                    mob:setLocalVar("[jobSpecial]between_" .. i, 7200)
                end

                if v.duration and type(v.duration) == "number" then
                    mob:setLocalVar("[jobSpecial]duration_" .. i, utils.clamp(v.duration, 1))
                end

                if v.hpp and type(v.hpp) == "number" then
                    mob:setLocalVar("[jobSpecial]hpp_" .. i, utils.clamp(v.hpp, 0, 100))
                else
                    mob:setLocalVar("[jobSpecial]hpp_" .. i, math.random(40, 60))
                end

                if type(v.begCode) == "function" then
                    mob:setLocalVar("[jobSpecial]begCode_" .. i, 1)
                    mob:removeListener("JOB_SPECIAL_BEG_" .. i)
                    mob:addListener("JOB_SPECIAL_BEG_" .. i, "JOB_SPECIAL_BEG_" .. i, v.begCode)
                end

                if type(v.endCode) == "function" then
                    mob:setLocalVar("[jobSpecial]endCode_" .. i, 1)
                    mob:removeListener("JOB_SPECIAL_END_" .. i)
                    mob:addListener("JOB_SPECIAL_END_" .. i, "JOB_SPECIAL_END_" .. i, v.endCode)
                end
            end
        end

        mob:setLocalVar("[jobSpecial]numAbilities", i)
    end
end

--[[ ----------------------------------------------------------------
    return table of abilities mob is ready to use
---------------------------------------------------------------- --]]

local abilitiesReady = function(mob)
    local abilities = {}
    local now = os.time()
    local readyTime = mob:getLocalVar("[jobSpecial]readyInitial")

    if readyTime > 0 and now > readyTime and now > mob:getLocalVar("[jobSpecial]cooldown") then
        local numAbilities = mob:getLocalVar("[jobSpecial]numAbilities")

        for i = 1, numAbilities do
            if now > mob:getLocalVar("[jobSpecial]cooldown_" .. i) and mob:getHPP() <= mob:getLocalVar("[jobSpecial]hpp_" .. i)  then
                table.insert(abilities, i)
            end
        end
    end

    return abilities
end


--[[ ----------------------------------------------------------------
    mob listeners
---------------------------------------------------------------- --]]

g_mixins.job_special = function(mob)

    -- at spawn, give mob its default main job 2hr, which it'll use at 40-60% HP.
    -- these defaults can be overwritten by using tpz.mix.jobSpecial.config() in onMobSpawn.
    mob:addListener("SPAWN", "JOB_SPECIAL_SPAWN", function(mob)
        local ability = nil
        local mJob = mob:getMainJob()

        if mJob == tpz.job.RNG then
            ability = familyEES[mob:getFamily()]
        elseif mJob == tpz.job.SMN and mob:isInDynamis() then
            ability = tpz.jsa.ASTRAL_FLOW_MAAT
        else
            ability = job2hr[mJob]
        end

        if ability then
            mob:setLocalVar("[jobSpecial]numAbilities", 1)
            mob:setLocalVar("[jobSpecial]ability_1", ability)
            mob:setLocalVar("[jobSpecial]hpp_1", math.random(40, 60))
            mob:setLocalVar("[jobSpecial]between_1", 7200)
        end

        mob:setLocalVar("[jobSpecial]chance", 100)     -- chance that mob will use any special at all during engagement
        mob:setLocalVar("[jobSpecial]delayInitial", 2) -- default wait until mob can use its first special (prevents insta-flow)
    end)

    mob:addListener("ENGAGE", "JOB_SPECIAL_ENGAGE", function(mob)
        if math.random(100) <= mob:getLocalVar("[jobSpecial]chance") then
            mob:setLocalVar("[jobSpecial]readyInitial", os.time() + mob:getLocalVar("[jobSpecial]delayInitial"))
        end
    end)

    mob:addListener("COMBAT_TICK", "JOB_SPECIAL_CTICK", function(mob)
        local abilities = abilitiesReady(mob)

        if #abilities > 0 then
            local i = abilities[math.random(#abilities)]
            local ability = mob:getLocalVar("[jobSpecial]ability_" .. i)
            local now = os.time()

            if mob:getLocalVar("[jobSpecial]begCode_" .. i) == 1 then
                mob:triggerListener("JOB_SPECIAL_BEG_" .. i, mob)
            end

            mob:useMobAbility(ability)

            local customDuration = mob:getLocalVar("[jobSpecial]duration_" .. i)
            if customDuration > 0 then
                local specialEffect = effectByAbility[ability]
                if specialEffect then
                    local effect = mob:getStatusEffect(specialEffect)
                    if effect then
                        effect:setDuration(customDuration)
                    end
                end
            end

            if mob:getLocalVar("[jobSpecial]endCode_" .. i) == 1 then
                mob:triggerListener("JOB_SPECIAL_END_" .. i, mob)
            end

            mob:setLocalVar("[jobSpecial]cooldown_" .. i, now + mob:getLocalVar("[jobSpecial]between_" .. i)) -- set ability cooldown (wait to use this particular special again)
            mob:setLocalVar("[jobSpecial]cooldown", now + mob:getLocalVar("[jobSpecial]between")) -- set global cooldown (wait between using any specials)
        end
    end)
end

return g_mixins.job_special
