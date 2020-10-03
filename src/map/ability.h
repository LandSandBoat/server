/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#ifndef _CABILITY_H
#define _CABILITY_H

#include "../common/cbasetypes.h"
#include "../common/mmo.h"
#include "packets/action.h"

#include "entities/battleentity.h"

enum ADDTYPE
{
    ADDTYPE_NORMAL      = 0,
    ADDTYPE_MERIT       = 1,
    ADDTYPE_ASTRAL_FLOW = 2,
    ADDTYPE_MAIN_ONLY   = 4,
    ADDTYPE_LEARNED     = 8,
    ADDTYPE_LIGHT_ARTS  = 16,
    ADDTYPE_DARK_ARTS   = 32,
    ADDTYPE_JUGPET      = 64,
    ADDTYPE_CHARMPET    = 128,
    ADDTYPE_AVATAR      = 256,
    ADDTYPE_AUTOMATON   = 512,
};

enum ABILITY
{
    ABILITY_MIGHTY_STRIKES     = 16,
    ABILITY_HUNDRED_FISTS      = 17,
    ABILITY_BENEDICTION        = 18,
    ABILITY_MANAFONT           = 19,
    ABILITY_CHAINSPELL         = 20,
    ABILITY_PERFECT_DODGE      = 21,
    ABILITY_INVINCIBLE         = 22,
    ABILITY_BLOOD_WEAPON       = 23,
    ABILITY_FAMILIAR           = 24,
    ABILITY_SOUL_VOICE         = 25,
    ABILITY_EAGLE_EYE_SHOT     = 26,
    ABILITY_MEIKYO_SHISUI      = 27,
    ABILITY_MIJIN_GAKURE       = 28,
    ABILITY_SPIRIT_SURGE       = 29,
    ABILITY_ASTRAL_FLOW        = 30,
    ABILITY_BERSERK            = 31,
    ABILITY_WARCRY             = 32,
    ABILITY_DEFENDER           = 33,
    ABILITY_AGGRESSOR          = 34,
    ABILITY_PROVOKE            = 35,
    ABILITY_FOCUS              = 36,
    ABILITY_DODGE              = 37,
    ABILITY_CHAKRA             = 38,
    ABILITY_BOOST              = 39,
    ABILITY_COUNTERSTANCE      = 40,
    ABILITY_STEAL              = 41,
    ABILITY_FLEE               = 42,
    ABILITY_HIDE               = 43,
    ABILITY_SNEAK_ATTACK       = 44,
    ABILITY_MUG                = 45,
    ABILITY_SHIELD_BASH        = 46,
    ABILITY_HOLY_CIRCLE        = 47,
    ABILITY_SENTINEL           = 48,
    ABILITY_SOULEATER          = 49,
    ABILITY_ARCANE_CIRCLE      = 50,
    ABILITY_LAST_RESORT        = 51,
    ABILITY_CHARM              = 52,
    ABILITY_GAUGE              = 53,
    ABILITY_TAME               = 54,
    ABILITY_PET_COMMANDS       = 55,
    ABILITY_SCAVENGE           = 56,
    ABILITY_SHADOWBIND         = 57,
    ABILITY_CAMOUFLAGE         = 58,
    ABILITY_SHARPSHOT          = 59,
    ABILITY_BARRAGE            = 60,
    ABILITY_CALL_WYVERN        = 61,
    ABILITY_THIRD_EYE          = 62,
    ABILITY_MEDITATE           = 63,
    ABILITY_WARDING_CIRCLE     = 64,
    ABILITY_ANCIENT_CIRCLE     = 65,
    ABILITY_JUMP               = 66,
    ABILITY_HIGH_JUMP          = 67,
    ABILITY_SUPER_JUMP         = 68,
    ABILITY_FIGHT              = 69,
    ABILITY_HEEL               = 70,
    ABILITY_LEAVE              = 71,
    ABILITY_SIC                = 72,
    ABILITY_STAY               = 73,
    ABILITY_DIVINE_SEAL        = 74,
    ABILITY_ELEMENTAL_SEAL     = 75,
    ABILITY_TRICK_ATTACK       = 76,
    ABILITY_WEAPON_BASH        = 77,
    ABILITY_REWARD             = 78,
    ABILITY_COVER              = 79,
    ABILITY_SPIRIT_LINK        = 80,
    ABILITY_CHI_BLAST          = 82,
    ABILITY_CONVERT            = 83,
    ABILITY_ACCOMPLICE         = 84,
    ABILITY_CALL_BEAST         = 85,
    ABILITY_UNLIMITED_SHOT     = 86,
    ABILITY_DISMISS            = 87,
    ABILITY_ASSAULT            = 88,
    ABILITY_RETREAT            = 89,
    ABILITY_RELEASE            = 90,
    ABILITY_BLOOD_PACT_RAGE    = 91,
    ABILITY_RAMPART            = 92,
    ABILITY_AZURE_LORE         = 93,
    ABILITY_CHAIN_AFFINITY     = 94,
    ABILITY_BURST_AFFINITY     = 95,
    ABILITY_WILD_CARD          = 96,
    ABILITY_PHANTOM_ROLL       = 97,
    ABILITY_FIGHTERS_ROLL      = 98,
    ABILITY_MONKS_ROLL         = 99,
    ABILITY_HEALERS_ROLL       = 100,
    ABILITY_WIZARDS_ROLL       = 101,
    ABILITY_WARLOCKS_ROLL      = 102,
    ABILITY_ROGUES_ROLL        = 103,
    ABILITY_GALLANTS_ROLL      = 104,
    ABILITY_CHAOS_ROLL         = 105,
    ABILITY_BEAST_ROLL         = 106,
    ABILITY_CHORAL_ROLL        = 107,
    ABILITY_HUNTERS_ROLL       = 108,
    ABILITY_SAMURAI_ROLL       = 109,
    ABILITY_NINJA_ROLL         = 110,
    ABILITY_DRACHEN_ROLL       = 111,
    ABILITY_EVOKERS_ROLL       = 112,
    ABILITY_MAGUSS_ROLL        = 113,
    ABILITY_CORSAIRS_ROLL      = 114,
    ABILITY_PUPPET_ROLL        = 115,
    ABILITY_DANCERS_ROLL       = 116,
    ABILITY_SCHOLARS_ROLL      = 117,
    ABILITY_BOLTERS_ROLL       = 118,
    ABILITY_CASTERS_ROLL       = 119,
    ABILITY_COURSERS_ROLL      = 120,
    ABILITY_BLITZERS_ROLL      = 121,
    ABILITY_TACTICIANS_ROLL    = 122,
    ABILITY_DOUBLE_UP          = 123,
    ABILITY_QUICK_DRAW         = 124,
    ABILITY_FIRE_SHOT          = 125,
    ABILITY_ICE_SHOT           = 126,
    ABILITY_WIND_SHOT          = 127,
    ABILITY_EARTH_SHOT         = 128,
    ABILITY_THUNDER_SHOT       = 129,
    ABILITY_WATER_SHOT         = 130,
    ABILITY_LIGHT_SHOT         = 131,
    ABILITY_DARK_SHOT          = 132,
    ABILITY_RANDOM_DEAL        = 133,
    ABILITY_OVERDRIVE          = 135,
    ABILITY_ACTIVATE           = 136,
    ABILITY_REPAIR             = 137,
    ABILITY_DEPLOY             = 138,
    ABILITY_DEACTIVATE         = 139,
    ABILITY_RETRIEVE           = 140,
    ABILITY_FIRE_MANEUVER      = 141,
    ABILITY_ICE_MANEUVER       = 142,
    ABILITY_WIND_MANEUVER      = 143,
    ABILITY_EARTH_MANEUVER     = 144,
    ABILITY_THUNDER_MANEUVER   = 145,
    ABILITY_WATER_MANEUVER     = 146,
    ABILITY_LIGHT_MANEUVER     = 147,
    ABILITY_DARK_MANEUVER      = 148,
    ABILITY_WARRIORS_CHARGE    = 149,
    ABILITY_TOMAHAWK           = 150,
    ABILITY_MANTRA             = 151,
    ABILITY_FORMLESS_STRIKES   = 152,
    ABILITY_MARTYR             = 153,
    ABILITY_DEVOTION           = 154,
    ABILITY_ASSASSINS_CHARGE   = 155,
    ABILITY_FEINT              = 156,
    ABILITY_FEALTY             = 157,
    ABILITY_CHIVALRY           = 158,
    ABILITY_DARK_SEAL          = 159,
    ABILITY_DIABOLIC_EYE       = 160,
    ABILITY_FERAL_HOWL         = 161,
    ABILITY_KILLER_INSTINCT    = 162,
    ABILITY_NIGHTINGALE        = 163,
    ABILITY_TROUBADOUR         = 164,
    ABILITY_STEALTH_SHOT       = 165,
    ABILITY_FLASHY_SHOT        = 166,
    ABILITY_SHIKIKOYO          = 167,
    ABILITY_BLADE_BASH         = 168,
    ABILITY_DEEP_BREATHING     = 169,
    ABILITY_ANGON              = 170,
    ABILITY_SANGE              = 171,
    ABILITY_BLOOD_PACT_WARD    = 172,
    ABILITY_HASSO              = 173,
    ABILITY_SEIGAN             = 174,
    ABILITY_CONVERGENCE        = 175,
    ABILITY_DIFFUSION          = 176,
    ABILITY_SNAKE_EYE          = 177,
    ABILITY_FOLD               = 178,
    ABILITY_ROLE_REVERSAL      = 179,
    ABILITY_VENTRILOQUY        = 180,
    ABILITY_TRANCE             = 181,
    ABILITY_SAMBAS             = 182,
    ABILITY_WALTZES            = 183,
    ABILITY_DRAIN_SAMBA        = 184,
    ABILITY_DRAIN_SAMBA_II     = 185,
    ABILITY_DRAIN_SAMBA_III    = 186,
    ABILITY_ASPIR_SAMBA        = 187,
    ABILITY_ASPIR_SAMBA_II     = 188,
    ABILITY_HASTE_SAMBA        = 189,
    ABILITY_CURING_WALTZ       = 190,
    ABILITY_CURING_WALTZ_II    = 191,
    ABILITY_CURING_WALTZ_III   = 192,
    ABILITY_CURING_WALTZ_IV    = 193,
    ABILITY_HEALING_WALTZ      = 194,
    ABILITY_DIVINE_WALTZ       = 195,
    ABILITY_SPECTRAL_JIG       = 196,
    ABILITY_CHOCOBO_JIG        = 197,
    ABILITY_JIGS               = 198,
    ABILITY_STEPS              = 199,
    ABILITY_FLOURISHES_I       = 200,
    ABILITY_QUICKSTEP          = 201,
    ABILITY_BOX_STEP           = 202,
    ABILITY_STUTTER_STEP       = 203,
    ABILITY_ANIMATED_FLOURISH  = 204,
    ABILITY_DESPERATE_FLOURISH = 205,
    ABILITY_REVERSE_FLOURISH   = 206,
    ABILITY_VIOLENT_FLOURISH   = 207,
    ABILITY_BUILDING_FLOURISH  = 208,
    ABILITY_WILD_FLOURISH      = 209,
    ABILITY_TABULA_RASA        = 210,
    ABILITY_LIGHT_ARTS         = 211,
    ABILITY_DARK_ARTS          = 212,
    ABILITY_FLOURISHES_II      = 213,
    ABILITY_MODUS_VERITAS      = 214,
    ABILITY_PENURY             = 215,
    ABILITY_CELERITY           = 216,
    ABILITY_RAPTURE            = 217,
    ABILITY_ACCESSION          = 218,
    ABILITY_PARSIMONY          = 219,
    ABILITY_ALACRITY           = 220,
    ABILITY_EBULLIENCE         = 221,
    ABILITY_MANIFESTATION      = 222,
    ABILITY_STRATAGEMS         = 223,
    ABILITY_VELOCITY_SHOT      = 224,
    ABILITY_SNARL              = 225,
    ABILITY_RETALIATION        = 226,
    ABILITY_FOOTWORK           = 227,
    ABILITY_DESPOIL            = 228,
    ABILITY_PIANISSIMO         = 229,
    ABILITY_SEKKANOKI          = 230,
    ABILITY_ELEMENTAL_SIPHON   = 232,
    ABILITY_SUBLIMATION        = 233,
    ABILITY_ADDENDUM_WHITE     = 234,
    ABILITY_ADDENDUM_BLACK     = 235,
    ABILITY_COLLABORATOR       = 236,
    ABILITY_SABER_DANCE        = 237,
    ABILITY_FAN_DANCE          = 238,
    ABILITY_NO_FOOT_RISE       = 239,
    ABILITY_ALTRUISM           = 240,
    ABILITY_FOCALIZATION       = 241,
    ABILITY_TRANQUILITY        = 242,
    ABILITY_EQUANIMITY         = 243,
    ABILITY_ENLIGHTENMENT      = 244,
    ABILITY_AFFLATUS_SOLACE    = 245,
    ABILITY_AFFLATUS_MISERY    = 246,
    ABILITY_COMPOSURE          = 247,
    ABILITY_YONIN              = 248,
    ABILITY_INNIN              = 249,
    ABILITY_AVATARS_FAVOR      = 250,
    ABILITY_READY              = 251,
    ABILITY_RESTRAINT          = 252,
    ABILITY_PERFECT_COUNTER    = 253,
    ABILITY_MANA_WALL          = 254,
    ABILITY_DIVINE_EMBLEM      = 255,
    ABILITY_NETHER_VOID        = 256,
    ABILITY_DOUBLE_SHOT        = 257,
    ABILITY_SENGIKORI          = 258,
    ABILITY_FUTAE              = 259,
    ABILITY_SPIRIT_JUMP        = 260,
    ABILITY_PRESTO             = 261,
    ABILITY_DIVINE_WALTZ_II    = 262,
    ABILITY_FLOURISHES_III     = 263,
    ABILITY_CLIMACTIC_FLOURISH = 264,
    ABILITY_LIBRA              = 265,
    ABILITY_TACTICAL_SWITCH    = 266,
    ABILITY_BLOOD_RAGE         = 267,
    ABILITY_IMPETUS            = 269,
    ABILITY_DIVINE_CARESS      = 270,
    ABILITY_SANCROSANCTITY     = 271,
    ABILITY_ENMITY_DOUSE       = 272,
    ABILITY_MANAWELL           = 273,
    ABILITY_SABOTEUR           = 274,
    ABILITY_SPONTANEITY        = 275,
    ABILITY_CONSPIRATOR        = 276,
    ABILITY_SEPULCHER          = 277,
    ABILITY_PALISADE           = 278,
    ABILITY_ARCANE_CREST       = 279,
    ABILITY_SCARLET_DELIRIUM   = 280,
    ABILITY_SPUR               = 281,
    ABILITY_RUN_WILD           = 282,
    ABILITY_TENUTO             = 283,
    ABILITY_MARCATO            = 284,
    ABILITY_BOUNTY_SHOT        = 285,
    ABILITY_DECOY_SHOT         = 286,
    ABILITY_HAMANOHA           = 287,
    ABILITY_HAGAKURE           = 288,
    ABILITY_ISSEKIGAN          = 291,
    ABILITY_DRAGON_BREAKER     = 292,
    ABILITY_SOUL_JUMP          = 293,
    ABILITY_STEADY_WING        = 295,
    ABILITY_MANA_CEDE          = 296,
    ABILITY_EFFLUX             = 297,
    ABILITY_UNBRIDLED_LEARNING = 298,
    ABILITY_TRIPLE_SHOT        = 301,
    ABILITY_ALLIES_ROLL        = 302,
    ABILITY_MISERS_ROLL        = 303,
    ABILITY_COMPANIONS_ROLL    = 304,
    ABILITY_AVENGERS_ROLL      = 305,
    ABILITY_COOLDOWN           = 309,
    ABILITY_DEUX_EX_AUTOMATA   = 310,
    ABILITY_CURING_WALTZ_V     = 311,
    ABILITY_FEATHER_STEP       = 312,
    ABILITY_STRIKING_FLOURISH  = 313,
    ABILITY_TERNARY_FLOURISH   = 314,
    ABILITY_PERPETUANCE        = 316,
    ABILITY_IMMANENCE          = 317,
    ABILITY_SMITING_BREATH     = 318,
    ABILITY_RESTORING_BREATH   = 319,
    ABILITY_KONZEN_ITTAI       = 320,
    ABILITY_BULLY              = 321,
    ABILITY_MAINTENANCE        = 322,
    ABILITY_BRAZEN_RUSH        = 323,
    ABILITY_INNER_STRENGTH     = 324,
    ABILITY_ASYLUM             = 325,
    ABILITY_SUBTLE_SORCERY     = 326,
    ABILITY_STYMIE             = 327,
    ABILITY_LARCENY            = 328,
    ABILITY_INTERVENE          = 329,
    ABILITY_SOUL_ENSLAVEMENT   = 330,
    ABILITY_UNLEASH            = 331,
    ABILITY_CLARION_CALL       = 332,
    ABILITY_OVERKILL           = 333,
    ABILITY_YAEGASUMI          = 334,
    ABILITY_MIKAGE             = 335,
    ABILITY_FLY_HIGH           = 336,
    ABILITY_ASTRAL_CONDUIT     = 337,
    ABILITY_UNBRIDLED_WISDOM   = 338,
    ABILITY_CUTTING_CARDS      = 339,
    ABILITY_HEADY_ARTIFICE     = 340,
    ABILITY_GRAND_PAS          = 341,
    ABILITY_CAPER_EMISSARIUS   = 342,
    ABILITY_BOLSTER            = 343,
    ABILITY_SWIPE              = 344,
    ABILITY_FULL_CIRCLE        = 345,
    ABILITY_LASTING_EMANATION  = 346,
    ABILITY_ECLIPTIC_ATTRITION = 347,
    ABILITY_COLLIMATED_FERVOR  = 348,
    ABILITY_LIFE_CYCLE         = 349,
    ABILITY_BLAZE_OF_GLORY     = 350,
    ABILITY_DEMATERIALIZE      = 351,
    ABILITY_THEURGIC_FOCUS     = 352,
    ABILITY_CONCENTRIC_PULSE   = 353,
    ABILITY_MENDING_HALATION   = 354,
    ABILITY_RADIAL_ARCANA      = 355,
    ABILITY_ELEMENTAL_SFORZO   = 356,
    ABILITY_RUNE_ENCHANTMENT   = 357,
    ABILITY_IGNIS              = 358,
    ABILITY_GELUS              = 359,
    ABILITY_FLABRA             = 360,
    ABILITY_TELLUS             = 361,
    ABILITY_SULPOR             = 362,
    ABILITY_UNDA               = 363,
    ABILITY_LUX                = 364,
    ABILITY_TENEBRAE           = 365,
    ABILITY_VALLATION          = 366,
    ABILITY_SWORDPLAY          = 367,
    ABILITY_LUNGE              = 368,
    ABILITY_PFLUG              = 369,
    ABILITY_EMBOLDEN           = 370,
    ABILITY_VALIANCE           = 371,
    ABILITY_GAMBIT             = 372,
    ABILITY_LIEMENT            = 373,
    ABILITY_ONE_FOR_ALL        = 374,
    ABILITY_RAYKE              = 375,
    ABILITY_BATTUTA            = 376,
    ABILITY_WIDENED_COMPASS    = 377,
    ABILITY_ODYLLIC_SUBTERFUGE = 378,
    ABILITY_WARD               = 379,
    ABILITY_EFFUSION           = 380,
    ABILITY_CHOCOBO_JIG_II     = 381,
    ABILITY_RELINQUISH         = 382,
    ABILITY_VIVACIOUS_PULSE    = 383,
    ABILITY_CONTRADANCE        = 384,
    ABILITY_APOGEE             = 385,
    ABILITY_ENTRUST            = 386,
    ABILITY_BESTIAL_LOYALTY    = 387,
    ABILITY_CASCADE            = 388,
    ABILITY_CONSUME_MANA       = 389,
    ABILITY_NATURALISTS_ROLL   = 390,
    ABILITY_RUNEISTS_ROLL      = 391,
    ABILITY_CROOKED_CARDS      = 392,
    ABILITY_SPIRIT_BOND        = 393,
    ABILITY_MAJESTY            = 394,

    ABILITY_HEALING_RUBY       = 512,
    ABILITY_POISON_NAILS       = 513,
    ABILITY_SHINING_RUBY       = 514,
    ABILITY_GLITTERING_RUBY    = 515,
    ABILITY_METEORITE          = 516,
    ABILITY_HEALING_RUBY_II    = 517,
    ABILITY_SEARING_LIGHT      = 518,
    ABILITY_HOLY_MIST          = 519,
    ABILITY_SOOTHING_RUBY      = 520,
    ABILITY_REGAL_SCRATCH      = 521,
    ABILITY_MEWING_LULLABY     = 522,
    ABILITY_EARIE_EYE          = 523,
    ABILITY_LEVEL_QUESTION_HOLY= 524,
    ABILITY_RAISE_II           = 525,
    ABILITY_RERAISE_II         = 526,
    ABILITY_ALTANAS_FAVOR      = 527,
    ABILITY_MOONLIT_CHARGE     = 528,
    ABILITY_CRESCENT_FANG      = 529,
    ABILITY_LUNAR_CRY          = 530,
    ABILITY_LUNAR_ROAR         = 531,
    ABILITY_ECLIPTIC_GROWL     = 532,
    ABILITY_ECLIPTIC_HOWL      = 533,
    ABILITY_ECLIPSE_BITE       = 534,

    ABILITY_HOWLING_MOON       = 536,
    ABILITY_LUNAR_BAY          = 537,
    ABILITY_HEAVENWARD_HOWL    = 538,
    ABILITY_IMPACT             = 539,

    ABILITY_PUNCH              = 544,
    ABILITY_FIRE_II            = 545,
    ABILITY_BURNING_STRIKE     = 546,
    ABILITY_DOUBLE_PUNCH       = 547,
    ABILITY_CRIMSON_HOWL       = 548,
    ABILITY_FIRE_IV            = 549,
    ABILITY_FLAMING_CRUSH      = 550,
    ABILITY_METEOR_STRIKE      = 551,
    ABILITY_INFERNO            = 552,
    ABILITY_INFERNO_HOWL       = 553,
    ABILITY_CONFLAG_STRIKE     = 554,

    ABILITY_ROCK_THROW         = 560,
    ABILITY_STONE_II           = 561,
    ABILITY_ROCK_BUSTER        = 562,
    ABILITY_MEGALITH_THROW     = 563,
    ABILITY_EARTHEN_WARD       = 564,
    ABILITY_STONE_IV           = 565,
    ABILITY_MOUNTAIN_BUSTER    = 566,
    ABILITY_GEOCRUSH           = 567,
    ABILITY_EARTHEN_FURY       = 568,
    ABILITY_EARTHEN_ARMOR      = 569,
    ABILITY_CRAG_THROW         = 570,

    ABILITY_BARRACUDA_DIVE     = 576,
    ABILITY_WATER_II           = 577,
    ABILITY_TAIL_WHIP          = 578,
    ABILITY_SPRING_WATER       = 579,
    ABILITY_SLOWGA             = 580,
    ABILITY_WATER_IV           = 581,
    ABILITY_SPINNING_DIVE      = 582,
    ABILITY_GRAND_FALL         = 583,
    ABILITY_TIDAL_WAVE         = 584,
    ABILITY_TIDAL_ROAR         = 585,
    ABILITY_SOOTHING_CURRENT   = 586,

    ABILITY_CLAW               = 592,
    ABILITY_AERO_II            = 593,
    ABILITY_WHISPERING_WIND    = 594,
    ABILITY_HASTEGA            = 595,
    ABILITY_AERIAL_ARMOR       = 596,
    ABILITY_AERO_IV            = 597,
    ABILITY_PREDATOR_CLAWS     = 598,
    ABILITY_WIND_BLADE         = 599,
    ABILITY_AERIAL_BLAST       = 600,
    ABILITY_FLEET_WIND         = 601,
    ABILITY_HASTEGA_II         = 602,

    ABILITY_AXE_KICK           = 608,
    ABILITY_BLIZZARD_II        = 609,
    ABILITY_FROST_ARMOR        = 610,
    ABILITY_SLEEPGA            = 611,
    ABILITY_DOUBLE_SLAP        = 612,
    ABILITY_BLIZZARD_IV        = 613,
    ABILITY_RUSH               = 614,
    ABILITY_HEAVENLY_STRIKE    = 615,
    ABILITY_DIAMOND_DUST       = 616,
    ABILITY_DIAMOND_STORM      = 617,
    ABILITY_CRYSTAL_BLESSING   = 618,

    ABILITY_SHOCK_STRIKE       = 624,
    ABILITY_THUNDER_II         = 625,
    ABILITY_ROLLING_THUNDER    = 626,
    ABILITY_THUNDERSPARK       = 627,
    ABILITY_LIGHTNING_ARMOR    = 628,
    ABILITY_THUNDER_IV         = 629,
    ABILITY_CHAOTIC_STRIKE     = 630,
    ABILITY_THUNDERSTORM       = 631,
    ABILITY_JUDGMENT_BOLT      = 632,
    ABILITY_SHOCK_SQUALL       = 633,
    ABILITY_VOLT_STRIKE        = 634,

    ABILITY_HEALING_BREATH_IV  = 639,
    ABILITY_HEALING_BREATH     = 640,
    ABILITY_HEALING_BREATH_II  = 641,
    ABILITY_HEALING_BREATH_III = 642,
    ABILITY_REMOVE_POISON      = 643,
    ABILITY_REMOVE_BLINDNESS   = 644,
    ABILITY_REMOVE_PARALYSIS   = 645,
    ABILITY_FLAME_BREATH       = 646,
    ABILITY_FROST_BREATH       = 647,
    ABILITY_GUST_BREATH        = 648,
    ABILITY_SAND_BREATH        = 649,
    ABILITY_LIGHTNING_BREATH   = 650,
    ABILITY_HYDRO_BREATH       = 651,
    ABILITY_SUPER_CLIMB        = 652,
    ABILITY_REMOVE_CURSE       = 653,
    ABILITY_REMOVE_DISEASE     = 654,
    ABILITY_CAMISADO           = 656,
    ABILITY_SOMNOLENCE         = 657,
    ABILITY_NIGHTMARE          = 658,
    ABILITY_ULTIMATE_TERROR    = 659,
    ABILITY_NOCTOSHIELD        = 660,
    ABILITY_DREAM_SHROUD       = 661,
    ABILITY_NETHER_BLAST       = 662,
    ABILITY_CACODEMONIA        = 663,
    ABILITY_RUINOUS_OMEN       = 664,
    ABILITY_NIGHT_TERROR       = 665,
    ABILITY_PAVOR_NOCTURNUS    = 666,
    ABILITY_BLINDSIDE          = 667,
    ABILITY_DECONSTRUCTION     = 668,
    ABILITY_CHRONOSHIFT        = 669,
    ABILITY_ZANTETSUKEN        = 670,
    ABILITY_PERFECT_DEFENSE    = 671,
    ABILITY_FOOT_KICK          = 672,
    ABILITY_DUST_CLOUD         = 673,
    ABILITY_WHIRL_CLAWS        = 674,
    ABILITY_HEAD_BUTT          = 675,
    ABILITY_DREAM_FLOWER       = 676,
    ABILITY_WILD_OATS          = 677,
    ABILITY_LEAF_DAGGER        = 678,
    ABILITY_SCREAM             = 679,
    ABILITY_ROAR               = 680,
    ABILITY_RAZOR_FANG         = 681,
    ABILITY_CLAW_CYCLONE       = 682,
    ABILITY_TAIL_BLOW          = 683,
    ABILITY_FIREBALL           = 684,
    ABILITY_BLOCKHEAD          = 685,
    ABILITY_BRAINCRUSH         = 686,
    ABILITY_INFRASONICS        = 687,
    ABILITY_SECRETION          = 688,
    ABILITY_LAMB_CHOP          = 689,
    ABILITY_RAGE               = 690,
    ABILITY_SHEEP_CHARGE       = 691,
    ABILITY_SHEEP_SONG         = 692,
    ABILITY_BUBBLE_SHOWER      = 693,
    ABILITY_BUBBLE_CURTAIN     = 694,
    ABILITY_BIG_SCISSORS       = 695,
    ABILITY_SCISSOR_GAURD      = 696,
    ABILITY_METALLIC_BODY      = 697,
    ABILITY_NEEDLESHOT         = 698,
    ABILITY_QUESTION_NEEDLES   = 699,
    ABILITY_FROGKICK           = 700,
    ABILITY_SPORE              = 701,
    ABILITY_QUEASYSHROOM       = 702,
    ABILITY_NUMBSHROOM         = 703,
    ABILITY_SHAKESHROOM        = 704,
    ABILITY_SILENCE_GAS        = 705,
    ABILITY_DARK_SPORE         = 706,
    ABILITY_POWER_ATTACK       = 707,
    ABILITY_HI_FREQ_FIELD      = 708,
    ABILITY_RHINO_ATTACK       = 709,
    ABILITY_RHINO_GAURD        = 710,
    ABILITY_SPOIL              = 711,
    ABILITY_CURSED_SPHERE      = 712,
    ABILITY_VENOM              = 713,
    ABILITY_SANDBLAST          = 714,
    ABILITY_SANDPIT            = 715,
    ABILITY_VENOM_SPRAY        = 716,
    ABILITY_MANDIBULAR_BITE    = 717,
    ABILITY_SOPORIFIC          = 718,
    ABILITY_GLOEOSUCCUS        = 719,
    ABILITY_PALSY_POLLEN       = 720,
    ABILITY_GEIST_WALL         = 721,
    ABILITY_NUMBING_NOISE      = 722,
    ABILITY_NIMBLE_SNAP        = 723,
    ABILITY_CYCLOTAIL          = 724,
    ABILITY_TOXIC_SPIT         = 725,
    ABILITY_DOUBLE_CLAW        = 726,
    ABILITY_GRAPPLE            = 727,
    ABILITY_SPINNING_TOP       = 728,
    ABILITY_FILAMENTED_HOLD    = 729,
    ABILITY_CHAOTIC_EYE        = 730,
    ABILITY_BLASTER            = 731,
    ABILITY_SUCTION            = 732,
    ABILITY_DRAINKISS          = 733,
    ABILITY_SNOW_CLOUD         = 734,
    ABILITY_WILD_CARROT        = 735,
    ABILITY_SUDDEN_LUNGE       = 736,
    ABILITY_SPIRAL_SPIN        = 737,
    ABILITY_NOISOME_POWDER     = 738,

    ABILITY_ACID_MIST          = 740,
    ABILITY_TP_DRAINKISS       = 741,

    ABILITY_SCYTHE_TAIL        = 743,
    ABILITY_RIPPER_FANG        = 744,
    ABILITY_CHOMP_RUSH         = 745,
    ABILITY_CHARGED_WHISKER    = 746,
    ABILITY_PURULENT_OOZE      = 747,
    ABILITY_CORROSIVE_OOZE     = 748,
    ABILITY_BACK_HEEL          = 749,
    ABILITY_JETTATURA          = 750,
    ABILITY_CHOKE_BREATH       = 751,
    ABILITY_FANTOD             = 752,
    ABILITY_TORTOISE_STOMP     = 753,
    ABILITY_HARDEN_SHELL       = 754,
    ABILITY_AQUA_BREATH        = 755,
    ABILITY_WING_SLAP          = 756,
    ABILITY_BEAK_LUNGE         = 757,
    ABILITY_INTIMIDATE         = 758,
    ABILITY_RECOIL_DIVE        = 759,
    ABILITY_WATER_WALL         = 760,
    ABILITY_SENSILLA_BLADES    = 761,
    ABILITY_TEGMINA_BUFFET     = 762,
    ABILITY_MOLTING_PLUMAGE    = 763,
    ABILITY_SWOOPING_FRENZY    = 764,
    ABILITY_SWEEPING_GOUGE     = 765,
    ABILITY_ZEALOUS_SNORT      = 766,
    ABILITY_PENTAPECK          = 767,
    ABILITY_TICKLING_TENDRILS  = 768,
    ABILITY_STINK_BOMB         = 769,
    ABILITY_NECTAROUS_DELUGE   = 770,
    ABILITY_NEPENTHIC_PLUNGE   = 771,
    ABILITY_SOMERSAULT         = 772,
    ABILITY_PACIFYING_RUBY     = 773,
    ABILITY_FOUL_WATERS        = 774,
    ABILITY_PESTILENT_PLUME    = 775,
    ABILITY_PECKING_FLURRY     = 776,
    ABILITY_SICKLE_SLASH       = 777,
    ABILITY_ACID_SPRAY         = 778,
    ABILITY_SPIDER_WEB         = 779,
    ABILITY_REGAL_GASH         = 780,
    ABILITY_INFECTED_LEECH     = 781,
    ABILITY_GLOOM_SPRAY        = 782,

    ABILITY_DISEMBOWEL         = 786,
    ABILITY_EXTIRPATING_SALVO  = 787,

    ABILITY_CLARSACH_CALL      = 960,
    ABILITY_WELT               = 961,
    ABILITY_KATABATIC_BLADES   = 962,
    ABILITY_LUNATIC_VOICE      = 963,
    ABILITY_ROUNDHOUSE         = 964,
    ABILITY_CHINOOK            = 965,
    ABILITY_BITTER_ELEGY       = 966,
    ABILITY_SONIC_BUFFET       = 967,
    ABILITY_TORNADO_II         = 968,
    ABILITY_WINDS_BLESSING     = 969,
    ABILITY_HYSTERIC_ASSAULT   = 970

};

#define MAX_ABILITY_ID  970

struct Charge_t
{
    uint16     ID;          //recastId
    JOBTYPE    job;         //job
    uint8      level;       //level
    uint8      maxCharges;  //maximum number of stored charges
    uint32     chargeTime;  //time required to restore one charge
    uint16     merit;
};

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

class CAbility
{
public:

    CAbility(uint16 id);

    bool        isPetAbility();
    bool        isAoE();
    bool        isConal();

    uint16      getID();
    uint16      getMobSkillID();
    JOBTYPE     getJob();
    uint8       getLevel();
    uint16      getAnimationID();
    duration    getAnimationTime();
    duration    getCastTime();
    float       getRange();
    uint8       getAOE();
    uint16      getValidTarget();
    uint16      getAddType();
    uint16      getMessage();
    uint16      getAoEMsg();
    uint16      getRecastTime();
    uint16      getRecastId();
    uint16      getCE();
    uint16      getVE();
    uint16      getMeritModID();
    ACTIONTYPE  getActionType();

    void        setID(uint16 id);
    void        setMobSkillID(uint16 id);
    void        setJob(JOBTYPE Job);
    void        setLevel(uint8 level);
    void        setAnimationID(uint16 animationID);
    void        setAnimationTime(duration time);
    void        setCastTime(duration time);
    void        setRange(float range);
    void        setAOE(uint8 aoe);
    void        setValidTarget(uint16 validTarget);
    void        setAddType(uint16 addtype);
    void        setMessage(uint16 message);
    void        setRecastTime(uint16 recastTime);
    void        setRecastId(uint16 recastId);
    void        setCE(uint16 CE);
    void        setVE(uint16 VE);
    void        setMeritModID(uint16 value);
    void        setActionType(ACTIONTYPE type);

    const int8* getName();
    void        setName(int8* name);

private:

    uint16      m_ID;
    JOBTYPE     m_Job;
    uint8       m_level;
    uint16      m_animationID;
    duration    m_animationTime;
    duration    m_castTime;
    float       m_range;
    uint8       m_aoe;
    uint16      m_validTarget;
    uint16      m_addType;
    uint16      m_message;
    uint16      m_recastTime;
    uint16      m_recastId;
    uint16      m_CE;
    uint16      m_VE;
    uint16      m_meritModID;
    string_t    m_name;
    uint16      m_mobskillId;
    ACTIONTYPE  m_actionType;
};

/************************************************************************
*                                                                       *
*  namespase для работы со способностями                                *
*                                                                       *
************************************************************************/

namespace ability
{
    void    LoadAbilitiesList();

    CAbility* GetAbility(uint16 AbilityID);

    CAbility* GetTwoHourAbility(JOBTYPE JobID);
    bool CanLearnAbility(CBattleEntity* PUser, uint16 AbilityID);
    Charge_t* GetCharge(CBattleEntity* PUser, uint16 chargeID);
    uint32 GetAbsorbMessage(uint32 message);

    std::vector<CAbility*> GetAbilities(JOBTYPE JobID);
};

#endif
