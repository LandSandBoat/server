-----------------------------------
-- Assault Data Tables
-- desc: Static data tables for the Assault system. All per-area
--       lookups, shop inventories, and level cap tables live here.
-----------------------------------
xi = xi or {}
xi.assault = xi.assault or {}
-----------------------------------

-- Ordered list of all assault orders key items, used for hasOrders checks
xi.assault.assaultOrders =
{
    xi.ki.LEUJAOAM_ASSAULT_ORDERS,
    xi.ki.MAMOOL_JA_ASSAULT_ORDERS,
    xi.ki.LEBROS_ASSAULT_ORDERS,
    xi.ki.PERIQIA_ASSAULT_ORDERS,
    xi.ki.ILRUSI_ASSAULT_ORDERS,
    xi.ki.NYZUL_ISLE_ASSAULT_ORDERS,
}

xi.assault.areaData =
{
    [xi.assault.assaultArea.LEUJAOAM_SANCTUM] =
    {
        orders  = xi.ki.LEUJAOAM_ASSAULT_ORDERS,
        map     = xi.ki.MAP_OF_LEUJAOAM_SANCTUM,
        firefly = xi.item.CAGE_OF_AZOUPH_FIREFLIES,
    },
    [xi.assault.assaultArea.MAMOOL_JA_TRAINING_GROUNDS] =
    {
        orders  = xi.ki.MAMOOL_JA_ASSAULT_ORDERS,
        map     = xi.ki.MAP_OF_THE_TRAINING_GROUNDS,
        firefly = xi.item.CAGE_OF_BHAFLAU_FIREFLIES,
    },
    [xi.assault.assaultArea.LEBROS_CAVERN] =
    {
        orders  = xi.ki.LEBROS_ASSAULT_ORDERS,
        map     = xi.ki.MAP_OF_LEBROS_CAVERN,
        firefly = xi.item.CAGE_OF_ZHAYOLM_FIREFLIES,
    },
    [xi.assault.assaultArea.PERIQIA] =
    {
        orders  = xi.ki.PERIQIA_ASSAULT_ORDERS,
        map     = xi.ki.MAP_OF_PERIQIA,
        firefly = xi.item.CAGE_OF_DVUCCA_FIREFLIES,
    },
    [xi.assault.assaultArea.ILRUSI_ATOLL] =
    {
        orders  = xi.ki.ILRUSI_ASSAULT_ORDERS,
        map     = xi.ki.MAP_OF_ILRUSI_ATOLL,
        firefly = xi.item.CAGE_OF_REEF_FIREFLIES,
    },
}

xi.assault.zoneToArea =
{
    [xi.zone.LEUJAOAM_SANCTUM]           = xi.assault.assaultArea.LEUJAOAM_SANCTUM,
    [xi.zone.MAMOOL_JA_TRAINING_GROUNDS] = xi.assault.assaultArea.MAMOOL_JA_TRAINING_GROUNDS,
    [xi.zone.LEBROS_CAVERN]              = xi.assault.assaultArea.LEBROS_CAVERN,
    [xi.zone.PERIQIA]                    = xi.assault.assaultArea.PERIQIA,
    [xi.zone.ILRUSI_ATOLL]               = xi.assault.assaultArea.ILRUSI_ATOLL,
}

xi.assault.missionsByArea =
{
    [xi.assault.assaultArea.LEUJAOAM_SANCTUM] =
    {
        xi.assault.mission.LEUJAOAM_CLEANSING,
        xi.assault.mission.ORICHALCUM_SURVEY,
        xi.assault.mission.ESCORT_PROFESSOR_CHANOIX,
        xi.assault.mission.SHANARHA_GRASS_CONSERVATION,
        xi.assault.mission.COUNTING_SHEEP,
        xi.assault.mission.SUPPLIES_RECOVERY,
        xi.assault.mission.AZURE_EXPERIMENTS,
        xi.assault.mission.IMPERIAL_CODE,
        xi.assault.mission.RED_VERSUS_BLUE,
        xi.assault.mission.BLOODY_RONDO,
    },
    [xi.assault.assaultArea.MAMOOL_JA_TRAINING_GROUNDS] =
    {
        xi.assault.mission.IMPERIAL_AGENT_RESCUE,
        xi.assault.mission.PREEMPTIVE_STRIKE,
        xi.assault.mission.SAGELORD_ELIMINATION,
        xi.assault.mission.BREAKING_MORALE,
        xi.assault.mission.THE_DOUBLE_AGENT,
        xi.assault.mission.IMPERIAL_TREASURE_RETRIEVAL,
        xi.assault.mission.BLITZKRIEG,
        xi.assault.mission.MARIDS_IN_THE_MIST,
        xi.assault.mission.AZURE_AILMENTS,
        xi.assault.mission.THE_SUSANOO_SHUFFLE,
    },
    [xi.assault.assaultArea.LEBROS_CAVERN] =
    {
        xi.assault.mission.EXCAVATION_DUTY,
        xi.assault.mission.LEBROS_SUPPLIES,
        xi.assault.mission.TROLL_FUGITIVES,
        xi.assault.mission.EVADE_AND_ESCAPE,
        xi.assault.mission.SIEGEMASTER_ASSASSINATION,
        xi.assault.mission.APKALLU_BREEDING,
        xi.assault.mission.WAMOURA_FARM_RAID,
        xi.assault.mission.EGG_CONSERVATION,
        xi.assault.mission.OPERATION_BLACK_PEARL,
        xi.assault.mission.BETTER_THAN_ONE,
    },
    [xi.assault.assaultArea.PERIQIA] =
    {
        xi.assault.mission.SEAGULL_GROUNDED,
        xi.assault.mission.REQUIEM,
        xi.assault.mission.SAVING_PRIVATE_RYAAF,
        xi.assault.mission.SHOOTING_DOWN_THE_BARON,
        xi.assault.mission.BUILDING_BRIDGES,
        xi.assault.mission.STOP_THE_BLOODSHED,
        xi.assault.mission.DEFUSE_THE_THREAT,
        xi.assault.mission.OPERATION_SNAKE_EYES,
        xi.assault.mission.WAKE_THE_PUPPET,
        xi.assault.mission.THE_PRICE_IS_RIGHT,
    },
    [xi.assault.assaultArea.ILRUSI_ATOLL] =
    {
        xi.assault.mission.GOLDEN_SALVAGE,
        xi.assault.mission.LAMIA_NO_13,
        xi.assault.mission.EXTERMINATION,
        xi.assault.mission.DEMOLITION_DUTY,
        xi.assault.mission.SEARAT_SALVATION,
        xi.assault.mission.APKALLU_SEIZURE,
        xi.assault.mission.LOST_AND_FOUND,
        xi.assault.mission.DESERTER,
        xi.assault.mission.DESPERATELY_SEEKING_CEPHALOPODS,
        xi.assault.mission.BELLEROPHONS_BLISS,
    },

    [xi.assault.assaultArea.NYZUL_ISLE] =
    {
        xi.assault.mission.NYZUL_ISLE_INVESTIGATION,
        xi.assault.mission.NYZUL_ISLE_UNCHARTED_AREA_SURVEY,
    },
}

xi.assault.missionToArea = {}
for area, missions in pairs(xi.assault.missionsByArea) do
    for _, missionId in ipairs(missions) do
        xi.assault.missionToArea[missionId] = area
    end
end

xi.assault.levelCapByIndex =
{
    [0] = 0,   -- No level cap
    [1] = 70,
    [2] = 60,
    [3] = 50,
}

-- Assault Point shop inventories per area
xi.assault.shops =
{
    [xi.assault.assaultArea.LEUJAOAM_SANCTUM] =
    {
        [1]  = { itemid = xi.item.STOIC_EARRING,                price =  3000 },
        [2]  = { itemid = xi.item.UNFETTERED_RING,              price =  5000 },
        [3]  = { itemid = xi.item.TEMPERED_CHAIN,               price =  8000 },
        [4]  = { itemid = xi.item.POTENT_BELT,                  price = 10000 },
        [5]  = { itemid = xi.item.MIRACULOUS_CAPE,              price = 10000 },
        [6]  = { itemid = xi.item.YIGIT_BULAWA,                 price = 10000 },
        [7]  = { itemid = xi.item.IMPERIAL_BHUJ,                price = 15000 },
        [8]  = { itemid = xi.item.PAHLUWAN_PATAS,               price = 15000 },
        [9]  = { itemid = xi.item.AMIR_KOLLUKS,                 price = 15000 },
        [10] = { itemid = xi.item.PAHLUWAN_QALANSUWA,           price = 20000 },
        [11] = { itemid = xi.item.YIGIT_SERAWEELS,              price = 20000 },
        [12] = { itemid = xi.item.CIPHER_OF_OVJANGS_ALTER_EGO,  price =  3000 },
        [13] = { itemid = xi.item.CIPHER_OF_MNEJINGS_ALTER_EGO, price =  3000 },
    },

    [xi.assault.assaultArea.MAMOOL_JA_TRAINING_GROUNDS] =
    {
        [1]  = { itemid = xi.item.ANTIVENOM_EARRING,            price =  3000 },
        [2]  = { itemid = xi.item.EBULLIENT_RING,               price =  5000 },
        [3]  = { itemid = xi.item.ENLIGHTENED_CHAIN,            price =  8000 },
        [4]  = { itemid = xi.item.SPECTRAL_BELT,                price = 10000 },
        [5]  = { itemid = xi.item.BULLSEYE_CAPE,                price = 10000 },
        [6]  = { itemid = xi.item.STORM_TULWAR,                 price = 15000 },
        [7]  = { itemid = xi.item.IMPERIAL_NEZA,                price = 15000 },
        [8]  = { itemid = xi.item.STORM_TABAR,                  price = 15000 },
        [9]  = { itemid = xi.item.YIGIT_GAGES,                  price = 20000 },
        [10] = { itemid = xi.item.AMIR_BOOTS,                   price = 20000 },
        [11] = { itemid = xi.item.PAHLUWAN_SERAWEELS,           price = 20000 },
        [12] = { itemid = xi.item.CIPHER_OF_OVJANGS_ALTER_EGO,  price =  3000 },
        [13] = { itemid = xi.item.CIPHER_OF_MNEJINGS_ALTER_EGO, price =  3000 },
    },

    [xi.assault.assaultArea.LEBROS_CAVERN] =
    {
        [1]  = { itemid = xi.item.INSOMNIA_EARRING,             price =  3000 },
        [2]  = { itemid = xi.item.HALE_RING,                    price =  5000 },
        [3]  = { itemid = xi.item.CHIVALROUS_CHAIN,             price =  8000 },
        [4]  = { itemid = xi.item.PRECISE_BELT,                 price = 10000 },
        [5]  = { itemid = xi.item.INTENSIFYING_CAPE,            price = 10000 },
        [6]  = { itemid = xi.item.IMPERIAL_POLE,                price = 15000 },
        [7]  = { itemid = xi.item.DOOMBRINGER,                  price = 15000 },
        [8]  = { itemid = xi.item.SAYOSAMONJI,                  price = 15000 },
        [9]  = { itemid = xi.item.PAHLUWAN_DASTANAS,            price = 20000 },
        [10] = { itemid = xi.item.YIGIT_CRACKOWS,               price = 20000 },
        [11] = { itemid = xi.item.AMIR_KORAZIN,                 price = 20000 },
        [12] = { itemid = xi.item.CIPHER_OF_OVJANGS_ALTER_EGO,  price =  3000 },
        [13] = { itemid = xi.item.CIPHER_OF_MNEJINGS_ALTER_EGO, price =  3000 },
    },

    [xi.assault.assaultArea.PERIQIA] =
    {
        [1]  = { itemid = xi.item.VISION_EARRING,               price =  3000 },
        [2]  = { itemid = xi.item.UNYIELDING_RING,              price =  5000 },
        [3]  = { itemid = xi.item.FORTIFIED_CHAIN,              price =  8000 },
        [4]  = { itemid = xi.item.RESOLUTE_BELT,                price = 10000 },
        [5]  = { itemid = xi.item.BUSHIDO_CAPE,                 price = 10000 },
        [6]  = { itemid = xi.item.KHANJAR,                      price = 15000 },
        [7]  = { itemid = xi.item.HOTARUMARU,                   price = 15000 },
        [8]  = { itemid = xi.item.IMPERIAL_GUN,                 price = 15000 },
        [9]  = { itemid = xi.item.AMIR_PUGGAREE,                price = 20000 },
        [10] = { itemid = xi.item.PAHLUWAN_CRACKOWS,            price = 20000 },
        [11] = { itemid = xi.item.YIGIT_GOMLEK,                 price = 20000 },
        [12] = { itemid = xi.item.CIPHER_OF_OVJANGS_ALTER_EGO,  price =  3000 },
        [13] = { itemid = xi.item.CIPHER_OF_MNEJINGS_ALTER_EGO, price =  3000 },
    },

    [xi.assault.assaultArea.ILRUSI_ATOLL] =
    {
        [1]  = { itemid = xi.item.VELOCITY_EARRING,             price =  3000 },
        [2]  = { itemid = xi.item.GARRULOUS_RING,               price =  5000 },
        [3]  = { itemid = xi.item.GRANDIOSE_CHAIN,              price =  8000 },
        [4]  = { itemid = xi.item.HURLING_BELT,                 price = 10000 },
        [5]  = { itemid = xi.item.INVIGORATING_CAPE,            price = 10000 },
        [6]  = { itemid = xi.item.IMPERIAL_KAMAN,               price = 15000 },
        [7]  = { itemid = xi.item.STORM_ZAGHNAL,                price = 15000 },
        [8]  = { itemid = xi.item.STORM_FIFE,                   price = 15000 },
        [9]  = { itemid = xi.item.YIGIT_TURBAN,                 price = 20000 },
        [10] = { itemid = xi.item.AMIR_DIRS,                    price = 20000 },
        [11] = { itemid = xi.item.PAHLUWAN_KHAZAGAND,           price = 20000 },
        [12] = { itemid = xi.item.CIPHER_OF_OVJANGS_ALTER_EGO,  price =  3000 },
        [13] = { itemid = xi.item.CIPHER_OF_MNEJINGS_ALTER_EGO, price =  3000 },
    },
}
