-----------------------------------
-- Battlefield Functions
-----------------------------------
require('scripts/globals/pathfind')
-----------------------------------
xi = xi or {}

local maxAreas =
{
    {
        Max   = 8,
        Zones =
        {
            xi.zone.TEMENOS,
        },
    },

    {
        Max   = 6,
        Zones =
        {
            xi.zone.APOLLYON,
        },
    },

    {
        Max   = 1,
        Zones =
        {
            xi.zone.DYNAMIS_VALKURM,
            xi.zone.DYNAMIS_BUBURIMU,
            xi.zone.DYNAMIS_QUFIM,
            xi.zone.DYNAMIS_TAVNAZIA,
            xi.zone.DYNAMIS_BEAUCEDINE,
            xi.zone.DYNAMIS_XARCABARD,
            xi.zone.DYNAMIS_SAN_DORIA,
            xi.zone.DYNAMIS_BASTOK,
            xi.zone.DYNAMIS_WINDURST,
            xi.zone.DYNAMIS_JEUNO,
            xi.zone.RIVERNE_SITE_B01,
            xi.zone.GHELSBA_OUTPOST,
            xi.zone.THE_GARDEN_OF_RUHMET
        },
    },
}

function onBattlefieldHandlerInitialise(zone)
    local id      = zone:getID()
    local default = 3

    for _, battlefield in pairs(maxAreas) do
        for _, zoneid in pairs(battlefield.Zones) do
            if id == zoneid then
                return battlefield.Max
            end
        end
    end

    return default
end

xi.loot = xi.loot or {}

xi.loot.weight =
{
    EXTREMELY_LOW  = 2,
    VERY_LOW       = 10,
    LOW            = 30,
    NORMAL         = 50,
    HIGH           = 70,
    VERY_HIGH      = 100,
    EXTREMELY_HIGH = 140,
}

xi.battlefield = xi.battlefield or {}
xi.battlefield.contents = xi.battlefield.contents or {}
xi.battlefield.contentsByZone = xi.battlefield.contentsByZone or {}

xi.battlefield.status =
{
    OPEN     = 0,
    LOCKED   = 1,
    WON      = 2,
    LOST     = 3,
}

xi.battlefield.returnCode =
{
    WAIT              = 1,
    CUTSCENE          = 2,
    INCREMENT_REQUEST = 3,
    LOCKED            = 4,
    REQS_NOT_MET      = 5,
    BATTLEFIELD_FULL  = 6
}

xi.battlefield.leaveCode =
{
    EXIT   = 1,
    WON    = 2,
    WARPDC = 3,
    LOST   = 4
}

xi.battlefield.id =
{
    RANK_2_MISSION_1                           = 0,   -- Converted
    TAILS_OF_WOE                               = 1,   -- Converted
    DISMEMBERMENT_BRIGADE                      = 2,   -- Converted
    THE_SECRET_WEAPON                          = 3,   -- Converted
    HOSTILE_HERBIVORES                         = 4,   -- Converted
    SHATTERING_STARS_WAR                       = 5,   -- Converted
    SHATTERING_STARS_BLM                       = 6,   -- Converted
    SHATTERING_STARS_RNG                       = 7,   -- Converted
    CARAPACE_COMBATANTS                        = 8,   -- Converted
    SHOOTING_FISH                              = 9,   -- Experimental
    DROPPING_LIKE_FLIES                        = 10,  -- Converted
    HORNS_OF_WAR                               = 11,  -- Experimental
    UNDER_OBSERVATION                          = 12,  -- Converted
    EYE_OF_THE_TIGER                           = 13,  -- Converted
    SHOTS_IN_THE_DARK                          = 14,  -- Experimental
    DOUBLE_DRAGONIAN                           = 15,  -- Converted
    TODAYS_HOROSCOPE                           = 16,
    CONTAMINATED_COLOSSEUM                     = 17,  -- Converted
    KINDERGARTEN_CAP                           = 18,
    LAST_ORC_SHUNNED_HERO                      = 19,
    BEYOND_INFINITY_HORLAIS_PEAK               = 20,  -- Converted
    AMAN_TROVE_MARS_HORLAIS_PEAK               = 24,  -- Incomplete
    AMAN_TROVE_VENUS_HORLAIS_PEAK              = 25,  -- Incomplete
    SAVE_THE_CHILDREN                          = 32,  -- Converted
    HOLY_CREST                                 = 33,  -- Converted
    WINGS_OF_FURY                              = 34,  -- Converted
    PETRIFYING_PAIR                            = 35,  -- Converted
    TOADAL_RECALL                              = 36,  -- Converted
    MIRROR_MIRROR                              = 37,
    RANK_2_MISSION_2                           = 64,  -- Converted
    WORMS_TURN                                 = 65,  -- Converted
    GRIMSHELL_SHOCKTROOPERS                    = 66,  -- Converted
    ON_MY_WAY                                  = 67,  -- Converted
    THIEF_IN_NORG                              = 68,  -- Converted
    THREE_TWO_ONE                              = 69,  -- Converted
    SHATTERING_STARS_RDM                       = 70,  -- Converted
    SHATTERING_STARS_THF                       = 71,  -- Converted
    SHATTERING_STARS_BST                       = 72,  -- Converted
    BIRDS_OF_A_FEATHER                         = 73,  -- Converted
    CRUSTACEAN_CONUNDRUM                       = 74,  -- Experimental
    GROVE_GUARDIANS                            = 75,  -- Converted
    HILLS_ARE_ALIVE                            = 76,  -- Experimental
    ROYAL_JELLY                                = 77,  -- Converted
    FINAL_BOUT                                 = 78,  -- Experimental
    UP_IN_ARMS                                 = 79,  -- Converted
    COPYCAT                                    = 80,
    OPERATION_DESERT_SWARM                     = 81,  -- Experimental
    PREHISTORIC_PIGEONS                        = 82,  -- Experimental
    PALBOROUGH_PROJECT                         = 83,
    SHELL_SHOCKED                              = 84,
    BEYOND_INFINITY_WAUGHROON_SHRINE           = 85,  -- Converted
    RANK_2_MISSION                             = 96,  -- Converted
    STEAMED_SPROUTS                            = 97,  -- Converted
    DIVINE_PUNISHERS                           = 98,  -- Converted
    SAINTLY_INVITATION                         = 99,  -- Converted
    TREASURE_AND_TRIBULATIONS                  = 100, -- Converted
    SHATTERING_STARS_MNK                       = 101, -- Converted
    SHATTERING_STARS_WHM                       = 102, -- Converted
    SHATTERING_STARS_SMN                       = 103, -- Converted
    CREEPING_DOOM                              = 104, -- Converted
    CHARMING_TRIO                              = 105, -- Converted
    HAREM_SCAREM                               = 106, -- Converted
    EARLY_BIRD_CATCHES_THE_WYRM                = 107, -- Experimental
    ROYAL_SUCCESSION                           = 108, -- Converted
    RAPID_RAPTORS                              = 109, -- Converted
    WILD_WILD_WHISKERS                         = 110, -- Converted
    SEASONS_GREETINGS                          = 111,
    ROYALE_RAMBLE                              = 112,
    MOA_CONSTRICTORS                           = 113,
    V_FORMATION                                = 114,
    AVIAN_APOSTATES                            = 115,
    BEYOND_INFINITY_BALGAS_DAIS                = 116, -- Converted
    TEMPLE_OF_UGGALEPIH                        = 128, -- Converted
    JUNGLE_BOOGYMEN                            = 129, -- Converted
    AMPHIBIAN_ASSAULT                          = 130, -- Converted
    PROJECT_SHANTOTTOFICATION                  = 131,
    WHOM_WILT_THOU_CALL                        = 132,
    SHADOW_LORD_BATTLE                         = 160,
    WHERE_TWO_PATHS_CONVERGE                   = 161,
    KINDRED_SPIRITS                            = 162,
    SURVIVAL_OF_THE_WISEST                     = 163,
    SMASH_A_MALEVOLENT_MENACE                  = 164, -- Experimental
    THROUGH_THE_QUICKSAND_CAVES                = 192, -- Converted
    LEGION_XI_COMITATENSIS                     = 193, -- Converted
    SHATTERING_STARS_SAM                       = 194, -- Converted
    SHATTERING_STARS_NIN                       = 195, -- Converted
    SHATTERING_STARS_DRG                       = 196, -- Converted
    CACTUAR_SUAVE                              = 197,
    EYE_OF_THE_STORM                           = 198, -- Converted
    SCARLET_KING                               = 199,
    CAT_BURGLAR_BARES_FANGS                    = 200, -- Experimental
    DRAGON_SCALES                              = 201,
    MOONLIT_PATH                               = 224, -- Converted
    MOON_READING                               = 225, -- Converted
    WAKING_THE_BEAST_FULLMOON                  = 226,
    BATTARU_ROYALE                             = 227,
    RETURN_TO_DELKFUTTS_TOWER                  = 256,
    INDOMITABLE_TRIUMVIRATE_VS3                = 257,
    DAUNTLESS_DUO_VS2                          = 258,
    SOLITARY_DEMOLISHER_VS1                    = 259,
    HEROINES_COMBAT                            = 260,
    MERCENARY_CAMP                             = 261,
    ODE_OF_LIFE_BESTOWING                      = 262,
    ARK_ANGELS_1                               = 288, -- Converted
    ARK_ANGELS_2                               = 289, -- Converted
    ARK_ANGELS_3                               = 290, -- Converted
    ARK_ANGELS_4                               = 291, -- Converted
    ARK_ANGELS_5                               = 292, -- Converted
    DIVINE_MIGHT                               = 293, -- Converted
    CELESTIAL_NEXUS                            = 320, -- Converted
    FIAT_LUX                                   = 352,
    DARKNESS_DESCENDS                          = 353,
    BONDS_OF_MYTHRIL                           = 354,
    MAIDEN_OF_THE_DUSK                         = 385,
    TRIAL_BY_WIND                              = 416, -- Converted
    CARBUNCLE_DEBACLE_CLOISTER_OF_GALES        = 417, -- Converted
    TRIAL_SIZE_TRIAL_BY_WIND                   = 418, -- Converted
    WAKING_THE_BEAST_CLOISTER_OF_GALES         = 419,
    SUGAR_COATED_DIRECTIVE_CLOISTER_OF_GALES   = 420, -- Converted
    TRIAL_BY_LIGHTNING                         = 448, -- Converted
    CARBUNCLE_DEBACLE_CLOISTER_OF_STORMS       = 449, -- Converted
    TRIAL_SIZE_TRIAL_BY_LIGHTNING              = 450, -- Converted
    WAKING_THE_BEAST_CLOISTER_OF_STORMS        = 451,
    SUGAR_COATED_DIRECTIVE_CLOISTER_OF_STORMS  = 452, -- Converted
    TRIAL_BY_ICE                               = 480, -- Converted
    CLASS_REUNION                              = 481, -- Converted
    TRIAL_SIZE_TRIAL_BY_ICE                    = 482, -- Converted
    WAKING_THE_BEAST_CLOISTER_OF_FROST         = 483,
    SUGAR_COATED_DIRECTIVE_CLOISTER_OF_FROST   = 484, -- Converted
    RANK_5_MISSION                             = 512, -- Converted
    COME_INTO_MY_PARLOR                        = 513,
    E_VASE_IVE_ACTION                          = 514,
    INFERNAL_SWARM                             = 515,
    HEIR_TO_THE_LIGHT                          = 516, -- Converted
    SHATTERING_STARS_PLD                       = 517, -- Converted
    SHATTERING_STARS_DRK                       = 518, -- Converted
    SHATTERING_STARS_BRD                       = 519, -- Converted
    DEMOLITION_SQUAD                           = 520, -- Converted
    DIE_BY_THE_SWORD                           = 521, -- Converted
    LET_SLEEPING_DOGS_DIE                      = 522, -- Converted
    BROTHERS_D_AURPHE                          = 523, -- Converted
    UNDYING_PROMISE                            = 524, -- Converted
    FACTORY_REJECTS                            = 525, -- Converted
    IDOL_THOUGHTS                              = 526, -- Converted
    AWFUL_AUTOPSY                              = 527, -- Converted
    CELERY                                     = 528, -- Experimental
    MIRROR_IMAGES                              = 529,
    FURIOUS_FINALE                             = 530,
    CLASH_OF_THE_COMRADES                      = 531,
    THOSE_WHO_LURK_IN_SHADOWS                  = 532, -- Experimental
    BEYOND_INFINITY                            = 533, -- Converted
    TRIAL_BY_FIRE                              = 544, -- Converted
    TRIAL_SIZE_TRIAL_BY_FIRE                   = 545, -- Converted
    WAKING_THE_BEAST_CLOISTER_OF_FLAMES        = 546,
    SUGAR_COATED_DIRECTIVE_CLOISTER_OF_FLAMES  = 547, -- Converted
    TRIAL_BY_EARTH                             = 576, -- Converted
    PUPPET_MASTER                              = 577, -- Converted
    TRIAL_SIZE_TRIAL_BY_EARTH                  = 578, -- Converted
    WAKING_THE_BEAST_CLOISTER_OF_TREMORS       = 579,
    SUGAR_COATED_DIRECTIVE_CLOISTER_OF_TREMORS = 580, -- Converted
    TRIAL_BY_WATER                             = 608, -- Converted
    TRIAL_SIZE_TRIAL_BY_WATER                  = 609, -- Converted
    WAKING_THE_BEAST_CLOISTER_OF_TIDES         = 610,
    SUGAR_COATED_DIRECTIVE_CLOISTER_OF_TIDES   = 611, -- Converted
    FLAMES_FOR_THE_DEAD                        = 640, -- Converted
    FOLLOW_THE_WHITE_RABBIT                    = 641,
    WHEN_HELL_FREEZES_OVER                     = 642,
    BROTHERS                                   = 643, -- Converted
    HOLY_COW                                   = 644, -- Converted
    HEAD_WIND                                  = 672, -- Converted
    LIKE_THE_WIND                              = 673, -- Experimental
    SHEEP_IN_ANTLIONS_CLOTHING                 = 674, -- Converted
    SHELL_WE_DANCE                             = 675, -- Experimental
    TOTENTANZ                                  = 676,
    TANGO_WITH_A_TRACKER                       = 677,
    REQUIEM_OF_A_SIN                           = 678,
    ANTAGONISTIC_AMBUSCADE                     = 679,
    DARKNESS_NAMED                             = 704, -- Converted
    TEST_YOUR_MITE                             = 705,
    WAKING_DREAMS                              = 706, -- Converted
    CENTURY_OF_HARDSHIP                        = 736, -- Converted
    RETURN_TO_THE_DEPTHS                       = 737,
    BIONIC_BUG                                 = 738,
    PULLING_THE_STRINGS                        = 739,
    AUTOMATON_ASSAULT                          = 740,
    MOBLINE_COMEDY                             = 741,
    ANCIENT_FLAMES_BECKON_SPIRE_OF_HOLLA       = 768, -- Converted
    SIMULANT                                   = 769,
    EMPTY_HOPES                                = 770,
    ANCIENT_FLAMES_BECKON_SPIRE_OF_DEM         = 800, -- Converted
    YOU_ARE_WHAT_YOU_EAT                       = 801,
    EMPTY_DREAMS                               = 802,
    ANCIENT_FLAMES_BECKON_SPIRE_OF_MEA         = 832, -- Converted
    PLAYING_HOST                               = 833,
    EMPTY_DESIRES                              = 834,
    DESIRES_OF_EMPTINESS                       = 864, -- Converted
    PULLING_THE_PLUG                           = 865,
    EMPTY_ASPIRATIONS                          = 866,
    STORMS_OF_FATE                             = 896, -- Converted
    WYRMKING_DESCENDS                          = 897,
    OURYU_COMETH                               = 928,
    ANCIENT_VOWS                               = 960, -- Converted
    SAVAGE                                     = 961,
    FIRE_IN_THE_SKY                            = 962,
    BAD_SEED                                   = 963,
    BUGARD_IN_THE_CLOUDS                       = 964,
    BELOVED_OF_THE_ATLANTES                    = 965,
    UNINVITED_GUESTS                           = 966,
    NEST_OF_NIGHTMARES                         = 967,
    ONE_TO_BE_FEARED                           = 992,  -- Converted
    WARRIORS_PATH                              = 993,  -- Converted
    WHEN_ANGELS_FALL                           = 1024, -- Converted
    DAWN                                       = 1056, -- Converted
    APOCALYPSE_NIGH                            = 1057, -- Converted
    CALL_TO_ARMS                               = 1088,
    COMPLIMENTS_TO_THE_CHEF                    = 1089,
    PUPPETMASTER_BLUES                         = 1090,
    BREAKING_THE_BONDS_OF_FATE                 = 1091,
    LEGACY_OF_THE_LOST                         = 1092, -- Converted
    TOUGH_NUT_TO_CRACK                         = 1120,
    HAPPY_CASTER                               = 1121,
    OMENS                                      = 1122, -- Converted
    ACHIEVING_TRUE_POWER                       = 1123,
    SHIELD_OF_DIPLOMACY                        = 1124, -- Converted
    MAKING_A_MOCKERY                           = 1152,
    SHADOWS_OF_THE_MIND                        = 1153,
    BEAST_WITHIN                               = 1154,
    MOMENT_OF_TRUTH                            = 1155,
    PUPPET_IN_PERIL                            = 1156, -- Converted
    RIDER_COMETH                               = 1184,
    NW_APOLLYON                                = 1290, -- Converted
    SW_APOLLYON                                = 1291, -- Converted
    NE_APOLLYON                                = 1292, -- Converted
    SE_APOLLYON                                = 1293, -- Converted
    CS_APOLLYON                                = 1294, -- Converted
    CS_APOLLYON_II                             = 1295, -- Converted
    CENTRAL_APOLLYON                           = 1296, -- Converted
    CENTRAL_APOLLYON_II                        = 1297, -- Converted
    TEMENOS_WESTERN_TOWER                      = 1298, -- Converted
    TEMENOS_NORTHERN_TOWER                     = 1299, -- Converted
    TEMENOS_EASTERN_TOWER                      = 1300, -- Converted
    CENTRAL_TEMENOS_BASEMENT                   = 1301, -- Converted
    CENTRAL_TEMENOS_BASEMENT_II                = 1302, -- Converted
    CENTRAL_TEMENOS_1ST_FLOOR                  = 1303, -- Converted
    CENTRAL_TEMENOS_2ND_FLOOR                  = 1304, -- Converted
    CENTRAL_TEMENOS_3RD_FLOOR                  = 1305, -- Converted
    CENTRAL_TEMENOS_4TH_FLOOR                  = 1306, -- Converted
    CENTRAL_TEMENOS_4TH_FLOOR_II               = 1307, -- Converted
    PURPLE_THE_NEW_BLACK                       = 2721, -- Converted
}

xi.battlefield.itemUses =
{
    [xi.item.WARRIORS_TESTIMONY]      = 3,
    [xi.item.MONKS_TESTIMONY]         = 3,
    [xi.item.WHITE_MAGES_TESTIMONY]   = 3,
    [xi.item.BLACK_MAGES_TESTIMONY]   = 3,
    [xi.item.RED_MAGES_TESTIMONY]     = 3,
    [xi.item.THIEFS_TESTIMONY]        = 3,
    [xi.item.PALADINS_TESTIMONY]      = 3,
    [xi.item.DARK_KNIGHTS_TESTIMONY]  = 3,
    [xi.item.BEASTMASTERS_TESTIMONY]  = 3,
    [xi.item.BARDS_TESTIMONY]         = 3,
    [xi.item.RANGERS_TESTIMONY]       = 3,
    [xi.item.SAMURAIS_TESTIMONY]      = 3,
    [xi.item.NINJAS_TESTIMONY]        = 3,
    [xi.item.DRAGOONS_TESTIMONY]      = 3,
    [xi.item.SUMMONERS_TESTIMONY]     = 3,
    [xi.item.BLUE_MAGES_TESTIMONY]    = 3,
    [xi.item.CORSAIRS_TESTIMONY]      = 3,
    [xi.item.PUPPETMASTERS_TESTIMONY] = 3,
}

Battlefield         = setmetatable({}, { __index = Container })
Battlefield.__index = Battlefield

---@diagnostic disable-next-line: duplicate-set-field
Battlefield.__eq    = function(m1, m2)
    return m1.id == m2.id
end

-- Creates a new Battlefield interaction
-- Data takes the following keys:
--  - zoneId: Which zone this battlefield exists within (required)
--  - battlefieldId: Battlefield ID used in the database (required)
--  - maxPlayers: Maximum number of players allowed to enter (required)
--  - timeLimit: Time in seconds alotted to complete the battlefield before being ejected. (required)
--  - index: The index of the battlefield within the zone. This is used to communicate with the client on which menu item this battlefield is. (required)
--  - levelCap: Level cap imposed upon the battlefield. Defaults to 0 - no level cap. (optional)
--  - area: Some battlefields has multiple areas (Burning Circles) while others have fixed areas (Apollyon). Set to have a fixed area. (optional)
--  - entryNpc: The name of the NPC used for entering (required)
--  - exitNpc: The name of the NPC used for exiting (optional)
--  - exitNpcs: The names of the NPC used for exiting (optional)
--  - allowSubjob: Determines if character subjobs are enabled or disabled upon entry. Defaults to true. (optional)
--  - hasWipeGrace: Grants players a 3 minute grace period on a full wipe before ejecting them. Defaults to true. (optional)
--  - canLoseExp: Determines if a character loses experience points upon death while inside the battlefield. Defaults to true. (optional)
--  - showTimer: Show the time remaining in the battlefield in the UI for the player. Defaults to true. (optional)
--  - delayToExit: Amount of time to wait before exiting the battlefield. Defaults to 5 seconds. (optional)
--  - requiredItems: Items required to be traded to enter the battlefield.
--                   Needs to be in the format of { itemid, quantity, useMessage = ID.text.*, wearMessage = ID.text.*, wornMessage = ID.text.* }. (optional)
--  - requiredKeyItems: Key items required to be able to enter the battlefield - these are removed upon entry unless 'keep = true' (optional)
--  - title: Title given to players upon victory (optional)
--  - grantXP: Amount of XP to grant upon victory (optional)
--  - lossEventParams: Parameters given to the loss event (32002). Defaults to none. (optional)
---@diagnostic disable-next-line: duplicate-set-field
function Battlefield:new(data)
    local obj = Container:new(Battlefield.getVarPrefix(data.battlefieldId))

    setmetatable(obj, self)
    obj.zoneId        = data.zoneId
    obj.battlefieldId = data.battlefieldId
    obj.maxPlayers    = data.maxPlayers
    obj.timeLimit     = data.timeLimit
    obj.index         = data.index

    if data.entryNpcs then
        obj.entryNpcs = data.entryNpcs
    elseif data.entryNpc then
        obj.entryNpcs = { data.entryNpc }
    end

    obj.area          = data.area

    if data.exitNpcs then
        obj.exitNpcs = data.exitNpcs
    elseif data.exitNpc then
        obj.exitNpcs = { data.exitNpc }
    end

    obj.title            = data.title
    obj.grantXP          = data.grantXP
    obj.levelCap         = data.levelCap or 0
    obj.allowSubjob      = (data.allowSubjob == nil or data.allowSubjob) or false
    obj.allowTrusts      = data.allowTrusts and data.allowTrusts or false
    obj.hasWipeGrace     = (data.hasWipeGrace == nil or data.hasWipeGrace) or false
    obj.isMission        = data.isMission and data.isMission or false
    obj.canLoseExp       = (data.canLoseExp == nil or data.canLoseExp) or false
    obj.showTimer        = (data.showTimer == nil or data.showTimer) or false
    obj.delayToExit      = data.delayToExit or 5
    obj.requiredItems    = data.requiredItems or {}
    obj.requiredKeyItems = data.requiredKeyItems or {}
    obj.lossEventParams  = data.lossEventParams or {}
    obj.armouryCrates    = data.armouryCrates or false
    obj.experimental     = data.experimental or false
    obj.allowedAreas     = data.allowedAreas

    obj.sections = obj.sections or { { [obj.zoneId] = {} } }
    obj.groups   = {}
    obj.paths    = {}
    obj.loot     = {}

    -- Determine which items need to be traded as the requiredItems format is incompatable with npcUtil.tradeHasExactly
    obj.tradeItems = {}

    for index, value in ipairs(obj.requiredItems) do
        obj.tradeItems[index] = value
    end

    return obj
end

function Battlefield.getVarPrefix(battlefieldID)
    return string.format('Battlefield[%d]', battlefieldID)
end

function Battlefield:register()
    -- Only hookup the entry and exit listeners if there aren't any other battlefields already registered for that entrance
    local setupEvents    = true
    local setupEntryNpcs = true

    if utils.hasKey(self.zoneId, xi.battlefield.contentsByZone) then
        local contents = xi.battlefield.contentsByZone[self.zoneId]

        for _, content in ipairs(contents) do
            -- Always setup listeners if we're reloading a battlefield
            if self.battlefieldId == content.battlefieldId and content.hasListeners then
                setupEvents    = true
                setupEntryNpcs = true

                break
            end

            -- Do not setup events if there are any other battlefields
            setupEvents = false

            -- Do not setup npcs if there is another battlefield using the same entry npc
            if self.entryNpcs then
                for _, entryNpc in ipairs(self.entryNpcs) do
                    if utils.contains(entryNpc, content.entryNpcs) then
                        setupEntryNpcs = false

                        break
                    end
                end
            end
        end
    end

    local zoneSection = self.sections[1][self.zoneId]
    if setupEvents then
        utils.append(zoneSection, {
            onEventUpdate =
            {
                [32000] = Battlefield.redirectEventUpdate,
                [32003] = utils.bind(Battlefield.redirectEventCall, 'onExitEventUpdate'),
            },

            onEventFinish =
            {
                [32000] = utils.bind(Battlefield.redirectEventCall, 'onEventFinishEnter'),
                [32001] = utils.bind(Battlefield.redirectEventCall, 'onEventFinishWin'),
                [32002] = utils.bind(Battlefield.redirectEventCall, 'onEventFinishLeave'),
                [32003] = utils.bind(Battlefield.redirectEventCall, 'onEventFinishExit'),
                [32004] = utils.bind(Battlefield.redirectEventCall, 'onEventFinishBattlefield'),
            }
        })
        self.hasListeners = true
    end

    if setupEntryNpcs and self.entryNpcs then
        for _, entryNpc in ipairs(self.entryNpcs) do
            utils.append(zoneSection, {
                [entryNpc] =
                {
                    onTrade   = Battlefield.onEntryTrade,
                    onTrigger = Battlefield.onEntryTrigger,
                }
            })
        end
    end

    if self.exitNpcs then
        local exitTrigger = self.onExitTrigger and self.onExitTrigger or Battlefield.onExitTrigger
        for _, exitNpc in ipairs(self.exitNpcs) do
            utils.append(zoneSection, {
                [exitNpc] =
                {
                    onTrigger = exitTrigger,
                }
            })
        end
    end

    xi.battlefield.contents[self.battlefieldId] = self

    if utils.hasKey(self.zoneId, xi.battlefield.contentsByZone) then
        table.insert(xi.battlefield.contentsByZone[self.zoneId], self)
    else
        xi.battlefield.contentsByZone[self.zoneId] = { self }
    end

    return self
end

function Battlefield:isValidEntry(player, npc)
    return utils.contains(npc:getName(), self.entryNpcs)
end

-- Allow for Battlefield scripts to easily add additional requirements for entry by
-- redefining this function
function Battlefield:entryRequirement(player, npc, isRegistrant, trade)
    return true
end

function Battlefield:checkRequirements(player, npc, isRegistrant, trade)
    if not self:isValidEntry(player, npc) then
        return false
    end

    -- Do not show battlefields to registrant when either they don't require items and player is trading or
    -- that do require items and but player is not trading
    if isRegistrant and (trade == nil) ~= (#self.tradeItems == 0) then
        return false
    end

    for _, keyItem in ipairs(self.requiredKeyItems) do
        if type(keyItem) == 'table' then

            -- Only need one from the group
            local hasAny = false

            for _, subitem in ipairs(keyItem) do
                if player:hasKeyItem(subitem) then
                    hasAny = true

                    break
                end
            end

            if not hasAny then
                return false
            end

        else
            if not player:hasKeyItem(keyItem) then
                return false
            end
        end
    end

    if trade and #self.tradeItems > 0 then
        if not npcUtil.tradeHasExactly(trade, self.tradeItems) then
            return false
        end
    end

    -- Additional Requirements that may be necessary for battlefield entry
    -- contained within the script itself, defaults to True
    return self:entryRequirement(player, npc, isRegistrant, trade)
end

function Battlefield:checkSkipCutscene(player)
    return false
end

function Battlefield.onEntryTrade(player, npc, trade, onUpdate)
    -- Check if player's party has level sync
    if xi.battlefield.rejectLevelSyncedParty(player, npc) then
        return
    end

    -- Validate trade
    if not trade then
        return
    end

    -- Validate battlefield status
    if player:hasStatusEffect(xi.effect.BATTLEFIELD) and not onUpdate then
        player:messageBasic(xi.msg.basic.WAIT_LONGER, 0, 0)

        return
    end

    -- Check if another party member has battlefield status effect. If so, don't allow trade.
    local alliance = player:getAlliance()

    for _, member in pairs(alliance) do
        if member:hasStatusEffect(xi.effect.BATTLEFIELD) then
            player:messageBasic(xi.msg.basic.WAIT_LONGER, 0, 0)

            return
        end
    end

    local zoneId = player:getZoneID()

    -- Determine which battlefields are available given the traded items
    local options = xi.battlefield.getBattlefieldOptions(player, npc, trade)

    if options == 0 then
        local noEntryMessage = zones[zoneId].text.NO_BATTLEFIELD_ENTRY

        if noEntryMessage then
            player:messageSpecial(noEntryMessage)
        end

        return
    end

    -- Ensure that the traded item(s) are not worn out
    local contents = xi.battlefield.contentsByZone[zoneId]

    for _, content in ipairs(contents) do
        if
            #content.requiredItems > 0 and
            content.requiredItems.wornMessage and
            npcUtil.tradeHas(trade, content.tradeItems)
        then
            local itemId = content.requiredItems[1]
            -- Gets the total number of item uses for the given item. Default to one since that is the majority of them.
            local totalUses = xi.battlefield.itemUses[itemId] or 1

            if player:getWornUses(itemId) >= totalUses then
                if type(content.requiredItems.wornMessage) == 'table' then
                    player:messageSpecial(unpack(content.requiredItems.wornMessage))
                elseif totalUses > 1 then
                    player:messageSpecial(content.requiredItems.wornMessage, itemId)
                else
                    player:messageSpecial(content.requiredItems.wornMessage, 0, 0, 0, itemId)
                end

                return
            end
        end
    end

    if not onUpdate then
        -- Open menu of valid battlefields
        return Battlefield:event(32000, 0, 0, 0, options, 0, 0, 0, 0)
    end
end

function Battlefield.onEntryTrigger(player, npc)
    -- Cannot enter if anyone in party is level/master sync'd
    if xi.battlefield.rejectLevelSyncedParty(player, npc) then
        return
    end

    -- Player has battlefield status effect. That means a battlefield is open OR the player is inside a battlefield.
    if player:hasStatusEffect(xi.effect.BATTLEFIELD) then
        -- Player is outside battlefield. Attempting to enter.
        local status  = player:getStatusEffect(xi.effect.BATTLEFIELD)
        local id      = status:getPower()
        local content = xi.battlefield.contents[id]

        if not content then
            return
        end

        if not content:checkRequirements(player, npc, false) then
            return
        end

        local options = utils.mask.setBit(0, content.index, true)
        return Battlefield:event(32000, 0, 0, 0, options, 0, 0, 0, 0)
    end

    -- Player doesn't have battlefield status effect. That means player wants to register a new battlefield OR is attempting to enter a closed one.
    -- Check if another party member has battlefield status effect. If so, that means the player is trying to enter a closed battlefield.
    local alliance = player:getAlliance()

    for _, member in pairs(alliance) do
        if member:hasStatusEffect(xi.effect.BATTLEFIELD) then
            player:messageSpecial(zones[player:getZoneID()].text.PARTY_MEMBERS_ARE_ENGAGED)
            return
        end
    end

    -- No one in party/alliance has battlefield status effect. We want to register a new battlefield.
    local options = xi.battlefield.getBattlefieldOptions(player, npc)

    -- GMs get access to all BCNMs with visible GM
    if player:getGMLevel() > 0 and player:getVisibleGMLevel() >= 3 then
        options = 268435455
    end

    -- options = 268435455 -- uncomment to open menu with all possible battlefields
    if options == 0 then
        local noEntryMessage = zones[player:getZoneID()].text.NO_BATTLEFIELD_ENTRY

        if noEntryMessage then
            player:messageSpecial(noEntryMessage)
        end

        return
    end

    return Battlefield:event(32000, 0, 0, 0, options, 0, 0, 0, 0)
end

-- Static function to lookup the correct battlefield to handle this event update
function Battlefield.redirectEventUpdate(player, csid, option, npc)
    if option == 0 or option == 255 then
        return false
    end

    local contents = xi.battlefield.contentsByZone[player:getZoneID()]
    local value    = bit.rshift(option, 4)

    for _, content in pairs(contents) do
        if value == content.index then
            content:onEntryEventUpdate(player, csid, option, npc)

            break
        end
    end
end

-- NOTE: Return values from this function impact if the server will honor update position
-- requests or not.  The client will request each area, and so long as we return 0, it
-- will still send the appropriate position packet, but not change the values for the player.

function Battlefield:onEntryEventUpdate(player, csid, option, npc)
    local clearTime = 1
    local name      = 'Meme'
    local partySize = 1
    local area      = self.area or (player:getLocalVar('[battlefield]area') + 1)

    -- NOTE: 'area' is used when there are not multiple arenas present, and cannot be used
    -- if there are indeed multiple areas, but the implementation is partial.  allowedAreas
    -- is used for this purpose, and additional logic on increment request below.  Setting area
    -- for this purpose will cause issues with mob spawning if the implementation has placeholder
    -- areas!  This should be used sparingly and removed upon proper captures for BCNM areas, as
    -- this bypasses all registration logic if the battlefield area is flagged as disabled.

    if
        self.allowedAreas and
        not self.allowedAreas[area]
    then
        if area < 3 then
            player:setLocalVar('[battlefield]area', area)
        else
            player:updateEvent(xi.battlefield.returnCode.WAIT)
        end

        -- TODO: Remove the localVar when issue with function return is resolved
        player:setLocalVar('noPosUpdate', 1)
        return 0
    end

    if self.area then
        area = self.area
    end

    local result = player:registerBattlefield(self.battlefieldId, area, player:getID(), self)
    local status = xi.battlefield.status.OPEN

    if result ~= xi.battlefield.returnCode.CUTSCENE then
        if result == xi.battlefield.returnCode.INCREMENT_REQUEST then
            if area < 3 then
                player:setLocalVar('[battlefield]area', area)
            else
                player:updateEvent(xi.battlefield.returnCode.WAIT)
            end
        end

        -- TODO: Remove the localVar when issue with function return is resolved
        player:setLocalVar('noPosUpdate', 1)
        return 0
    end

    -- Only allow entrance if battlefield is open and player has battlefield effect, witch can be lost mid battlefield selection.
    if
        not player:getBattlefield() and
        player:hasStatusEffect(xi.effect.BATTLEFIELD)
        -- and id:getStatus() == xi.battlefield.status.OPEN -- TODO: Uncomment only once that can-of-worms is dealt with.
    then
        player:enterBattlefield()
    end

    -- Handle record
    local initiatorId = 0
    local battlefield = player:getBattlefield()

    if battlefield then
        name, clearTime, partySize = battlefield:getRecord()
        initiatorId, _ = battlefield:getInitiator()
    end

    -- Register party members
    if initiatorId == player:getID() then
        local effect = player:getStatusEffect(xi.effect.BATTLEFIELD)
        local zone   = player:getZoneID()

        -- Handle traded items if not wearing them
        if
            self.requiredItems.wearMessage == nil and
            #self.tradeItems > 0
        then
            player:tradeComplete()
        end

        -- Handle party/alliance members
        local alliance = player:getAlliance()
        for _, member in pairs(alliance) do
            if
                member:getZoneID() == zone and
                not member:hasStatusEffect(xi.effect.BATTLEFIELD) and
                not member:getBattlefield()
            then
                member:addStatusEffect(effect)
                member:registerBattlefield(self.battlefieldId, area, player:getID(), self)
            end
        end
    end

    local autoSkipCS = self:getLocalVar(player, 'CS') == 1 and 100 or 0
    player:updateEvent(result, self.index, autoSkipCS, clearTime, partySize, self:checkSkipCutscene(player))
    player:updateEventString(name)

    return (status < xi.battlefield.status.LOCKED and result < xi.battlefield.returnCode.LOCKED) and 1 or 0
end

function Battlefield.redirectEventCall(eventName, player, csid, option)
    local battlefieldID = 0
    local battlefield   = player:getBattlefield()

    if battlefield then
        battlefieldID = battlefield:getID()
    else
        battlefieldID = player:getLocalVar('battlefieldID')
    end

    if battlefieldID == 0 then
        return
    end

    local content = xi.battlefield.contents[battlefieldID]
    content[eventName](content, player, csid, option)
end

function Battlefield:onEventFinishEnter(player, csid, option, npc)
    player:setEnteredBattlefield(true)
    player:setLocalVar('[battlefield]area', 0)
    self:setLocalVar(player, 'CS', 1)
end

function Battlefield:onEventFinishWin(player, csid, option, npc)
    if self.title then
        player:addTitle(self.title)
    end

    if self.grantXP then
        player:addExp(self.grantXP)
    end
end

function Battlefield.onExitTrigger(player, npc)
    if player:getBattlefield() then
        return Battlefield:progressCutscene(32003)
    end
end

function Battlefield:onExitEventUpdate(player, csid, option, npc)
    if option == 2 then
        player:updateEvent(3)
    elseif option == 3 then
        player:updateEvent(0)
    end
end

function Battlefield:onEventFinishLeave(player, csid, option, npc)
    player:leaveBattlefield(1)
end

function Battlefield:onEventFinishExit(player, csid, option, npc)
    if option == 4 and player:getBattlefield() then
        player:leaveBattlefield(1)
    end
end

function Battlefield:onEventFinishBattlefield(player, csid, option, npc)
end

-- Override this function if necessary to perform additional steps in battlefield
-- initialise.
function Battlefield:setupBattlefield(battlefield)
end

function Battlefield:onBattlefieldInitialise(battlefield)
    local hasMultipleAreas = not self.area
    battlefield:addGroups(self.groups, hasMultipleAreas)

    -- NOTE: Experimental battlefields are at most partially implemented.  Increase mob levels
    -- for temporary tuning.
    if self.experimental then
        local battlefieldMobs = battlefield:getMobs(true, true)
        for _, mobObj in ipairs(battlefieldMobs) do
            mobObj:setMobLevel(math.min(mobObj:getMainLvl() * 2, 255))
        end
    end

    for mobId, path in pairs(self.paths) do
        GetMobByID(mobId):pathThrough(path, xi.path.flag.PATROL)
    end

    self:setupBattlefield(battlefield)
end

function Battlefield:onBattlefieldTick(battlefield, tick)
    local status        = battlefield:getStatus()
    local cutsceneTimer = battlefield:getLocalVar('cutsceneTimer')
    local isExiting     = status == xi.battlefield.status.LOST or status == xi.battlefield.status.WON

    if isExiting then
        battlefield:setLocalVar('cutsceneTimer', cutsceneTimer - 1)
    end

    -- Check that players haven't all died or that their dead time is over.
    local players = battlefield:getPlayers()
    self:handleWipe(battlefield, players)

    local hasTimeRemaining = xi.battlefield.SendTimePrompts(battlefield, players)

    if not hasTimeRemaining then
        for _, player in pairs(players) do
            player:messageSpecial(zones[player:getZoneID()].text.TIME_IN_THE_BATTLEFIELD_IS_UP)
        end

        battlefield:setStatus(xi.battlefield.status.LOST)
        isExiting = true
    end

    if isExiting then
        -- Remaining in battlefield for an extended time
        if cutsceneTimer > 0 then
            return
        end

        if status == xi.battlefield.status.LOST then
            for _, player in pairs(players) do
                player:messageSpecial(zones[player:getZoneID()].text.PARTY_MEMBERS_HAVE_FALLEN)
            end
        end

        battlefield:cleanup(true)
    end
end

function Battlefield:onBattlefieldRegister(player, battlefield)
end

function Battlefield:onBattlefieldStatusChange(battlefield, status)
    -- Remove battlefield effect for players in alliance not inside battlefield once the battlefield gets locked. Do this only once.
    if
        status == xi.battlefield.status.LOCKED and
        battlefield:getLocalVar('statusRemoval') == 0
    then
        battlefield:setLocalVar('statusRemoval', 1)
        local players = battlefield:getPlayers()

        for _, player in pairs(players) do
            local alliance = player:getAlliance()

            for _, member in pairs(alliance) do
                if
                    member:hasStatusEffect(xi.effect.BATTLEFIELD) and
                    not member:getBattlefield()
                then
                    member:delStatusEffect(xi.effect.BATTLEFIELD)
                end
            end
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function Battlefield:battlefieldEntry(player, battlefield)
end

---@diagnostic disable-next-line: duplicate-set-field
function Battlefield:onBattlefieldEnter(player, battlefield)
    player:setLocalVar('battlefieldID', battlefield:getID())

    local initiatorId, _ = battlefield:getInitiator()

    if
        #self.requiredKeyItems > 0 and
        (not self.requiredKeyItems.onlyInitiator or player:getID() == initiatorId)
    then

        local items = {}

        for _, item in ipairs(self.requiredKeyItems) do
            -- If this item is a table then that means we only need one of them so delete the first one we find
            if type(item) == 'table' then
                for _, subitem in ipairs(item) do
                    if player:hasKeyItem(subitem) then
                        if not self.requiredKeyItems.keep then
                            player:delKeyItem(subitem)
                        end

                        table.insert(items, subitem)
                    end
                end
            else
                if not self.requiredKeyItems.keep then
                    player:delKeyItem(item)
                end

                table.insert(items, item)
            end
        end

        if type(self.requiredKeyItems.message) == 'table' then
            player:messageSpecial(self.requiredKeyItems.message[1], unpack(self.requiredKeyItems.message[2]))
        elseif self.requiredKeyItems.message then
            player:messageSpecial(self.requiredKeyItems.message, unpack(items))
        end

        if not self.requiredKeyItems.keep and self.requiredKeyItems.deleteMessage then
            for _, keyItemId in ipairs(items) do
                player:messageSpecial(self.requiredKeyItems.deleteMessage, keyItemId)
            end
        end
    end

    if
        player:getID() == initiatorId and
        self.requiredItems.wearMessage and
        player:hasItem(self.requiredItems[1])
    then
        local itemId    = self.requiredItems[1]
        local uses      = player:incrementItemWear(itemId)
        local totalUses = xi.battlefield.itemUses[itemId] or 1 -- Gets number of item uses. (Tests = 3; Else = 1)

        if totalUses > 1 then
            local remaining = totalUses - uses
            player:messageSpecial(self.requiredItems.wearMessage, itemId, remaining + 1, remaining)
        else
            player:messageSpecial(self.requiredItems.wearMessage, 0, 0, 0, itemId)
        end
    end

    local ID = zones[self.zoneId]
    player:messageSpecial(ID.text.ENTERING_THE_BATTLEFIELD_FOR, 0, self.index)

    if self.maxPlayers > 6 then
        -- NOTE: Update tooling does not allow for duplicate messages to be stored in IDs.lua, even if the ID is different.
        -- Apollyon does not differentiate between party and alliance for message, so if the entry is nil, use party message.
        local messageId = ID.text.MEMBERS_OF_YOUR_ALLIANCE and ID.text.MEMBERS_OF_YOUR_ALLIANCE or ID.text.MEMBERS_OF_YOUR_PARTY

        player:messageSpecial(messageId, 0, 0, 0, self.maxPlayers)
    else
        player:messageSpecial(ID.text.MEMBERS_OF_YOUR_PARTY, 0, 0, 0, self.maxPlayers)
    end

    player:messageSpecial(ID.text.TIME_LIMIT_FOR_THIS_BATTLE_IS, 0, 0, 0, math.floor(self.timeLimit / 60))

    if self.experimental then
        player:printToPlayer('This battlefield has been marked as experimental.  Enemy levels have increased!', xi.msg.channel.NS_SHOUT)
    end

    self:battlefieldEntry(player, battlefield)
end

---@diagnostic disable-next-line: duplicate-set-field
function Battlefield:onBattlefieldDestroy(battlefield)
end

---@diagnostic disable-next-line: duplicate-set-field
function Battlefield:onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        self:onBattlefieldWin(player, battlefield)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        self:onBattlefieldLoss(player, battlefield)
    end
end

function Battlefield:onBattlefieldWin(player, battlefield)
    local _, clearTime, partySize = battlefield:getRecord()

    player:setLocalVar('battlefieldWin', battlefield:getID())
    player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), player:getZoneID(), self.index, 0)
end

function Battlefield:onBattlefieldLoss(player, battlefield)
    player:startEvent(32002, self.lossEventParams)
end

function Battlefield:onBattlefieldKick(player)
    player:startEvent(32002, self.lossEventParams)
end

function Battlefield:handleWipe(battlefield, players)
    local wipeTime = battlefield:getWipeTime()
    local elapsed  = battlefield:getTimeInside()

    -- If party has not yet wiped.
    if wipeTime <= 0 then
        -- Return if any players are still alive
        for _, player in pairs(players) do
            if player:isAlive() then
                return
            end
        end

        self:onBattlefieldWipe(battlefield, players)

    -- Party has already wiped.
    else
        if (elapsed - wipeTime) > utils.minutes(3) then
            battlefield:setStatus(xi.battlefield.status.LOST)
        else
            -- Cancel the wipe timer if any players are alive once again
            for _, player in pairs(players) do
                if player:isAlive() then
                    battlefield:setWipeTime(0)
                    break
                end
            end
        end
    end
end

function Battlefield:onBattlefieldWipe(battlefield, players)
    -- Party has wiped. Save and send time remaining before being booted.
    if self.hasWipeGrace then
        for _, player in pairs(players) do
            player:messageSpecial(zones[player:getZoneID()].text.THE_PARTY_WILL_BE_REMOVED, 0, 0, 0, 3)
        end

        battlefield:setWipeTime(battlefield:getTimeInside())
    else
        battlefield:setStatus(xi.battlefield.status.LOST)
    end
end

function Battlefield:addEssentialMobs(mobNames)
    table.insert(self.groups, {
        mobs      = mobNames,
        superlink = true,
        allDeath  = utils.bind(self.handleAllMonstersDefeated, self),
    })
end

function Battlefield:handleAllMonstersDefeated(battlefield, mob)
    local crateId = battlefield:getArmouryCrate()

    -- NOTE: Default to core returning us a value, but if that fails, use the fallback
    -- definition if available.  This should only be used where mobIds table has to be
    -- used instead of mobs!
    if crateId == 0 and self.armouryCrates then
        crateId = self.armouryCrates[battlefield:getArea()]
    end

    if crateId ~= 0 then
        local crate = GetNPCByID(crateId)

        battlefield:insertEntity(crate:getTargID(), false, true)
        npcUtil.showCrate(crate)
        crate:addListener('ON_TRIGGER', 'TRIGGER_CRATE', utils.bind(self.handleOpenArmouryCrate, self))
    else
        battlefield:setLocalVar('cutsceneTimer', self.delayToExit)
        battlefield:setStatus(xi.battlefield.status.WON)
    end
end

function Battlefield:handleOpenArmouryCrate(player, npc)
    npcUtil.openCrate(npc, function()
        local battlefield = player:getBattlefield()
        self:handleLootRolls(battlefield, self.loot, npc)
        battlefield:setStatus(xi.battlefield.status.WON)
        battlefield:setLocalVar('cutsceneTimer', self.delayToExit)

        return true
    end)
end

function Battlefield:handleLootRolls(battlefield, lootTable, npc)
    local players = battlefield:getPlayers()

    for i = 1, #lootTable, 1 do
        local lootGroup = lootTable[i]

        if lootGroup then
            local max = 0

            for _, entry in pairs(lootGroup) do
                if type(entry) == 'table' then
                    max = max + entry.weight
                end
            end

            local quantity = lootGroup.quantity or 1

            for j = 1, quantity do
                local roll    = math.random(max)
                local current = 0

                for _, entry in pairs(lootGroup) do
                    if type(entry) == 'table' then
                        current = current + entry.weight

                        if current >= roll then
                            if entry.item == 0 then
                                break
                            end

                            if entry.item == 65535 then
                                local gil = entry.amount / #players

                                for k = 1, #players, 1 do
                                    npcUtil.giveCurrency(players[k], 'gil', gil)
                                end

                                break
                            end

                            players[1]:addTreasure(entry.item, npc)

                            break
                        end
                    end
                end
            end
        end
    end
end

function xi.battlefield.getBattlefieldOptions(player, npc, trade)
    local result   = 0
    local contents = xi.battlefield.contentsByZone[player:getZoneID()]

    if contents == nil then
        return result
    end

    -- TODO: if the battlefield is at capacity, the 32000 event should not start, but instead
    -- a separate message is displayed on retail

    for _, content in ipairs(contents) do
        if
            content:checkRequirements(player, npc, true, trade) and
            not player:battlefieldAtCapacity(content.battlefieldId) and
            (xi.settings.map.BCNM_ENABLE_EXPERIMENTAL or not content.experimental)
        then
            result = utils.mask.setBit(result, content.index, true)
        end
    end

    return result
end

function xi.battlefield.rejectLevelSyncedParty(player, npc)
    for _, member in pairs(player:getAlliance()) do
        if member:isLevelSync() then
            local zoneId = player:getZoneID()
            local ID     = zones[zoneId]

            -- Your party is unable to participate because certain members' levels are restricted
            player:messageText(npc, ID.text.MEMBERS_LEVELS_ARE_RESTRICTED, false)

            return true
        end
    end

    return false
end

BattlefieldMission         = setmetatable({ }, { __index = Battlefield })
BattlefieldMission.__index = BattlefieldMission

---@diagnostic disable-next-line: duplicate-set-field
BattlefieldMission.__eq    = function(m1, m2)
    return m1.name == m2.name
end

-- Creates a new Limbus Battlefield interaction
-- Data takes the additional following keys:
--  - missionArea: The mission area this battlefield is associated with (optional)
--  - mission: The mission this battlefield is associated with (optional)
--  - missionStatusArea: The mission area to retrieve the mission status from. Will default to using the player's nation (optional)
--  - missionStatus: The optional extra status information xi.mission.status (optional)
--  - requiredMissionStatus: The required mission status to enter
--  - skipMissionStatus: The required mission status to skip the cutscene. Defaults to the required mission status.
--  - canLoseExp: Determines if a character loses experience points upon death while inside the battlefield. Defaults to false. (optional)
---@diagnostic disable-next-line: duplicate-set-field
function BattlefieldMission:new(data)
    local obj = Battlefield:new(data)

    setmetatable(obj, self)
    obj.isMission             = true
    obj.missionArea           = data.missionArea
    obj.mission               = data.mission
    obj.missionStatusArea     = data.missionStatusArea
    obj.missionStatus         = data.missionStatus
    obj.requiredMissionStatus = data.requiredMissionStatus
    obj.skipMissionStatus     = data.skipMissionStatus or data.requiredMissionStatus
    obj.requiredVar           = data.requiredVar
    obj.requiredValue         = data.requiredValue
    obj.canLoseExp            = data.canLoseExp or false

    return obj
end

---@diagnostic disable-next-line: duplicate-set-field
function BattlefieldMission:checkRequirements(player, npc, isRegistrant, trade)
    if not Battlefield.checkRequirements(self, player, npc, isRegistrant, trade) then
        return false
    end

    local missionArea = self.missionArea or player:getNation()
    local current     = player:getCurrentMission(missionArea)

    if self.requiredMissionStatus ~= nil then
        local missionStatusArea = self.missionStatusArea or player:getNation()
        local status            = player:getMissionStatus(missionStatusArea, self.missionStatus)

        return (not isRegistrant and (player:hasCompletedMission(missionArea, self.mission) or
            (current == self.mission and status >= self.requiredMissionStatus))) or
            (current == self.mission and status == self.requiredMissionStatus)
    elseif self.requiredVar ~= nil then
        -- COP Missions use a charVar to track since missionStatus is used to define menu settings.
        -- When converting these, allow for the same structure of status, but with defined requiredVar (str)
        -- and requiredValue (uint requirement).  These are currently mutually exclusive, and treated
        -- as such.

        local status = player:getCharVar(self.requiredVar)

        return (not isRegistrant and (player:hasCompletedMission(missionArea, self.mission) or
            (current == self.mission and status >= self.requiredValue))) or
            (current == self.mission and status == self.requiredValue)
    else
        return (not isRegistrant and player:hasCompletedMission(missionArea, self.mission)) or
            current == self.mission
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function BattlefieldMission:checkSkipCutscene(player)
    local missionArea       = self.missionArea or player:getNation()
    local current           = player:getCurrentMission(missionArea)
    local missionStatusArea = self.missionStatusArea or player:getNation()
    local status            = player:getMissionStatus(missionStatusArea, self.missionStatus)

    return player:hasCompletedMission(missionArea, self.mission) or
        (self.requiredMissionStatus and current == self.mission and status > self.skipMissionStatus) or
        (self.requiredValue and current == self.mission and player:getCharVar(self.requiredVar) > self.requiredValue)
end

---@diagnostic disable-next-line: duplicate-set-field
function BattlefieldMission:onBattlefieldWin(player, battlefield)
    local missionArea       = self.missionArea or player:getNation()
    local current           = player:getCurrentMission(missionArea)
    local missionStatusArea = self.missionStatusArea or player:getNation()

    if current == self.mission then
        player:setLocalVar('battlefieldWin', battlefield:getID())
    end

    local _, clearTime, partySize = battlefield:getRecord()
    local canSkipCS               = (player:hasCompletedMission(missionArea, self.mission) or
        (self.requiredMissionStatus and current == self.mission and player:getMissionStatus(missionStatusArea, self.missionStatus) > self.skipMissionStatus) or
        (self.requiredValue and current == self.mission and player:getCharVar(self.requiredVar) > self.requiredValue)) and 1 or 0

    player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), player:getZoneID(), self.index, canSkipCS)
end

---@diagnostic disable-next-line: duplicate-set-field
function BattlefieldMission:onEventFinishWin(player, csid, option, npc)
    if self.title then
        player:addTitle(self.title)
    end

    -- Only grant mission XP once per JP midnight
    if self.grantXP and self:getVar(player, 'XP') <= os.time() then
        self:setVar(player, 'XP', getMidnight())
        player:addExp(self.grantXP)
    end
end

BattlefieldQuest         = setmetatable({ }, { __index = Battlefield })
BattlefieldQuest.__index = BattlefieldQuest

---@diagnostic disable-next-line: duplicate-set-field
BattlefieldQuest.__eq    = function(m1, m2)
    return m1.name == m2.name
end

BattlefieldQuest.isQuest = true

-- Creates a new Limbus Battlefield interaction
-- Data takes the additional following keys:
--  - questArea: The quest area this battlefield is associated with (optional)
--  - quest: The quest this battlefield is associated with (optional)
--  - canLoseExp: Determines if a character loses experience points upon death while inside the battlefield. Defaults to false. (optional)
---@diagnostic disable-next-line: duplicate-set-field
function BattlefieldQuest:new(data)
    local obj = Battlefield:new(data)
    setmetatable(obj, self)

    obj.questArea  = data.questArea
    obj.quest      = data.quest
    obj.canLoseExp = data.canLoseExp or false

    return obj
end

---@diagnostic disable-next-line: duplicate-set-field
function BattlefieldQuest:checkRequirements(player, npc, isRegistrant, trade)
    if not Battlefield.checkRequirements(self, player, npc, isRegistrant, trade) then
        return false
    end

    if self.requiredVar ~= nil then
        -- COP Missions use a charVar to track since missionStatus is used to define menu settings.
        -- When converting these, allow for the same structure of status, but with defined requiredVar (str)
        -- and requiredValue (uint requirement).  These are currently mutually exclusive, and treated
        -- as such.

        local status      = player:getCharVar(self.requiredVar)
        local hasAccepted = player:getQuestStatus(self.questArea, self.quest) == xi.questStatus.QUEST_ACCEPTED

        return (not isRegistrant and (player:hasCompletedQuest(self.questArea, self.quest) or
            (hasAccepted and status >= self.requiredValue))) or
            (hasAccepted and status == self.requiredValue)
    else
        return player:getQuestStatus(self.questArea, self.quest) >= xi.questStatus.QUEST_ACCEPTED
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function BattlefieldQuest:checkSkipCutscene(player)
    return player:getQuestStatus(self.questArea, self.quest) == xi.questStatus.QUEST_COMPLETED
end

---@diagnostic disable-next-line: duplicate-set-field
function BattlefieldQuest:onBattlefieldWin(player, battlefield)
    local status = player:getQuestStatus(self.questArea, self.quest)

    if status == xi.questStatus.QUEST_ACCEPTED then
        player:setLocalVar('battlefieldWin', battlefield:getID())
    end

    local _, clearTime, partySize = battlefield:getRecord()
    local canSkipCS               = status ~= xi.questStatus.QUEST_ACCEPTED and 1 or 0

    player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), player:getZoneID(), self.index, canSkipCS)
end

-- returns false if out of time
function xi.battlefield.SendTimePrompts(battlefield, players)
    local remainingTime  = battlefield:getRemainingTime()
    local lastTimeUpdate = battlefield:getLastTimeUpdate()
    local timeLimit      = battlefield:getTimeLimit()
    local message        = 0

    players = players or battlefield:getPlayers()

    if remainingTime < 600 and lastTimeUpdate > 600 and timeLimit > 600 then
        message = 600
    elseif remainingTime < 300 and lastTimeUpdate > 300 and timeLimit > 300 then
        message = 300
    elseif remainingTime < 60 and lastTimeUpdate > 60 and timeLimit > 60 then
        message = 60
    elseif remainingTime < 30 and lastTimeUpdate > 30 and timeLimit > 30 then
        message = 30
    elseif remainingTime < 10 and lastTimeUpdate > 10 and timeLimit > 10 then
        message = 10
    end

    if message ~= 0 then
        for i, player in pairs(players) do
            player:messageBasic(xi.msg.basic.TIME_LEFT, message)
        end

        battlefield:setLastTimeUpdate(message)
    end

    return remainingTime > 0
end
