-----------------------------------
-- Module: Beastmaster Job Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_job_utils_beastmaster'
local m = Module:new(moduleName)

if not xi.module.isContentEnabled('ABYSSEA') then
    -- Reward: Override pet food healing values to pre-Abyssea values
    -- Source: https://www.bg-wiki.com/ffxi/Version_Update_(09/08/2010)
    xi.job_utils.beastmaster.petFoodData =
    {
        [xi.item.PET_FOOD_ALPHA_BISCUIT]   = { minHealing =  25, regen =  1, mndMult = 2, mndThreshold = 10 },
        [xi.item.PET_FOOD_BETA_BISCUIT]    = { minHealing =  50, regen =  3, mndMult = 1, mndThreshold = 33 },
        [xi.item.PET_FOOD_GAMMA_BISCUIT]   = { minHealing = 100, regen =  5, mndMult = 1, mndThreshold = 35 },
        [xi.item.PET_FOOD_DELTA_BISCUIT]   = { minHealing = 150, regen =  8, mndMult = 2, mndThreshold = 40 },
        [xi.item.PET_FOOD_EPSILON_BISCUIT] = { minHealing = 300, regen = 11, mndMult = 2, mndThreshold = 45 },
        [xi.item.PET_FOOD_ZETA_BISCUIT]    = { minHealing = 350, regen = 14, mndMult = 3, mndThreshold = 45 },
    }

    -- Feral Howl: Apply merit recast reduction, remove extra accuracy from merits
    m:addOverride('xi.job_utils.beastmaster.useFeralHowl', function(player, target, ability, action)
        local recastReduction = player:getMerit(xi.merit.FERAL_HOWL) - 150
        action:setRecast(action:getRecast() - recastReduction)

        if
            not xi.data.statusEffect.isTargetImmune(target, xi.effect.TERROR, xi.element.DARK) and
            not xi.data.statusEffect.isTargetResistant(player, target, xi.effect.TERROR) and
            not xi.data.statusEffect.isEffectNullified(target, xi.effect.TERROR, 0)
        then
            local resistanceRate = xi.combat.magicHitRate.calculateResistRate(player, target, 0, 0, xi.skillRank.B_MINUS, xi.element.DARK, xi.mod.CHR, xi.effect.TERROR)

            if xi.data.statusEffect.isResistRateSuccessfull(xi.effect.TERROR, resistanceRate, 0) then
                target:addStatusEffect(xi.effect.TERROR, { power = 1, duration = 10 * resistanceRate, origin = player })
            end
        end

        return xi.effect.TERROR
    end)

    -- Killer Insinct: Apply merit recast reduction, remove extra duration from merits
    m:addOverride('xi.job_utils.beastmaster.useKillerInstinct', function(player, target, ability, action)
        local recastReduction = player:getMerit(xi.merit.KILLER_INSTINCT) - 150
        action:setRecast(action:getRecast() - recastReduction)

        -- Notes: Pet ecosystem is assigned to the subPower, then mapped to the correct killer mod in the effect script.
        local pet          = player:getPet()
        local petEcosystem = pet:getEcosystem()
        local power        = 10

        target:addStatusEffect(xi.effect.KILLER_INSTINCT, { power = power, duration = 60, origin = player, subPower = petEcosystem })

        return xi.effect.KILLER_INSTINCT
    end)
end

if not xi.module.isContentEnabled('WOTG') then
    -- Jug pet skill lists mapped to mob species for utilization in Sic.
    -- Baseline skill lists in mob_skill_list.sql for jugs map to pet_skill.sql for use in "Ready"
    -- This breaks when reverting to Sic, causing jug pets to use the wrong skills
    local jugSkillLists =
    {
        [xi.mobSpecies.RABBIT]       = 206,
        [xi.mobSpecies.SHEEP]        = 226,
        [xi.mobSpecies.CRAB]         = 372,
        [xi.mobSpecies.MANDRAGORA]   = 903,
        [xi.mobSpecies.TIGER]        = 242,
        [xi.mobSpecies.FLYTRAP]      = 114,
        [xi.mobSpecies.HILL_LIZARD]  = 174,
        [xi.mobSpecies.FLY]          = 113,
        [xi.mobSpecies.EFT]          =  98,
        [xi.mobSpecies.FUNGUAR]      = 116,
        [xi.mobSpecies.BEETLE]       =  49,
        [xi.mobSpecies.ANTLION]      =  26,
        [xi.mobSpecies.DIREMITE]     =  81,
        [xi.mobSpecies.SABOTENDER]   = 939,
    }

    -- Jug Pets: Applies a skill list on spawn of pet to properly utilize Sic.
    -- Source: https://www.bg-wiki.com/ffxi/Version_Update_(11/09/2009)
    m:addOverride('xi.job_utils.beastmaster.useCallBeast', function(player, target, ability, action)
        super(player, target, ability, action)

        local pet = player:getPet()
        if pet then
            local listId = jugSkillLists[pet:getSpecies()]
            if listId then
                pet:setMobMod(xi.mobMod.SKILL_LIST, listId)
            end
        end
    end)
end

-- Return a real module only when a content gate registered overrides.
-- Otherwise return a data-only table to avoid a "No overrides found" loader warning.
if #m.overrides > 0 then
    return m
end

return { name = moduleName }
