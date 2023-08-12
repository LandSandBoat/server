-----------------------------------
-- Merits
-----------------------------------
xi = xi or {}

local meritCategory =
{
    HP_MP      = 0x0040,
    ATTRIBUTES = 0x0080,
    COMBAT     = 0x00C0,
    MAGIC      = 0x0100,
    OTHERS     = 0x0140,

    WAR_1 = 0x0180,
    MNK_1 = 0x01C0,
    WHM_1 = 0x0200,
    BLM_1 = 0x0240,
    RDM_1 = 0x0280,
    THF_1 = 0x02C0,
    PLD_1 = 0x0300,
    DRK_1 = 0x0340,
    BST_1 = 0x0380,
    BRD_1 = 0x03C0,
    RNG_1 = 0x0400,
    SAM_1 = 0x0440,
    NIN_1 = 0x0480,
    DRG_1 = 0x04C0,
    SMN_1 = 0x0500,
    BLU_1 = 0x0540,
    COR_1 = 0x0580,
    PUP_1 = 0x05C0,
    DNC_1 = 0x0600,
    SCH_1 = 0x0640,

    WS = 0x0680,

    GEO_1 = 0x06C0,
    RUN_1 = 0x0700,

    -- UNK_1 = 0x0740,
    -- UNK_2 = 0x0780,
    -- UNK_3 = 0x07C0,

    WAR_2 = 0x0800,
    MNK_2 = 0x0840,
    WHM_2 = 0x0880,
    BLM_2 = 0x08C0,
    RDM_2 = 0x0900,
    THF_2 = 0x0940,
    PLD_2 = 0x0980,
    DRK_2 = 0x09C0,
    BST_2 = 0x0A00,
    BRD_2 = 0x0A40,
    RNG_2 = 0x0A80,
    SAM_2 = 0x0AC0,
    NIN_2 = 0x0B00,
    DRG_2 = 0x0B40,
    SMN_2 = 0x0B80,
    BLU_2 = 0x0BC0,
    COR_2 = 0x0C00,
    PUP_2 = 0x0C40,
    DNC_2 = 0x0C80,
    SCH_2 = 0x0CC0,
    -- UNK_4 = 0x0D00,
    GEO_2 = 0x0D40,
    RUN_2 = 0x0D80,

    -- START = 0x0040,
    -- COUNT = 0x0D80,
}

xi.merit =
{
    -- HP
    MAX_HP                      = meritCategory.HP_MP + 0x00,
    MAX_MP                      = meritCategory.HP_MP + 0x02,

    -- ATTRIBUTES
    STR                         = meritCategory.ATTRIBUTES + 0x00,
    DEX                         = meritCategory.ATTRIBUTES + 0x02,
    VIT                         = meritCategory.ATTRIBUTES + 0x04,
    AGI                         = meritCategory.ATTRIBUTES + 0x08,
    INT                         = meritCategory.ATTRIBUTES + 0x0A,
    MND                         = meritCategory.ATTRIBUTES + 0x0C,
    CHR                         = meritCategory.ATTRIBUTES + 0x0E,

    -- COMBAT SKILLS
    H2H                         = meritCategory.COMBAT + 0x00,
    DAGGER                      = meritCategory.COMBAT + 0x02,
    SWORD                       = meritCategory.COMBAT + 0x04,
    GSWORD                      = meritCategory.COMBAT + 0x06,
    AXE                         = meritCategory.COMBAT + 0x08,
    GAXE                        = meritCategory.COMBAT + 0x0A,
    SCYTHE                      = meritCategory.COMBAT + 0x0C,
    POLEARM                     = meritCategory.COMBAT + 0x0E,
    KATANA                      = meritCategory.COMBAT + 0x10,
    GKATANA                     = meritCategory.COMBAT + 0x12,
    CLUB                        = meritCategory.COMBAT + 0x14,
    STAFF                       = meritCategory.COMBAT + 0x16,
    ARCHERY                     = meritCategory.COMBAT + 0x18,
    MARKSMANSHIP                = meritCategory.COMBAT + 0x1A,
    THROWING                    = meritCategory.COMBAT + 0x1C,
    GUARDING                    = meritCategory.COMBAT + 0x1E,
    EVASION                     = meritCategory.COMBAT + 0x20,
    SHIELD                      = meritCategory.COMBAT + 0x22,
    PARRYING                    = meritCategory.COMBAT + 0x24,

    -- MAGIC SKILLS
    DIVINE                      = meritCategory.MAGIC + 0x00,
    HEALING                     = meritCategory.MAGIC + 0x02,
    ENHANCING                   = meritCategory.MAGIC + 0x04,
    ENFEEBLING                  = meritCategory.MAGIC + 0x06,
    ELEMENTAL                   = meritCategory.MAGIC + 0x08,
    DARK                        = meritCategory.MAGIC + 0x0A,
    SUMMONING                   = meritCategory.MAGIC + 0x0C,
    NINJITSU                    = meritCategory.MAGIC + 0x0E,
    SINGING                     = meritCategory.MAGIC + 0x10,
    STRING                      = meritCategory.MAGIC + 0x12,
    WIND                        = meritCategory.MAGIC + 0x14,
    BLUE                        = meritCategory.MAGIC + 0x16,
    GEOMANCY                    = meritCategory.MAGIC + 0x18,
    HANDBELL                    = meritCategory.MAGIC + 0x1A,

    -- OTHERS
    ENMITY_INCREASE             = meritCategory.OTHERS + 0x00,
    ENMITY_DECREASE             = meritCategory.OTHERS + 0x02,
    CRIT_HIT_RATE               = meritCategory.OTHERS + 0x04,
    ENEMY_CRIT_RATE             = meritCategory.OTHERS + 0x06,
    SPELL_INTERUPTION_RATE      = meritCategory.OTHERS + 0x08,

    -- WAR 1
    BERSERK_RECAST              = meritCategory.WAR_1 + 0x00,
    DEFENDER_RECAST             = meritCategory.WAR_1 + 0x02,
    WARCRY_RECAST               = meritCategory.WAR_1 + 0x04,
    AGGRESSOR_RECAST            = meritCategory.WAR_1 + 0x06,
    DOUBLE_ATTACK_RATE          = meritCategory.WAR_1 + 0x08,

    -- MNK 1
    FOCUS_RECAST                = meritCategory.MNK_1 + 0x00,
    DODGE_RECAST                = meritCategory.MNK_1 + 0x02,
    CHAKRA_RECAST               = meritCategory.MNK_1 + 0x04,
    COUNTER_RATE                = meritCategory.MNK_1 + 0x06,
    KICK_ATTACK_RATE            = meritCategory.MNK_1 + 0x08,

    -- WHM 1
    DIVINE_SEAL_RECAST          = meritCategory.WHM_1 + 0x00,
    CURE_CAST_TIME              = meritCategory.WHM_1 + 0x02,
    BAR_SPELL_EFFECT            = meritCategory.WHM_1 + 0x04,
    BANISH_EFFECT               = meritCategory.WHM_1 + 0x06,
    REGEN_EFFECT                = meritCategory.WHM_1 + 0x08,

    -- BLM 1
    ELEMENTAL_SEAL_RECAST       = meritCategory.BLM_1 + 0x00,
    FIRE_MAGIC_POTENCY          = meritCategory.BLM_1 + 0x02,
    ICE_MAGIC_POTENCY           = meritCategory.BLM_1 + 0x04,
    WIND_MAGIC_POTENCY          = meritCategory.BLM_1 + 0x06,
    EARTH_MAGIC_POTENCY         = meritCategory.BLM_1 + 0x08,
    LIGHTNING_MAGIC_POTENCY     = meritCategory.BLM_1 + 0x0A,
    WATER_MAGIC_POTENCY         = meritCategory.BLM_1 + 0x0C,

    -- RDM 1
    CONVERT_RECAST              = meritCategory.RDM_1 + 0x00,
    FIRE_MAGIC_ACCURACY         = meritCategory.RDM_1 + 0x02,
    ICE_MAGIC_ACCURACY          = meritCategory.RDM_1 + 0x04,
    WIND_MAGIC_ACCURACY         = meritCategory.RDM_1 + 0x06,
    EARTH_MAGIC_ACCURACY        = meritCategory.RDM_1 + 0x08,
    LIGHTNING_MAGIC_ACCURACY    = meritCategory.RDM_1 + 0x0A,
    WATER_MAGIC_ACCURACY        = meritCategory.RDM_1 + 0x0C,

    -- THF 1
    FLEE_RECAST                 = meritCategory.THF_1 + 0x00,
    HIDE_RECAST                 = meritCategory.THF_1 + 0x02,
    SNEAK_ATTACK_RECAST         = meritCategory.THF_1 + 0x04,
    TRICK_ATTACK_RECAST         = meritCategory.THF_1 + 0x06,
    TRIPLE_ATTACK_RATE          = meritCategory.THF_1 + 0x08,

    -- PLD 1
    SHIELD_BASH_RECAST          = meritCategory.PLD_1 + 0x00,
    HOLY_CIRCLE_RECAST          = meritCategory.PLD_1 + 0x02,
    SENTINEL_RECAST             = meritCategory.PLD_1 + 0x04,
    COVER_EFFECT_LENGTH         = meritCategory.PLD_1 + 0x06,
    RAMPART_RECAST              = meritCategory.PLD_1 + 0x08,

    -- DRK 1
    SOULEATER_RECAST            = meritCategory.DRK_1 + 0x00,
    ARCANE_CIRCLE_RECAST        = meritCategory.DRK_1 + 0x02,
    LAST_RESORT_RECAST          = meritCategory.DRK_1 + 0x04,
    LAST_RESORT_EFFECT          = meritCategory.DRK_1 + 0x06,
    WEAPON_BASH_EFFECT          = meritCategory.DRK_1 + 0x08,

    -- BST 1
    KILLER_EFFECTS              = meritCategory.BST_1 + 0x00,
    REWARD_RECAST               = meritCategory.BST_1 + 0x02,
    CALL_BEAST_RECAST           = meritCategory.BST_1 + 0x04,
    SIC_RECAST                  = meritCategory.BST_1 + 0x06,
    TAME_RECAST                 = meritCategory.BST_1 + 0x08,

    -- BRD 1
    LULLABY_RECAST              = meritCategory.BRD_1 + 0x00,
    FINALE_RECAST               = meritCategory.BRD_1 + 0x02,
    MINNE_EFFECT                = meritCategory.BRD_1 + 0x04,
    MINUET_EFFECT               = meritCategory.BRD_1 + 0x06,
    MADRIGAL_EFFECT             = meritCategory.BRD_1 + 0x08,

    -- RNG 1
    SCAVENGE_EFFECT             = meritCategory.RNG_1 + 0x00,
    CAMOUFLAGE_RECAST           = meritCategory.RNG_1 + 0x02,
    SHARPSHOT_RECAST            = meritCategory.RNG_1 + 0x04,
    UNLIMITED_SHOT_RECAST       = meritCategory.RNG_1 + 0x06,
    RAPID_SHOT_RATE             = meritCategory.RNG_1 + 0x08,

    -- SAM 1
    THIRD_EYE_RECAST            = meritCategory.SAM_1 + 0x00,
    WARDING_CIRCLE_RECAST       = meritCategory.SAM_1 + 0x02,
    STORE_TP_EFFECT             = meritCategory.SAM_1 + 0x04,
    MEDITATE_RECAST             = meritCategory.SAM_1 + 0x06,
    ZASHIN_ATTACK_RATE          = meritCategory.SAM_1 + 0x08,

    -- NIN 1
    SUBTLE_BLOW_EFFECT          = meritCategory.NIN_1 + 0x00,
    KATON_EFFECT                = meritCategory.NIN_1 + 0x02,
    HYOTON_EFFECT               = meritCategory.NIN_1 + 0x04,
    HUTON_EFFECT                = meritCategory.NIN_1 + 0x06,
    DOTON_EFFECT                = meritCategory.NIN_1 + 0x08,
    RAITON_EFFECT               = meritCategory.NIN_1 + 0x0A,
    SUITON_EFFECT               = meritCategory.NIN_1 + 0x0C,

    -- DRG 1
    ANCIENT_CIRCLE_RECAST       = meritCategory.DRG_1 + 0x00,
    JUMP_RECAST                 = meritCategory.DRG_1 + 0x02,
    HIGH_JUMP_RECAST            = meritCategory.DRG_1 + 0x04,
    SUPER_JUMP_RECAST           = meritCategory.DRG_1 + 0x05,
    SPIRIT_LINK_RECAST          = meritCategory.DRG_1 + 0x08,

    -- SMN 1
    AVATAR_PHYSICAL_ACCURACY    = meritCategory.SMN_1 + 0x00,
    AVATAR_PHYSICAL_ATTACK      = meritCategory.SMN_1 + 0x02,
    AVATAR_MAGICAL_ACCURACY     = meritCategory.SMN_1 + 0x04,
    AVATAR_MAGICAL_ATTACK       = meritCategory.SMN_1 + 0x06,
    SUMMONING_MAGIC_CAST_TIME   = meritCategory.SMN_1 + 0x08,

    -- BLU 1
    CHAIN_AFFINITY_RECAST       = meritCategory.BLU_1 + 0x00,
    BURST_AFFINITY_RECAST       = meritCategory.BLU_1 + 0x02,
    MONSTER_CORRELATION         = meritCategory.BLU_1 + 0x04,
    PHYSICAL_POTENCY            = meritCategory.BLU_1 + 0x06,
    MAGICAL_ACCURACY            = meritCategory.BLU_1 + 0x08,

    -- COR 1
    PHANTOM_ROLL_RECAST         = meritCategory.COR_1 + 0x00,
    QUICK_DRAW_RECAST           = meritCategory.COR_1 + 0x02,
    QUICK_DRAW_ACCURACY         = meritCategory.COR_1 + 0x04,
    RANDOM_DEAL_RECAST          = meritCategory.COR_1 + 0x06,
    BUST_DURATION               = meritCategory.COR_1 + 0x08,

    -- PUP 1
    AUTOMATON_SKILLS            = meritCategory.PUP_1 + 0x00,
    MAINTENACE_RECAST           = meritCategory.PUP_1 + 0x02,
    REPAIR_EFFECT               = meritCategory.PUP_1 + 0x04,
    ACTIVATE_RECAST             = meritCategory.PUP_1 + 0x06,
    REPAIR_RECAST               = meritCategory.PUP_1 + 0x08,

    -- DNC 1
    STEP_ACCURACY               = meritCategory.DNC_1 + 0x00,
    HASTE_SAMBA_EFFECT          = meritCategory.DNC_1 + 0x02,
    REVERSE_FLOURISH_EFFECT     = meritCategory.DNC_1 + 0x04,
    BUILDING_FLOURISH_EFFECT    = meritCategory.DNC_1 + 0x06,

    -- SCH 1
    GRIMOIRE_RECAST             = meritCategory.SCH_1 + 0x00,
    MODUS_VERITAS_DURATION      = meritCategory.SCH_1 + 0x02,
    HELIX_MAGIC_ACC_ATT         = meritCategory.SCH_1 + 0x04,
    MAX_SUBLIMATION             = meritCategory.SCH_1 + 0x06,

    -- GEO 1
    FULL_CIRCLE_EFFECT          = meritCategory.GEO_1 + 0x00,
    ECLIPTIC_ATT_RECAST         = meritCategory.GEO_1 + 0x02,
    LIFE_CYCLE_RECAST           = meritCategory.GEO_1 + 0x04,
    BLAZE_OF_GLORY_RECAST       = meritCategory.GEO_1 + 0x06,
    DEMATERIALIZE_RECAST        = meritCategory.GEO_1 + 0x08,

    -- RUN 1
    MERIT_RUNE_ENHANCE          = meritCategory.RUN_1 + 0x00,
    MERIT_VALLATION_EFFECT      = meritCategory.RUN_1 + 0x02,
    MERIT_LUNGE_EFFECT          = meritCategory.RUN_1 + 0x04,
    MERIT_PFLUG_EFFECT          = meritCategory.RUN_1 + 0x06,
    MERIT_GAMBIT_EFFECT         = meritCategory.RUN_1 + 0x08,

    -- WEAPON SKILLS
    SHIJIN_SPIRAL               = meritCategory.WS + 0x00,
    EXENTERATOR                 = meritCategory.WS + 0x02,
    REQUIESCAT                  = meritCategory.WS + 0x04,
    RESOLUTION                  = meritCategory.WS + 0x06,
    RUINATOR                    = meritCategory.WS + 0x08,
    UPHEAVAL                    = meritCategory.WS + 0x0A,
    ENTROPY                     = meritCategory.WS + 0x0C,
    STARDIVER                   = meritCategory.WS + 0x0E,
    BLADE_SHUN                  = meritCategory.WS + 0x10,
    TACHI_SHOHA                 = meritCategory.WS + 0x12,
    REALMRAZER                  = meritCategory.WS + 0x14,
    SHATTERSOUL                 = meritCategory.WS + 0x16,
    APEX_ARROW                  = meritCategory.WS + 0x18,
    LAST_STAND                  = meritCategory.WS + 0x1A,

    -- WAR 2
    WARRIORS_CHARGE             = meritCategory.WAR_2 + 0x00,
    TOMAHAWK                    = meritCategory.WAR_2 + 0x02,
    SAVAGERY                    = meritCategory.WAR_2 + 0x04,
    AGGRESSIVE_AIM              = meritCategory.WAR_2 + 0x06,

    -- MNK 2
    MANTRA                      = meritCategory.MNK_2 + 0x00,
    FORMLESS_STRIKES            = meritCategory.MNK_2 + 0x02,
    INVIGORATE                  = meritCategory.MNK_2 + 0x04,
    PENANCE                     = meritCategory.MNK_2 + 0x06,

    -- WHM 2
    MARTYR                      = meritCategory.WHM_2 + 0x00,
    DEVOTION                    = meritCategory.WHM_2 + 0x02,
    PROTECTRA_V                 = meritCategory.WHM_2 + 0x04,
    SHELLRA_V                   = meritCategory.WHM_2 + 0x06,
    ANIMUS_SOLACE               = meritCategory.WHM_2 + 0x08,
    ANIMUS_MISERY               = meritCategory.WHM_2 + 0x0A,

    -- BLM 2
    FLARE_II                    = meritCategory.BLM_2 + 0x00,
    FREEZE_II                   = meritCategory.BLM_2 + 0x02,
    TORNADO_II                  = meritCategory.BLM_2 + 0x04,
    QUAKE_II                    = meritCategory.BLM_2 + 0x06,
    BURST_II                    = meritCategory.BLM_2 + 0x08,
    FLOOD_II                    = meritCategory.BLM_2 + 0x0A,
    ANCIENT_MAGIC_ATK_BONUS     = meritCategory.BLM_2 + 0x0C,
    ANCIENT_MAGIC_BURST_DMG     = meritCategory.BLM_2 + 0x0E,
    ELEMENTAL_MAGIC_ACCURACY    = meritCategory.BLM_2 + 0x10,
    ELEMENTAL_DEBUFF_DURATION   = meritCategory.BLM_2 + 0x12,
    ELEMENTAL_DEBUFF_EFFECT     = meritCategory.BLM_2 + 0x14,
    ASPIR_ABSORPTION_AMOUNT     = meritCategory.BLM_2 + 0x16,

    -- RDM 2
    DIA_III                     = meritCategory.RDM_2 + 0x00,
    SLOW_II                     = meritCategory.RDM_2 + 0x02,
    PARALYZE_II                 = meritCategory.RDM_2 + 0x04,
    PHALANX_II                  = meritCategory.RDM_2 + 0x06,
    BIO_III                     = meritCategory.RDM_2 + 0x08,
    BLIND_II                    = meritCategory.RDM_2 + 0x0A,
    ENFEEBLING_MAGIC_DURATION   = meritCategory.RDM_2 + 0x0C,
    MAGIC_ACCURACY              = meritCategory.RDM_2 + 0x0E,
    ENHANCING_MAGIC_DURATION    = meritCategory.RDM_2 + 0x10,
    IMMUNOBREAK_CHANCE          = meritCategory.RDM_2 + 0x12,
    ENSPELL_DAMAGE              = meritCategory.RDM_2 + 0x14,
    ACCURACY                    = meritCategory.RDM_2 + 0x16,

    -- THF 2
    ASSASSINS_CHARGE            = meritCategory.THF_2 + 0x00,
    FEINT                       = meritCategory.THF_2 + 0x02,
    AURA_STEAL                  = meritCategory.THF_2 + 0x04,
    AMBUSH                      = meritCategory.THF_2 + 0x06,

    -- PLD 2
    FEALTY                      = meritCategory.PLD_2 + 0x00,
    CHIVALRY                    = meritCategory.PLD_2 + 0x02,
    IRON_WILL                   = meritCategory.PLD_2 + 0x04,
    GUARDIAN                    = meritCategory.PLD_2 + 0x06,

    -- DRK 2
    DARK_SEAL                   = meritCategory.DRK_2 + 0x00,
    DIABOLIC_EYE                = meritCategory.DRK_2 + 0x02,
    MUTED_SOUL                  = meritCategory.DRK_2 + 0x04,
    DESPERATE_BLOWS             = meritCategory.DRK_2 + 0x06,

    -- BST 2
    FERAL_HOWL                  = meritCategory.BST_2 + 0x00,
    KILLER_INSTINCT             = meritCategory.BST_2 + 0x02,
    BEAST_AFFINITY              = meritCategory.BST_2 + 0x04,
    BEAST_HEALER                = meritCategory.BST_2 + 0x06,

    -- BRD 2
    NIGHTINGALE                 = meritCategory.BRD_2 + 0x00,
    TROUBADOUR                  = meritCategory.BRD_2 + 0x02,
    FOE_SIRVENTE                = meritCategory.BRD_2 + 0x04,
    ADVENTURERS_DIRGE           = meritCategory.BRD_2 + 0x06,
    CON_ANIMA                   = meritCategory.BRD_2 + 0x08,
    CON_BRIO                    = meritCategory.BRD_2 + 0x0A,

    -- RNG 2
    STEALTH_SHOT                = meritCategory.RNG_2 + 0x00,
    FLASHY_SHOT                 = meritCategory.RNG_2 + 0x02,
    SNAPSHOT                    = meritCategory.RNG_2 + 0x04,
    RECYCLE                     = meritCategory.RNG_2 + 0x06,

    -- SAM 2
    SHIKIKOYO                   = meritCategory.SAM_2 + 0x00,
    BLADE_BASH                  = meritCategory.SAM_2 + 0x02,
    IKISHOTEN                   = meritCategory.SAM_2 + 0x04,
    OVERWHELM                   = meritCategory.SAM_2 + 0x06,

    -- NIN 2
    SANGE                       = meritCategory.NIN_2 + 0x00,
    NINJA_TOOL_EXPERTISE        = meritCategory.NIN_2 + 0x02,
    KATON_SAN                   = meritCategory.NIN_2 + 0x04,
    HYOTON_SAN                  = meritCategory.NIN_2 + 0x06,
    HUTON_SAN                   = meritCategory.NIN_2 + 0x08,
    DOTON_SAN                   = meritCategory.NIN_2 + 0x0A,
    RAITON_SAN                  = meritCategory.NIN_2 + 0x0C,
    SUITON_SAN                  = meritCategory.NIN_2 + 0x0E,
    YONIN_EFFECT                = meritCategory.NIN_2 + 0x10,
    INNIN_EFFECT                = meritCategory.NIN_2 + 0x12,
    NIN_MAGIC_ACCURACY          = meritCategory.NIN_2 + 0x14,
    NIN_MAGIC_BONUS             = meritCategory.NIN_2 + 0x16,

    -- DRG 2
    DEEP_BREATHING              = meritCategory.DRG_2 + 0x00,
    ANGON                       = meritCategory.DRG_2 + 0x02,
    EMPATHY                     = meritCategory.DRG_2 + 0x04,
    STRAFE_EFFECT               = meritCategory.DRG_2 + 0x06,

    -- SMN 2
    METEOR_STRIKE               = meritCategory.SMN_2 + 0x00,
    HEAVENLY_STRIKE             = meritCategory.SMN_2 + 0x02,
    WIND_BLADE                  = meritCategory.SMN_2 + 0x04,
    GEOCRUSH                    = meritCategory.SMN_2 + 0x06,
    THUNDERSTORM                = meritCategory.SMN_2 + 0x08,
    GRANDFALL                   = meritCategory.SMN_2 + 0x0A,

    -- BLU 2
    CONVERGENCE                 = meritCategory.BLU_2 + 0x00,
    DIFFUSION                   = meritCategory.BLU_2 + 0x02,
    ENCHAINMENT                 = meritCategory.BLU_2 + 0x04,
    ASSIMILATION                = meritCategory.BLU_2 + 0x06,

    -- COR 2
    SNAKE_EYE                   = meritCategory.COR_2 + 0x00,
    FOLD                        = meritCategory.COR_2 + 0x02,
    WINNING_STREAK              = meritCategory.COR_2 + 0x04,
    LOADED_DECK                 = meritCategory.COR_2 + 0x06,

    -- PUP 2
    ROLE_REVERSAL               = meritCategory.PUP_2 + 0x00,
    VENTRILOQUY                 = meritCategory.PUP_2 + 0x02,
    FINE_TUNING                 = meritCategory.PUP_2 + 0x04,
    OPTIMIZATION                = meritCategory.PUP_2 + 0x06,

    -- DNC 2
    SABER_DANCE                 = meritCategory.DNC_2 + 0x00,
    FAN_DANCE                   = meritCategory.DNC_2 + 0x02,
    NO_FOOT_RISE                = meritCategory.DNC_2 + 0x04,
    CLOSED_POSITION             = meritCategory.DNC_2 + 0x06,

    -- SCH 2
    ALTRUISM                    = meritCategory.SCH_2 + 0x00,
    FOCALIZATION                = meritCategory.SCH_2 + 0x02,
    TRANQUILITY                 = meritCategory.SCH_2 + 0x04,
    EQUANIMITY                  = meritCategory.SCH_2 + 0x06,
    ENLIGHTENMENT               = meritCategory.SCH_2 + 0x08,
    STORMSURGE                  = meritCategory.SCH_2 + 0x0A,

    -- GEO 2
    MENDING_HALATION            = meritCategory.GEO_2 + 0x00,
    RADIAL_ARCANA               = meritCategory.GEO_2 + 0x02,
    CURATIVE_RECANTATION        = meritCategory.GEO_2 + 0x04,
    PRIMEVAL_ZEAL               = meritCategory.GEO_2 + 0x06,

    -- RUN 2
    MERIT_BATTUTA               = meritCategory.RUN_2 + 0x00,
    MERIT_RAYKE                 = meritCategory.RUN_2 + 0x02,
    MERIT_INSPIRATION           = meritCategory.RUN_2 + 0x04,
    MERIT_SLEIGHT_OF_SWORD      = meritCategory.RUN_2 + 0x06,
}
