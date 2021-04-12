-----------------------------------
-- Job Points Global
-----------------------------------
xi = xi or {}

------------------------------------
-- Job Points
------------------------------------
local JPCATEGORY_WAR      = 0x020
local JPCATEGORY_MNK      = 0x040
local JPCATEGORY_WHM      = 0x060
local JPCATEGORY_BLM      = 0x080
local JPCATEGORY_RDM      = 0x0A0
local JPCATEGORY_THF      = 0x0C0
local JPCATEGORY_PLD      = 0x0E0
local JPCATEGORY_DRK      = 0x100
local JPCATEGORY_BST      = 0x120
local JPCATEGORY_BRD      = 0x140
local JPCATEGORY_RNG      = 0x160
local JPCATEGORY_SAM      = 0x180
local JPCATEGORY_NIN      = 0x1A0
local JPCATEGORY_DRG      = 0x1C0
local JPCATEGORY_SMN      = 0x1E0
local JPCATEGORY_BLU      = 0x200
local JPCATEGORY_COR      = 0x220
local JPCATEGORY_PUP      = 0x240
local JPCATEGORY_DNC      = 0x260
local JPCATEGORY_SCH      = 0x280
local JPCATEGORY_GEO      = 0x2A0
local JPCATEGORY_RUN      = 0x2C0

xi.jp = {

    --WAR
    MIGHTY_STRIKES_EFFECT    = JPCATEGORY_WAR + 0x00, --+ Physical Accuracy +2
    BRAZEN_RUSH_EFFECT       = JPCATEGORY_WAR + 0x02, --+ Physical Attack +4
    BERSERK_EFFECT           = JPCATEGORY_WAR + 0x01, --+ Physical Attack +2
    DEFENDER_EFFECT          = JPCATEGORY_WAR + 0x03, --+ Physical Defense +3
    WARCRY_EFFECT            = JPCATEGORY_WAR + 0x04, --+ Physical Attack +3
    AGGRESSOR_EFFECT         = JPCATEGORY_WAR + 0x05, --+ Physical Accuracy +1
    RETALIATION_EFFECT       = JPCATEGORY_WAR + 0x06, --X retaliation chance +1
    RESTRAINT_EFFECT         = JPCATEGORY_WAR + 0x07, --X time to max ws bonus -2%
    BLOOD_RAGE_EFFECT        = JPCATEGORY_WAR + 0x08, --X crit. hit rate +1
    DOUBLE_ATTACK_EFFECT     = JPCATEGORY_WAR + 0x09, --X double attack p.atk +1

    --MNK
    HUNDRED_FISTS_EFFECT     = JPCATEGORY_MNK + 0x00, --+ Physical Accuracy +2
    INNER_STRENGTH_EFFECT    = JPCATEGORY_MNK + 0x02, --X hp recovered +2%
    DODGE_EFFECT             = JPCATEGORY_MNK + 0x01, --+ Evasion +2
    FOCUS_EFFECT             = JPCATEGORY_MNK + 0x03, --+ Accuracy +1
    CHAKRA_EFFECT            = JPCATEGORY_MNK + 0x04, --+ HP Recovered +10
    COUNTERSTANCE_EFFECT     = JPCATEGORY_MNK + 0x05, --+ Counter Attack Bonus (2% DEX)
    FOOTWORK_EFFECT          = JPCATEGORY_MNK + 0x06, --+ Kick Attack Damage +1
    PERFECT_COUNTER_EFFECT   = JPCATEGORY_MNK + 0x07, --X VIT bonus +1
    IMPETUS_EFFECT           = JPCATEGORY_MNK + 0x08, --X maximum p.atk +2
    KICK_ATTACKS_EFFECT      = JPCATEGORY_MNK + 0x09, --X kick attacks atk +2 acc +1

    --WHM
    BENEDICTION_EFFECT       = JPCATEGORY_WHM + 0x00, --X mp recovered +1%
    ASYLUM_EFFECT            = JPCATEGORY_WHM + 0x02, --X m.eva +4
    DIVINE_SEAL_EFFECT       = JPCATEGORY_WHM + 0x01, --X reduce emnity from use +3
    WHM_MAGIC_ACC_BONUS      = JPCATEGORY_WHM + 0x03, --O m.acc +1
    AFFLATUS_SOLACE_EFFECT   = JPCATEGORY_WHM + 0x04, --X cure potency +2 (not %) ||||I DON'T KNOW WHAT THIS MEANS||||
    AFFLATUS_MISERY_EFFECT   = JPCATEGORY_WHM + 0x05, --X banish +2 m.dmg, miss => acc +1 dmg +1
    DIVINE_CARESS_DURATION   = JPCATEGORY_WHM + 0x06, --X dur. +2 sec
    SACROSANCTITY_EFFECT     = JPCATEGORY_WHM + 0x07, --X minimum DEF +1
    REGEN_DURATION           = JPCATEGORY_WHM + 0x08, --O dur. +3 sec
    BAR_SPELL_EFFECT         = JPCATEGORY_WHM + 0x09, --O resistance +2

    --BLM
    MANAFONT_EFFECT          = JPCATEGORY_BLM + 0x00, --O elemental m.dmg +2
    SUBTLE_SORCERY_EFFECT    = JPCATEGORY_BLM + 0x02, --X spellcasting time -1%
    ELEMENTAL_SEAL_EFFECT    = JPCATEGORY_BLM + 0x01, --X elemental magic emnity -3
    MAGIC_BURST_DMG_BONUS    = JPCATEGORY_BLM + 0x03, --O magic burst dmg +1%
    MANA_WALL_EFFECT         = JPCATEGORY_BLM + 0x04, --X mp consumed -1%
    BLM_MAGIC_ACC_BONUS      = JPCATEGORY_BLM + 0x05, --+ m.acc +1
    EMNITY_DOUSE_RECAST      = JPCATEGORY_BLM + 0x06, --X recast -3sec
    MANAWELL_EFFECT          = JPCATEGORY_BLM + 0x07, --O m.dmg +1
    MAGIC_BURST_EMNITY_BONUS = JPCATEGORY_BLM + 0x08, --X emnity -1
    MAGIC_DMG_BONUS          = JPCATEGORY_BLM + 0x09, --O m.dmg +1

    --RDM
    CHAINSPELL_EFFECT        = JPCATEGORY_RDM + 0x00, --+ elem. m.dmg +2
    STYMIE_EFFECT            = JPCATEGORY_RDM + 0x02, --+ effect dur. +1s
    CONVERT_EFFECT           = JPCATEGORY_RDM + 0x01, --+ HP consumed -1%
    RDM_MAGIC_ACC_BONUS      = JPCATEGORY_RDM + 0x03, --+ m.acc +1
    COMPOSURE_EFFECT         = JPCATEGORY_RDM + 0x04, --+ p.acc +1
    RDM_MAGIC_ATK_BONUS      = JPCATEGORY_RDM + 0x05, --+ MAB +1
    SABOTEUR_EFFECT          = JPCATEGORY_RDM + 0x06, --+ enfeeble m.acc +2
    ENFEEBLE_DURATION        = JPCATEGORY_RDM + 0x07, --+ enfeeble dur. +1s
    QUICK_MAGIC_EFFECT       = JPCATEGORY_RDM + 0x08, --X MP consumption -2%
    ENHANCING_DURATION       = JPCATEGORY_RDM + 0x09, --O dur. +1s

    --THF
    PERFECT_DODGE_EFFECT     = JPCATEGORY_THF + 0x00, --+ m.eva +3
    LARCENY_EFFECT           = JPCATEGORY_THF + 0x02, --X dur. +1s
    SNEAK_ATTACK_EFFECT      = JPCATEGORY_THF + 0x01, --+ DEX bonus +1%
    TRICK_ATTACK_EFFECT      = JPCATEGORY_THF + 0x03, --+ AGI bonus +1%
    STEAL_RECAST             = JPCATEGORY_THF + 0x04, --+ recast -2s
    MUG_EFFECT               = JPCATEGORY_THF + 0x05, --+ drain HP == 5% (DEX + AGI)
    DESPOIL_EFFECT           = JPCATEGORY_THF + 0x06, --+ drain 2% tp
    CONSPIRATOR_EFFECT       = JPCATEGORY_THF + 0x07, --+ p.acc +1
    BULLY_EFFECT             = JPCATEGORY_THF + 0x08, --+ intimidation chance +1%
    TRIPLE_ATTACK_EFFECT     = JPCATEGORY_THF + 0x09, --X p.atk +1

    --PLD
    INVINCIBLE_EFFECT        = JPCATEGORY_PLD + 0x00, --O emnity +100
    INTERVENE_EFFECT         = JPCATEGORY_PLD + 0x02, --X dmg +2%
    HOLY_CIRCLE_EFFECT       = JPCATEGORY_PLD + 0x01, --X dmg taken -1
    SENTINEL_EFFECT          = JPCATEGORY_PLD + 0x03, --O emnity +1
    SHIELD_BASH_EFFECT       = JPCATEGORY_PLD + 0x04, --O dmg +10
    COVER_DURATION           = JPCATEGORY_PLD + 0x05, --X dur. +1s
    DIVINE_EMBLEM_EFFECT     = JPCATEGORY_PLD + 0x06, --X m.dmg +2
    SEPULCHER_DURATION       = JPCATEGORY_PLD + 0x07, --X dur. +1s
    PALISADE_EFFECT          = JPCATEGORY_PLD + 0x08, --X block chance +1%
    ENLIGHT_EFFECT           = JPCATEGORY_PLD + 0x09, --O ae.dmg +1 p.acc +1

    --DRK
    BLOOD_WEAPON_EFFECT      = JPCATEGORY_DRK + 0x00, --O hp absorb +2%
    SOUL_ENSLAVEMENT_EFFECT  = JPCATEGORY_DRK + 0x02, --X tp absorb +1%
    ARCANE_CIRCLE_EFFECT     = JPCATEGORY_DRK + 0x01, --X dmg taken -1
    LAST_RESORT_EFFECT       = JPCATEGORY_DRK + 0x03, --O p.atk +2
    SOULEATER_DURATION       = JPCATEGORY_DRK + 0x04, --O dur. +1s
    WEAPON_BASH_EFFECT       = JPCATEGORY_DRK + 0x05, --O dmg +10
    NETHER_VOID_EFFECT       = JPCATEGORY_DRK + 0x06, --X absorb +2% abs-attri status +1/10
    ARCANE_CREST_DURATION    = JPCATEGORY_DRK + 0x07, --X dur. +1s
    SCARLET_DLRIUM_DURATION  = JPCATEGORY_DRK + 0x08, --X dur. +1s
    ENDARK_EFFECT            = JPCATEGORY_DRK + 0x09, --O enspell dmg, p.atk, p.acc +1

    --BST
    FAMILIAR_EFFECT          = JPCATEGORY_BST + 0x00, --X all pet attr. +3
    UNLEASH_EFFECT           = JPCATEGORY_BST + 0x02, --X sp.atk dmg +2%
    PET_ACC_BONUS            = JPCATEGORY_BST + 0x01, --X pet p.acc +1
    CHARM_SUCCESS_RATE       = JPCATEGORY_BST + 0x03, --X success rate +1%
    REWARD_EFFECT            = JPCATEGORY_BST + 0x04, --X pet hp recov. +1%
    PET_ATK_SPD_BONUS        = JPCATEGORY_BST + 0x05, --X pet atk spd +1%
    READY_EFFECT             = JPCATEGORY_BST + 0x06, --X pet sp.ability dmg +1%
    SPUR_EFFECT              = JPCATEGORY_BST + 0x07, --X pet p.atk +3
    RUN_WILD_DURATION        = JPCATEGORY_BST + 0x08, --X dur. +2s
    PET_EMNITY_BONUS         = JPCATEGORY_BST + 0x09, --X emnity +1

    --BRD
    SOUL_VOICE_EFFECT        = JPCATEGORY_BRD + 0x00, --O casting time -2%
    CLARION_CALL_EFFECT      = JPCATEGORY_BRD + 0x02, --X effect dur. +2s
    MINNE_EFFECT             = JPCATEGORY_BRD + 0x01, --O p.def +1
    MINUET_EFFECT            = JPCATEGORY_BRD + 0x03, --O p.atk +1
    PIANISSIMO_EFFECT        = JPCATEGORY_BRD + 0x04, --O casting time -2%
    SONG_ACC_BONUS           = JPCATEGORY_BRD + 0x05, --X song acc +1
    TENUTO_EFFECT            = JPCATEGORY_BRD + 0x06, --X song dur. +1s
    LULLABY_DURATION         = JPCATEGORY_BRD + 0x07, --O lullaby dur. +1
    MARCATO_EFFECT           = JPCATEGORY_BRD + 0x08, --X song dur. +1s
    REQUIEM_EFFECT           = JPCATEGORY_BRD + 0x09, --O dot dmg +3

    --RNG
    EAGLE_EYE_SHOT_EFFECT    = JPCATEGORY_RNG + 0x00, --+ dmg +3%
    OVERKILL_EFFECT          = JPCATEGORY_RNG + 0x02, --X emnity -1
    SHARPSHOT_EFFECT         = JPCATEGORY_RNG + 0x01, --+ r.atk +2
    CAMOUFLAGE_EFFECT        = JPCATEGORY_RNG + 0x03, --+ crit. hit rate +1%
    BARRAGE_EFFECT           = JPCATEGORY_RNG + 0x04, --+ r.atk +3
    SHADOWBIND_DURATION      = JPCATEGORY_RNG + 0x05, --+ dur. +1s
    VELOCITY_SHOT_EFFECT     = JPCATEGORY_RNG + 0x06, --+ r.atk +2
    DOUBLE_SHOT_EFFECT       = JPCATEGORY_RNG + 0x07, --+ chance +1%
    DECOY_SHOT_EFFECT        = JPCATEGORY_RNG + 0x08, --X max emnity vol. +15, cum. +5
    UNLIMITED_SHOT_EFFECT    = JPCATEGORY_RNG + 0x09, --+ emnity -2

    --SAM
    MEIKYO_SHISUI_EFFECT     = JPCATEGORY_SAM + 0x00, --O sc dmg +2%
    YAEGASUMI_EFFECT         = JPCATEGORY_SAM + 0x02, --X tp bonus +30
    WARDING_CIRCLE_EFFECT    = JPCATEGORY_SAM + 0x01, --X dmg taken -1
    HASSO_EFFECT             = JPCATEGORY_SAM + 0x03, --O STR +1
    MEDITATE_EFFECT          = JPCATEGORY_SAM + 0x04, --O tp +5 per tick
    SEIGAN_EFFECT            = JPCATEGORY_SAM + 0x05, --O p.def +3
    KONZEN_ITTAI_EFFECT      = JPCATEGORY_SAM + 0x06, --X sc dmg +1%
    HAMANOHA_DURATION        = JPCATEGORY_SAM + 0x07, --X dur. +1s
    HAGAKURE_EFFECT          = JPCATEGORY_SAM + 0x08, --O tp bonus +10
    ZANSHIN_EFFECT           = JPCATEGORY_SAM + 0x09, --X zanshin follow-ups p.atk +2

    --NIN
    MIJIN_GAUKURE_EFFECT     = JPCATEGORY_NIN + 0x00, --+ dmg +3%
    MIKAGE_EFFECT            = JPCATEGORY_NIN + 0x02, --+ p.atk +3
    YONIN_EFFECT             = JPCATEGORY_NIN + 0x01, --+ p.eva +2
    INNIN_EFFECT             = JPCATEGORY_NIN + 0x03, --+ p.acc +1
    NINJITSU_ACC_BONUS       = JPCATEGORY_NIN + 0x04, --+ ninjitsu acc +1
    NINJITSU_CAST_TIME_BONUS = JPCATEGORY_NIN + 0x05, --+ casting time -1%
    FUTAE_EFFECT             = JPCATEGORY_NIN + 0x06, --+ m.dmg +5
    ELEM_NINJITSU_EFFECT     = JPCATEGORY_NIN + 0x07, --+ m.dmg +2
    ISSEKIGAN_EFFECT         = JPCATEGORY_NIN + 0x08, --+ vol. emnity +10
    TACTICAL_PARRY_EFFECT    = JPCATEGORY_NIN + 0x09, --X counter when parry +1%

    --DRG
    SPIRIT_SURGE_EFFECT      = JPCATEGORY_DRG + 0x00, --O Weapon DMG +1
    FLY_HIGH_EFFECT          = JPCATEGORY_DRG + 0x02, --X all jump p.atk +5
    ANCIENT_CIRCLE_EFFECT    = JPCATEGORY_DRG + 0x01, --X dmg taken -1
    JUMP_EFFECT              = JPCATEGORY_DRG + 0x03, --X jump/spirit jump p.atk +3 -- missing spirit jump
    SPIRIT_LINK_EFFECT       = JPCATEGORY_DRG + 0x04, --O hp consumption -1%
    WYVERN_MAX_HP_BONUS      = JPCATEGORY_DRG + 0x05, --O wyvern max hp +10
    DRAGON_BREAKER_DURATION  = JPCATEGORY_DRG + 0x06, --X dur. +1s
    WYVERN_BREATH_EFFECT     = JPCATEGORY_DRG + 0x07, --X breath effect +10
    HIGH_JUMP_EFFECT         = JPCATEGORY_DRG + 0x08, --O high jump/soul jump atk +3
    WYVERN_ATTR_BONUS        = JPCATEGORY_DRG + 0x09, --X player p.atk/p.def +2 when wyvern boosted

    --SMN
    ASTRAL_FLOW_EFFECT       = JPCATEGORY_SMN + 0x00, --O all pet attr. +5
    ASTRAL_CONDUIT_EFFECT    = JPCATEGORY_SMN + 0x02, --X BPR: dmg +1% BPW: duration +1%
    SUMMON_ACC_BONUS         = JPCATEGORY_SMN + 0x01, --O pet p.acc +1
    SUMMON_MAGIC_ACC_BONUS   = JPCATEGORY_SMN + 0x03, --O pet m.acc +1
    ELEMENTAL_SIPHON_EFFECT  = JPCATEGORY_SMN + 0x04, --O mp recov. +3
    SUMMON_PHYS_ATK_BONUS    = JPCATEGORY_SMN + 0x05, --O pet p.atk +2
    MANA_CEDE_EFFECT         = JPCATEGORY_SMN + 0x06, --X pet tp +50
    AVATARS_FAVOR_EFFECT     = JPCATEGORY_SMN + 0x07, --X favor +3s dur. bonus
    SUMMON_MAGIC_DMG_BONUS   = JPCATEGORY_SMN + 0x08, --O pet m.dmg +5
    BLOOD_PACT_DMG_BONUS     = JPCATEGORY_SMN + 0x09, --O BPR/BPW dmg +5

    --BLU
    AZURE_LORE_EFFECT        = JPCATEGORY_BLU + 0x00, --O dmg +1 --needs verification
    UNBRIDLED_WISDOM_EFFECT  = JPCATEGORY_BLU + 0x02, --X conserve mp +3
    BLUE_MAGIC_POINT_BONUS   = JPCATEGORY_BLU + 0x01, --O blue magic points +1
    BURST_AFFINITY_BONUS     = JPCATEGORY_BLU + 0x03, --X dmg +2
    CHAIN_AFFINITY_EFFECT    = JPCATEGORY_BLU + 0x04, --X sc dmg +1%
    BLUE_PHYS_AE_ACC_BONUS   = JPCATEGORY_BLU + 0x05, --X phys. add. effect acc +1
    UNBRIDLED_LRN_EFFECT     = JPCATEGORY_BLU + 0x06, --X dmg +1%
    UNBRIDLED_LRN_EFFECT_II  = JPCATEGORY_BLU + 0x07, --X party enhancing dur. +1%
    EFFLUX_EFFECT            = JPCATEGORY_BLU + 0x08, --X tp bonus +10
    BLU_MAGIC_ACC_BONUS      = JPCATEGORY_BLU + 0x09, --X m.acc +1

    --COR
    WILD_CARD_EFFECT         = JPCATEGORY_COR + 0x00, --O probability of reset +1%
    CUTTING_CARDS_EFFECT     = JPCATEGORY_COR + 0x02, --X recast of party abil. -1%
    PHANTOM_ROLL_DURATION    = JPCATEGORY_COR + 0x01, --O dur. +2s
    BUST_EVASION             = JPCATEGORY_COR + 0x03, --X bust chance -1%
    QUICK_DRAW_EFFECT        = JPCATEGORY_COR + 0x04, --X m.dmg +2
    AMMO_CONSUMPTION         = JPCATEGORY_COR + 0x05, --O no ammo chance +1%
    RANDOM_DEAL_EFFECT       = JPCATEGORY_COR + 0x06, --X 2 abil random deal +2%
    COR_RANGED_ACC_BONUS     = JPCATEGORY_COR + 0x07, --X r.acc +1
    TRIPLE_SHOT_EFFECT       = JPCATEGORY_COR + 0x08, --X triple shot chance +1%
    OPTIMAL_RANGE_BONUS      = JPCATEGORY_COR + 0x09, --X sweet spot dmg +1

    --PUP
    OVERDRIVE_EFFECT         = JPCATEGORY_PUP + 0x00, --O all pet attr. +5
    HEADY_ARTIFICE_EFFECT    = JPCATEGORY_PUP + 0x02, --X increase head effects (see wiki)
    AUTOMATON_HP_MP_BONUS    = JPCATEGORY_PUP + 0x01, --O pet hp+10, mp+5
    ACTIVATE_EFFECT          = JPCATEGORY_PUP + 0x03, --O burden -1
    REPAIR_EFFECT            = JPCATEGORY_PUP + 0x04, --O mp hot based on oil (see wiki)
    DEUS_EX_AUTOMATA_RECAST  = JPCATEGORY_PUP + 0x05, --O recast -1s
    TACTICAL_SWITCH_BONUS    = JPCATEGORY_PUP + 0x06, --X tp +20
    COOLDOWN_EFFECT          = JPCATEGORY_PUP + 0x07, --O burden -1
    DEACTIVATE_EFFECT        = JPCATEGORY_PUP + 0x08, --X hp require. -1%
    PUP_MARTIAL_ARTS_EFFECT  = JPCATEGORY_PUP + 0x09, --X delay -2

    --DNC
    TRANCE_EFFECT            = JPCATEGORY_DNC + 0x00, --O tp +100
    GRAND_PAS_EFFECT         = JPCATEGORY_DNC + 0x02, --X dmg +1
    STEP_DURATION            = JPCATEGORY_DNC + 0x01, --X dur. +1s
    SAMBA_DURATION           = JPCATEGORY_DNC + 0x03, --X dur. +2s
    WALTZ_POTENCY_BONUS      = JPCATEGORY_DNC + 0x04, --X waltz potency +2 (not %)
    JIG_DURATION             = JPCATEGORY_DNC + 0x05, --X dur. +1s
    FLOURISH_I_EFFECT        = JPCATEGORY_DNC + 0x06, --X effect bonuses (see wiki)
    FLOURISH_II_EFFECT       = JPCATEGORY_DNC + 0x07, --X effect bonuses (see wiki)
    FLOURISH_III_EFFECT      = JPCATEGORY_DNC + 0x08, --X CHR bonus +1%
    CONTRADANCE_EFFECT       = JPCATEGORY_DNC + 0x09, --X waltz tp -3%

    --SCH
    TABULA_RASA_EFFECT       = JPCATEGORY_SCH + 0x00, --O mp recov. +2%
    CAPER_EMMISSARIUS_EFFECT = JPCATEGORY_SCH + 0x02, --X hp recov. +2%
    LIGHT_ARTS_EFFECT        = JPCATEGORY_SCH + 0x01, --O dur. +3s
    DARK_ARTS_EFFECT         = JPCATEGORY_SCH + 0x03, --O dur. +3s
    STRATEGEM_EFFECT_I       = JPCATEGORY_SCH + 0x04, --O m.acc +1
    STRATEGEM_EFFECT_II      = JPCATEGORY_SCH + 0x05, --O cast time -1%
    STRATEGEM_EFFECT_III     = JPCATEGORY_SCH + 0x06, --O m.dmg +2
    STRATEGEM_EFFECT_IV      = JPCATEGORY_SCH + 0x07, --O recast -2%
    MODUS_VERITAS_EFFECT     = JPCATEGORY_SCH + 0x08, --O dot +3
    SUBLIMATION_EFFECT       = JPCATEGORY_SCH + 0x09, --O sublimation mp +3%

    --GEO
    BOLSTER_EFFECT           = JPCATEGORY_GEO + 0x00, --X luopan hp +3% perp. -1mp
    WIDENED_COMPASS_EFFECT   = JPCATEGORY_GEO + 0x02, --X cast time -3%
    LIFE_CYCLE_EFFECT        = JPCATEGORY_GEO + 0x01, --X luopan hp recov. +1%
    BLAZE_OF_GLORY_EFFECT    = JPCATEGORY_GEO + 0x03, --X luopan init. hp +1%
    GEO_MAGIC_ATK_BONUS      = JPCATEGORY_GEO + 0x04, --+ m.att bonus +1
    GEO_MAGIC_ACC_BONUS      = JPCATEGORY_GEO + 0x05, --X m.acc +1
    DEMATERIALIZE_DURATION   = JPCATEGORY_GEO + 0x06, --X dur. +1s
    THEURGIC_FOCUS_EFFECT    = JPCATEGORY_GEO + 0x07, --X m.dmg +3
    CONCENTRIC_PULSE_EFFECT  = JPCATEGORY_GEO + 0x08, --X dmg +1%
    INDI_SPELL_DURATION      = JPCATEGORY_GEO + 0x09, --X indi dur. +2s

    --RUN
    ELEMENTAL_SFORZO_EFFECT  = JPCATEGORY_RUN + 0x00, --X dmg absorb +2%
    ODYLLIC_SUBTER_EFFECT    = JPCATEGORY_RUN + 0x02, --X enemy m.att bonus -2
    RUNE_ENCHANTMENT_EFFECT  = JPCATEGORY_RUN + 0x01, --X rune resist +1
    VALLATION_DURATION       = JPCATEGORY_RUN + 0x03, --X dur. +1s
    SWORDPLAY_EFFECT         = JPCATEGORY_RUN + 0x04, --X max p.acc/p.eva +2
    SWIPE_EFFECT             = JPCATEGORY_RUN + 0x05, --X swipe/lunge dmg (skill) +1%
    EMBOLDEN_EFFECT          = JPCATEGORY_RUN + 0x06, --X enhanc. mag effect +1
    VIVACIOUS_PULSE_EFFECT   = JPCATEGORY_RUN + 0x07, --X viv. pulse => hp +1%
    ONE_FOR_ALL_DURATION     = JPCATEGORY_RUN + 0x08, --X dur. +1s
    GAMBIT_DURATION          = JPCATEGORY_RUN + 0x09, --X dur +1s
}
