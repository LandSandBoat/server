-----------------------------------
-- Area : Chamber of Oracles
-- Mob  : Hoplomachus XI-XXVI
-- BCNM : Legion XI Comitatensis
-- Job  : Paladin
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

local buffTable =
{
    [1] = { xi.magic.spell.PROTECT_III, xi.effect.PROTECT },
    [2] = { xi.magic.spell.SHELL_III,   xi.effect.SHELL   },
}

local groupTable =
{
    [1] = -2, -- Secutor XI-XXXII
    [2] = -1, -- Retiarius XI-XIX
    [3] =  0, -- Hoplamachus XI-XXVI
    [4] =  1, -- Centurio XI-I
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 8)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 8)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        { xi.magic.spell.BANISH_II, target },
        { xi.magic.spell.FLASH,     target },
    }

    local baseMobId = mob:getID()

    -- Check for missing buffs on self and allies
    for i = 1, #buffTable do
        local buffTargets = {}

        for j = 1, #groupTable do
            local allyEntity = GetMobByID(baseMobId + groupTable[j])
            if
                allyEntity and
                allyEntity:isAlive() and
                not allyEntity:hasStatusEffect(buffTable[i][2])
            then
                table.insert(buffTargets, allyEntity)
            end
        end

        -- Adds each missing buff to the spell list one time with a random target that is missing it
        if #buffTargets > 0 then
            table.insert(spellList,
            {
                buffTable[i][1],
                buffTargets[math.random(#buffTargets)],
            })
        end
    end

    -- Check for low HP allies to heal (33% or lower)
    for j = 1, #groupTable do
        local allyEntity = GetMobByID(baseMobId + groupTable[j])
        if
            allyEntity and
            allyEntity:isAlive() and
            allyEntity:getHPP() <= 33
        then
            table.insert(spellList, { xi.magic.spell.CURE_IV, allyEntity })
        end
    end

    -- Pick a random spell from the compiled list
    local randomEntry   = math.random(1, #spellList)
    local spellIdChosen = spellList[randomEntry][1]
    local entityChosen  = spellList[randomEntry][2]

    return spellIdChosen, entityChosen
end

return entity
