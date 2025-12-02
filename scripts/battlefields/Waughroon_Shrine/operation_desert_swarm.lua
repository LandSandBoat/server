-----------------------------------
-- Operation Desert Storm
-- Waughroon Shrine KSNM30, Lachesis Orb
-- !additem 1178
-----------------------------------
local waughroonID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.WAUGHROON_SHRINE,
    battlefieldId    = xi.battlefield.id.OPERATION_DESERT_SWARM,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 17,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.LACHESIS_ORB, wearMessage = waughroonID.text.A_CRACK_HAS_FORMED, wornMessage = waughroonID.text.ORB_IS_CRACKED },

    experimental = true,
})

content:addEssentialMobs({ 'Platoon_Scorpion' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                         weight = 1000, amount = 24000 },
    },

    {
        { itemId = xi.item.HIGH_QUALITY_SCORPION_SHELL, weight = 850 },
        { itemId = xi.item.SERKET_RING,                 weight =  50 },
        { itemId = xi.item.VENOMOUS_CLAW,               weight = 150 },
    },

    {
        { itemId = xi.item.EXPUNGER,                    weight = 250 },
        { itemId = xi.item.HEART_SNATCHER,              weight = 250 },
        { itemId = xi.item.RAMPAGER,                    weight = 250 },
        { itemId = xi.item.SENJUINRIKIO,                weight = 250 },
    },

    {
        { itemId = xi.item.ANUBISS_KNIFE,               weight = 500 },
        { itemId = xi.item.CLAYMORE_GRIP,               weight = 100 },
        { itemId = xi.item.POLE_GRIP,                   weight = 100 },
        { itemId = xi.item.SWORD_STRAP,                 weight = 200 },
        { itemId = xi.item.ADAMAN_INGOT,                weight =  50 },
        { itemId = xi.item.ORICHALCUM_INGOT,            weight =  50 },
    },

    {
        { itemId = xi.item.HIERARCH_BELT,               weight = 250 },
        { itemId = xi.item.PALMERINS_SHIELD,            weight = 250 },
        { itemId = xi.item.TRAINERS_GLOVES,             weight = 250 },
        { itemId = xi.item.WARWOLF_BELT,                weight = 250 },
    },

    {
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,      weight =  50 },
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,           weight =  50 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,        weight =  50 },
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,       weight =  50 },
        { itemId = xi.item.EBONY_LOG,                   weight =  50 },
        { itemId = xi.item.MAHOGANY_LOG,                weight =  50 },
        { itemId = xi.item.PETRIFIED_LOG,               weight =  50 },
        { itemId = xi.item.PHILOSOPHERS_STONE,          weight =  50 },
        { itemId = xi.item.SPOOL_OF_GOLD_THREAD,        weight =  50 },
        { itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH,     weight =  50 },
        { itemId = xi.item.SQUARE_OF_RAXA,              weight =  50 },
        { itemId = xi.item.CORAL_FRAGMENT,              weight =  50 },
        { itemId = xi.item.DEMON_HORN,                  weight =  50 },
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES,    weight =  50 },
        { itemId = xi.item.RAM_HORN,                    weight =  50 },
        { itemId = xi.item.SLAB_OF_GRANITE,             weight =  50 },
        { itemId = xi.item.RERAISER,                    weight =  50 },
        { itemId = xi.item.HI_RERAISER,                 weight =  50 },
        { itemId = xi.item.VILE_ELIXIR,                 weight =  50 },
        { itemId = xi.item.VILE_ELIXIR_P1,              weight =  50 },
    },

    {
        { itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD,  weight =  63 },
        { itemId = xi.item.SQUARE_OF_DAMASCENE_CLOTH,   weight =  62 },
        { itemId = xi.item.DAMASCUS_INGOT,              weight =  62 },
        { itemId = xi.item.SPOOL_OF_MALBORO_FIBER,      weight =  63 },
        { itemId = xi.item.PHILOSOPHERS_STONE,          weight = 200 },
        { itemId = xi.item.PHOENIX_FEATHER,             weight = 350 },
        { itemId = xi.item.SQUARE_OF_RAXA,              weight = 200 },
    },
}

return content:register()
