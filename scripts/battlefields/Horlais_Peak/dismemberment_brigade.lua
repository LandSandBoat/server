-----------------------------------
-- Dismemberment Brigade
-- Horlais Peak BCNM60, Moon Orb
-- !additem 1130
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.HORLAIS_PEAK,
    battlefieldId    = xi.battlefield.id.DISMEMBERMENT_BRIGADE,
    maxPlayers       = 6,
    levelCap         = 60,
    timeLimit        = utils.minutes(30),
    index            = 2,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.MOON_ORB, wearMessage = horlaisID.text.A_CRACK_HAS_FORMED, wornMessage = horlaisID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        horlaisID.mob.ARMSMASTER_DEKBUK + 6,
        horlaisID.mob.ARMSMASTER_DEKBUK + 13,
        horlaisID.mob.ARMSMASTER_DEKBUK + 20,
    },
})

content.groups =
{
    {
        mobIds =
        {
            {
                horlaisID.mob.ARMSMASTER_DEKBUK,
                horlaisID.mob.ARMSMASTER_DEKBUK + 1,
                horlaisID.mob.ARMSMASTER_DEKBUK + 2,
                horlaisID.mob.ARMSMASTER_DEKBUK + 3,
                horlaisID.mob.ARMSMASTER_DEKBUK + 4,
                horlaisID.mob.ARMSMASTER_DEKBUK + 5,
            },

            {
                horlaisID.mob.ARMSMASTER_DEKBUK + 7,
                horlaisID.mob.ARMSMASTER_DEKBUK + 8,
                horlaisID.mob.ARMSMASTER_DEKBUK + 9,
                horlaisID.mob.ARMSMASTER_DEKBUK + 10,
                horlaisID.mob.ARMSMASTER_DEKBUK + 11,
                horlaisID.mob.ARMSMASTER_DEKBUK + 12,
            },

            {
                horlaisID.mob.ARMSMASTER_DEKBUK + 14,
                horlaisID.mob.ARMSMASTER_DEKBUK + 15,
                horlaisID.mob.ARMSMASTER_DEKBUK + 16,
                horlaisID.mob.ARMSMASTER_DEKBUK + 17,
                horlaisID.mob.ARMSMASTER_DEKBUK + 18,
                horlaisID.mob.ARMSMASTER_DEKBUK + 19,
            },
        },

        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
    },
}

content.loot =
{
    {
        { itemId = xi.item.KABRAKANS_AXE, weight = 250 }, -- kabrakans_axe
        { itemId = xi.item.SARNGA,        weight = 250 }, -- sarnga
        { itemId = xi.item.DRAGVANDIL,    weight = 250 }, -- dragvandil
        { itemId = xi.item.HAMELIN_FLUTE, weight = 250 }, -- hamelin_flute
    },

    {
        { itemId = xi.item.NONE,            weight = 400 }, -- nothing
        { itemId = xi.item.SPECTACLES,      weight = 200 }, -- spectacles
        { itemId = xi.item.ASSAULT_EARRING, weight = 200 }, -- assault_earring
        { itemId = xi.item.PEACE_RING,      weight = 200 }, -- peace_ring
    },

    {
        { itemId = xi.item.NONE,             weight = 200 }, -- nothing
        { itemId = xi.item.TRANSLUCENT_ROCK, weight = 200 }, -- translucent_rock
        { itemId = xi.item.GREEN_ROCK,       weight = 200 }, -- green_rock
        { itemId = xi.item.YELLOW_ROCK,      weight = 200 }, -- yellow_rock
        { itemId = xi.item.PURPLE_ROCK,      weight = 200 }, -- purple_rock
    },

    {
        { itemId = xi.item.PAINITE,         weight = 100 }, -- painite
        { itemId = xi.item.JADEITE,         weight = 100 }, -- jadeite
        { itemId = xi.item.MYTHRIL_INGOT,   weight = 100 }, -- mythril_ingot
        { itemId = xi.item.STEEL_INGOT,     weight = 100 }, -- steel_ingot
        { itemId = xi.item.FLUORITE,        weight = 100 }, -- fluorite
        { itemId = xi.item.GOLD_INGOT,      weight = 100 }, -- gold_ingot
        { itemId = xi.item.ZIRCON,          weight = 100 }, -- zircon
        { itemId = xi.item.CHRYSOBERYL,     weight = 100 }, -- chrysoberyl
        { itemId = xi.item.DARKSTEEL_INGOT, weight = 100 }, -- darksteel_ingot
        { itemId = xi.item.MOONSTONE,       weight = 100 }, -- moonstone
    },

    {
        { itemId = xi.item.NONE,           weight =  900 }, -- nothing
        { itemId = xi.item.VILE_ELIXIR_P1, weight =  100 }, -- vile_elixir_+1
    },
}

return content:register()
