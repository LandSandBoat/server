-----------------------------------
-- How it works : On spawn, the mob picks one of its allowed pet types at random.
-- It then changes its model, spell list, and elemental resistance ranks accordingly.
-----------------------------------

g_mixins = g_mixins or {}

g_mixins.pet_summon_setup = function(mob)
    mob:addListener('SPAWN', 'SUMMON_SPAWN', function(mobArg)
        -- Fetches the possible elements for this mob
        local summonBitmask = mobArg:getLocalVar('[Summon]mask')
        local summonTable = {}
        for i = 1, #xi.pets.summon.type do
            if utils.mask.getBit(summonBitmask, i) then
                table.insert(summonTable, i)
            end
        end

        -- Pick a random summon.
        local chosenSummon = summonTable[math.random(1, #summonTable)]

        -- Sets the spell list and model
        mobArg:setSpellList(xi.pets.summon.spellListId[chosenSummon])
        mobArg:setModelId(xi.pets.summon.modelId[chosenSummon])

        -- Apply resistance ranks
        for element = xi.element.FIRE, xi.element.DARK do
            local resistanceRankMod   = xi.data.element.getElementalResistanceRankModifier(element)
            local resistanceRankValue = xi.pets.summon.resistanceRanks[chosenSummon][element]
            mobArg:setMod(resistanceRankMod, resistanceRankValue)
        end
    end)
end

return g_mixins.pet_summon_setup
