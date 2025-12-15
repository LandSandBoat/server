-----------------------------------
-- Amphibian Assault
-- Sacrificial Chamber BCNM60, Moon Orb
-- !additem 1130
-----------------------------------
local sacrificialChamberID = zones[xi.zone.SACRIFICIAL_CHAMBER]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.SACRIFICIAL_CHAMBER,
    battlefieldId    = xi.battlefield.id.AMPHIBIAN_ASSAULT,
    maxPlayers       = 6,
    levelCap         = 60,
    timeLimit        = utils.minutes(30),
    index            = 2,
    entryNpc         = '_4j0',
    exitNpcs         = { '_4j2', '_4j3', '_4j4' },
    requiredItems    = { xi.item.MOON_ORB, wearMessage = sacrificialChamberID.text.A_CRACK_HAS_FORMED, wornMessage = sacrificialChamberID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 4,
        sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 10,
        sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 16,
    },
})

-- Alternate death handler to check all mobs including the wyvern
local function handleDeath(battlefield, mob)
    local baseMobId = sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + (battlefield:getArea() - 1) * 6

    for _, mobOffset in ipairs({ 0, 1, 2, 3, 5 }) do
        local battlefieldMob = GetMobByID(baseMobId + mobOffset)
        if battlefieldMob and battlefieldMob:isAlive() then
            return
        end
    end

    content:handleAllMonstersDefeated(battlefield, mob)
end

content.groups =
{
    {
        mobIds =
        {
            {
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER,     -- Qull the Fallstopper
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 1, -- Rauu the Whaleswooner
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 2, -- Hyohh the Conchblower
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 3, -- Pevv the Riverleaper
            },

            {
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 6, -- Qull the Fallstopper
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 7, -- Rauu the Whaleswooner
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 8, -- Hyohh the Conchblower
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 9, -- Pevv the Riverleaper
            },

            {
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 12, -- Qull the Fallstopper
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 13, -- Rauu the Whaleswooner
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 14, -- Hyohh the Conchblower
                sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 15, -- Pevv the Riverleaper
            },
        },

        allDeath = handleDeath,
    },

    {
        mobIds =
        {
            { sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 5  }, -- Sahagins Wyvern
            { sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 11 }, -- Sahagins Wyvern
            { sacrificialChamberID.mob.QULL_THE_FALLSTOPPER + 17 }, -- Sahagins Wyvern
        },

        spawned = false,
        allDeath = handleDeath,
    },
}

content.loot =
{
    {
        { itemId = xi.item.GIL,                    weight = 1000, amount = 18000 },
    },

    {
        { itemId = xi.item.DIVINE_TORQUE,          weight = 250 },
        { itemId = xi.item.ENFEEBLING_TORQUE,      weight = 250 },
        { itemId = xi.item.SHIELD_TORQUE,          weight = 250 },
        { itemId = xi.item.STRING_TORQUE,          weight = 250 },
    },

    {
        { itemId = xi.item.PLATINUM_BEASTCOIN,     weight = 500 },
        { itemId = xi.item.FIRE_SPIRIT_PACT,       weight = 100 },
        { itemId = xi.item.SCROLL_OF_ABSORB_STR,   weight = 100 },
        { itemId = xi.item.SCROLL_OF_ERASE,        weight = 100 },
        { itemId = xi.item.SCROLL_OF_PHALANX,      weight = 100 },
        { itemId = xi.item.SCROLL_OF_RAISE_II,     weight = 100 },
    },

    {
        { itemId = xi.item.PLATINUM_BEASTCOIN,     weight = 500 },
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,      weight =  50 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE, weight =  50 },
        { itemId = xi.item.CHUNK_OF_DARK_ORE,      weight =  50 },
        { itemId = xi.item.CHUNK_OF_EARTH_ORE,     weight =  50 },
        { itemId = xi.item.CHUNK_OF_FIRE_ORE,      weight =  50 },
        { itemId = xi.item.CHUNK_OF_ICE_ORE,       weight =  50 },
        { itemId = xi.item.CHUNK_OF_LIGHT_ORE,     weight =  50 },
        { itemId = xi.item.CHUNK_OF_LIGHTNING_ORE, weight =  50 },
        { itemId = xi.item.CHUNK_OF_WATER_ORE,     weight =  50 },
        { itemId = xi.item.CHUNK_OF_WIND_ORE,      weight =  50 },
    },

    {
        { itemId = xi.item.ELEMENTAL_TORQUE,       weight = 200 },
        { itemId = xi.item.ENHANCING_TORQUE,       weight = 200 },
        { itemId = xi.item.EVASION_TORQUE,         weight = 200 },
        { itemId = xi.item.GUARDING_TORQUE,        weight = 200 },
        { itemId = xi.item.SUMMONING_TORQUE,       weight = 200 },
    },

    {
        quantity = 2,
        { itemId = xi.item.AQUAMARINE,             weight = 25 },
        { itemId = xi.item.CHRYSOBERYL,            weight = 25 },
        { itemId = xi.item.FLUORITE,               weight = 25 },
        { itemId = xi.item.JADEITE,                weight = 25 },
        { itemId = xi.item.MOONSTONE,              weight = 25 },
        { itemId = xi.item.PAINITE,                weight = 25 },
        { itemId = xi.item.SUNSTONE,               weight = 25 },
        { itemId = xi.item.ZIRCON,                 weight = 25 },
        { itemId = xi.item.BLACK_ROCK,             weight = 25 },
        { itemId = xi.item.BLUE_ROCK,              weight = 25 },
        { itemId = xi.item.GREEN_ROCK,             weight = 25 },
        { itemId = xi.item.PURPLE_ROCK,            weight = 25 },
        { itemId = xi.item.RED_ROCK,               weight = 25 },
        { itemId = xi.item.TRANSLUCENT_ROCK,       weight = 25 },
        { itemId = xi.item.WHITE_ROCK,             weight = 25 },
        { itemId = xi.item.YELLOW_ROCK,            weight = 25 },
        { itemId = xi.item.EBONY_LOG,              weight = 25 },
        { itemId = xi.item.MAHOGANY_LOG,           weight = 25 },
        { itemId = xi.item.DARKSTEEL_INGOT,        weight = 25 },
        { itemId = xi.item.GOLD_INGOT,             weight = 25 },
        { itemId = xi.item.MYTHRIL_INGOT,          weight = 25 },
        { itemId = xi.item.STEEL_INGOT,            weight = 25 },
        { itemId = xi.item.DEMON_HORN,             weight = 25 },
        { itemId = xi.item.CORAL_FRAGMENT,         weight = 25 },
        { itemId = xi.item.HI_RERAISER,            weight = 25 },
        { itemId = xi.item.VILE_ELIXIR,            weight = 25 },
        { itemId = xi.item.VILE_ELIXIR_P1,         weight = 25 },
    },
}

return content:register()
