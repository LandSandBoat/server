--[[ -----------------------------
Mobs that use job special abilities.

If required by a mob script, mob will use its main job's special sometime under 60 HPP.

This can be modified by calling xi.mix.jobSpecial.config(mob, params) from within onMobSpawn.

params is a table that can contain the following keys:
    between    : Number of seconds betwen using any specials. Only matters if mob has multiple specials.
    chance     : Percent chance that a mob will use a special at all during engagement. (0 to 100)
    delay      : Grace period at start of fight, during which a mob not use any special, regardless of HPP. Min-clamped at 2 to avoid insta-flow. (2 to any)
    specials   : Table of job specials, with each entry a table that can contain the following keys:
      id       : the job ability ID (see xi.jobSpecialAbility definition in scripts/enum/jobSpecialAbility.lua). Required.
      cooldown : cooldown in seconds for this special. Optional. Default 7200.
      duration : duration in seconds for specials that apply a status effect for a non-standard number of seconds.  Optional.  No default. (1 to any)
      hpp      : mob must be below this HP percent to use this special.  Optional.  Default random 40 to 60. (0 to 100)
      begCode  : callback function before the mob uses its special.
      endCode  : callback function after the mob uses its special.

Examples:

-- mob has a 50% chance to use its special, and if it does it will wait at least a minute (note: it must still be below its default HPP trigger)
xi.mix.jobSpecial.config(mob, {
    chance = 50,
    delay  = 60,
})

-- mob will use its special at the start of fight (100 HPP), and every 60 seconds thereafter.
xi.mix.jobSpecial.config(mob, {
    specials =
    {
        { id = xi.jsa.MEIKYO_SHISUI, cooldown = 60, hpp = 100 },
    },
})

-- mob will use Mighty Strikes immediately, but the effect will only last 10 seconds
xi.mix.jobSpecial.config(mob, {
    specials =
    {
        { id = xi.jsa.MIGHTY_STRIKES, duration = 10, hpp = 100 },
    },
})

-- mob can use both Manafont and Chainspell (once each, unless you wait two hours for the cooldown to reset.)
-- Manafont will only be used under 75% HP.  Chainspell will only be used under 25% HP.
-- 30 seconds must elapse between the two specials, no matter how fast you take it down to 25% HP.
-- There's a 50% chance it will not use a special at all.
xi.mix.jobSpecial.config(mob, {
    between = 30,
    chance = 50,
    specials =
    {
        { id = xi.jsa.MANAFONT, hpp = 75 },
        { id = xi.jsa.CHAINSPELL, hpp = 25 },
    },
})

-- every 20 seconds the mob will pick one of its three specials, which are always ready (no cooldown, and 100% HPP trigger), and use it.
xi.mix.jobSpecial.config(mob, {
    between = 20,
    specials =
    {
        { id = xi.jsa.MANAFONT, cooldown = 0, hpp = 100 },
        { id = xi.jsa.CHAINSPELL, cooldown = 0, hpp = 100 },
        { id = xi.jsa.BENEDICTION, cooldown = 0, hpp = 100 },
    },
})

-- mob will use Perfect Dodge at 30% HP. before and after its use, it will make a sassy remark.
xi.mix.jobSpecial.config(mob, {
    specials =
    {
        {
            id = xi.jsa.PERFECT_DODGE,
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
require('scripts/globals/mixins')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.jobSpecial = xi.mix.jobSpecial or {}

g_mixins = g_mixins or {}

local job2hr =
{
    [xi.job.WAR] = xi.jsa.MIGHTY_STRIKES,
    [xi.job.MNK] = xi.jsa.HUNDRED_FISTS,
    [xi.job.WHM] = xi.jsa.BENEDICTION,
    [xi.job.BLM] = xi.jsa.MANAFONT,
    [xi.job.RDM] = xi.jsa.CHAINSPELL,
    [xi.job.THF] = xi.jsa.PERFECT_DODGE,
    [xi.job.PLD] = xi.jsa.INVINCIBLE,
    [xi.job.DRK] = xi.jsa.BLOOD_WEAPON,
    [xi.job.BST] = xi.jsa.FAMILIAR,
    [xi.job.BRD] = xi.jsa.SOUL_VOICE,
    [xi.job.SAM] = xi.jsa.MEIKYO_SHISUI,
    [xi.job.NIN] = xi.jsa.MIJIN_GAKURE,
    [xi.job.DRG] = xi.jsa.CALL_WYVERN,
    [xi.job.SMN] = xi.jsa.ASTRAL_FLOW,
    [xi.job.BLU] = xi.jsa.AZURE_LORE,

-- following abilities are not yet defined on xi.jsa:
--  [xi.job.COR] = xi.jsa.WILD_CARD,
--  [xi.job.PUP] = xi.jsa.OVERDRIVE,
--  [xi.job.DNC] = xi.jsa.TRANCE,
--  [xi.job.SCH] = xi.jsa.TABULA_RASA,
--  [xi.job.GEO] = xi.jsa.BOLSTER,
--  [xi.job.RUN] = xi.jsa.ELEMENTAL_SFORZO,
}

-- eagle eye shot ability IDs by mob family
local familyEES =
{
    [  3] = xi.jsa.EES_AERN,    -- Aern
    [ 25] = xi.jsa.EES_ANTICA,  -- Antica
    [115] = xi.jsa.EES_SHADE,   -- Fomor
    [126] = xi.jsa.EES_GIGA,    -- Gigas
    [127] = xi.jsa.EES_GIGA,    -- Gigas
    [128] = xi.jsa.EES_GIGA,    -- Gigas
    [129] = xi.jsa.EES_GIGA,    -- Gigas
    [130] = xi.jsa.EES_GIGA,    -- Gigas
    [133] = xi.jsa.EES_GOBLIN,  -- Goblin
    [169] = xi.jsa.EES_KINDRED, -- Kindred
    [171] = xi.jsa.EES_LAMIA,   -- Lamiae
    [182] = xi.jsa.EES_MERROW,  -- Merrow
    [184] = xi.jsa.EES_GOBLIN,  -- Moblin
    [189] = xi.jsa.EES_ORC,     -- Orc
    [200] = xi.jsa.EES_QUADAV,  -- Quadav
    [201] = xi.jsa.EES_QUADAV,  -- Quadav
    [202] = xi.jsa.EES_QUADAV,  -- Quadav
    [221] = xi.jsa.EES_SHADE,   -- Shadow
    [222] = xi.jsa.EES_SHADE,   -- Shadow
    [223] = xi.jsa.EES_SHADE,   -- Shadow
    [246] = xi.jsa.EES_TROLL,   -- Troll
    [270] = xi.jsa.EES_YAGUDO,  -- Yagudo
    [327] = xi.jsa.EES_GOBLIN,  -- Goblin
    [328] = xi.jsa.EES_GIGA,    -- Gigas
    [334] = xi.jsa.EES_ORC,     -- OrcNM
    [335] = xi.jsa.EES_MAAT,    -- Maat
    [337] = xi.jsa.EES_QUADAV,  -- QuadavNM
    [358] = xi.jsa.EES_KINDRED, -- Kindred
    [359] = xi.jsa.EES_SHADE,   -- Fomor
    [360] = xi.jsa.EES_YAGUDO,  -- YagudoNM
    [373] = xi.jsa.EES_GOBLIN,  -- Goblin_Armored
}

local effectByAbility =
{
    [xi.jsa.MIGHTY_STRIKES] = xi.effect.MIGHTY_STRIKES,
    [xi.jsa.HUNDRED_FISTS]  = xi.effect.HUNDRED_FISTS,
    [xi.jsa.MANAFONT]       = xi.effect.MANAFONT,
    [xi.jsa.CHAINSPELL]     = xi.effect.CHAINSPELL,
    [xi.jsa.PERFECT_DODGE]  = xi.effect.PERFECT_DODGE,
    [xi.jsa.INVINCIBLE]     = xi.effect.INVINCIBLE,
    [xi.jsa.BLOOD_WEAPON]   = xi.effect.BLOOD_WEAPON,
    [xi.jsa.SOUL_VOICE]     = xi.effect.SOUL_VOICE,
    [xi.jsa.AZURE_LORE]     = xi.effect.AZURE_LORE,

-- following abilities are not yet defined on xi.jsa, and/or do not have effect luas:
-- [xi.jsa.OVERDRIVE]        = xi.effect.OVERDRIVE,
-- [xi.jsa.TRANCE]           = xi.effect.TRANCE,
-- [xi.jsa.TABULA_RASA]      = xi.effect.TABULA_RASA,
-- [xi.jsa.BOLSTER]          = xi.effect.BOLSTER,
-- [xi.jsa.ELEMENTAL_SFORZO] = xi.effect.ELEMENTAL_SFORZO,
}

xi.mix.jobSpecial.config = function(mob, params)
    if params.between and type(params.between) == 'number' then
        mob:setLocalVar('[jobSpecial]between', utils.clamp(params.between, 0))
    end

    if params.chance and type(params.chance) == 'number' then
        mob:setLocalVar('[jobSpecial]chance', utils.clamp(params.chance, 0, 100))
    end

    if params.delay and type(params.delay) == 'number' then
        mob:setLocalVar('[jobSpecial]delayInitial', utils.clamp(params.delay, 2))
    end

    if params.specials and type(params.specials) == 'table' then
        local specials = params.specials
        local i = 0

        for _, v in pairs(specials) do
            if v.id and type(v.id) == 'number' then
                i = i + 1
                mob:setLocalVar('[jobSpecial]ability_' .. i, v.id)

                if v.cooldown and type(v.cooldown) == 'number' then
                    mob:setLocalVar('[jobSpecial]between_' .. i, utils.clamp(v.cooldown, 0))
                else
                    mob:setLocalVar('[jobSpecial]between_' .. i, 7200)
                end

                if v.duration and type(v.duration) == 'number' then
                    mob:setLocalVar('[jobSpecial]duration_' .. i, utils.clamp(v.duration, 1))
                end

                if v.hpp and type(v.hpp) == 'number' then
                    mob:setLocalVar('[jobSpecial]hpp_' .. i, utils.clamp(v.hpp, 0, 100))
                else
                    mob:setLocalVar('[jobSpecial]hpp_' .. i, math.random(40, 60))
                end

                if type(v.begCode) == 'function' then
                    mob:setLocalVar('[jobSpecial]begCode_' .. i, 1)
                    mob:removeListener('JOB_SPECIAL_BEG_' .. i)
                    mob:addListener('JOB_SPECIAL_BEG_' .. i, 'JOB_SPECIAL_BEG_' .. i, v.begCode)
                end

                if type(v.endCode) == 'function' then
                    mob:setLocalVar('[jobSpecial]endCode_' .. i, 1)
                    mob:removeListener('JOB_SPECIAL_END_' .. i)
                    mob:addListener('JOB_SPECIAL_END_' .. i, 'JOB_SPECIAL_END_' .. i, v.endCode)
                end
            end
        end

        mob:setLocalVar('[jobSpecial]numAbilities', i)
    end
end

--[[ ----------------------------------------------------------------
    return table of abilities mob is ready to use
---------------------------------------------------------------- --]]

local abilitiesReady = function(mob)
    local abilities = {}
    local now = os.time()
    local readyTime = mob:getLocalVar('[jobSpecial]readyInitial')

    if
        readyTime > 0 and
        now > readyTime and
        now > mob:getLocalVar('[jobSpecial]cooldown')
    then
        local numAbilities = mob:getLocalVar('[jobSpecial]numAbilities')

        for i = 1, numAbilities do
            if
                now > mob:getLocalVar('[jobSpecial]cooldown_' .. i) and
                mob:getHPP() <= mob:getLocalVar('[jobSpecial]hpp_' .. i)
            then
                table.insert(abilities, i)
            end
        end
    end

    return abilities
end

--[[ ----------------------------------------------------------------
    mob listeners
---------------------------------------------------------------- --]]

g_mixins.job_special = function(jobSpecialMob)
    -- At spawn, give mob its default main job 2hr, which it'll use at 40-60% HP.
    -- these defaults can be overwritten by using xi.mix.jobSpecial.config() in onMobSpawn.

    jobSpecialMob:addListener('SPAWN', 'JOB_SPECIAL_SPAWN', function(mob)
        local mJob    = mob:getMainJob()
        local ability = job2hr[mJob]

        if mJob == xi.job.RNG then
            ability = familyEES[mob:getFamily()]
        elseif mJob == xi.job.SMN and mob:isInDynamis() then
            ability = xi.jsa.ASTRAL_FLOW_MAAT
        end

        if ability then
            mob:setLocalVar('[jobSpecial]numAbilities', 1)
            mob:setLocalVar('[jobSpecial]ability_1', ability)
            mob:setLocalVar('[jobSpecial]hpp_1', math.random(40, 60))
            mob:setLocalVar('[jobSpecial]between_1', 7200)
        end

        mob:setLocalVar('[jobSpecial]chance', 100)     -- chance that mob will use any special at all during engagement
        mob:setLocalVar('[jobSpecial]delayInitial', 2) -- default wait until mob can use its first special (prevents insta-flow)
    end)

    jobSpecialMob:addListener('ENGAGE', 'JOB_SPECIAL_ENGAGE', function(mob)
        if math.random(100) <= mob:getLocalVar('[jobSpecial]chance') then
            mob:setLocalVar('[jobSpecial]readyInitial', os.time() + mob:getLocalVar('[jobSpecial]delayInitial'))
        end
    end)

    jobSpecialMob:addListener('COMBAT_TICK', 'JOB_SPECIAL_CTICK', function(mob)
        local abilities = abilitiesReady(mob)

        if #abilities > 0 then
            local i = abilities[math.random(#abilities)]
            local ability = mob:getLocalVar('[jobSpecial]ability_' .. i)
            local now = os.time()

            if mob:getLocalVar('[jobSpecial]begCode_' .. i) == 1 then
                mob:triggerListener('JOB_SPECIAL_BEG_' .. i, mob)
            end

            mob:useMobAbility(ability)

            local customDuration = mob:getLocalVar('[jobSpecial]duration_' .. i)
            if customDuration > 0 then
                local specialEffect = effectByAbility[ability]
                if specialEffect then
                    local effect = mob:getStatusEffect(specialEffect)
                    if effect then
                        effect:setDuration(customDuration)
                    end
                end
            end

            if mob:getLocalVar('[jobSpecial]endCode_' .. i) == 1 then
                mob:triggerListener('JOB_SPECIAL_END_' .. i, mob)
            end

            mob:setLocalVar('[jobSpecial]cooldown_' .. i, now + mob:getLocalVar('[jobSpecial]between_' .. i)) -- set ability cooldown (wait to use this particular special again)
            mob:setLocalVar('[jobSpecial]cooldown', now + mob:getLocalVar('[jobSpecial]between')) -- set global cooldown (wait between using any specials)
        end
    end)
end

return g_mixins.job_special
