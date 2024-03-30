-----------------------------------
-- MOBMODs
-- maps src/map/mob_modifier.h
-- always edit both
-----------------------------------
xi = xi or {}

xi.mobMod =
{
    NONE                   = 0,
    GIL_MIN                = 1,  -- minimum gil drop -- spawn mod only
    GIL_MAX                = 2,  -- maximum gil drop -- spawn mod only
    MP_BASE                = 3,  -- Give mob mp. Used for mobs that are not mages, wyverns, avatars
    SIGHT_RANGE            = 4,  -- sight range
    SOUND_RANGE            = 5,  -- sound range
    BUFF_CHANCE            = 6,  -- % chance to buff (combat only)
    GA_CHANCE              = 7,  -- % chance to use -ga spell
    HEAL_CHANCE            = 8,  -- % chance to use heal
    HP_HEAL_CHANCE         = 9,  -- can cast cures below this HP %
    SUBLINK                = 10, -- sub link group
    LINK_RADIUS            = 11, -- link radius
    DRAW_IN                = 12, -- 1 - player draw in, 2 - alliance draw in -- only add as a spawn mod!
    SEVERE_SPELL_CHANCE    = 13, -- % chance to use a severe spell like death or impact
    SKILL_LIST             = 14, -- uses given mob skill list
    MUG_GIL                = 15, -- amount gil carried for mugging
    DETECTION              = 16, -- Overrides mob family's detection method. In order to set to override to none an unused bit must be set such as DETECT_NONE1.
    NO_DESPAWN             = 17, -- do not despawn when too far from spawn. Gob Diggers have this.
    VAR                    = 18, -- temp var for whatever. Gets cleared on spawn
    CAN_SHIELD_BLOCK       = 19, -- toggle shield use for mobs without physical shields (trusts)
    TP_USE_CHANCE          = 20, -- % chance to use tp
    PET_SPELL_LIST         = 21, -- set pet spell list
    NA_CHANCE              = 22, -- % chance to cast -na
    IMMUNITY               = 23, -- immune to set status effects. This only works from the db, not scripts
    GRADUAL_RAGE           = 24, -- (!) TODO: NOT YET IMPLEMENTED -- gradually rages
    BUILD_RESIST           = 25, -- (!) TODO: NOT YET IMPLEMENTED -- builds resistance to given effects
    SUPERLINK              = 26, -- super link group. Only use this in mob_spawn_mods / scripts!
    SPELL_LIST             = 27, -- set spell list
    EXP_BONUS              = 28, -- bonus exp (bonus / 100) negative values reduce exp.
    ASSIST                 = 29, -- mobs will assist me
    SPECIAL_SKILL          = 30, -- give special skill (example: Gigas boulder ranged attack)
    ROAM_DISTANCE          = 31, -- distance allowed to roam from spawn
    DONT_ROAM_HOME         = 32, -- Allow mobs to roam any distance from spawn. Useful for mobs with scripted roaming behavior.
    SPECIAL_COOL           = 33, -- cool down for special (example: Time between Gigas boulder ranged attacks)
    MAGIC_COOL             = 34, -- cool down for magic
    STANDBACK_COOL         = 35, -- cool down time for standing back (casting spell while not in attack range)
    ROAM_COOL              = 36, -- cool down time in seconds after roaming
    ALWAYS_AGGRO           = 37, -- aggro regardless of level. Spheroids
    NO_DROPS               = 38, -- If set monster cannot drop any items, not even seals.
    SHARE_POS              = 39, -- share a pos with another mob (eald'narche exoplates)
    TELEPORT_CD            = 40, -- cooldown for teleport abilities (tarutaru AA, angra mainyu, eald'narche)
    TELEPORT_START         = 41, -- mobskill ID to begin teleport
    TELEPORT_END           = 42, -- mobskill ID to end teleport
    TELEPORT_TYPE          = 43, -- teleport type - 1: on cooldown, 2 - to close distance
    DUAL_WIELD             = 44, -- enables a mob to use their offhand in attacks
    ADD_EFFECT             = 45, -- enables additional effect script to process on mobs attacks
    AUTO_SPIKES            = 46, -- enables additional effect script to process when mob is attacked
    SPAWN_LEASH            = 47, -- forces a mob to not move farther from its spawn than its leash distance
    SHARE_TARGET           = 48, -- mob always targets same target as ID in this var
    CHECK_AS_NM            = 49, -- If set, a mob will check as a NM.
    ROAM_RESET_FACING      = 50, -- Resume facing the default spawn rotation after roaming home.
    ROAM_TURNS             = 51, -- Maximum amount of turns during a roam
    ROAM_RATE              = 52, -- Roaming frequency. roam_cool - rand(roam_cool / (roam_rate / 10))
    BEHAVIOR               = 53, -- Add behaviors to mob
    GIL_BONUS              = 54, -- Allow mob to drop gil. Multiplier to gil dropped by mob (bonus / 100) * total
    IDLE_DESPAWN           = 55, -- Time (in seconds) to despawn after being idle
    HP_STANDBACK           = 56, -- mob will always standback with hp % higher to value
    MAGIC_DELAY            = 57, -- Amount of seconds mob waits before casting first spell
    SPECIAL_DELAY          = 58, -- Amount of seconds mob waits before using first special
    WEAPON_BONUS           = 59, -- Add a flat modifer mob weapon damage ( damage + bonus )
    SPAWN_ANIMATIONSUB     = 60, -- reset animationsub to this on spawn
    HP_SCALE               = 61, -- Scale the mobs max HP. ( hp_scale / 100 ) * maxhp
    NO_STANDBACK           = 62, -- Mob will never standback
    ATTACK_SKILL_LIST      = 63, -- skill list to use in place of regular attacks
    CHARMABLE              = 64, -- mob is charmable
    NO_MOVE                = 65, -- Mob will not be able to move
    MULTI_HIT              = 66, -- Mob will have as many swings as defined.
    NO_AGGRO               = 67, -- If set, mob cannot aggro until unset.
    ALLI_HATE              = 68, -- Range around target to add alliance member to enmity list.
    NO_LINK                = 69, -- If set, mob cannot link until unset.
    NO_REST                = 70, -- Mob cannot regain hp (e.g. re-burrowing antlions during ENM).
    LEADER                 = 71, -- Used for mobs that follow a defined "leader", such as Ul'xzomit mobs.
    MAGIC_RANGE            = 72, -- magic aggro range
    TARGET_DISTANCE_OFFSET = 73, -- Adjusts how close a mob will move to it's target. 12 = 1.2 yalm. Positive values to go closer, negative farther.
    ONE_WAY_LINKING        = 74, -- Will link with other mobs in its party (typically the same mob family) while roaming, but will not let others link with it once engaged
    CAN_PARRY              = 75, -- Check if a mob is allowed to have parry rank (Rank Value 1-5)
    NO_WIDESCAN            = 76, -- Disables widescan for a specific mob
    TRUST_DISTANCE         = 77, -- TRUSTS ONLY: Set movement type/distance. See trust.lua for details.
    MOBSKILL_DELAY         = 78, -- Delay (in ms) before using a mobskill after using a mobskill.
}
