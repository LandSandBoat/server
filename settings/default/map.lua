-----------------------------------
-- MAP SERVER SETTINGS
-----------------------------------
-- All settings are attached to the `xi.settings` object. This is published globally, and be accessed from C++ and any script.
--
-- This file is concerned mainly with game administration and configuring the map executable
-----------------------------------

xi          = xi or {}
xi.settings = xi.settings or {}

xi.settings.map =
{
    -- --------------------------------
    -- Packet settings
    -- --------------------------------

    MAX_TIME_LASTUPDATE = 60,

    -- --------------------------------
    -- SQL settings
    -- --------------------------------

    -- Used by serverutils::PersistServerVar() for the maximum attempts to retry verification
    -- of a written Server Variable.
    SETVAR_RETRY_MAX = 3,

    -- --------------------------------
    -- Game settings
    -- --------------------------------

    -- PacketGuard will block and report any packets that aren't in the allow-list for a
    -- player's current state.
    PACKETGUARD_ENABLED = true,

    -- Minimal number of 0x3A packets which uses for detect lightluggage (set 0 for disable)
    LIGHTLUGGAGE_BLOCK = 4,

    -- Enable or disable Recycle Bin (Set to false for items to be dropped immediately)
    ENABLE_ITEM_RECYCLE_BIN = true,

    -- AH fee structure, defaults are retail.
    AH_BASE_FEE_SINGLE = 1,
    AH_BASE_FEE_STACKS = 4,
    AH_TAX_RATE_SINGLE = 1.0,
    AH_TAX_RATE_STACKS = 0.5,
    AH_MAX_FEE         = 10000,

    -- Max open listings per player, 0 = no limit. (Default 7)
    -- Note = Settings over 7 may need client-side plugin to work under all circumstances.
    -- If this is the case, consider using the ah_pagination module (which supports setting AH_LIST_LIMIT to 0 or >7).
    AH_LIST_LIMIT = 7,

    -- The total enmity cap for a given entity on the enmity table.
    -- 30,000 is believed to be approximately current retail cap.
    -- This directly affects a tank's ability to hold enmity over time.
    -- The lower the value, the faster damage dealers will reach the cap and the mob will bounce.
    ENMITY_CAP = 30000,

    -- Misc EXP related settings
    EXP_RATE                = 1.0,
    EXP_LOSS_RATE           = 1.0,
    EXP_PARTY_GAP_PENALTIES = true,

    -- A party member's experience points are nullified if the level difference with the highest-level party member exceeds this value.
    -- When set to 0, there is no nullification of EXP regardless of how wide the gap is between party members.
    -- When set to 10, if you are level 65 or below in a party with a level 75, you will receive no EXP.
    EXP_PARTY_GAP_NO_EXP = 0,

    -- Capacity Point Settings
    CAPACITY_RATE = 1.0,

    -- Determines Vana'diel time epoch (886/1/1 Firesday)
    -- current timestamp - vanadiel_time_epoch = vana'diel time
    -- 0 defaults to SE epoch 1009810800 (JP midnight 1/1/2002)
    -- safe range is 1 - current timestamp
    VANADIEL_TIME_EPOCH = 0,

    -- For old fame calculation use .25
    FAME_MULTIPLIER = 1.00,

    -- Percentage of experience normally lost to keep upon death. 0 means full loss, where 1 means no loss.
    EXP_RETAIN = 0,

    -- Minimum level at which experience points can be lost
    EXP_LOSS_LEVEL = 31,

    -- Minimum level at which regional influence is lost in conquest when a player dies
    -- Level 5 and below don't lose influence: http://wiki.ffo.jp/html/498.html
    MINIMUM_LEVEL_CONQUEST_INFUENCE_LOSS = 6,

    -- Enable/disable Level Sync
    LEVEL_SYNC_ENABLE = true,

    -- Disables ability to equip higher level gear when level cap/sync effect is on player.
    DISABLE_GEAR_SCALING = false,

    -- Disables Treasure Hunter procs (Era behavior wants this true)
    DISABLE_TREASURE_HUNTER_PROCS = false,

    -- Weaponskill point base (before skillchain) for breaking latent - whole numbers only. retail is 1.
    WS_POINTS_BASE = 1,

    -- Weaponskill points per skillchain element - whole numbers only, retail is 1
    -- (tier 3 sc's have 4 elements, plus 1 for the ws itself, giving 5 points to the closer).
    WS_POINTS_SKILLCHAIN = 1,

    -- Enable/disable jobs other than BST and RNG having widescan
    ALL_JOBS_WIDESCAN = true,

    -- Base player movement speed
    BASE_SPEED = 50,

    -- Player movement speed limit
    SPEED_LIMIT = 80,

    -- Mount speed, expressed as player speed. Can surpass speed limit.
    MOUNT_SPEED = 80,

    -- Player animation speed divisor
    -- Raising this increases the players movement animation speed
    ANIMATION_SPEED_DIVISOR = 1.0,

    -- Multiplier for speed of engaged mobs when their target is out of range.
    -- The default for almost all mobs on retail is 2.5x their normal speed.
    MOB_RUN_SPEED_MULTIPLIER = 2.5,

    -- Allows you to manipulate the constant multiplier in the skill-up rate formulas, having a potent effect on skill-up rates.
    SKILLUP_CHANCE_MULTIPLIER = 1.0,
    CRAFT_CHANCE_MULTIPLIER   = 1.0,

    -- Multiplier for skillup amounts. Using anything above 1 will break the 0.5 cap, the cap will become 0.9 (For maximum, set to 5)
    SKILLUP_AMOUNT_MULTIPLIER = 1,
    CRAFT_AMOUNT_MULTIPLIER   = 1,

    -- Gardening Factors. DO NOT change defaults without verifiable proof that your change IS how retail does it. Myths need to be optional.
    GARDEN_DAY_MATTERS       = false,
    GARDEN_MOONPHASE_MATTERS = false,
    GARDEN_POT_MATTERS       = false,
    GARDEN_MH_AURA_MATTERS   = false,

    -- Use current retail skill up rates and margins (Retail = High Skill-Up rate; Skill-Up when at or under 10 levels above synth recipe level.)
    CRAFT_MODERN_SYSTEM = true,

    -- Craft level limit from witch specialization points beginning to count. (Retail = 700; Level 75 era:600)
    CRAFT_COMMON_CAP = 700,

    -- Amount of points allowed in crafts over the level defined above. Points are shared across all crafting skills. (Retail = 400; All skills can go to max = 3200)
    CRAFT_SPECIALIZATION_POINTS = 400,

    -- Multiplier applied to high quality chance
    CRAFT_HQ_CHANCE_MULTIPLIER = 1.0,

    -- Enable/disable all fishing, including quests. ENABLE AT YOUR OWN RISK.
    FISHING_ENABLE = false,

    -- Sets the minimum level a character must be to fish.
    FISHING_MIN_LEVEL = 1,

    -- Multiplier for fishing skill-up chance. Default = 1.0, very hard.
    FISHING_SKILL_MULTIPLIER = 1.0,

    -- Enable/disable skill-ups from bloodpacts
    SKILLUP_BLOODPACT = true,

    -- Adjust rate of TP gain for mobs, pets (includes charmed pets), fellows, trusts and players.
    -- Acts as a multiplier, so default is 1.
    MOB_TP_MULTIPLIER    = 1.0,
    PET_TP_MULTIPLIER    = 1.0,
    PLAYER_TP_MULTIPLIER = 1.0,
    TRUST_TP_MULTIPLIER  = 1.0,
    FELLOW_TP_MULTIPLIER = 1.0,

    -- Adjust max HP pool for NMs, regular mobs, players, and trusts/fellows. Acts as a multiplier, so default is 1.
    NM_HP_MULTIPLIER        = 1.0,
    MOB_HP_MULTIPLIER       = 1.0,
    PLAYER_HP_MULTIPLIER    = 1.0,
    ALTER_EGO_HP_MULTIPLIER = 1.0,

    -- Adjust max MP pool for NMs, regular mobs, players, and trusts/fellows. Acts as a multiplier, so default is 1.
    NM_MP_MULTIPLIER        = 1.0,
    MOB_MP_MULTIPLIER       = 1.0,
    PLAYER_MP_MULTIPLIER    = 1.0,
    ALTER_EGO_MP_MULTIPLIER = 1.0,

    -- Sets the fraction of MP a subjob provides to the main job. Retail is half and this acts as a divisor so default is 2
    SJ_MP_DIVISOR = 2.0,

    -- Modify ratio of subjob-to-mainjob
    -- 0            = no subjobs
    -- 1            = 1/2   (default, 75/37, 99/49)
    -- 2            = 2/3   (75/50, 99/66)
    -- 3            = equal (75/75, 99/99)
    SUBJOB_RATIO = 1,

    -- Also adjust monsters subjob in ratio adjustments? 1 = true / 0 = false
    INCLUDE_MOB_SJ = false,

    -- Adjust base stats (str/vit/etc.) for NMs, regular mobs, players, and trusts/fellows. Acts as a multiplier, so default is 1.
    NM_STAT_MULTIPLIER        = 1.0,
    MOB_STAT_MULTIPLIER       = 1.0,
    PLAYER_STAT_MULTIPLIER    = 1.0,
    ALTER_EGO_STAT_MULTIPLIER = 1.0,

    -- Adjust skill caps for trusts/fellows. Acts as a multiplier, so default is 1.
    ALTER_EGO_SKILL_MULTIPLIER = 1.0,

    -- Adjust the recast time for abilities. Acts as a multiplier, so default is 1
    ABILITY_RECAST_MULTIPLIER = 1.0,

    -- Enable/disable shared blood pact timer
    BLOOD_PACT_SHARED_TIMER = false,

    -- Adjust mob drop rate. Acts as a multiplier, so default is 1.
    DROP_RATE_MULTIPLIER = 1.0,

    -- Multiplier for gil naturally dropped by mobs. Does not apply to the bonus gil from all_mobs_gil_bonus. Default is 1.0.
    MOB_GIL_MULTIPLIER = 1.0,

    -- All mobs drop this much extra gil per mob LV even if they normally drop zero.
    ALL_MOBS_GIL_BONUS = 0,

    -- Maximum total bonus gil that can be dropped. Default 9999 gil.
    MAX_GIL_BONUS = 9999,

    -- Allow mobs to walk back home instead of despawning
    MOB_NO_DESPAWN = false,

    -- Adds extra time to mob despawn in seconds. Base time is 25s, so a setting of 5 here would be a total of 30 seconds.
    MOB_ADDITIONAL_TIME_TO_DEAGGRO = 0,

    -- Allows parry, block, and guard to skill up regardless of the action occuring.
    -- This did not happen in previous eras
    PARRY_OLD_SKILLUP_STYLE = false,
    BLOCK_OLD_SKILLUP_STYLE = false,
    GUARD_OLD_SKILLUP_STYLE = false,

    -- Globally adjusts ALL battlefield level caps by this many levels.
    BATTLE_CAP_TWEAK = 0,

    -- Enable/disable level cap of mission battlefields stored in database.
    LV_CAP_MISSION_BCNM = false,

    -- Allow players to enter BCNMs which are flagged as experimental
    BCNM_ENABLE_EXPERIMENTAL = true,

    -- Max allowed merits points players can hold
    -- 10 classic
    -- 30 abyssea
    MAX_MERIT_POINTS = 30,

    -- Minimum time between uses of yell command (in seconds).
    YELL_COOLDOWN = 30,

    -- Prevent players from sending tells to hidden GMs. You will still receive them from other GMs.
    BLOCK_TELL_TO_HIDDEN_GM = false,

    -- Prevent players from performing WS while unengaged using packet injection.
    PREVENT_UNENGAGED_WS = false,

    -- Command Audit [logging] commands with lower permission than this will not be logged.
    -- Zero for no logging at all. Commands given to non GMs are not logged.
    AUDIT_GM_CMD = false,

    -- Todo = other logging including anti-cheat messages

    -- Chat Audit[logging] settings
    AUDIT_CHAT      = false,
    AUDIT_SAY       = false,
    AUDIT_SHOUT     = false,
    AUDIT_TELL      = false,
    AUDIT_YELL      = false,
    AUDIT_LINKSHELL = false,
    AUDIT_UNITY     = false,
    AUDIT_PARTY     = false,

    -- Seconds between healing ticks. Default is 10
    HEALING_TICK_DELAY = 10,

    -- Set to 1 to enable server side anti-cheating measurements
    ANTICHEAT_ENABLED = true,

    -- Set to 1 to completely disable auto-jailing offenders
    ANTICHEAT_JAIL_DISABLE = false,

    -- Enable/disable keeping jug pets through zoning
    KEEP_JUGPET_THROUGH_ZONING = false,

    -- Despawn jug pets that have a minimum level below level sync or zone level restriction.
    -- Such as despawning Courier Carrie in a level 20 cap when their minimum level to summon is 23.
    -- While the default value of false is retail accurate, there are some balance concerns such as using 1000 needles at low levels from the cactuar pet.
    DESPAWN_JUGPETS_BELOW_MINIMUM_LEVEL = false,

    -- Send stack traces to the client after caught Lua errors if
    -- their GM level is the same or higher than this number.
    -- The max GM level is 5, so setting this to 6 disables it
    -- for everone. Setting it to 0 enables for everyone.
    REPORT_LUA_ERRORS_TO_PLAYER_LEVEL = 6,
}
