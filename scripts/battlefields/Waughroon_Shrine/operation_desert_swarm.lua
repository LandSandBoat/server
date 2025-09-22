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
        { itemId = xi.item.HIGH_QUALITY_SCORPION_SHELL, weight = 813 }, -- High-quality Scorpion Shell
        { itemId = xi.item.SERKET_RING,                 weight =  55 }, -- Serket Ring
        { itemId = xi.item.VENOMOUS_CLAW,               weight = 123 }, -- Venomous Claw
    },

    {
        { itemId = xi.item.EXPUNGER,       weight = 216 }, -- Expunger
        { itemId = xi.item.HEART_SNATCHER, weight = 295 }, -- Heart Snatcher
        { itemId = xi.item.RAMPAGER,       weight = 239 }, -- Rampager
        { itemId = xi.item.SENJUINRIKIO,   weight = 231 }, -- Senjuinrikio
    },

    {
        { itemId = xi.item.ANUBISS_KNIFE,    weight = 504 }, -- Anubiss Knife
        { itemId = xi.item.ADAMAN_INGOT,     weight =   4 }, -- Adaman Ingot
        { itemId = xi.item.CLAYMORE_GRIP,    weight =  86 }, -- Claymore Grip
        { itemId = xi.item.ORICHALCUM_INGOT, weight =  22 }, -- Orichalcum Ingot
        { itemId = xi.item.POLE_GRIP,        weight = 146 }, -- Pole Grip
        { itemId = xi.item.SWORD_STRAP,      weight =  22 }, -- Sword Strap
    },

    {
        { itemId = xi.item.HIERARCH_BELT,    weight = 287 }, -- Hierarch Belt
        { itemId = xi.item.PALMERINS_SHIELD, weight = 216 }, -- Palmerins Shield
        { itemId = xi.item.TRAINERS_GLOVES,  weight = 198 }, -- Trainers Gloves
        { itemId = xi.item.WARWOLF_BELT,     weight = 287 }, -- Warwolf Belt
    },

    {
        { itemId = xi.item.CORAL_FRAGMENT,           weight =  52 }, -- Coral Fragment
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,   weight =  56 }, -- Chunk Of Darksteel Ore
        { itemId = xi.item.DEMON_HORN,               weight =  41 }, -- Demon Horn
        { itemId = xi.item.EBONY_LOG,                weight =  63 }, -- Ebony Log
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,        weight =  52 }, -- Chunk Of Gold Ore
        { itemId = xi.item.SPOOL_OF_GOLD_THREAD,     weight =  26 }, -- Spool Of Gold Thread
        { itemId = xi.item.SLAB_OF_GRANITE,          weight =  11 }, -- Slab Of Granite
        { itemId = xi.item.HI_RERAISER,              weight =  37 }, -- Hi-reraiser
        { itemId = xi.item.MAHOGANY_LOG,             weight = 101 }, -- Mahogany Log
        { itemId = xi.item.MYTHRIL_INGOT,            weight =   0 }, -- Mythril Ingot
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,     weight =  52 }, -- Chunk Of Mythril Ore
        { itemId = xi.item.PETRIFIED_LOG,            weight = 116 }, -- Petrified Log
        { itemId = xi.item.PHOENIX_FEATHER,          weight =  15 }, -- Phoenix Feather
        { itemId = xi.item.PHILOSOPHERS_STONE,       weight =  56 }, -- Philosophers Stone
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,    weight =  45 }, -- Chunk Of Platinum Ore
        { itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH,  weight =  22 }, -- Square Of Rainbow Cloth
        { itemId = xi.item.RAM_HORN,                 weight =  67 }, -- Ram Horn
        { itemId = xi.item.SQUARE_OF_RAXA,           weight = 119 }, -- Square Of Raxa
        { itemId = xi.item.RERAISER,                 weight =  45 }, -- Reraiser
        { itemId = xi.item.VILE_ELIXIR,              weight =  19 }, -- Vile Elixir
        { itemId = xi.item.VILE_ELIXIR_P1,           weight =  41 }, -- Vile Elixir +1
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =  34 }, -- Handful Of Wyvern Scales
    },

    {
        { itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =  78 }, -- Vial Of Black Beetle Blood
        { itemId = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =  56 }, -- Square Of Damascene Cloth
        { itemId = xi.item.DAMASCUS_INGOT,             weight =  93 }, -- Damascus Ingot
        { itemId = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =  56 }, -- Spool Of Malboro Fiber
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight = 157 }, -- Philosophers Stone
        { itemId = xi.item.PHOENIX_FEATHER,            weight = 276 }, -- Phoenix Feather
        { itemId = xi.item.SQUARE_OF_RAXA,             weight = 209 }, -- Square Of Raxa
    },
}

return content:register()
