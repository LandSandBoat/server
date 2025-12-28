-----------------------------------
-- Global file for all summons
-----------------------------------
xi = xi or {}
xi.pets = xi.pets or {}
xi.pets.summon = xi.pets.summon or {}
-----------------------------------
-- Summon enums. Note: This aren't their real IDs.
xi.pets.summon.type =
{
    FIRE_SPIRIT    =  1,
    ICE_SPIRIT     =  2,
    AIR_SPIRIT     =  3,
    EARTH_SPIRIT   =  4,
    THUNDER_SPIRIT =  5,
    WATER_SPIRIT   =  6,
    LIGHT_SPIRIT   =  7,
    DARK_SPIRIT    =  8,
    CARBUNCLE      =  9,
    FENRIR         = 10,
    IFRIT          = 11,
    TITAN          = 12,
    LEVIATHAN      = 13,
    GARUDA         = 14,
    SHIVA          = 15,
    RAMUH          = 16,
    DIABOLOS       = 17,
    ALEXANDER      = 18,
    ODIN           = 19,
    ATOMOS         = 20,
    CAIT_SITH      = 21,
    SIREN          = 22,
    -- Add new entries if different expansion summons have different properties.
}

-- Summon associated element.
xi.pets.summon.element =
{
    [xi.pets.summon.type.FIRE_SPIRIT   ] = xi.element.FIRE,
    [xi.pets.summon.type.ICE_SPIRIT    ] = xi.element.ICE,
    [xi.pets.summon.type.AIR_SPIRIT    ] = xi.element.WIND,
    [xi.pets.summon.type.EARTH_SPIRIT  ] = xi.element.EARTH,
    [xi.pets.summon.type.THUNDER_SPIRIT] = xi.element.THUNDER,
    [xi.pets.summon.type.WATER_SPIRIT  ] = xi.element.WATER,
    [xi.pets.summon.type.LIGHT_SPIRIT  ] = xi.element.LIGHT,
    [xi.pets.summon.type.DARK_SPIRIT   ] = xi.element.DARK,
    [xi.pets.summon.type.CARBUNCLE     ] = xi.element.LIGHT,
    [xi.pets.summon.type.FENRIR        ] = xi.element.DARK,
    [xi.pets.summon.type.IFRIT         ] = xi.element.FIRE,
    [xi.pets.summon.type.TITAN         ] = xi.element.EARTH,
    [xi.pets.summon.type.LEVIATHAN     ] = xi.element.WATER,
    [xi.pets.summon.type.GARUDA        ] = xi.element.WIND,
    [xi.pets.summon.type.SHIVA         ] = xi.element.ICE,
    [xi.pets.summon.type.RAMUH         ] = xi.element.THUNDER,
    [xi.pets.summon.type.DIABOLOS      ] = xi.element.DARK,
    [xi.pets.summon.type.ALEXANDER     ] = xi.element.LIGHT,
    [xi.pets.summon.type.ODIN          ] = xi.element.DARK,
    [xi.pets.summon.type.ATOMOS        ] = xi.element.DARK,
    [xi.pets.summon.type.CAIT_SITH     ] = xi.element.LIGHT,
    [xi.pets.summon.type.SIREN         ] = xi.element.WIND,
}

-- Summon associated resistance ranks. Ordered by element order. TODO: Study effect resistance ranks.
xi.pets.summon.resistanceRanks =
{
-- [avatar] = { fire, ice, wind, earth, thunder, water, light, dark }
    [xi.pets.summon.type.FIRE_SPIRIT   ] = { 11, 11,  1,  1,  1, -3,  1,  1 },
    [xi.pets.summon.type.ICE_SPIRIT    ] = { -3, 11, 11,  1,  1,  1,  1,  1 },
    [xi.pets.summon.type.AIR_SPIRIT    ] = {  1, -3, 11, 11,  1,  1,  1,  1 },
    [xi.pets.summon.type.EARTH_SPIRIT  ] = {  1,  1, -3, 11, 11,  1,  1,  1 },
    [xi.pets.summon.type.THUNDER_SPIRIT] = {  1,  1,  1, -3, 11, 11,  1,  1 },
    [xi.pets.summon.type.WATER_SPIRIT  ] = { 11,  1,  1,  1, -3, 11,  1,  1 },
    [xi.pets.summon.type.LIGHT_SPIRIT  ] = {  1,  1,  1,  1,  1,  1, 11, -3 },
    [xi.pets.summon.type.DARK_SPIRIT   ] = {  1,  1,  1,  1,  1,  1, -3, 11 },
    [xi.pets.summon.type.CARBUNCLE     ] = {  1,  1,  1,  1,  1,  1, 11, -3 },
    [xi.pets.summon.type.FENRIR        ] = {  1,  1,  1,  1,  1,  1, -3, 11 },
    [xi.pets.summon.type.IFRIT         ] = { 11, 11,  1,  1,  1, -3,  1,  1 },
    [xi.pets.summon.type.TITAN         ] = {  1,  1, -3, 11, 11,  1,  1,  1 },
    [xi.pets.summon.type.LEVIATHAN     ] = { 11,  1,  1,  1, -3, 11,  1,  1 },
    [xi.pets.summon.type.GARUDA        ] = {  1, -3, 11, 11,  1,  1,  1,  1 },
    [xi.pets.summon.type.SHIVA         ] = { -3, 11, 11,  1,  1,  1,  1,  1 },
    [xi.pets.summon.type.RAMUH         ] = {  1,  1,  1, -3, 11, 11,  1,  1 },
    [xi.pets.summon.type.DIABOLOS      ] = {  1,  1,  1,  1,  1,  1, -3, 11 },
    [xi.pets.summon.type.ALEXANDER     ] = {  1,  1,  1,  1,  1,  1, 11, -3 },
    [xi.pets.summon.type.ODIN          ] = {  1,  1,  1,  1,  1,  1, -3, 11 },
    [xi.pets.summon.type.ATOMOS        ] = {  1,  1,  1,  1,  1,  1, -3, 11 },
    [xi.pets.summon.type.CAIT_SITH     ] = {  1,  1,  1,  1,  1,  1, 11, -3 },
    [xi.pets.summon.type.SIREN         ] = {  1, -3, 11, 11,  1,  1,  1,  1 },
}

xi.pets.summon.modelId =
{
    [xi.pets.summon.type.FIRE_SPIRIT   ] =  8,
    [xi.pets.summon.type.ICE_SPIRIT    ] =  9,
    [xi.pets.summon.type.AIR_SPIRIT    ] = 10,
    [xi.pets.summon.type.EARTH_SPIRIT  ] = 11,
    [xi.pets.summon.type.THUNDER_SPIRIT] = 13,
    [xi.pets.summon.type.WATER_SPIRIT  ] = 12,
    [xi.pets.summon.type.LIGHT_SPIRIT  ] = 14,
    [xi.pets.summon.type.DARK_SPIRIT   ] = 15,
    [xi.pets.summon.type.CARBUNCLE     ] =  0,
    [xi.pets.summon.type.FENRIR        ] =  0,
    [xi.pets.summon.type.IFRIT         ] =  0,
    [xi.pets.summon.type.TITAN         ] =  0,
    [xi.pets.summon.type.LEVIATHAN     ] =  0,
    [xi.pets.summon.type.GARUDA        ] =  0,
    [xi.pets.summon.type.SHIVA         ] =  0,
    [xi.pets.summon.type.RAMUH         ] =  0,
    [xi.pets.summon.type.DIABOLOS      ] =  0,
    [xi.pets.summon.type.ALEXANDER     ] =  0,
    [xi.pets.summon.type.ODIN          ] =  0,
    [xi.pets.summon.type.ATOMOS        ] =  0,
    [xi.pets.summon.type.CAIT_SITH     ] =  0,
    [xi.pets.summon.type.SIREN         ] =  0,
}

xi.pets.summon.spellListId =
{
    [xi.pets.summon.type.FIRE_SPIRIT   ] = 17,
    [xi.pets.summon.type.ICE_SPIRIT    ] = 14,
    [xi.pets.summon.type.AIR_SPIRIT    ] = 12,
    [xi.pets.summon.type.EARTH_SPIRIT  ] = 13,
    [xi.pets.summon.type.THUNDER_SPIRIT] = 16,
    [xi.pets.summon.type.WATER_SPIRIT  ] = 15,
    [xi.pets.summon.type.LIGHT_SPIRIT  ] = 19,
    [xi.pets.summon.type.DARK_SPIRIT   ] = 18,
    [xi.pets.summon.type.CARBUNCLE     ] =  0,
    [xi.pets.summon.type.FENRIR        ] =  0,
    [xi.pets.summon.type.IFRIT         ] =  0,
    [xi.pets.summon.type.TITAN         ] =  0,
    [xi.pets.summon.type.LEVIATHAN     ] =  0,
    [xi.pets.summon.type.GARUDA        ] =  0,
    [xi.pets.summon.type.SHIVA         ] =  0,
    [xi.pets.summon.type.RAMUH         ] =  0,
    [xi.pets.summon.type.DIABOLOS      ] =  0,
    [xi.pets.summon.type.ALEXANDER     ] =  0,
    [xi.pets.summon.type.ODIN          ] =  0,
    [xi.pets.summon.type.ATOMOS        ] =  0,
    [xi.pets.summon.type.CAIT_SITH     ] =  0,
    [xi.pets.summon.type.SIREN         ] =  0,
}

xi.pets.summon.setupSummon = function(mob, summonTable)
    local chosenSummon = summonTable[math.random(1, #summonTable)]

    -- Sets the spell list and model
    mob:setSpellList(xi.pets.summon.spellListId[chosenSummon])
    mob:setModelId(xi.pets.summon.modelId[chosenSummon])

    -- Apply resistance ranks
    for element = xi.element.FIRE, xi.element.DARK do
        local resistanceRankMod   = xi.data.element.getElementalResistanceRankModifier(element)
        local resistanceRankValue = xi.pets.summon.resistanceRanks[chosenSummon][element]
        mob:setMod(resistanceRankMod, resistanceRankValue)
    end
end
