-----------------------------------
-- Automaton Pet Global Era Module
-----------------------------------
require('modules/module_utils')
require('scripts/globals/pets/automaton')
-----------------------------------
local m = Module:new('automaton_pet')

-- Sets Maneuver Duration back to 60 seconds, without scaling time while in combat : https://wiki.ffo.jp/html/32936.html
m:addOverrideByEra('xi.pets.automaton.onMobSpawn', {
    [xi.expansion.SOA] = function(mob)
        super(mob)
        mob:removeListener('MANEUVER_DURATION')
    end,
})

-- Reduces HP of Automatons to Pre-2015 Values : https://wiki.ffo.jp/html/33858.html
local frameHPMultipliers =
{
    [xi.automaton.frame.HARLEQUIN ] = 0.705, -- 29.5% less HP
    [xi.automaton.frame.VALOREDGE ] = 0.740, -- 26.0% less HP
    [xi.automaton.frame.SHARPSHOT ] = 0.700, -- 30.0% less HP
    [xi.automaton.frame.STORMWAKER] = 0.690, -- 31.0% less HP
}

local function applyEraFrameHPReductions()
    for frame, hpMultiplier in pairs(frameHPMultipliers) do
        local frameData = xi.pets.automaton.frameStats[frame]
        if frameData then
            for _, levelData in pairs(frameData) do
                if levelData.maxHP then
                    levelData.maxHP = math.floor(levelData.maxHP * hpMultiplier)
                end
            end
        end
    end
end

m:addOverrideByEra('xi.server.onServerStart', {
    [xi.expansion.SOA] = function()
        super()

        applyEraFrameHPReductions()
    end,

    [xi.expansion.ABYSSEA] = function()
        super()

        -- Adds Frame Specific DT Taken Modifiers. / Removes Valoredge Block : https://wiki.ffo.jp/html/19739.html / https://wiki.ffo.jp/html/31705.html
        xi.pets.automaton.frameMods[xi.automaton.frame.HARLEQUIN] =
        {
            mods =
            {
                { xi.mod.DMG,  -625 },
                { xi.mod.DEFP,   20 },
            },
        }

        xi.pets.automaton.frameMods[xi.automaton.frame.VALOREDGE] =
        {
            mods =
            {
                { xi.mod.DMG, -1250 },
                { xi.mod.DEFP,   50 },
            },
        }

        xi.pets.automaton.frameMods[xi.automaton.frame.SHARPSHOT] =
        {
            mods =
            {
                { xi.mod.PIERCE_SDT,  8750 },
                { xi.mod.DMGBREATH,  -1250 },
                { xi.mod.DMGMAGIC,   -1250 },
                { xi.mod.DEFP,          10 },
            },
        }

        xi.pets.automaton.frameMods[xi.automaton.frame.STORMWAKER] =
        {
            mods =
            {
                { xi.mod.DMGBREATH, -2500 },
                { xi.mod.DMGMAGIC,  -2500 },
            },
        }

        -- Era skill caps: Valoredge, Sharpshot, and Stormwaker heads only grant a 1 rank skill bonus. : https://wiki.ffo.jp/html/32037.html
        xi.pets.automaton.skillCaps.heads[xi.automaton.head.VALOREDGE ][xi.skill.AUTOMATON_MELEE ] = -1
        xi.pets.automaton.skillCaps.heads[xi.automaton.head.SHARPSHOT ][xi.skill.AUTOMATON_RANGED] = -1
        xi.pets.automaton.skillCaps.heads[xi.automaton.head.STORMWAKER][xi.skill.AUTOMATON_MAGIC ] = -1
    end,

    [xi.expansion.WOTG] = function()
        super()

        -- Removes Frame Specific DT Taken Modifiers for Automaton Frames & Removes Valoredge Block : https://wiki.ffo.jp/html/19739.html / https://wiki.ffo.jp/html/31705.html
        xi.pets.automaton.frameMods[xi.automaton.frame.HARLEQUIN] =
        {
            mods =
            {
                { xi.mod.DEFP, 20 },
            },
        }

        xi.pets.automaton.frameMods[xi.automaton.frame.VALOREDGE] =
        {
            mods =
            {
                { xi.mod.DEFP, 50 },
            },
        }

        xi.pets.automaton.frameMods[xi.automaton.frame.SHARPSHOT] =
        {
            mods =
            {
                { xi.mod.DEFP, 10 },
            },
        }

        xi.pets.automaton.frameMods[xi.automaton.frame.STORMWAKER] = {}
    end,
})
