-----------------------------------
-- Area: Throne Room
-- BCNM 60 - Kindred Spirits
-- !pos -111 -6 0.1 165
-----------------------------------
local throneRoomID = zones[xi.zone.THRONE_ROOM]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.THRONE_ROOM,
    battlefieldId = xi.battlefield.id.KINDRED_SPIRITS,
    maxPlayers    = 6,
    levelCap      = 60,
    timeLimit     = utils.minutes(30),
    index         = 2,
    entryNpc      = '_4l1',
    exitNpcs      = { '_4l2', '_4l3', '_4l4' },
    requiredItems = { xi.item.MOON_ORB, wearMessage = throneRoomID.text.A_CRACK_HAS_FORMED, wornMessage = throneRoomID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 4,
        throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 11,
        throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 18,
    },

    experimental = true, -- This is an experimental BCNM, it is not yet fully implemented.
})

content.groups =
{
    {
        -- TODO: Verify full list of spells Duke Amduscias can cast
        mobIds =
        {
            {
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL,
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 1,
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 2,
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 3,
            },

            {
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 7,
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 8,
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 9,
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 10,
            },

            {
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 14,
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 15,
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 16,
                throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 17,
            },
        },

        superlink = true,
        allDeath  = utils.bind(content.handleAllMonstersDefeated, content),
    },

    -- Elemental
    {
        mobIds =
        {
            { throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 5  },
            { throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 12 },
            { throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 19 },
        },

        spawned = false,
    },

    -- Avatar
    {
        mobIds =
        {
            { throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 6  },
            { throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 13 },
            { throneRoomID.mob.GRAND_MARQUIS_CHOMIEL + 20 },
        },

        spawned = false,
    },
}

content.loot =
{
    -- TODO: Loot pool items and weight require more data to extrapolate correct values and placement.
    {
        { itemId = xi.item.DEMON_HORN, weight = xi.loot.weight.NORMAL },
    },

    {
        { itemId = xi.item.SUNSTONE, weight = xi.loot.weight.LOW },
        { itemId = xi.item.CHRYSOBERYL, weight = xi.loot.weight.LOW },
        { itemId = xi.item.MYTHRIL_INGOT, weight = xi.loot.weight.VERY_HIGH },
        { itemId = xi.item.DEMON_QUIVER, weight = xi.loot.weight.NORMAL },
    },

    {
        { itemId = xi.item.FORSETIS_AXE, weight = xi.loot.weight.NORMAL },
        { itemId = xi.item.ARAMISS_RAPIER, weight = xi.loot.weight.NORMAL },
        { itemId = xi.item.SPARTAN_CESTI, weight = xi.loot.weight.NORMAL },
        { itemId = xi.item.SAIREN, weight = xi.loot.weight.NORMAL },
        { itemId = xi.item.ARCHALAUSS_POLE, weight = xi.loot.weight.NORMAL },
    },

    {
        { itemId = xi.item.LIGHT_BOOMERANG, weight = xi.loot.weight.NORMAL },
        { itemId = xi.item.ARMBRUST, weight = xi.loot.weight.NORMAL },
        { itemId = xi.item.SCHWARZ_LANCE, weight = xi.loot.weight.NORMAL },
        { itemId = xi.item.OMOKAGE, weight = xi.loot.weight.NORMAL },
        { itemId = xi.item.ARCHALAUSS_POLE, weight = xi.loot.weight.NORMAL },
    },

    {
        { itemId = xi.item.VASSAGOS_SCYTHE, weight = xi.loot.weight.NORMAL },
        { itemId = xi.item.KABRAKANS_AXE, weight = xi.loot.weight.NORMAL },
        { itemId = xi.item.DRAGVANDIL, weight = xi.loot.weight.NORMAL },
        { itemId = xi.item.HAMELIN_FLUTE, weight = xi.loot.weight.NORMAL },
    },

    {
        { itemId = xi.item.NONE, weight = xi.loot.weight.HIGH },
        { itemId = xi.item.SCROLL_OF_CARNAGE_ELEGY, weight = xi.loot.weight.NORMAL },
        { itemId = xi.item.ICE_SPIRIT_PACT, weight = xi.loot.weight.NORMAL },
    },
}

return content:register()
