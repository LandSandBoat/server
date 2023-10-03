-----------------------------------
-- MAIN SETTINGS
-----------------------------------
-- All settings are attached to the `xi.settings` object. This is published globally, and be accessed from C++ and any script.
--
-- This file is concerned mainly with content, balance, and gameplay tweaking.
-----------------------------------

xi = xi or {}
xi.settings = xi.settings or {}

xi.settings.main =
{
    -- Server name (not longer than 15 characters)
    SERVER_NAME = "Nameless",

    SERVER_MESSAGE =
        "Please visit https://github.com/LandSandBoat/server for the latest information on the project.\n" ..
        "Thank you, and we hope you enjoy sailing the sands!",

    -- Setting to lock content more accurately to the expansions defined below.
    -- This generally results in a more accurate presentation of your selected expansions,
    -- as well as a less confusing player experience for things that are disabled (things that are disabled are not loaded).
    -- This feature correlates to the content_tag column in the SQL files.
    RESTRICT_CONTENT = 0,

    -- Enable Expansion (1 = Enabled, 0 = Disabled)
    ENABLE_COP       = 1,
    ENABLE_TOAU      = 1,
    ENABLE_WOTG      = 1,
    ENABLE_ACP       = 1,
    ENABLE_AMK       = 1,
    ENABLE_ASA       = 1,
    ENABLE_ABYSSEA   = 1,
    ENABLE_SOA       = 1,
    ENABLE_ROV       = 1,
    ENABLE_VOIDWATCH = 1, -- Not an expansion, but has its own storyline. (Not Implemented)

    -- FIELDS OF VALOR/Grounds of Valor settings
    ENABLE_FIELD_MANUALS  = 1, -- Enables Fields of Valor
    ENABLE_GROUNDS_TOMES  = 1, -- Enables Grounds of Valor
    ENABLE_SURVIVAL_GUIDE = 1, -- Enables Survival Guides (Not Implemented)
    REGIME_WAIT           = 1, -- Make people wait till 00:00 game time as in retail. If it's 0, there is no wait time.
    FOV_REWARD_ALLIANCE   = 0, -- Allow Fields of Valor rewards while being a member of an alliance. (default retail behavior: 0)
    GOV_REWARD_ALLIANCE   = 1, -- Allow Grounds of Valor rewards while being a member of an alliance. (default retail behavior: 1)

    -- Daily points / Gobbie mystery box.
    ENABLE_DAILY_TALLY = 1,  -- Allows acquisition of daily points for gobbie mystery box.
    DAILY_TALLY_AMOUNT = 10,
    DAILY_TALLY_LIMIT  = 50000,
    GOBBIE_BOX_MIN_AGE = 45, -- Minimum character age in days before a character can sign up for Gobbie Mystery Box

    -- Records of Eminence
    ENABLE_ROE            = 1, -- Enable Records of Eminence
    ENABLE_ROE_TIMED      = 1, -- Enable 4-hour timed records
    ENABLE_EXCHANGE_LIMIT = 1, -- Enable Maximum limit of sparks spent per Week (default retail behavior: 1)

    WEEKLY_EXCHANGE_LIMIT = 100000, -- Maximum amount of sparks/accolades that can be spent per week (default retail value: 100000)

    -- Currency Caps (Change at your own risk!)
    CAP_CURRENCY_ACCOLADES = 99999,
    CAP_CURRENCY_BALLISTA  = 2000,
    CAP_CURRENCY_SPARKS    = 99999,
    CAP_CURRENCY_VALOR     = 50000,

    -- Magian Trials
    ENABLE_MAGIAN_TRIALS             = 1,

    -- VoidWalker
    ENABLE_VOIDWALKER = 1,

    -- TREASURE CASKETS
    -- Retail droprate = 0.1 (10%) with no other effects active
    -- Set to 0 to disable caskets.
    -- max is clamped to 1.0 (100%)
    CASKET_DROP_RATE = 0.1,

    -- Abyssea lights
    -- certain mobs that reduces the drop rate automatically depending on the light.
    -- pearl light is a dramaticly lower drop rate.
    -- min is 0 max is 100 (1 = 1%)
    ABYSSEA_LIGHTS_DROP_RATE = 80,

    -- This bonus will be added to players lights apon entering abyssea, it is mainly used during events
    -- recomended amount 0 - 100, some lights will cap at 255 while others are less, these are capped automatically
    ABYSSEA_BONUSLIGHT_AMOUNT = 0,

    -- CHARACTER CONFIG
    INITIAL_LEVEL_CAP              = 50, -- The initial level cap for new players.  There seems to be a hardcap of 255.
    MAX_LEVEL                      = 99, -- Level max of the server, lowers the attainable cap by disabling Limit Break quests.
    NORMAL_MOB_MAX_LEVEL_RANGE_MIN = 0,  -- Lower Bound of Max Level Range for Normal Mobs (0 = Uncapped)
    NORMAL_MOB_MAX_LEVEL_RANGE_MAX = 0,  -- Upper Bound of Max Level Range for Normal Mobs (0 = Uncapped)
    START_GIL                      = 10, -- Amount of gil given to newly created characters.
    START_INVENTORY                = 30, -- Starting inventory and satchel size.  Ignores values < 30.  Do not set above 80!
    NEW_CHARACTER_CUTSCENE         = 1,  -- Set to 1 to enable opening cutscenes, 0 to disable.
    SUBJOB_QUEST_LEVEL             = 18, -- Minimum level to accept either subjob quest.  Set to 0 to start the game with subjobs unlocked.
    ADVANCED_JOB_LEVEL             = 30, -- Minimum level to accept advanced job quests.  Set to 0 to start the game with advanced jobs.
    ALL_MAPS                       = 0,  -- Set to 1 to give starting characters all the maps.
    UNLOCK_OUTPOST_WARPS           = 0,  -- Set to 1 to give starting characters all outpost warps.  2 to add Tu'Lia and Tavnazia.

    SHOP_PRICE      = 1.000, -- Multiplies prices in NPC shops.
    GIL_RATE        = 1.000, -- Multiplies gil earned from quests.  Won't always display in game.
    BAYLD_RATE      = 1.000, -- Multiples bayld earned from quests.
    -- Note: EXP rates are also influenced by conf setting
    EXP_RATE        = 1.000, -- Multiplies exp from script (except FoV/GoV).
    CAPACITY_RATE   = 1.000, -- Multiplies capacy points gained.
    BOOK_EXP_RATE   = 1.000, -- Multiplies exp from FoV/GoV book pages.
    TABS_RATE       = 1.000, -- Multiplies tabs earned from fov.
    ROE_EXP_RATE    = 1.000, -- Multiplies exp earned from records of eminence.
    SPARKS_RATE     = 1.000, -- Multiplies sparks earned from records of eminence.
    CURE_POWER      = 1.000, -- Multiplies amount healed from Healing Magic, including the relevant Blue Magic.
    ELEMENTAL_POWER = 1.000, -- Multiplies damage dealt by Elemental and non-drain Dark Magic.
    DIVINE_POWER    = 1.000, -- Multiplies damage dealt by Divine Magic.
    NINJUTSU_POWER  = 1.000, -- Multiplies damage dealt by Ninjutsu Magic.
    BLUE_POWER      = 1.000, -- Multiplies damage dealt by Blue Magic.
    DARK_POWER      = 1.000, -- Multiplies amount drained by Dark Magic.
    ITEM_POWER      = 1.000, -- Multiplies the effect of items such as Potions and Ethers.
    WEAPON_SKILL_POWER  = 1.000, -- Multiplies damage dealt by Weapon Skills.

    USE_ADOULIN_WEAPON_SKILL_CHANGES = true,  -- true/false. Change to toggle new Adoulin weapon skill damage calculations
    DISABLE_PARTY_EXP_PENALTY        = false, -- true/false.
    ENABLE_IMMUNOBREAK               = true,  -- true/false. Allow/Disallow immunobreaks to happen.

    -- TRUSTS
    ENABLE_TRUST_CASTING           = 1,
    ENABLE_TRUST_QUESTS            = 1,
    ENABLE_TRUST_CUSTOM_ENGAGEMENT = 0,

    ENABLE_TRUST_ALTER_EGO_EXTRAVAGANZA          = 0, -- 0 = disabled, 1 = summer/ny, 2 = spring/autumn, 3 = both
    ENABLE_TRUST_ALTER_EGO_EXTRAVAGANZA_ANNOUNCE = 0, -- 0 = disabled, 1 = add announcement to player login
    ENABLE_TRUST_ALTER_EGO_EXPO                  = 0, -- 0 = disabled, 1 = expo - HPP/MPP/Status Resistance, 2 = expo plus (not implemented)
    ENABLE_TRUST_ALTER_EGO_EXPO_ANNOUNCE         = 0, -- 0 = disabled, 1 = add announcement to player login

    TRUST_ALTER_EGO_EXTRAVAGANZA_MESSAGE =
        "\n \n" .. -- The space between these newlines is intentional
        "\129\153\129\154 The Alter Ego Extravaganza Campaign is active! \129\154\129\153\n" ..
        "This is an excellent time to fill out your roster of Trusts!",

    TRUST_ALTER_EGO_EXPO_MESSAGE =
        "\n \n" .. -- The space between these newlines is intentional
        "\129\153\129\154 The Alter Ego Expo Campaign is active! \129\154\129\153\n" ..
        "Trusts gain the benefits of Increased HP, MP, and Status Resistances!",

    HARVESTING_BREAK_CHANCE = 33, -- % chance for the sickle to break during harvesting.  Set between 0 and 100.
    EXCAVATION_BREAK_CHANCE = 33, -- % chance for the pickaxe to break during excavation.  Set between 0 and 100.
    LOGGING_BREAK_CHANCE    = 33, -- % chance for the hatchet to break during logging.  Set between 0 and 100.
    MINING_BREAK_CHANCE     = 33, -- % chance for the pickaxe to break during mining.  Set between 0 and 100.
    HARVESTING_RATE         = 50, -- % chance to recieve an item from haresting.  Set between 0 and 100.
    EXCAVATION_RATE         = 50, -- % chance to recieve an item from excavation.  Set between 0 and 100.
    LOGGING_RATE            = 50, -- % chance to recieve an item from logging.  Set between 0 and 100.
    MINING_RATE             = 50, -- % chance to recieve an item from mining.  Set between 0 and 100.
    DIGGING_RATE            = 85, -- % chance to receive an item from chocbo digging during favorable weather.  Set between 0 and 100.

    HEALING_TP_CHANGE       = -100, -- Change in TP for each healing tick. Default is -100

    -- SE implemented coffer/chest illusion time in order to prevent coffer farming. No-one in the same area can open a chest or coffer for loot (gil, gems & items)
    -- till a random time between MIN_ILLSION_TIME and MAX_ILLUSION_TIME. During this time players can loot keyitem and item related to quests (AF, maps... etc.)
    COFFER_MAX_ILLUSION_TIME = 3600,  -- 1 hour
    COFFER_MIN_ILLUSION_TIME = 1800,  -- 30 minutes
    CHEST_MAX_ILLUSION_TIME  = 3600,  -- 1 hour
    CHEST_MIN_ILLUSION_TIME  = 1800,  -- 30 minutes

    -- Multiplier to NM lottery spawn chance. (Default 1.0) eg. 0 = disable lottery spawns. -1 for always 100% chance.
    NM_LOTTERY_CHANCE = 1.0,
    -- Multiplier to NM lottery cooldown time (Default 1.0) eg. 2.0 = twice as long. 0 = no cooldowns.
    NM_LOTTERY_COOLDOWN = 1.0,

    -- GARRISON SETTINGS
    ENABLE_GARRISON        = true,  -- If true, enables garrison functionality
    GARRISON_LOCKOUT       = 1800,  -- Time in seconds before a new garrison can be started (default: 1800)
    GARRISON_TIME_LIMIT    = 1800,  -- Time in seconds before lose ongoing garrison (default: 1800)
    GARRISON_ONCE_PER_WEEK = true,  -- Set to false to bypass the limit of one garrison per Conquest Tally Week.
    GARRISON_PARTY_LIMIT   = 18,    -- Set to max party members you want to do garrison (default: 18).
    GARRISON_NATION_BYPASS = false, -- Set to true to bypass the nation requirement.
    GARRISON_RANK          = 2,     -- Set to minumum Nation Rank to start Garrison (default: 2).

    -- DYNAMIS SETTINGS
    BETWEEN_2DYNA_WAIT_TIME     = 24,       -- Hours before player can re-enter Dynamis. Default is 1 Earthday (24 hours).
    DYNA_MIDNIGHT_RESET         = true,     -- If true, makes the wait time count by number of server midnights instead of full 24 hour intervals
    DYNA_LEVEL_MIN              = 65,       -- Level min for entering in Dynamis
    TIMELESS_HOURGLASS_COST     = 500000,   -- Refund for the timeless hourglass for Dynamis.
    PRISMATIC_HOURGLASS_COST    = 50000,    -- Cost of the prismatic hourglass for Dynamis.
    CURRENCY_EXCHANGE_RATE      = 100,      -- X Tier 1 ancient currency -> 1 Tier 2, and so on. Certain values may conflict with shop items. Not designed to exceed 198.
    ENABLE_EXCHANGE_100S_TO_1S  = false,    -- true/false. Allow exchange of 100s to 1s, like you can with 10Ks to 100s.
    RELIC_2ND_UPGRADE_WAIT_TIME = 7200,     -- Wait time for 2nd relic upgrade (stage 2 -> stage 3) in seconds. 7200s = 2 hours.
    RELIC_3RD_UPGRADE_WAIT_TIME = 3600,     -- Wait time for 3rd relic upgrade (stage 3 -> stage 4) in seconds. 3600s = 1 hour.
    FREE_COP_DYNAMIS            = 0,        -- Authorize player to entering inside COP Dynamis without completing COP mission (1 = enable 0 = disable)

    -- LIMBUS SETTINGS
    COSMO_CLEANSE_BASE_COST     = 15000,    -- Base gil cost for a Cosmo Cleanse from Sagheera

    -- QUEST/MISSION SPECIFIC SETTINGS
    AF1_QUEST_LEVEL = 40,    -- Minimum level to start AF1 quest
    AF2_QUEST_LEVEL = 50,    -- Minimum level to start AF2 quest
    AF3_QUEST_LEVEL = 50,    -- Minimum level to start AF3 quest
    OLDSCHOOL_G1    = false, -- Set to true to require farming Exoray Mold, Bombd Coal, and Ancient Papyrus drops instead of allowing key item method.
    OLDSCHOOL_G2    = false, -- Set true to require the NMs for "Atop the Highest Mountains" be dead to get KI like before SE changed it.
    FRIGICITE_TIME  = 30,    -- When OLDSCHOOL_G2 is enabled, this is the time (in seconds) you have from killing Boreal NMs to click the "???" target.
    ASSAULT_MINIMUM = 1,     -- Minimum amount of people needed to start an assault mission. TOAU era is 3, Default is 1.

    -- SPELL SPECIFIC SETTINGS
    DIA_OVERWRITE                   = 1,     -- Set to 1 to allow Bio to overwrite same tier Dia.  Default is 1.
    BIO_OVERWRITE                   = 0,     -- Set to 1 to allow Dia to overwrite same tier Bio.  Default is 0.
    STONESKIN_CAP                   = 350,   -- Soft cap for hp absorbed by stoneskin
    BLINK_SHADOWS                   = 2,     -- Number of shadows supplied by Blink spell
    SPIKE_EFFECT_DURATION           = 180,   -- the duration of RDM, BLM spikes effects (not Reprisal)
    ELEMENTAL_DEBUFF_DURATION       = 120,   -- base duration of elemental debuffs
    AQUAVEIL_COUNTER                = 1,     -- Base amount of hits Aquaveil absorbs to prevent spell interrupts. Retail is 1.
    ABSORB_SPELL_AMOUNT             = 8,     -- how much of a stat gets absorbed by DRK absorb spells - expected to be a multiple of 8.
    ABSORB_SPELL_TICK               = 9,     -- duration of 1 absorb spell tick
    SNEAK_INVIS_DURATION_MULTIPLIER = 1,     -- multiplies duration of sneak, invis, deodorize to reduce player torture. 1 = retail behavior.
    USE_OLD_CURE_FORMULA            = false, -- true/false. if true, uses older cure formula (3*MND + VIT + 3*(healing skill/5)) // cure 6 will use the newer formula
    USE_OLD_MAGIC_DAMAGE            = false, -- true/false. if true, uses older magic damage formulas

    -- CELEBRATIONS
    EXPLORER_MOOGLE_LV              = 10, -- Enables Explorer Moogle teleports and sets required level. Zero to disable.
    HALLOWEEN_2005                  = 0,  -- Set to 1 to Enable the 2005 version of Harvest Festival, will start on Oct. 20 and end Nov. 1.
    HALLOWEEN_YEAR_ROUND            = 0,  -- Set to 1 to have Harvest Festival initialize outside of normal times.
    EGG_HUNT                        =
    {
        START                       = { DAY = 6,  MONTH = 4 },
        FINISH                      = { DAY = 17, MONTH = 4 },

        -- Default era is 2005
        ERA_2006 = false, -- Orphic Egg
        ERA_2007 = false, -- Jeweled Egg and Egg Helm
        ERA_2008 = false, -- Tier 2 nation eggs, allows trading Hard-Boiled Eggs
        ERA_2009 = false, -- Egg Buffet set
        -- 2009, 2010, 2011 and 2012 are identical
        ERA_2013 = false, -- Prinseggstarta
        ERA_2014 = false, -- Hatchling Shield, Copse Candy, Cracker
        ERA_2015 = false, -- Rabbit Cap, show Rabbit Cap wearing NPCs
        ERA_2018 = false, -- Allows trading Sairui-Ran x99 and Imperial Egg
        ERA_2019 = false, -- Allows trading Apkallu Egg

        -- Consolation prizes for repeating combinations where
        -- the player has already received the relevant reward
        MINOR_REWARDS = true,

        -- Set custom combinations, eg. WORD = 12345
        -- Where WORD  is an arrangement of lettered eggs
        -- Where 12345 is the itemID for the reward
        BONUS_WORDS =
        {
            -- WORD = 12345,
        },
    },

    -- Login Campaign (Set to 0 if you don't want to run a Login Campaign)
    -- Please visit scripts/globals/events/login_campaign.lua for assigning the correct campaign dates.
    ENABLE_LOGIN_CAMPAIGN = 0,

    -- NYZUL
    RUNIC_DISK_SAVE      = true, -- Allow anyone participating in Nyzul to save progress. Set to false so only initiator can save progress.
    ENABLE_NYZUL_CASKETS = true, -- Enable Treasure casket pops from NMs.
    ENABLE_VIGIL_DROPS   = true, -- Enable Vigil Weapon drops from NMs.
    ACTIVATE_LAMP_TIME   = 6000, -- Time in miliseconds for lamps to stay lit. TODO: Get retail confirmation.

    -- CHOCOBO RAISING (HEAVILY-IN-DEVELOPMENT, USE AT YOUR OWN RISK)
    -- GM command: `!chocoboraising`
    ENABLE_CHOCOBO_RAISING              = false, -- true/false. Enable Chocobo Raising features.
    DEBUG_CHOCOBO_RAISING               = false, -- true/false. Enable verbose debug logging for Chocobo Raising (visible by players).
    CHOCOBO_RAISING_STAT_POS_MULTIPLIER = 1.0,   -- float. Multiplier for positive stat changes. Default 1.0.
    CHOCOBO_RAISING_STAT_NEG_MULTIPLIER = 1.0,   -- float. Multiplier for negative stat changes. Default 1.0.
    CHOCOBO_RAISING_GIL_MULTIPLIER      = 1.0,   -- float. Multiplier for gil recieved through chocobo actions (care plans, etc.). Default 1.0.
    CHOCOBO_RAISING_DISABLE_RETIREMENT  = false, -- true/false.
    CHOCOBO_RAISING_STAT_GROWTH_CAP     = 512,   -- int.

    -- MISC
    RIVERNE_PORTERS              = 120,   -- Time in seconds that Unstable Displacements in Cape Riverne stay open after trading a scale.
    LANTERNS_STAY_LIT            = 1200,  -- time in seconds that lanterns in the Den of Rancor stay lit.
    ENABLE_COP_ZONE_CAP          = 0,     -- Enable or disable lvl cap
    ALLOW_MULTIPLE_EXP_RINGS     = 0,     -- Set to 1 to remove ownership restrictions on the Chariot/Empress/Emperor Band trio.
    BYPASS_EXP_RING_ONE_PER_WEEK = 0,     -- Set to 1 to bypass the limit of one ring per Conquest Tally Week.
    NUMBER_OF_DM_EARRINGS        = 1,     -- Number of earrings players can simultaneously own from Divine Might before scripts start blocking them (Default: 1)
    HOMEPOINT_TELEPORT           = 1,     -- Enables the homepoint teleport system
    DIG_ABUNDANCE_BONUS          = 0,     -- Increase chance of digging up an item (450  = item digup chance +45)
    DIG_FATIGUE                  = 1,     -- Set to 0 to disable Dig Fatigue
    DIG_GRANT_BURROW             = 0,     -- Set to 1 to grant burrow ability
    DIG_GRANT_BORE               = 0,     -- Set to 1 to grant bore ability
    ENM_COOLDOWN                 = 120,   -- Number of hours before a player can obtain same KI for ENMs (default: 5 days)
    FORCE_SPAWN_QM_RESET_TIME    = 300,   -- Number of seconds the ??? remains hidden for after the despawning of the mob it force spawns.
    EQUIP_FROM_OTHER_CONTAINERS  = false, -- true/false. Allows equipping items from Mog Satchel, Sack, and Case. Only possible with the use of client addons.
    REGIME_REWARD_THRESHOLD      = 15,    -- If the player is more than N levels below the minimum suggested range, do not award experience.

    -- SYSTEM
    DISABLE_INACTIVITY_WATCHDOG = false, -- true/false. If this is enabled, the watchdog which detects if the main loop isn't being ticked will no longer be able to kill the process.
    INACTIVITY_WATCHDOG_PERIOD  = 2000,  -- Time in milliseconds which the inactivity watchdog will wait between ticks of the main loop before potentially killing the target process.
}
