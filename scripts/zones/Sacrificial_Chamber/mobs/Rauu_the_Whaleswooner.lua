-----------------------------------
-- Area: Sacrificial Chamber
--  Mob: Rauu the Whaleswooner
-- BCNM: Amphibian Assault
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

local removableTable =
{
    [1] = { xi.magic.spell.BLINDNA,  xi.effect.BLINDNESS },
    [2] = { xi.magic.spell.PARALYNA, xi.effect.PARALYSIS },
    [3] = { xi.magic.spell.POISONA,  xi.effect.POISON    },
    [4] = { xi.magic.spell.SILENA,   xi.effect.SILENCE   },
    [5] = { xi.magic.spell.VIRUNA,   xi.effect.DISEASE   },
    [6] = { xi.magic.spell.VIRUNA,   xi.effect.PLAGUE    },
}

local buffTable =
{
    [1] = { xi.magic.spell.HASTE,       xi.effect.HASTE   },
    [2] = { xi.magic.spell.PROTECT_III, xi.effect.PROTECT },
    [3] = { xi.magic.spell.SHELL_III,   xi.effect.SHELL   },
}

local enfeebleTable =
{
    [1] = { xi.magic.spell.DIA_II,   xi.effect.DIA       },
    [2] = { xi.magic.spell.PARALYZE, xi.effect.PARALYSIS },
    [3] = { xi.magic.spell.SILENCE,  xi.effect.SILENCE   },
}

local groupTable =
{
    [1] = -1, -- Qull the Fallstopper
    [2] =  0, -- Rauu the Whaleswooner
    [3] =  1, -- Hyohh the Conchblower
    [4] =  2, -- Pevv the Riverleaper
}

local casterJobTable =
set
{
    xi.job.WHM,
    xi.job.BLM,
    xi.job.RDM,
    xi.job.PLD,
    xi.job.DRK,
    xi.job.BRD,
    xi.job.NIN,
    xi.job.SMN,
    xi.job.BLU,
    xi.job.SCH,
    xi.job.GEO,
    xi.job.RUN,
}

local function isCaster(target)
    local mainJob = target:getMainJob()
    local subjob  = target:getSubJob()

    if casterJobTable[mainJob] or casterJobTable[subjob] then
        return true
    end

    return false
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 4)
    mob:setMod(xi.mod.LIGHT_RES_RANK, 4)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        { xi.magic.spell.BANISH_II, target },
    }

    local baseMobId = mob:getID()

    -- Check for Aquaveil on self
    if not mob:hasStatusEffect(xi.effect.AQUAVEIL) then
        table.insert(spellList, { xi.magic.spell.AQUAVEIL, mob })
    end

    -- Check for debuffs to remove on self and allies, with Silena on the bard only
    for i = 1, #removableTable do
        local effectId = removableTable[i][2]

        for j = 1, #groupTable do
            local allyEntity = GetMobByID(baseMobId + groupTable[j])
            if
                allyEntity and
                allyEntity:isAlive() and
                allyEntity:hasStatusEffect(effectId) and
                (effectId ~= xi.effect.SILENCE or groupTable[j] == 1)
            then
                table.insert(spellList, { removableTable[i][1], allyEntity })
            end
        end
    end

    -- Check for missing buffs on self and allies
    for i = 1, #buffTable do
        for j = 1, #groupTable do
            local allyEntity = GetMobByID(baseMobId + groupTable[j])
            if
                allyEntity and
                allyEntity:isAlive() and
                not allyEntity:hasStatusEffect(buffTable[i][2])
            then
                table.insert(spellList, { buffTable[i][1], allyEntity })
            end
        end
    end

    -- Check for missing enfeebles on the target, check targets job to determine Silence
    for i = 1, #enfeebleTable do
        local effectId = enfeebleTable[i][2]

        if
            not target:hasStatusEffect(effectId) and
            (effectId ~= xi.effect.SILENCE or isCaster(target))
        then
            table.insert(spellList, { enfeebleTable[i][1], target })
        end
    end

    -- Check for severely wounded allies to heal
    local woundedCount = 0

    for j = 1, #groupTable do
        local allyEntity = GetMobByID(baseMobId + groupTable[j])
        if
            allyEntity and
            allyEntity:isAlive() and
            allyEntity:getHPP() <= 33
        then
            table.insert(spellList, { xi.magic.spell.CURE_V, allyEntity })
            woundedCount = woundedCount + 1
        end
    end

    -- Curaga II if at least one ally is wounded
    if woundedCount >= 1 then
        table.insert(spellList, { xi.magic.spell.CURAGA_II, mob })
    end

    -- Pick a random spell from the compiled list
    local randomEntry   = math.random(1, #spellList)
    local spellIdChosen = spellList[randomEntry][1]
    local entityChosen  = spellList[randomEntry][2]

    return spellIdChosen, entityChosen
end

return entity
