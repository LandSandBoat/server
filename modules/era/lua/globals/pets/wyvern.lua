-----------------------------------
-- Module: Wyvern Adjustments
-- Description: Various overrides for wyvern related changes.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_wyvern_adjustments')

m:addOverrideByEra('xi.pets.wyvern.onPetStatCalculate', {
    -- Wyvern Breath: Show readying animation to match the reverted 3-second prepare time
    -- Source: https://forum.square-enix.com/ffxi/threads/44090-Sep-9-2014-%28JST%29-Version-Update
    [xi.expansion.SOA] = function(master, pet)
        super(master, pet)

        -- TODO: Might want to convert this to a mobmMod at some point.
        pet:addMod(xi.mod.WYVERN_SHOW_READYING, 1)
    end,

    -- Wyvern Spawn: Revert innate -40% DT and reduce status breath table
    -- DT Source: https://www.bg-wiki.com/ffxi/Version_Update_(09/19/2011)
    -- Status Breath Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
    [xi.expansion.ABYSSEA] = function(master, pet)
        super(master, pet)

        -- Revert innate -40% DT
        pet:setMod(xi.mod.DMG, 0)

        -- Wyvern subtle blow got increased at some point. Need to research older videos/data captures for era values.
    end,
})

m:addOverrideByEra('xi.pets.wyvern.onMobSpawn', {
    -- Wyvern Spawn: Reduce status breath table
    -- Status Breath Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
    [xi.expansion.ABYSSEA] = function(mob)
        super(mob)

        local master = mob:getMaster()

        -- Determine if wyvern is DEFENSIVE type (status breath on WS)
        local defensiveJobs =
        {
            [xi.job.WHM] = true,
            [xi.job.BLM] = true,
            [xi.job.RDM] = true,
            [xi.job.SMN] = true,
            [xi.job.BLU] = true,
            [xi.job.SCH] = true,
            [xi.job.GEO] = true,
        }

        if defensiveJobs[master:getSubJob()] then
            -- Replace WS listener with pre-2012 status breath table
            master:removeListener('PET_WYVERN_WS')

            local removeBreathTable =
            {
                { 40, xi.jobAbility.REMOVE_PARALYSIS, { xi.effect.PARALYSIS } },
                { 20, xi.jobAbility.REMOVE_BLINDNESS, { xi.effect.BLINDNESS } },
                {  1, xi.jobAbility.REMOVE_POISON,    { xi.effect.POISON    } },
            }

            local breathRange = 14

            local function doStatusBreath(target, player)
                local wyvern = player:getPet()

                for _, v in pairs(removeBreathTable) do
                    local minLevel = v[1]
                    local ability  = v[2]
                    local statuses = v[3]

                    if wyvern:getMainLvl() >= minLevel then
                        for _, effect in pairs(statuses) do
                            if
                                target:hasStatusEffect(effect) and
                                wyvern:checkDistance(target) <= breathRange
                            then
                                wyvern:usePetAbility(ability, target)

                                return true
                            end
                        end
                    end
                end

                return false
            end

            master:addListener('WEAPONSKILL_USE', 'PET_WYVERN_WS', function(player, target, skillid)
                if not doStatusBreath(player, player) then
                    local party = player:getParty()
                    for _, member in pairs(party) do
                        if doStatusBreath(member, player) then
                            break
                        end
                    end
                end
            end)
        end
    end,

    -- Wyvern Spawn: Remove EXPERIENCE_POINTS listener that feeds wyvern EXP system
    [xi.expansion.WOTG] = function(mob)
        super(mob)

        local master = mob:getMaster()
        master:removeListener('PET_WYVERN_EXP')
    end,
})

-- Wyvern Level Removal: Match addWyvernExp by omitting ALL_WSDMG_ALL_HITS
m:addOverrideByEra('xi.pets.wyvern.removeWyvernLevels', {
    [xi.expansion.ROV] = function(mob)
        local master  = mob:getMaster()
        local numLvls = mob:getLocalVar('level_Ups')

        if numLvls ~= 0 then
            local wyvernAttributeIncreaseEffectJP = master:getJobPointLevel(xi.jp.WYVERN_ATTR_BONUS)
            local wyvernBonusDA = master:getMod(xi.mod.WYVERN_ATTRIBUTE_DA)

            master:delMod(xi.mod.ATT, wyvernAttributeIncreaseEffectJP * numLvls)
            master:delMod(xi.mod.DEF, wyvernAttributeIncreaseEffectJP * numLvls)
            master:delMod(xi.mod.ATTP, 4 * numLvls)
            master:delMod(xi.mod.DEFP, 4 * numLvls)
            master:delMod(xi.mod.HASTE_ABILITY, 200 * numLvls)
            master:delMod(xi.mod.DOUBLE_ATTACK, wyvernBonusDA * numLvls)
        end
    end,
})
