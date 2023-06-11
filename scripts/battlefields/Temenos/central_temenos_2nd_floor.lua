-----------------------------------
-- Area: Temenos
-- Name: Central Temenos 1st Floor
-- !addkeyitem white_card
-- !addkeyitem cosmo_cleanse
-- !additem scarlet_chip
-- !pos 580.000 -2.375 104.000 37
-----------------------------------
local ID = require("scripts/zones/Temenos/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/limbus")
require("scripts/globals/items")
require("scripts/globals/keyitems")
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
    requiredItems    = { xi.items.SCARLET_CHIP },
    name             = "CENTRAL_TEMENOS_2ND_FLOOR",
})

local function weakenCarbuncle(elementalMod, bonusMods, bonusAmounts, battlefield, mob, count)
    -- Remove the elemental bonus effects
    local zone = mob:getZone()
    local carbuncle = zone:queryEntitiesByName("Mystic_Avatar_Carbuncle")[1]
    if elementalMod ~= xi.mod.NONE then
        carbuncle:setMod(elementalMod, 0)
    end

    for modIndex, bonusMod in ipairs(bonusMods) do
        carbuncle:delMod(bonusMod, bonusAmounts[modIndex])
    end
end

function content:handleElementalDeath(elementalMod, bonusMods, bonusAmounts, weakElemental, battlefield, mob, count)
    -- Spawn the Mystic Avatar if this elemental died from morphing
    if mob:getLocalVar("morphed") == 1 then
        local mysticID = mob:getID() + 6
        local mystic = GetMobByID(mysticID)
        mystic:timer(3000, function(mobArg)
            mystic:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos(), mob:getRotPos())
            SpawnMob(mysticID)
        end)

        return
    end

    weakenCarbuncle(elementalMod, bonusMods, bonusAmounts, battlefield, mob, count)

    -- Morph the weak elemental into a Mystic Avatar
    local zone = mob:getZone()
    local elemental = zone:queryEntitiesByName(weakElemental)[1]
    if elemental:isAlive() then
        elemental:setLocalVar("morphed", 1)
        elemental:setHP(0)
    end
end

content.groups =
{
    {
        mobs =
        {
            "Fire_Elemental",
            "Ice_Elemental",
            "Air_Elemental",
            "Earth_Elemental",
            "Thunder_Elemental",
            "Water_Elemental",
            "Light_Elemental",
        },

        mods =
        {
            -- 50% resist on all damage
            [xi.mod.DMG] = -5000,
            -- remove the normal phys down of elementals
            [xi.mod.PIERCE_SDT] = 1000,
            [xi.mod.SLASH_SDT] = 1000,
            [xi.mod.IMPACT_SDT] = 1000,
            [xi.mod.HTH_SDT] = 1000,
            [xi.mobMod.DETECTION] = xi.detects.HEARING,
        },
    },

    -- Each Mystic Avatar has special elemental SDTs
    {
        spawned = false,
        mobs = { "Mystic_Avatar_Ifrit" },
        mods =
        {
            [xi.mod.UDMGPHYS] = -2500,
            [xi.mod.UDMGRANGE] = -2500,
            [xi.mod.UDMGBREATH] = -2500,
            [xi.mod.FIRE_ABSORB] = 100,
            -- double fire damage so absorb painful
            [xi.mod.FIRE_SDT] = -10000,
            -- for elemental sdts 9000 means 90% less dmg
            [xi.mod.ICE_SDT] = 9000,
            [xi.mod.THUNDER_SDT] = 9000,
            [xi.mod.EARTH_SDT] = 9000,
            [xi.mod.WIND_SDT] = 9000,
            [xi.mod.DARK_SDT] = 9000,
        },
    },

    {
        spawned = false,
        mobs = { "Mystic_Avatar_Shiva" },
        mods =
        {
            [xi.mod.UDMGPHYS] = -2500,
            [xi.mod.UDMGRANGE] = -2500,
            [xi.mod.UDMGBREATH] = -2500,
            [xi.mod.ICE_ABSORB] = 100,
            [xi.mod.ICE_SDT] = -10000,
            [xi.mod.WATER_SDT] = 9000,
            [xi.mod.THUNDER_SDT] = 9000,
            [xi.mod.EARTH_SDT] = 9000,
            [xi.mod.WIND_SDT] = 9000,
            [xi.mod.DARK_SDT] = 9000,
        },
    },

    {
        spawned = false,
        mobs = { "Mystic_Avatar_Garuda" },
        mods =
        {
            [xi.mod.UDMGPHYS] = -2500,
            [xi.mod.UDMGRANGE] = -2500,
            [xi.mod.UDMGBREATH] = -2500,
            [xi.mod.WIND_ABSORB] = 100,
            [xi.mod.WIND_SDT] = -10000,
            [xi.mod.FIRE_SDT] = 9000,
            [xi.mod.WATER_SDT] = 9000,
            [xi.mod.THUNDER_SDT] = 9000,
            [xi.mod.EARTH_SDT] = 9000,
            [xi.mod.DARK_SDT] = 9000,
        },
    },

    {
        spawned = false,
        mobs = { "Mystic_Avatar_Titan" },
        mods =
        {
            [xi.mod.UDMGPHYS] = -2500,
            [xi.mod.UDMGRANGE] = -2500,
            [xi.mod.UDMGBREATH] = -2500,
            [xi.mod.EARTH_ABSORB] = 100,
            [xi.mod.EARTH_SDT] = -10000,
            [xi.mod.ICE_SDT] = 9000,
            [xi.mod.FIRE_SDT] = 9000,
            [xi.mod.WATER_SDT] = 9000,
            [xi.mod.THUNDER_SDT] = 9000,
            [xi.mod.DARK_SDT] = 9000,
        },
    },

    {
        spawned = false,
        mobs = { "Mystic_Avatar_Ramuh" },
        mods =
        {
            [xi.mod.UDMGPHYS] = -2500,
            [xi.mod.UDMGRANGE] = -2500,
            [xi.mod.UDMGBREATH] = -2500,
            [xi.mod.LTNG_ABSORB] = 100,
            [xi.mod.THUNDER_SDT] = -10000,
            [xi.mod.ICE_SDT] = 9000,
            [xi.mod.FIRE_SDT] = 9000,
            [xi.mod.WATER_SDT] = 9000,
            [xi.mod.WIND_SDT] = 9000,
            [xi.mod.DARK_SDT] = 9000,
        },
    },

    {
        spawned = false,
        mobs = { "Mystic_Avatar_Leviathan" },
        mods =
        {
            [xi.mod.UDMGPHYS] = -2500,
            [xi.mod.UDMGRANGE] = -2500,
            [xi.mod.UDMGBREATH] = -2500,
            [xi.mod.WATER_ABSORB] = 100,
            [xi.mod.WATER_SDT] = -10000,
            [xi.mod.FIRE_SDT] = 9000,
            [xi.mod.ICE_SDT] = 9000,
            [xi.mod.EARTH_SDT] = 9000,
            [xi.mod.WIND_SDT] = 9000,
            [xi.mod.DARK_SDT] = 9000,
        },
    },

    -- Whenever an elemental dies the corresponding weak element morphs into a Mystic Avatar
    -- Each Elemental/Mystic Avatar weakens Carbuncle's elemental SDT as well as some bonus modifier
    {
        spawned = false,
        mobs =
        {
            "Fire_Elemental",
            "Mystic_Avatar_Ifrit",
        },

        death = utils.bind(content.handleElementalDeath, content, xi.mod.FIRE_SDT, { xi.mod.ATTP }, { 50 }, "Ice_Elemental"),
    },

    {
        spawned = false,
        mobs =
        {
            "Ice_Elemental",
            "Mystic_Avatar_Shiva",
        },

        -- TODO: Figure out the bonus modifier
        death = utils.bind(content.handleElementalDeath, content, xi.mod.ICE_SDT, { xi.mod.MATT }, { 50 }, "Air_Elemental"),
    },

    {
        spawned = false,
        mobs =
        {
            "Air_Elemental",
            "Mystic_Avatar_Garuda",
        },

        death = utils.bind(content.handleElementalDeath, content, xi.mod.WIND_SDT, { xi.mod.EVA }, { 100 }, "Earth_Elemental"),
    },

    {
        spawned = false,
        mobs =
        {
            "Earth_Elemental",
            "Mystic_Avatar_Titan",
        },

        death = utils.bind(content.handleElementalDeath, content, xi.mod.EARTH_SDT, { xi.mod.UDMGPHYS, xi.mod.UDMGRANGE, xi.mod.UDMGBREATH }, { -5000, -5000, -5000 }, "Thunder_Elemental"),
    },

    {
        spawned = false,
        mobs =
        {
            "Thunder_Elemental",
            "Mystic_Avatar_Ramuh",
        },

        death = utils.bind(content.handleElementalDeath, content, xi.mod.THUNDER_SDT, { xi.mod.DOUBLE_ATTACK }, { 100 }, "Water_Elemental"),
    },

    {
        spawned = false,
        mobs =
        {
            "Water_Elemental",
            "Mystic_Avatar_Leviathan",
        },

        death = utils.bind(content.handleElementalDeath, content, xi.mod.WATER_SDT, { xi.mod.UDMGMAGIC }, { -5000 }, "Fire_Elemental"),
    },

    {
        mobs = { "Light_Elemental" },
        death = function(battlefield, mob)
            weakenCarbuncle(xi.mod.NONE, { xi.mod.DARK_SDT }, { 2500 }, battlefield, mob)
        end
    },

    {
        mobs =
        {
            "Light_Elemental",
            "Mystic_Avatar_Carbuncle",
        },
        mobMods = { [xi.mobMod.DETECTION] = xi.detects.HEARING },
        isParty = true,
        superlink = true,
    },

    {
        mobs = { "Mystic_Avatar_Carbuncle" },
        mods =
        {
            [xi.mod.FIRE_SDT] = 9000,
            [xi.mod.ICE_SDT] = 9000,
            [xi.mod.WIND_SDT] = 9000,
            [xi.mod.EARTH_SDT] = 9000,
            [xi.mod.THUNDER_SDT] = 9000,
            [xi.mod.WATER_SDT] = 9000,
            [xi.mod.DARK_SDT] = 5000,
        },

        setup = function(battlefield, mobs)
            local mob = mobs[1]
            mob:addMod(xi.mod.ATTP, 50)
            mob:addMod(xi.mod.MATT, 50)
            mob:addMod(xi.mod.EVA, 100)
            mob:addMod(xi.mod.UDMGPHYS, -5000)
            mob:addMod(xi.mod.UDMGRANGE, -5000)
            mob:addMod(xi.mod.UDMGBREATH, -5000)
            mob:addMod(xi.mod.DOUBLE_ATTACK, 100)
            mob:addMod(xi.mod.UDMGMAGIC, -5000)
        end,

        death = function(battlefield, mob)
            npcUtil.showCrate(GetNPCByID(ID.CENTRAL_TEMENOS_2ND_FLOOR.npc.LOOT_CRATE))
        end
    }
}

content.loot =
{
    [ID.CENTRAL_TEMENOS_2ND_FLOOR.npc.LOOT_CRATE] =
    {
        {
            quantity = 6,
            { item = xi.items.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.items.SQUARE_OF_ECARLATE_CLOTH, weight = xi.loot.weight.NORMAL },
            { item = xi.items.DARK_ORICHALCUM_INGOT, weight = xi.loot.weight.NORMAL },
            { item = xi.items.SQUARE_OF_SMALT_LEATHER, weight = xi.loot.weight.NORMAL },
            { item = xi.items.SQUARE_OF_FILET_LACE, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.items.SPOOL_OF_COILED_YARN, weight = xi.loot.weight.NORMAL },
            { item = xi.items.PLAITED_CORD, weight = xi.loot.weight.NORMAL },
            { item = xi.items.SHEET_OF_COBALT_MYTHRIL, weight = xi.loot.weight.NORMAL },
            { item = xi.items.SPOOL_OF_LUMINIAN_THREAD, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.items.NONE, weight = xi.loot.weight.VERY_HIGH },
            { item = xi.items.UTOPIAN_GOLD_THREAD, weight = xi.loot.weight.LOW },
            { item = xi.items.SQUARE_OF_SUPPLE_SKIN, weight = xi.loot.weight.LOW },
            { item = xi.items.SPOOL_OF_SCARLET_ODOSHI, weight = xi.loot.weight.LOW },
            { item = xi.items.SPOOL_OF_SILKWORM_THREAD, weight = xi.loot.weight.LOW },
        },

        {
            { item = xi.items.CERULEAN_CHIP, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.items.NONE, weight = xi.loot.weight.VERY_HIGH },
            { item = xi.items.METAL_CHIP, weight = xi.loot.weight.VERY_LOW },
        },
    }
}

return content:register()
