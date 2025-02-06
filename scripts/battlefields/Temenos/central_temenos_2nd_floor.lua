-----------------------------------
-- Area: Temenos
-- Name: Central Temenos 1st Floor
-- !addkeyitem white_card
-- !addkeyitem cosmo_cleanse
-- !additem scarlet_chip
-- !pos 580.000 -2.375 104.000 37
-----------------------------------
local ID = zones[xi.zone.TEMENOS]
-----------------------------------

local content = Limbus:new({
    zoneId           = xi.zone.TEMENOS,
    battlefieldId    = xi.battlefield.id.CENTRAL_TEMENOS_2ND_FLOOR,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(45),
    index            = 5,
    area             = 6,
    entryNpc         = 'Matter_Diffusion_Module',
    requiredKeyItems = { xi.ki.COSMO_CLEANSE, xi.ki.WHITE_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    requiredItems    = { xi.item.SCARLET_CHIP },
    name             = 'CENTRAL_TEMENOS_2ND_FLOOR',
    lootCrateId      = ID.npc.C2_LOOT_CRATE,
})

local function weakenCarbuncle(elementalMod, bonusMod, bonusAmount, battlefield, mob, count)
    -- Remove the elemental bonus effects
    local zone      = mob:getZone()
    local carbuncle = zone:queryEntitiesByName('Mystic_Avatar_Carbuncle')[1]

    if elementalMod ~= xi.mod.NONE then
        carbuncle:setMod(elementalMod, 0)
    end

    carbuncle:delMod(bonusMod, bonusAmount)
end

function content:handleElementalDeath(elementalMod, bonusMod, bonusAmount, weakElemental, battlefield, mob, count)
    -- Spawn the Mystic Avatar if this elemental died from morphing
    if mob:getLocalVar('morphed') == 1 then
        local mysticID = mob:getID() + 6
        local mystic   = GetMobByID(mysticID)

        if mystic then
            mystic:timer(3000, function(mobArg)
                mystic:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos(), mob:getRotPos())
                SpawnMob(mysticID)
            end)
        end

        return
    end

    weakenCarbuncle(elementalMod, bonusMod, bonusAmount, battlefield, mob, count)

    -- Morph the weak elemental into a Mystic Avatar
    local zone      = mob:getZone()
    local elemental = zone:queryEntitiesByName(weakElemental)[1]

    if elemental:isAlive() then
        elemental:setLocalVar('morphed', 1)
        elemental:setHP(0)
    end
end

content.groups =
{
    {
        mobs =
        {
            'Fire_Elemental',
            'Ice_Elemental',
            'Air_Elemental',
            'Earth_Elemental',
            'Thunder_Elemental',
            'Water_Elemental',
            'Light_Elemental',
        },

        -- NOTE: Elementals in here take 50% physical damage instead of the usual 25%
        -- TODO: Verify if the Elementals here should detect sound
        mods =
        {
            [xi.mod.SLASH_SDT   ] = 500,
            [xi.mod.PIERCE_SDT  ] = 500,
            [xi.mod.IMPACT_SDT  ] = 500,
            [xi.mod.HTH_SDT     ] = 500,
            [xi.mobMod.DETECTION] = xi.detects.HEARING,
        },
    },

    -- Each Mystic Avatar has special elemental SDTs
    {
        spawned = false,
        mobs    = { 'Mystic_Avatar_Ifrit' },
        mods =
        {
            [xi.mod.UDMGPHYS   ] = 2500,
            [xi.mod.FIRE_ABSORB] = 100,
            [xi.mod.FIRE_SDT   ] = -10000,
            [xi.mod.ICE_SDT    ] = 9000,
            [xi.mod.THUNDER_SDT] = 9000,
            [xi.mod.EARTH_SDT  ] = 9000,
            [xi.mod.WIND_SDT   ] = 9000,
            [xi.mod.DARK_SDT   ] = 9000,
        },
    },

    {
        spawned = false,
        mobs    = { 'Mystic_Avatar_Shiva' },
        mods =
        {
            [xi.mod.UDMGPHYS   ] = 2500,
            [xi.mod.ICE_ABSORB ] = 100,
            [xi.mod.ICE_SDT    ] = -10000,
            [xi.mod.WATER_SDT  ] = 9000,
            [xi.mod.THUNDER_SDT] = 9000,
            [xi.mod.EARTH_SDT  ] = 9000,
            [xi.mod.WIND_SDT   ] = 9000,
            [xi.mod.DARK_SDT   ] = 9000,
        },
    },

    {
        spawned = false,
        mobs    = { 'Mystic_Avatar_Garuda' },
        mods =
        {
            [xi.mod.UDMGPHYS   ] = 2500,
            [xi.mod.WIND_ABSORB] = 100,
            [xi.mod.WIND_SDT   ] = -10000,
            [xi.mod.FIRE_SDT   ] = 9000,
            [xi.mod.WATER_SDT  ] = 9000,
            [xi.mod.THUNDER_SDT] = 9000,
            [xi.mod.EARTH_SDT  ] = 9000,
            [xi.mod.DARK_SDT   ] = 9000,
        },
    },

    {
        spawned = false,
        mobs    = { 'Mystic_Avatar_Titan' },
        mods =
        {
            [xi.mod.UDMGPHYS    ] = 2500,
            [xi.mod.EARTH_ABSORB] = 100,
            [xi.mod.EARTH_SDT   ] = -10000,
            [xi.mod.ICE_SDT     ] = 9000,
            [xi.mod.FIRE_SDT    ] = 9000,
            [xi.mod.WATER_SDT   ] = 9000,
            [xi.mod.THUNDER_SDT ] = 9000,
            [xi.mod.DARK_SDT    ] = 9000,
        },
    },

    {
        spawned = false,
        mobs    = { 'Mystic_Avatar_Ramuh' },
        mods =
        {
            [xi.mod.UDMGPHYS   ] = 2500,
            [xi.mod.LTNG_ABSORB] = 100,
            [xi.mod.THUNDER_SDT] = -10000,
            [xi.mod.ICE_SDT    ] = 9000,
            [xi.mod.FIRE_SDT   ] = 9000,
            [xi.mod.WATER_SDT  ] = 9000,
            [xi.mod.WIND_SDT   ] = 9000,
            [xi.mod.DARK_SDT   ] = 9000,
        },
    },

    {
        spawned = false,
        mobs    = { 'Mystic_Avatar_Leviathan' },
        mods =
        {
            [xi.mod.UDMGPHYS    ] = 2500,
            [xi.mod.WATER_ABSORB] = 100,
            [xi.mod.WATER_SDT   ] = -10000,
            [xi.mod.FIRE_SDT    ] = 9000,
            [xi.mod.ICE_SDT     ] = 9000,
            [xi.mod.EARTH_SDT   ] = 9000,
            [xi.mod.WIND_SDT    ] = 9000,
            [xi.mod.DARK_SDT    ] = 9000,
        },
    },

    -- Whenever an elemental dies the corresponding weak element morphs into a Mystic Avatar
    -- Each Elemental/Mystic Avatar weakens Carbuncle's elemental SDT as well as some bonus modifier
    {
        spawned = false,
        mobs =
        {
            'Fire_Elemental',
            'Mystic_Avatar_Ifrit',
        },

        death = utils.bind(content.handleElementalDeath, content, xi.mod.FIRE_SDT, xi.mod.ATTP, 50, 'Ice_Elemental'),
    },

    {
        spawned = false,
        mobs =
        {
            'Ice_Elemental',
            'Mystic_Avatar_Shiva',
        },

        -- TODO: Figure out the bonus modifier
        death = utils.bind(content.handleElementalDeath, content, xi.mod.ICE_SDT, xi.mod.MATT, 50, 'Air_Elemental'),
    },

    {
        spawned = false,
        mobs =
        {
            'Air_Elemental',
            'Mystic_Avatar_Garuda',
        },

        death = utils.bind(content.handleElementalDeath, content, xi.mod.WIND_SDT, xi.mod.EVA, 100, 'Earth_Elemental'),
    },

    {
        spawned = false,
        mobs =
        {
            'Earth_Elemental',
            'Mystic_Avatar_Titan',
        },

        death = utils.bind(content.handleElementalDeath, content, xi.mod.EARTH_SDT, xi.mod.UDMGPHYS, 5000, 'Thunder_Elemental'),
    },

    {
        spawned = false,
        mobs =
        {
            'Thunder_Elemental',
            'Mystic_Avatar_Ramuh',
        },

        death = utils.bind(content.handleElementalDeath, content, xi.mod.THUNDER_SDT, xi.mod.DOUBLE_ATTACK, 100, 'Water_Elemental'),
    },

    {
        spawned = false,
        mobs =
        {
            'Water_Elemental',
            'Mystic_Avatar_Leviathan',
        },

        death = utils.bind(content.handleElementalDeath, content, xi.mod.WATER_SDT, xi.mod.UDMGMAGIC, 5000, 'Fire_Elemental'),
    },

    {
        mobs  = { 'Light_Elemental' },
        death = utils.bind(weakenCarbuncle, content, xi.mod.NONE, xi.mod.DARK_SDT, 2500),
    },

    {
        mobs =
        {
            'Light_Elemental',
            'Mystic_Avatar_Carbuncle',
        },
        mobMods = { [xi.mobMod.DETECTION] = xi.detects.HEARING },
        isParty = true,
    },

    {
        mobs = { 'Mystic_Avatar_Carbuncle' },
        mods =
        {
            [xi.mod.FIRE_SDT   ] = 9000,
            [xi.mod.ICE_SDT    ] = 9000,
            [xi.mod.WIND_SDT   ] = 9000,
            [xi.mod.EARTH_SDT  ] = 9000,
            [xi.mod.THUNDER_SDT] = 9000,
            [xi.mod.WATER_SDT  ] = 9000,
            [xi.mod.DARK_SDT   ] = 5000,
        },

        setup = function(battlefield, mobs)
            local mob = mobs[1]
            mob:addMod(xi.mod.ATTP, 50)
            mob:addMod(xi.mod.MATT, 50)
            mob:addMod(xi.mod.EVA, 100)
            mob:addMod(xi.mod.UDMGPHYS, 5000)
            mob:addMod(xi.mod.DOUBLE_ATTACK, 100)
            mob:addMod(xi.mod.UDMGMAGIC, 5000)
        end,

        death = function(battlefield, mob)
            npcUtil.showCrate(GetNPCByID(ID.npc.C2_LOOT_CRATE))
        end
    }
}

content.loot =
{
    [ID.npc.C2_LOOT_CRATE] =
    {
        {
            quantity = 6,
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.SQUARE_OF_ECARLATE_CLOTH, weight = xi.loot.weight.NORMAL },
            { item = xi.item.DARK_ORICHALCUM_INGOT,    weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_SMALT_LEATHER,  weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_FILET_LACE,     weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.SPOOL_OF_COILED_YARN,     weight = xi.loot.weight.NORMAL },
            { item = xi.item.PLAITED_CORD,             weight = xi.loot.weight.NORMAL },
            { item = xi.item.SHEET_OF_COBALT_MYTHRIL,  weight = xi.loot.weight.NORMAL },
            { item = xi.item.SPOOL_OF_LUMINIAN_THREAD, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,                     weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.UTOPIAN_GOLD_THREAD,      weight = xi.loot.weight.LOW       },
            { item = xi.item.SQUARE_OF_SUPPLE_SKIN,    weight = xi.loot.weight.LOW       },
            { item = xi.item.SPOOL_OF_SCARLET_ODOSHI,  weight = xi.loot.weight.LOW       },
            { item = xi.item.SPOOL_OF_SILKWORM_THREAD, weight = xi.loot.weight.LOW       },
        },

        {
            { item = xi.item.CERULEAN_CHIP, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,       weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.METAL_CHIP, weight = xi.loot.weight.VERY_LOW  },
        },
    }
}

return content:register()
