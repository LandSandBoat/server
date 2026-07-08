xi = xi or {}
xi.assault = xi.assault or {}

---@enum xi.assaultArea
xi.assault.assaultArea =
{
    LEUJAOAM_SANCTUM           = 0,
    MAMOOL_JA_TRAINING_GROUNDS = 1,
    LEBROS_CAVERN              = 2,
    PERIQIA                    = 3,
    ILRUSI_ATOLL               = 4,
    NYZUL_ISLE                 = 5,
}

---@enum xi.mission
xi.assault.mission =
{
    LEUJAOAM_CLEANSING                = 1,
    ORICHALCUM_SURVEY                 = 2,
    ESCORT_PROFESSOR_CHANOIX          = 3,
    SHANARHA_GRASS_CONSERVATION       = 4,
    COUNTING_SHEEP                    = 5,
    SUPPLIES_RECOVERY                 = 6,
    AZURE_EXPERIMENTS                 = 7,
    IMPERIAL_CODE                     = 8,
    RED_VERSUS_BLUE                   = 9,
    BLOODY_RONDO                      = 10,
    IMPERIAL_AGENT_RESCUE             = 11,
    PREEMPTIVE_STRIKE                 = 12,
    SAGELORD_ELIMINATION              = 13,
    BREAKING_MORALE                   = 14,
    THE_DOUBLE_AGENT                  = 15,
    IMPERIAL_TREASURE_RETRIEVAL       = 16,
    BLITZKRIEG                        = 17,
    MARIDS_IN_THE_MIST                = 18,
    AZURE_AILMENTS                    = 19,
    THE_SUSANOO_SHUFFLE               = 20,
    EXCAVATION_DUTY                   = 21,
    LEBROS_SUPPLIES                   = 22,
    TROLL_FUGITIVES                   = 23,
    EVADE_AND_ESCAPE                  = 24,
    SIEGEMASTER_ASSASSINATION         = 25,
    APKALLU_BREEDING                  = 26,
    WAMOURA_FARM_RAID                 = 27,
    EGG_CONSERVATION                  = 28,
    OPERATION_BLACK_PEARL             = 29,
    BETTER_THAN_ONE                   = 30,
    SEAGULL_GROUNDED                  = 31,
    REQUIEM                           = 32,
    SAVING_PRIVATE_RYAAF              = 33,
    SHOOTING_DOWN_THE_BARON           = 34,
    BUILDING_BRIDGES                  = 35,
    STOP_THE_BLOODSHED                = 36,
    DEFUSE_THE_THREAT                 = 37,
    OPERATION_SNAKE_EYES              = 38,
    WAKE_THE_PUPPET                   = 39,
    THE_PRICE_IS_RIGHT                = 40,
    GOLDEN_SALVAGE                    = 41,
    LAMIA_NO_13                       = 42,
    EXTERMINATION                     = 43,
    DEMOLITION_DUTY                   = 44,
    SEARAT_SALVATION                  = 45,
    APKALLU_SEIZURE                   = 46,
    LOST_AND_FOUND                    = 47,
    DESERTER                          = 48,
    DESPERATELY_SEEKING_CEPHALOPODS   = 49,
    BELLEROPHONS_BLISS                = 50,
    NYZUL_ISLE_INVESTIGATION          = 51,
    NYZUL_ISLE_UNCHARTED_AREA_SURVEY  = 52,
}

---@enum xi.assault.mercenaryRank
xi.assault.mercenaryRank =
{
    PRIVATE_SECOND_CLASS = 1,
    PRIVATE_FIRST_CLASS  = 2,
    SUPERIOR_PRIVATE     = 3,
    LANCE_CORPORAL       = 4,
    CORPORAL             = 5,
    SERGEANT             = 6,
    SERGEANT_MAJOR       = 7,
    CHIEF_SERGEANT       = 8,
    SECOND_LIEUTENANT    = 9,
    FIRST_LIEUTENANT     = 10,
    CAPTAIN              = 11,
}

---@enum xi.assault.instance
xi.assault.instance =
{
    -- Ilrusi Atoll
    GOLDEN_SALVAGE                  = 5500,
    LAMIA_NO_13                     = 5501,
    EXTERMINATION                   = 5502,
    DEMOLITION_DUTY                 = 5503,
    SEARAT_SALVATION                = 5504,
    APKALLU_SEIZURE                 = 5505,
    LOST_AND_FOUND                  = 5506,
    DESERTER                        = 5507,
    DESPERATELY_SEEKING_CEPHALOPODS = 5508,
    BELLEROPHONS_BLISS              = 5509,

    -- Periqia
    SEAGULL_GROUNDED                = 5601,
    REQUIEM                         = 5602,
    SAVING_PRIVATE_RYAAF            = 5603,
    SHOOTING_DOWN_THE_BARON         = 5604,
    BUILDING_BRIDGES                = 5605,
    STOP_THE_BLOODSHED              = 5606,
    DEFUSE_THE_THREAT               = 5607,
    OPERATION_SNAKE_EYES            = 5608,
    WAKE_THE_PUPPET                 = 5609,
    THE_PRICE_IS_RIGHT              = 5610,

    -- Lebros Cavern
    EXCAVATION_DUTY                 = 6300,
    LEBROS_SUPPLIES                 = 6301,
    TROLL_FUGITIVES                 = 6302,
    EVADE_AND_ESCAPE                = 6303,
    SIEGEMASTER_ASSASSINATION       = 6304,
    APKALLU_BREEDING                = 6305,
    WAMOURA_FARM_RAID               = 6306,
    EGG_CONSERVATION                = 6307,
    OPERATION_BLACK_PEARL           = 6308,
    BETTER_THAN_ONE                 = 6309,

    -- Mamool Ja Training Grounds
    IMPERIAL_AGENT_RESCUE           = 6600,
    PREEMPTIVE_STRIKE               = 6601,
    SAGELORD_ELIMINATION            = 6602,
    BREAKING_MORALE                 = 6603,
    THE_DOUBLE_AGENT                = 6604,
    IMPERIAL_TREASURE_RETRIEVAL     = 6605,
    BLITZKRIEG                      = 6606,
    MARIDS_IN_THE_MIST              = 6607,
    AZURE_AILMENTS                  = 6608,
    THE_SUSANOO_SHUFFLE             = 6609,

    -- Leujaoam Sanctum
    LEUJAOAM_CLEANSING              = 6900,
    ORICHALCUM_SURVEY               = 6901,
    ESCORT_PROFESSOR_CHANOIX        = 6902,
    SHANARHA_GRASS_CONSERVATION     = 6903,
    COUNTING_SHEEP                  = 6904,
    SUPPLIES_RECOVERY               = 6905,
    AZURE_EXPERIMENTS               = 6906,
    IMPERIAL_CODE                   = 6907,
    RED_VERSUS_BLUE                 = 6908,
    BLOODY_RONDO                    = 6909,
}
