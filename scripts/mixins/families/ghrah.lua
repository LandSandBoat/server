-----------------------------------
--- Ghrah Family Mixin
--  https://ffxiclopedia.fandom.com/wiki/Category:Ghrah
--  https://www.bg-wiki.com/ffxi/Category:Ghrah
--  Ghrahs change form to spider (WAR), bird (THF), or human (PLD) and back to ball (BLM) every 60 seconds.
--  Each form has different stats and a unique skill.
-----------------------------------
require('scripts/globals/mixins')
local palaceID = zones[xi.zone.GRAND_PALACE_OF_HUXZOI]
local gardenID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
-----------------------------------
g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local mobFormLookup = {}

-- Initialize lookup tables
local function initializeLookupTables()
    -- Already initialized
    if next(mobFormLookup) then
        return
    end

    -- Palace bird forms
    if palaceID and palaceID.mob.EOGHRAH_BIRD then
        for _, mobId in pairs(palaceID.mob.EOGHRAH_BIRD) do
            mobFormLookup[mobId] = 3 -- Bird form
        end
    end

    -- Palace spider forms
    if palaceID and palaceID.mob.EOGHRAH_SPIDER then
        for _, mobId in pairs(palaceID.mob.EOGHRAH_SPIDER) do
            mobFormLookup[mobId] = 2 -- Spider form
        end
    end

    -- Garden bird forms
    if gardenID and gardenID.mob.AWGHRAH_BIRD then
        for _, mobId in pairs(gardenID.mob.AWGHRAH_BIRD) do
            mobFormLookup[mobId] = 3 -- Bird form
        end
    end

    -- Garden spider forms
    if gardenID and gardenID.mob.AWGHRAH_SPIDER then
        for _, mobId in pairs(gardenID.mob.AWGHRAH_SPIDER) do
            mobFormLookup[mobId] = 2 -- Spider form
        end
    end

    -- Garden human forms
    if gardenID and gardenID.mob.AWGHRAH_HUMAN then
        for _, mobId in pairs(gardenID.mob.AWGHRAH_HUMAN) do
            mobFormLookup[mobId] = 1 -- Human form
        end
    end
end

local skinConfig = {
    [1161] = { -- Fire
        spellList = 484,
        mods = {
            { xi.mod.FIRE_RES_RANK,     11 },
            { xi.mod.ICE_RES_RANK,      11 },
            { xi.mod.WATER_RES_RANK,    -3 },
            { xi.mod.PARALYZE_RES_RANK, 11 },
            { xi.mod.BIND_RES_RANK,     11 },
            { xi.mod.POISON_RES_RANK,   -3 }
        }
    },
    [1162] = { -- Ice
        spellList = 479,
        mods = {
            { xi.mod.ICE_RES_RANK,      11 },
            { xi.mod.WIND_RES_RANK,     11 },
            { xi.mod.FIRE_RES_RANK,     -3 },
            { xi.mod.SILENCE_RES_RANK,  11 },
            { xi.mod.PARALYZE_RES_RANK, 11 },
            { xi.mod.BIND_RES_RANK,     11 }
        }
    },
    [1163] = { -- Wind
        spellList = 480,
        mods = {
            { xi.mod.WIND_RES_RANK,     11 },
            { xi.mod.EARTH_RES_RANK,    11 },
            { xi.mod.ICE_RES_RANK,      -3 },
            { xi.mod.SLOW_RES_RANK,     11 },
            { xi.mod.SILENCE_RES_RANK,  11 },
            { xi.mod.PARALYZE_RES_RANK, -3 },
            { xi.mod.BIND_RES_RANK,     -3 }
        }
    },
    [1164] = { -- Earth
        spellList = 481,
        mods = {
            { xi.mod.EARTH_RES_RANK,   11 },
            { xi.mod.THUNDER_RES_RANK, 11 },
            { xi.mod.WIND_RES_RANK,    -3 },
            { xi.mod.SLOW_RES_RANK,    11 },
            { xi.mod.SILENCE_RES_RANK, -3 }
        }
    },
    [1165] = { -- Lightning
        spellList = 482,
        mods = {
            { xi.mod.THUNDER_RES_RANK, 11 },
            { xi.mod.WATER_RES_RANK,   11 },
            { xi.mod.EARTH_RES_RANK,   -3 },
            { xi.mod.POISON_RES_RANK,  11 },
            { xi.mod.SLOW_RES_RANK,    -3 }
        }
    },
    [1166] = { -- Water
        spellList = 483,
        mods = {
            { xi.mod.WATER_RES_RANK,   11 },
            { xi.mod.FIRE_RES_RANK,    11 },
            { xi.mod.THUNDER_RES_RANK, -3 },
            { xi.mod.POISON_RES_RANK,  11 }
        }
    },
    [1167] = { -- Light
        spellList = 478,
        mods = {
            { xi.mod.LIGHT_RES_RANK,       11 },
            { xi.mod.DARK_RES_RANK,        -3 },
            { xi.mod.LIGHT_SLEEP_RES_RANK, 11 },
            { xi.mod.DARK_SLEEP_RES_RANK,  -3 },
            { xi.mod.BLIND_RES_RANK,       -3 }
        }
    },
    [1168] = { -- Dark
        spellList = 477,
        mods = {
            { xi.mod.DARK_RES_RANK,        11 },
            { xi.mod.LIGHT_RES_RANK,       -3 },
            { xi.mod.DARK_SLEEP_RES_RANK,  11 },
            { xi.mod.BLIND_RES_RANK,       11 },
            { xi.mod.LIGHT_SLEEP_RES_RANK, -3 },
        }
    }
}

-- Ghrah form determination using lookup table
-- Ball form (0) is default, Human (1), Spider (2), Bird (3)
local function getTargetForm(mob)
    return mobFormLookup[mob:getID()] or 0 -- Default to ball form if not found
end

local function initializeOriginalMods(mob)
    if mob:getLocalVar('originalATT') == 0 then
        mob:setLocalVar('originalATT', mob:getMod(xi.mod.ATT))
        mob:setLocalVar('originalDEF', mob:getMod(xi.mod.DEF))
        mob:setLocalVar('originalEVA', mob:getMod(xi.mod.EVA))
    end
end

local function switchMobForm(mob, form, aggressive)
    local originalAtt = mob:getLocalVar('originalATT')
    local originalDef = mob:getLocalVar('originalDEF')
    local originalEva = mob:getLocalVar('originalEVA')

    -- Reset to base stats first
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 0)
    mob:setMod(xi.mod.ATT, originalAtt)
    mob:setMod(xi.mod.DEF, originalDef)
    mob:setMod(xi.mod.EVA, originalEva)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 0)

    -- Apply form-specific modifications
    if form == 1 then
        -- Human form
        -- Has a 100% increase to DEF plus equivalent PLD defense bonus
        mob:setMod(xi.mod.DEF, originalDef * 2 + 60)
    elseif form == 2 then
        -- Spider form
        -- ATT and DEF traits equivalent to 75 WAR
        mob:setMobMod(xi.mobMod.WEAPON_BONUS, mob:getMainLvl() + 2)
        mob:setMod(xi.mod.ATT, originalAtt + 11)
        mob:setMod(xi.mod.DEF, originalDef + 11)
    elseif form == 3 then
        -- Bird form
        -- EVA and Triple Attack equivalent to 75 THF
        mob:setMod(xi.mod.EVA, originalEva + 48)
        mob:setMod(xi.mod.TRIPLE_ATTACK, 5)
    end

    mob:setAggressive(aggressive)
    mob:setAnimationSub(form)
end

-- Consolidated form change logic
local function handleFormChange(mob)
    local changeTime = mob:getLocalVar('changeTime')
    local currentTime = GetSystemTime()
    local currentForm = mob:getAnimationSub()

    if currentTime > changeTime then
        local targetForm = mob:getLocalVar('targetForm') or 0 -- Use cached target form
        if currentForm == 0 then
            switchMobForm(mob, targetForm, true)
        else
            switchMobForm(mob, 0, false)
        end

        mob:setLocalVar('changeTime', currentTime + 60)
    end
end

g_mixins.families.ghrah = function(ghrahMob)
    initializeLookupTables() -- Initialize lookup tables once

    ghrahMob:addListener('SPAWN', 'GHRAH_SPAWN', function(mob)
        local skin = math.random(1161, 1168)
        mob:setModelId(skin)
        mob:setAnimationSub(0)
        mob:setAggressive(false)
        mob:setLocalVar('changeTime', GetSystemTime() + math.random(40, 60)) -- Stagger first change
        mob:setLocalVar('targetForm', getTargetForm(mob))
        mob:addMod(xi.mod.MATT, 20) -- Ghrah have innate +20 MATT on top of BLM bonuses
        mob:addMod(xi.mod.DMGMAGIC, -1250)
        mob:addMod(xi.mod.MDEF, 20)
        mob:setMobMod(xi.mobMod.NO_SPELL_COST, 1)
        initializeOriginalMods(mob)

        local config = skinConfig[skin]
        if config then
            mob:setSpellList(config.spellList)
            for _, modData in ipairs(config.mods) do
                mob:setMod(modData[1], modData[2])
            end
        end
    end)

    ghrahMob:addListener('ROAM_TICK', 'GHRAH_TICK', function(mob)
        handleFormChange(mob)
    end)

    ghrahMob:addListener('COMBAT_TICK', 'GHRAH_COMBAT', function(mob)
        if not xi.combat.behavior.isEntityBusy(mob) then
            handleFormChange(mob)
        end
    end)
end

return g_mixins.families.ghrah
