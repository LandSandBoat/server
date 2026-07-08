-----------------------------------
-- Mezzotinting
-----------------------------------
xi = xi or {}
xi.mezzotint = xi.mezzotint or {}

-- Path/Type stored in Mezzotinted equipment exdata.
---@enum xi.mezzotint.type
xi.mezzotint.type =
{
    A = 0,
    B = 1,
    C = 2,
    D = 3,
}

-- Mezzotinting augments are stored client-side as a lookup table of 256 uint16 entries
-- Bits 14-15: Prefix (0=none, 1=Automaton, 2=Pet)
-- Bit 12:     Negate the received associated value
-- Bit 11:     Expand (1=bitmask in bits 0-6 is used to select sub-stats from pool - used for STR/DEX etc)
-- Bits 0-10:  Augment ID if Expand unset
-- Bits 0-6:   Bitmask to select pooled base stats if Expand set
-- Certain augments (*_II) are duplicated to cover both 1-256 and 257-512 value ranges
-- Source: FFXiMain.dll signature 66 8B 0C 45 ?? ?? ?? ?? F6 C5 08 74 0C
---@enum xi.mezzotint.augment
xi.mezzotint.augment =
{
    HP                           =   2, -- HP+#
    HP_II                        =   3, -- HP+# (257-512)
    MP                           =   4, -- MP+#
    MP_II                        =   5, -- MP+# (257-512)
    ATTACK                       =   8, -- Attack+#
    ATTACK_II                    =   9, -- Attack+# (257-512)
    RANGED_ATTACK                =  10, -- Rng. Atk.+#
    RANGED_ATTACK_II             =  11, -- Rng. Atk.+# (257-512)
    ACCURACY                     =  12, -- Accuracy+#
    ACCURACY_II                  =  13, -- Accuracy+# (257-512)
    RANGED_ACCURACY              =  14, -- Rng. Acc.+#
    RANGED_ACCURACY_II           =  15, -- Rng. Acc.+# (257-512)
    DEF                          =  16, -- DEF+#
    DEF_II                       =  17, -- DEF+# (257-512)
    EVASION                      =  18, -- Evasion+#
    EVASION_II                   =  19, -- Evasion+# (257-512)
    MAGIC_ATTACK_BONUS           =  20, -- Mag. Atk. Bns.+#
    MAGIC_ATTACK_BONUS_II        =  21, -- Mag. Atk. Bns.+# (257-512)
    MAGIC_DEFENSE_BONUS          =  22, -- Mag. Def. Bns.+#
    MAGIC_DEFENSE_BONUS_II       =  23, -- Mag. Def. Bns.+# (257-512)
    MAGIC_ACCURACY               =  24, -- Mag. Acc.+#
    MAGIC_ACCURACY_II            =  25, -- Mag. Acc.+# (257-512)
    MAGIC_EVASION                =  26, -- Mag. Evasion+#
    MAGIC_EVASION_II             =  27, -- Mag. Evasion+# (257-512)
    DMG                          =  28, -- DMG:+#
    DMG_II                       =  29, -- DMG:+# (257-512)
    WEAPON_SKILL_DAMAGE          = 114, -- Weapon skill damage +#%
    MAGIC_DAMAGE                 = 115, -- Magic Damage+#
    BLOOD_PACT_DAMAGE            = 116, -- Blood Pact damage +#
    AVATAR_PERPETUATION_COST     = 117, -- Avatar perpetuation cost -#
    BLOOD_PACT_ABILITY_DELAY     = 118, -- Blood Pact ability delay -#
    HASTE                        = 119, -- Haste+#%
    ENMITY_UP                    = 120, -- Enmity+#
    ENMITY_DOWN                  = 121, -- Enmity-#
    CRITICAL_HIT_RATE            = 122, -- Critical hit rate +#%
    CURE_SPELLCASTING_TIME       = 123, -- Cure spellcasting time -#%
    CURE_POTENCY                 = 124, -- Cure potency +#%
    REFRESH                      = 125, -- Refresh+#
    SPELL_INTERRUPTION_RATE_DOWN = 126, -- Spell interruption rate down #%
    CURE_EFFECT_RECEIVED         = 127, -- Pot. of Cure effect rec. +#%
    PET_MAGIC_ATTACK_BONUS       = 128, -- Pet: Mag. Atk. Bns.+#
    PET_MAGIC_ACCURACY           = 129, -- Pet: Mag. Acc.+#
    PET_ATTACK                   = 130, -- Pet: Attack+#
    PET_ACCURACY                 = 131, -- Pet: Accuracy+#
    PET_ENMITY_UP                = 132, -- Pet: Enmity+#
    PET_ENMITY_UP_2              = 133, -- Pet: Enmity+# (actual duplicate, unknown usage)
    PET_HP                       = 134, -- Pet: HP+#
    PET_MP                       = 135, -- Pet: MP+#
    PET_STR                      = 136, -- Pet: STR+#
    PET_DEX                      = 137, -- Pet: DEX+#
    PET_VIT                      = 138, -- Pet: VIT+#
    PET_AGI                      = 139, -- Pet: AGI+#
    PET_INT                      = 140, -- Pet: INT+#
    PET_MND                      = 141, -- Pet: MND+#
    PET_CHR                      = 142, -- Pet: CHR+#
    PET_DOUBLE_ATTACK            = 152, -- Pet: Double Attack+#%
    PET_DAMAGE_TAKEN_DOWN        = 153, -- Pet: Damage taken -#%
    PET_REGEN                    = 154, -- Pet: Regen+#
    PET_HASTE                    = 155, -- Pet: Haste+#%
    AUTOMATON_CURE_POTENCY       = 156, -- Automaton: Cure potency +#%
    AUTOMATON_FAST_CAST          = 157, -- Automaton: Fast Cast+#%
    DUAL_WIELD                   = 171, -- Dual Wield+#
    DAMAGE_TAKEN_DOWN            = 172, -- Damage taken -#%
    ALL_SONGS                    = 173, -- All songs +#
    CONSERVE_MP                  = 177, -- Conserve MP+#
    COUNTER                      = 178, -- Counter+#
    TRIPLE_ATTACK                = 179, -- Triple Attack+#%
    FAST_CAST                    = 180, -- Fast Cast+#%
    BLOOD_BOON                   = 181, -- Blood Boon+#
    SUBTLE_BLOW                  = 182, -- Subtle Blow+#
    RAPID_SHOT                   = 183, -- Rapid Shot+#
    RECYCLE                      = 184, -- Recycle+#
    STORE_TP                     = 185, -- Store TP+#
    DOUBLE_ATTACK                = 186, -- Double Attack+#%
    SNAPSHOT                     = 187, -- Snapshot+#
    PHYSICAL_DAMAGE_TAKEN_DOWN   = 188, -- Phys. dmg. taken -#%
    MAGIC_DAMAGE_TAKEN_DOWN      = 189, -- Magic dmg. taken -#%
    BREATH_DAMAGE_TAKEN_DOWN     = 190, -- Breath dmg. taken -#%
    STR                          = 191, -- STR+#
    DEX                          = 192, -- DEX+#
    VIT                          = 193, -- VIT+#
    AGI                          = 194, -- AGI+#
    INT                          = 195, -- INT+#
    MND                          = 196, -- MND+#
    CHR                          = 197, -- CHR+#
    ALL_STATS                    = 206, -- All Stats+#
    HAND_TO_HAND_SKILL           = 208, -- Hand-to-Hand skill +#
    DAGGER_SKILL                 = 209, -- Dagger skill +#
    SWORD_SKILL                  = 210, -- Sword skill +#
    GREAT_SWORD_SKILL            = 211, -- Great Sword skill +#
    AXE_SKILL                    = 212, -- Axe skill +#
    GREAT_AXE_SKILL              = 213, -- Great Axe skill +#
    SCYTHE_SKILL                 = 214, -- Scythe skill +#
    POLEARM_SKILL                = 215, -- Polearm skill +#
    KATANA_SKILL                 = 216, -- Katana skill +#
    GREAT_KATANA_SKILL           = 217, -- Great Katana skill +#
    CLUB_SKILL                   = 218, -- Club skill +#
    STAFF_SKILL                  = 219, -- Staff skill +#
    MELEE_SKILL                  = 229, -- Melee skill +#
    RANGED_SKILL                 = 230, -- Ranged skill +#
    MAGIC_SKILL                  = 231, -- Magic skill +#
    ARCHERY_SKILL                = 232, -- Archery skill +#
    MARKSMANSHIP_SKILL           = 233, -- Marksmanship skill +#
    THROWING_SKILL               = 234, -- Throwing skill +#
    SHIELD_SKILL                 = 237, -- Shield skill +#
    PARRYING_SKILL               = 238, -- Parrying skill +#
    DIVINE_MAGIC_SKILL           = 239, -- Divine magic skill +#
    HEALING_MAGIC_SKILL          = 240, -- Healing magic skill +#
    ENHANCING_MAGIC_SKILL        = 241, -- Enha. mag. skill +#
    ENFEEBLING_MAGIC_SKILL       = 242, -- Enfb. mag. skill +#
    ELEMENTAL_MAGIC_SKILL        = 243, -- Elem. magic skill +#
    DARK_MAGIC_SKILL             = 244, -- Dark magic skill +#
    SUMMONING_MAGIC_SKILL        = 245, -- Summoning magic skill +#
    NINJUTSU_SKILL               = 246, -- Ninjutsu skill +#
    SINGING_SKILL                = 247, -- Singing skill +#
    STRING_INSTRUMENT_SKILL      = 248, -- String instrument skill +#
    WIND_INSTRUMENT_SKILL        = 249, -- Wind instrument skill +#
    BLUE_MAGIC_SKILL             = 250, -- Blue magic skill +#
    GEOMANCY_SKILL               = 251, -- Geomancy skill +#
    HANDBELL_SKILL               = 252, -- Handbell skill +#
}
