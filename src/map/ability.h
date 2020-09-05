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
    ABILITY_MIGHTY_STRIKES     = 0,
    ABILITY_HUNDRED_FISTS      = 1,
    ABILITY_BENEDICTION        = 2,
    ABILITY_MANAFONT           = 3,
    ABILITY_CHAINSPELL         = 4,
    ABILITY_PERFECT_DODGE      = 5,
    ABILITY_INVINCIBLE         = 6,
    ABILITY_BLOOD_WEAPON       = 7,
    ABILITY_FAMILIAR           = 8,
    ABILITY_SOUL_VOICE         = 9,
    ABILITY_EAGLE_EYE_SHOT     = 10,
    ABILITY_MEIKYO_SHISUI      = 11,
    ABILITY_MIJIN_GAKURE       = 12,
    ABILITY_SPIRIT_SURGE       = 13,
    ABILITY_ASTRAL_FLOW        = 14,
    ABILITY_BERSERK            = 15,
    ABILITY_WARCRY             = 16,
    ABILITY_DEFENDER           = 17,
    ABILITY_AGGRESSOR          = 18,
    ABILITY_PROVOKE            = 19,
    ABILITY_FOCUS              = 20,
    ABILITY_DODGE              = 21,
    ABILITY_CHAKRA             = 22,
    ABILITY_BOOST              = 23,
    ABILITY_COUNTERSTANCE      = 24,
    ABILITY_STEAL              = 25,
    ABILITY_FLEE               = 26,
    ABILITY_HIDE               = 27,
    ABILITY_SNEAK_ATTACK       = 28,
    ABILITY_MUG                = 29,
    ABILITY_SHIELD_BASH        = 30,
    ABILITY_HOLY_CIRCLE        = 31,
    ABILITY_SENTINEL           = 32,
    ABILITY_SOULEATER          = 33,
    ABILITY_ARCANE_CIRCLE      = 34,
    ABILITY_LAST_RESORT        = 35,
    ABILITY_CHARM              = 36,
    ABILITY_GAUGE              = 37,
    ABILITY_TAME               = 38,
    ABILITY_PET_COMMANDS       = 39,
    ABILITY_SCAVENGE           = 40,
    ABILITY_SHADOWBIND         = 41,
    ABILITY_CAMOUFLAGE         = 42,
    ABILITY_SHARPSHOT          = 43,
    ABILITY_BARRAGE            = 44,
    ABILITY_CALL_WYVERN        = 45,
    ABILITY_THIRD_EYE          = 46,
    ABILITY_MEDITATE           = 47,
    ABILITY_WARDING_CIRCLE     = 48,
    ABILITY_ANCIENT_CIRCLE     = 49,
    ABILITY_JUMP               = 50,
    ABILITY_HIGH_JUMP          = 51,
    ABILITY_SUPER_JUMP         = 52,
    ABILITY_FIGHT              = 53,
    ABILITY_HEEL               = 54,
    ABILITY_LEAVE              = 55,
    ABILITY_SIC                = 56,
    ABILITY_STAY               = 57,
    ABILITY_DIVINE_SEAL        = 58,
    ABILITY_ELEMENTAL_SEAL     = 59,
    ABILITY_TRICK_ATTACK       = 60,
    ABILITY_WEAPON_BASH        = 61,
    ABILITY_REWARD             = 62,
    ABILITY_COVER              = 63,
    ABILITY_SPIRIT_LINK        = 64,
    ABILITY_ENRAGE             = 65,
    ABILITY_CHI_BLAST          = 66,
    ABILITY_CONVERT            = 67,
    ABILITY_ACCOMPLICE         = 68,
    ABILITY_CALL_BEAST         = 69,
    ABILITY_UNLIMITED_SHOT     = 70,
    ABILITY_DISMISS            = 71,
    ABILITY_ASSAULT            = 72,
    ABILITY_RETREAT            = 73,
    ABILITY_RELEASE            = 74,
    ABILITY_BLOOD_PACT_RAGE    = 75,
    ABILITY_RAMPART            = 76,
    ABILITY_AZURE_LORE         = 77,
    ABILITY_CHAIN_AFFINITY     = 78,
    ABILITY_BURST_AFFINITY     = 79,
    ABILITY_WILD_CARD          = 80,
    ABILITY_PHANTOM_ROLL       = 81,
    ABILITY_FIGHTERS_ROLL      = 82,
    ABILITY_MONKS_ROLL         = 83,
    ABILITY_HEALERS_ROLL       = 84,
    ABILITY_WIZARDS_ROLL       = 85,
    ABILITY_WARLOCKS_ROLL      = 86,
    ABILITY_ROGUES_ROLL        = 87,
    ABILITY_GALLANTS_ROLL      = 88,
    ABILITY_CHAOS_ROLL         = 89,
    ABILITY_BEAST_ROLL         = 90,
    ABILITY_CHORAL_ROLL        = 91,
    ABILITY_HUNTERS_ROLL       = 92,
    ABILITY_SAMURAI_ROLL       = 93,
    ABILITY_NINJA_ROLL         = 94,
    ABILITY_DRACHEN_ROLL       = 95,
    ABILITY_EVOKERS_ROLL       = 96,
    ABILITY_MAGUSS_ROLL        = 97,
    ABILITY_CORSAIRS_ROLL      = 98,
    ABILITY_PUPPET_ROLL        = 99,
    ABILITY_DANCERS_ROLL       = 100,
    ABILITY_SCHOLARS_ROLL      = 101,
    ABILITY_BOLTERS_ROLL       = 102,
    ABILITY_CASTERS_ROLL       = 103,
    ABILITY_COURSERS_ROLL      = 104,
    ABILITY_BLITZERS_ROLL      = 105,
    ABILITY_TACTICIANS_ROLL    = 106,
    ABILITY_DOUBLE_UP          = 107,
    ABILITY_QUICK_DRAW         = 108,
    ABILITY_FIRE_SHOT          = 109,
    ABILITY_ICE_SHOT           = 110,
    ABILITY_WIND_SHOT          = 111,
    ABILITY_EARTH_SHOT         = 112,
    ABILITY_THUNDER_SHOT       = 113,
    ABILITY_WATER_SHOT         = 114,
    ABILITY_LIGHT_SHOT         = 115,
    ABILITY_DARK_SHOT          = 116,
    ABILITY_RANDOM_DEAL        = 117,
    // .                        = 118,
    ABILITY_OVERDRIVE          = 119,
    ABILITY_ACTIVATE           = 120,
    ABILITY_REPAIR             = 121,
    ABILITY_DEPLOY             = 122,
    ABILITY_DEACTIVATE         = 123,
    ABILITY_RETRIEVE           = 124,
    ABILITY_FIRE_MANEUVER      = 125,
    ABILITY_ICE_MANEUVER       = 126,
    ABILITY_WIND_MANEUVER      = 127,
    ABILITY_EARTH_MANEUVER     = 128,
    ABILITY_THUNDER_MANEUVER   = 129,
    ABILITY_WATER_MANEUVER     = 130,
    ABILITY_LIGHT_MANEUVER     = 131,
    ABILITY_DARK_MANEUVER      = 132,
    ABILITY_WARRIORS_CHARGE    = 133,
    ABILITY_TOMAHAWK           = 134,
    ABILITY_MANTRA             = 135,
    ABILITY_FORMLESS_STRIKES   = 136,
    ABILITY_MARTYR             = 137,
    ABILITY_DEVOTION           = 138,
    ABILITY_ASSASSINS_CHARGE   = 139,
    ABILITY_FEINT              = 140,
    ABILITY_FEALTY             = 141,
    ABILITY_CHIVALRY           = 142,
    ABILITY_DARK_SEAL          = 143,
    ABILITY_DIABOLIC_EYE       = 144,
    ABILITY_FERAL_HOWL         = 145,
    ABILITY_KILLER_INSTINCT    = 146,
    ABILITY_NIGHTINGALE        = 147,
    ABILITY_TROUBADOUR         = 148,
    ABILITY_STEALTH_SHOT       = 149,
    ABILITY_FLASHY_SHOT        = 150,
    ABILITY_SHIKIKOYO          = 151,
    ABILITY_BLADE_BASH         = 152,
    ABILITY_DEEP_BREATHING     = 153,
    ABILITY_ANGON              = 154,
    ABILITY_SANGE              = 155,
    ABILITY_BLOOD_PACT_WARD    = 156,
    ABILITY_HASSO              = 157,
    ABILITY_SEIGAN             = 158,
    ABILITY_CONVERGENCE        = 159,
    ABILITY_DIFFUSION          = 160,
    ABILITY_SNAKE_EYE          = 161,
    ABILITY_FOLD               = 162,
    ABILITY_ROLE_REVERSAL      = 163,
    ABILITY_VENTRILOQUY        = 164,
    ABILITY_TRANCE             = 165,
    ABILITY_SAMBAS             = 166,
    ABILITY_WALTZES            = 167,
    ABILITY_DRAIN_SAMBA        = 168,
    ABILITY_DRAIN_SAMBA_II     = 169,
    ABILITY_DRAIN_SAMBA_III    = 170,
    ABILITY_ASPIR_SAMBA        = 171,
    ABILITY_ASPIR_SAMBA_II     = 172,
    ABILITY_HASTE_SAMBA        = 173,
    ABILITY_CURING_WALTZ       = 174,
    ABILITY_CURING_WALTZ_II    = 175,
    ABILITY_CURING_WALTZ_III   = 176,
    ABILITY_CURING_WALTZ_IV    = 177,
    ABILITY_HEALING_WALTZ      = 178,
    ABILITY_DIVINE_WALTZ       = 179,
    ABILITY_SPECTRAL_JIG       = 180,
    ABILITY_CHOCOBO_JIG        = 181,
    ABILITY_JIGS               = 182,
    ABILITY_STEPS              = 183,
    ABILITY_FLOURISHES_I       = 184,
    ABILITY_QUICKSTEP          = 185,
    ABILITY_BOX_STEP           = 186,
    ABILITY_STUTTER_STEP       = 187,
    ABILITY_ANIMATED_FLOURISH  = 188,
    ABILITY_DESPERATE_FLOURISH = 189,
    ABILITY_REVERSE_FLOURISH   = 190,
    ABILITY_VIOLENT_FLOURISH   = 191,
    ABILITY_BUILDING_FLOURISH  = 192,
    ABILITY_WILD_FLOURISH      = 193,
    ABILITY_TABULA_RASA        = 194,
    ABILITY_LIGHT_ARTS         = 195,
    ABILITY_DARK_ARTS          = 196,
    ABILITY_FLOURISHES_II      = 197,
    ABILITY_MODUS_VERITAS      = 198,
    ABILITY_PENURY             = 199,
    ABILITY_CELERITY           = 200,
    ABILITY_RAPTURE            = 201,
    ABILITY_ACCESSION          = 202,
    ABILITY_PARSIMONY          = 203,
    ABILITY_ALACRITY           = 204,
    ABILITY_EBULLIENCE         = 205,
    ABILITY_MANIFESTATION      = 206,
    ABILITY_STRATAGEMS         = 207,
    ABILITY_VELOCITY_SHOT      = 208,
    ABILITY_SNARL              = 209,
    ABILITY_RETALIATION        = 210,
    ABILITY_FOOTWORK           = 211,
    ABILITY_DESPOIL            = 212,
    ABILITY_PIANISSIMO         = 213,
    ABILITY_SEKKANOKI          = 214,
    // .                        = 215,
    ABILITY_ELEMENTAL_SIPHON   = 216,
    ABILITY_SUBLIMATION        = 217,
    ABILITY_ADDENDUM_WHITE     = 218,
    ABILITY_ADDENDUM_BLACK     = 219,
    ABILITY_COLLABORATOR       = 220,
    ABILITY_SABER_DANCE        = 221,
    ABILITY_FAN_DANCE          = 222,
    ABILITY_NO_FOOT_RISE       = 223,
    ABILITY_ALTRUISM           = 224,
    ABILITY_FOCALIZATION       = 225,
    ABILITY_TRANQUILITY        = 226,
    ABILITY_EQUANIMITY         = 227,
    ABILITY_ENLIGHTENMENT      = 228,
    ABILITY_AFFLATUS_SOLACE    = 229,
    ABILITY_AFFLATUS_MISERY    = 230,
    ABILITY_COMPOSURE          = 231,
    ABILITY_YONIN              = 232,
    ABILITY_INNIN              = 233,
    ABILITY_AVATARS_FAVOR      = 234,
    ABILITY_READY              = 235,
    ABILITY_RESTRAINT          = 236,
    ABILITY_PERFECT_COUNTER    = 237,
    ABILITY_MANA_WALL          = 238,
    ABILITY_DIVINE_EMBLEM      = 239,
    ABILITY_NETHER_VOID        = 240,
    ABILITY_DOUBLE_SHOT        = 241,
    ABILITY_SENGIKORI          = 242,
    ABILITY_FUTAE              = 243,
    ABILITY_SPIRIT_JUMP        = 244,
    ABILITY_PRESTO             = 245,
    ABILITY_DIVINE_WALTZ_II    = 246,
    ABILITY_FLOURISHES_III     = 247,
    ABILITY_CLIMACTIC_FLOURISH = 248,
    ABILITY_LIBRA              = 249,
    ABILITY_TACTICAL_SWITCH    = 250,
    ABILITY_BLOOD_RAGE         = 251,
    // .                        = 252,
    ABILITY_IMPETUS            = 253,
    ABILITY_DIVINE_CARESS      = 254,
    ABILITY_SANCROSANCTITY     = 255,
    ABILITY_ENMITY_DOUSE       = 256,
    ABILITY_MANAWELL           = 257,
    ABILITY_SABOTEUR           = 258,
    ABILITY_SPONTANEITY        = 259,
    ABILITY_CONSPIRATOR        = 260,
    ABILITY_SEPULCHER          = 261,
    ABILITY_PALISADE           = 262,
    ABILITY_ARCANE_CREST       = 263,
    ABILITY_SCARLET_DELIRIUM   = 264,
    ABILITY_SPUR               = 265,
    ABILITY_RUN_WILD           = 266,
    ABILITY_TENUTO             = 267,
    ABILITY_MARCATO            = 268,
    ABILITY_BOUNTY_SHOT        = 269,
    ABILITY_DECOY_SHOT         = 270,
    ABILITY_HAMANOHA           = 271,
    ABILITY_HAGAKURE           = 272,
    // .                        = 273,
    // .                        = 274,
    ABILITY_ISSEKIGAN          = 275,
    ABILITY_DRAGON_BREAKER     = 276,
    ABILITY_SOUL_JUMP          = 277,
    // .                        = 278,
    ABILITY_STEADY_WING        = 279,
    ABILITY_MANA_CEDE          = 280,
    ABILITY_EFFLUX             = 281,
    ABILITY_UNBRIDLED_LEARNING = 282,
    // .                        = 283,
    // .                        = 284,
    ABILITY_TRIPLE_SHOT        = 285,
    ABILITY_ALLIES_ROLL        = 286,
    ABILITY_MISERS_ROLL        = 287,
    ABILITY_COMPANIONS_ROLL    = 288,
    ABILITY_AVENGERS_ROLL      = 289,
    // .                        = 290,
    // .                        = 291,
    // .                        = 292,
    ABILITY_COOLDOWN           = 293,
    ABILITY_DEUX_EX_AUTOMATA   = 294,
    ABILITY_CURING_WALTZ_V     = 295,
    ABILITY_FEATHER_STEP       = 296,
    ABILITY_STRIKING_FLOURISH  = 297,
    ABILITY_TERNARY_FLOURISH   = 298,
    // .                        = 299,
    ABILITY_PERPETUANCE        = 300,
    ABILITY_IMMANENCE          = 301,
    ABILITY_SMITING_BREATH     = 302,
    ABILITY_RESTORING_BREATH   = 303,
    ABILITY_KONZEN_ITTAI       = 304,
    ABILITY_BULLY              = 305,
    ABILITY_MAINTENANCE        = 306,
    ABILITY_BRAZEN_RUSH        = 307,
    ABILITY_INNER_STRENGTH     = 308,
    ABILITY_ASYLUM             = 309,
    ABILITY_SUBLTE_SORCERY     = 310, // Yes, subtle is misspelled
    ABILITY_STYMIE             = 311,
    ABILITY_LARCENY            = 312,
    ABILITY_INTERVENE          = 313,
    ABILITY_SOUL_ENSLAVEMENT   = 314,
    ABILITY_UNLEASH            = 315,
    ABILITY_CLARION_CALL       = 316,
    ABILITY_OVERKILL           = 317,
    ABILITY_YAEGASUMI          = 318,
    ABILITY_MIKAGE             = 319,
    ABILITY_FLY_HIGH           = 320,
    ABILITY_ASTRAL_CONDUIT     = 321,
    ABILITY_UNBRIDLED_WISDOM   = 322,
    ABILITY_CUTTING_CARDS      = 323,
    ABILITY_HEADY_ARTIFICE     = 324,
    ABILITY_GRAND_PAS          = 325,
    ABILITY_CAPER_EMISSARIUS   = 326,
    ABILITY_BOLSTER            = 327,
    ABILITY_SWIPE              = 328,
    ABILITY_FULL_CIRCLE        = 329,
    ABILITY_LASTING_EMANATION  = 330,
    ABILITY_ECLIPTIC_ATTRITION = 331,
    ABILITY_COLLIMATED_FERVOR  = 332,
    ABILITY_LIFE_CYCLE         = 333,
    ABILITY_BLAZE_OF_GLORY     = 334,
    ABILITY_DEMATERIALIZE      = 335,
    ABILITY_THEURGIC_FOCUS     = 336,
    ABILITY_CONCENTRIC_PULSE   = 337,
    ABILITY_MENDING_HALATION   = 338,
    ABILITY_RADIAL_ARCANA      = 339,
    ABILITY_ELEMENTAL_SFORZO   = 340,
    ABILITY_RUNE_ENCHANTMENT   = 341,
    ABILITY_IGNIS              = 342,
    ABILITY_GELUS              = 343,
    ABILITY_FLABRA             = 344,
    ABILITY_TELLUS             = 345,
    ABILITY_SULPOR             = 346,
    ABILITY_UNDA               = 347,
    ABILITY_LUX                = 348,
    ABILITY_TENEBRAE           = 349,
    ABILITY_VALLATION          = 350,
    ABILITY_SWORDPLAY          = 351,
    ABILITY_LUNGE              = 352,
    ABILITY_PFLUG              = 353,
    ABILITY_EMBOLDEN           = 354,
    ABILITY_VALIANCE           = 355,
    ABILITY_GAMBIT             = 356,
    ABILITY_LIEMENT            = 357,
    ABILITY_ONE_FOR_ALL        = 358,
    ABILITY_RAYKE              = 359,
    ABILITY_BATTUTA            = 360,
    ABILITY_WIDENED_COMPASS    = 361,
    ABILITY_ODYLLIC_SUBTERFUGE = 362,
    ABILITY_WARD               = 363,
    ABILITY_EFFUSION           = 364,
    ABILITY_CHOCOBO_JIG_II     = 365,
    ABILITY_RELINQUISH         = 366,
    ABILITY_APOGEE             = 369,
    ABILITY_ENTRUST            = 370,
    ABILITY_BESTIAL_LOYALTY    = 371,
    ABILITY_CASCADE            = 372,
    ABILITY_CONSUME_MANA       = 373,
    ABILITY_NATURALISTS_ROLL   = 374,
    ABILITY_RUNEISTS_ROLL      = 375,
    ABILITY_CROOKED_CARDS      = 376,
    ABILITY_SPIRIT_BOND        = 377,
    ABILITY_MAJESTY            = 378,

    ABILITY_HEALING_RUBY       = 496,
    ABILITY_POISON_NAILS       = 497,
    ABILITY_SHINING_RUBY       = 498,
    ABILITY_GLITTERING_RUBY    = 499,
    ABILITY_METEORITE          = 500,
    ABILITY_HEALING_RUBY_II    = 501,
    ABILITY_SEARING_LIGHT      = 502,
    ABILITY_HOLY_MIST          = 503,
    ABILITY_SOOTHING_RUBY      = 504,
    ABILITY_REGAL_SCRATCH      = 505,
    ABILITY_MEWING_LULLABY     = 506,
    ABILITY_EERIE_EYE          = 507,
    ABILITY_LEVEL_QM_HOLY      = 508,
    ABILITY_RAISE_II           = 509,
    ABILITY_RERAISE_II         = 510,
    ABILITY_ALTANAS_FAVOR      = 511,
    ABILITY_MOONLIT_CHARGE     = 512,
    ABILITY_CRESCENT_FANG      = 513,
    ABILITY_LUNAR_CRY          = 514,
    ABILITY_LUNAR_ROAR         = 515,
    ABILITY_ECLIPTIC_GROWL     = 516,
    ABILITY_ECLIPTIC_HOWL      = 517,
    ABILITY_ECLIPSE_BITE       = 518,

    ABILITY_HOWLING_MOON       = 520,
    ABILITY_LUNAR_BAY          = 521,
    ABILITY_HEAVENWARD_HOWL    = 522,
    ABILITY_IMPACT             = 523,

    ABILITY_PUNCH              = 528,
    ABILITY_FIRE_II            = 529,
    ABILITY_BURNING_STRIKE     = 530,
    ABILITY_DOUBLE_PUNCH       = 531,
    ABILITY_CRIMSON_HOWL       = 532,
    ABILITY_FIRE_IV            = 533,
    ABILITY_FLAMING_CRUSH      = 534,
    ABILITY_METEOR_STRIKE      = 535,
    ABILITY_INFERNO            = 536,
    ABILITY_INFERNO_HOWL       = 537,
    ABILITY_CONFLAG_STRIKE     = 538,

    ABILITY_ROCK_THROW         = 544,
    ABILITY_STONE_II           = 545,
    ABILITY_ROCK_BUSTER        = 546,
    ABILITY_MEGALITH_THROW     = 547,
    ABILITY_EARTHEN_WARD       = 548,
    ABILITY_STONE_IV           = 549,
    ABILITY_MOUNTAIN_BUSTER    = 550,
    ABILITY_GEOCRUSH           = 551,
    ABILITY_EARTHEN_FURY       = 552,
    ABILITY_EARTHEN_ARMOR      = 553,
    ABILITY_CRAG_THROW         = 554,

    ABILITY_BARRACUDA_DIVE     = 560,
    ABILITY_WATER_II           = 561,
    ABILITY_TAIL_WHIP          = 562,
    ABILITY_SLOWGA             = 564,
    ABILITY_SPRING_WATER       = 563,
    ABILITY_WATER_IV           = 565,
    ABILITY_SPINNING_DIVE      = 566,
    ABILITY_GRAND_FALL         = 567,
    ABILITY_TIDAL_WAVE         = 568,
    ABILITY_TIDAL_ROAR         = 569,
    ABILITY_SOOTHING_CURRENT   = 570,

    ABILITY_CLAW               = 576,
    ABILITY_AERO_II            = 577,
    ABILITY_WHISPERING_WIND    = 578,
    ABILITY_HASTEGA            = 579,
    ABILITY_AERIAL_ARMOR       = 580,
    ABILITY_AERO_IV            = 581,
    ABILITY_PREDATOR_CLAWS     = 582,
    ABILITY_WIND_BLADE         = 583,
    ABILITY_AERIAL_BLAST       = 584,
    ABILITY_FLEET_WIND         = 585,
    ABILITY_HASTEGA_II         = 586,

    ABILITY_AXE_KICK           = 592,
    ABILITY_BLIZZARD_II        = 593,
    ABILITY_FROST_ARMOR        = 594,
    ABILITY_SLEEPGA            = 595,
    ABILITY_DOUBLE_SLAP        = 596,
    ABILITY_BLIZZARD_IV        = 597,
    ABILITY_RUSH               = 598,
    ABILITY_HEAVENLY_STRIKE    = 599,
    ABILITY_DIAMOND_DUST       = 600,
    ABILITY_DIAMOND_STORM      = 601,
    ABILITY_CRYSTAL_BLESSING   = 602,

    ABILITY_SHOCK_STRIKE       = 608,
    ABILITY_THUNDER_II         = 609,
    ABILITY_THUNDERSPARK       = 611,
    ABILITY_ROLLING_THUNDER    = 610,
    ABILITY_LIGHTNING_ARMOR    = 612,
    ABILITY_THUNDER_IV         = 613,
    ABILITY_CHAOTIC_STRIKE     = 614,
    ABILITY_THUNDERSTORM       = 615,
    ABILITY_JUDGMENT_BOLT      = 616,
    ABILITY_SHOCK_SQUALL       = 617,
    ABILITY_VOLT_STRIKE        = 618,

    ABILITY_HEALING_BREATH_IV  = 623,
    ABILITY_HEALING_BREATH     = 624,
    ABILITY_HEALING_BREATH_II  = 625,
    ABILITY_HEALING_BREATH_III = 626,
    ABILITY_REMOVE_POISON      = 627,
    ABILITY_REMOVE_BLINDNESS   = 628,
    ABILITY_REMOVE_PARALYSIS   = 629,
    ABILITY_FLAME_BREATH       = 630,
    ABILITY_FROST_BREATH       = 631,
    ABILITY_GUST_BREATH        = 632,
    ABILITY_SAND_BREATH        = 633,
    ABILITY_LIGHTNING_BREATH   = 634,
    ABILITY_HYDRO_BREATH       = 635,
    ABILITY_SUPER_CLIMB        = 636,
    ABILITY_REMOVE_CURSE       = 637,
    ABILITY_REMOVE_DISEASE     = 638,
    ABILITY_CAMISADO           = 640,
    ABILITY_SOMNOLENCE         = 641,
    ABILITY_NIGHTMARE          = 642,
    ABILITY_ULTIMATE_TERROR    = 643,
    ABILITY_NOCTOSHIELD        = 644,
    ABILITY_DREAM_SHROUD       = 645,
    ABILITY_NETHER_BLAST       = 646,
    ABILITY_CACODEMONIA        = 647,
    ABILITY_RUINOUS_OMEN       = 648,
    ABILITY_NIGHT_TERROR       = 649,
    ABILITY_PAVOR_NOCTURNUS    = 650,
    ABILITY_ZANTETSUKEN        = 654,
    ABILITY_PERFECT_DEFENSE    = 655,
    ABILITY_FOOT_KICK          = 656,
    ABILITY_DUST_CLOUD         = 657,
    ABILITY_WHIRL_CLAWS        = 658,
    ABILITY_HEAD_BUTT          = 659,
    ABILITY_DREAM_FLOWER       = 660,
    ABILITY_WILD_OATS          = 661,
    ABILITY_LEAF_DAGGER        = 662,
    ABILITY_SCREAM             = 663,
    ABILITY_ROAR               = 664,
    ABILITY_RAZOR_FANG         = 665,
    ABILITY_CLAW_CYCLONE       = 666,
    ABILITY_TAIL_BLOW          = 667,
    ABILITY_FIREBALL           = 668,
    ABILITY_BLOCKHEAD          = 669,
    ABILITY_BRAIN_CRUSH        = 670,
    ABILITY_INFRASONICS        = 671,
    ABILITY_SECRETION          = 672,
    ABILITY_LAMB_CHOP          = 673,
    ABILITY_RAGE               = 674,
    ABILITY_SHEEP_CHARGE       = 675,
    ABILITY_SHEEP_SONG         = 676,
    ABILITY_BUBBLE_SHOWER      = 677,
    ABILITY_BUBBLE_CURTAIN     = 678,
    ABILITY_BIG_SCISSORS       = 679,
    ABILITY_SCISSOR_GUARD      = 680,
    ABILITY_METALLIC_BODY      = 681,
    ABILITY_NEEDLESHOT         = 682,
    ABILITY_1000_NEEDLES       = 683,
    ABILITY_FROGKICK           = 684,
    ABILITY_SPORE              = 685,
    ABILITY_QUEASYSHROOM       = 686,
    ABILITY_NUMBSHROOM         = 687,
    ABILITY_SHAKESHROOM        = 688,
    ABILITY_SILENCE_GAS        = 689,
    ABILITY_DARK_SPORE         = 690,
    ABILITY_POWER_ATTACK       = 691,
    ABILITY_HI_FREQ_FIELD      = 692,
    ABILITY_RHINO_ATTACK       = 693,
    ABILITY_RHINO_GUARD        = 694,
    ABILITY_SPOIL              = 695,
    ABILITY_CURSED_SPHERE      = 696,
    ABILITY_VENOM              = 697,
    ABILITY_SANDBLAST          = 698,
    ABILITY_SANDPIT            = 699,
    ABILITY_VENOM_SPRAY        = 700,
    ABILITY_MANDIBULAR_BITE    = 701,
    ABILITY_SOPORIFIC          = 702,
    ABILITY_GLOEOSUCCUS        = 703,
    ABILITY_PALSY_POLLEN       = 704,
    ABILITY_GEIST_WALL         = 705,
    ABILITY_NUMBING_NOISE      = 706,
    ABILITY_NIMBLE_SNAP        = 707,
    ABILITY_CYCLOTAIL          = 708,
    ABILITY_TOXIC_SPIT         = 709,
    ABILITY_DOUBLE_CLAW        = 710,
    ABILITY_GRAPPLE            = 711,
    ABILITY_SPINNING_TOP       = 712,
    ABILITY_FILAMENTED_HOLD    = 713,
    ABILITY_CHAOTIC_EYE        = 714,
    ABILITY_BLASTER            = 715,
    ABILITY_SUCTION            = 716,
    ABILITY_DRAINKISS          = 717,
    ABILITY_SNOW_CLOUD         = 718,
    ABILITY_WILD_CARROT        = 719,
    ABILITY_SUDDEN_LUNGE       = 720,
    ABILITY_SPIRAL_SPIN        = 721,
    ABILITY_NOISOME_POWDER     = 722,

    ABILITY_ACID_MIST          = 724,
    ABILITY_TP_DRAINKISS       = 725,

    ABILITY_SCYTHE_TAIL        = 727,
    ABILITY_RIPPER_FANG        = 728,
    ABILITY_CHOMP_RUSH         = 729,
    ABILITY_CHARGED_WHISKER    = 730,
    ABILITY_PURULENT_OOZE      = 731,
    ABILITY_CORROSIVE_OOZE     = 732,
    ABILITY_BACK_HEEL          = 733,
    ABILITY_JETTATURA          = 734,
    ABILITY_CHOKE_BREATH       = 735,
    ABILITY_FANTOD             = 736,
    ABILITY_TORTOISE_STOMP     = 737,
    ABILITY_HARDEN_SHELL       = 738,
    ABILITY_AQUA_BREATH        = 739,
    ABILITY_WING_SLAP          = 740,
    ABILITY_BEAK_LUNGE         = 741,
    ABILITY_INTIMIDATE         = 742,
    ABILITY_RECOIL_DIVE        = 743,
    ABILITY_WATER_WALL         = 744,
    ABILITY_SENSILLA_BLADES    = 745,
    ABILITY_TEGMINA_BUFFET     = 746,
    ABILITY_MOLTING_PLUMAGE    = 747,
    ABILITY_SWOOPING_FRENZY    = 748,
    ABILITY_SWEEPING_GOUGE     = 749,
    ABILITY_ZEALOUS_SNORT      = 750,
    ABILITY_PENTAPECK          = 751,
    ABILITY_TICKLING_TENDRILS  = 752,
    ABILITY_STINK_BOMB         = 753,
    ABILITY_NECTAROUS_DELUGE   = 754,
    ABILITY_NEPENTHIC_PLUNGE   = 755,
    ABILITY_SOMERSAULT         = 756,
    ABILITY_PACIFYING_RUBY     = 757,
    ABILITY_FOUL_WATERS        = 758,
    ABILITY_PESTILENT_PLUME    = 759,
    ABILITY_PECKING_FLURRY     = 760,
    ABILITY_SICKLE_SLASH       = 761,
    ABILITY_ACID_SPRAY         = 762,
    ABILITY_SPIDER_WEB         = 763,
    ABILITY_REGAL_GASH         = 764,
    ABILITY_INFECTED_LEECH     = 765,
    ABILITY_GLOOM_SPRAY        = 766,

    ABILITY_DISEMBOWEL         = 770,
    ABILITY_EXTIRPATING_SALVO  = 771,

    ABILITY_CLARSACH_CALL      = 944,
    ABILITY_WELT               = 945,
    ABILITY_KATABATIC_BLADES   = 946,
    ABILITY_LUNATIC_VOICE      = 947,
    ABILITY_ROUNDHOUSE         = 948,
    ABILITY_CHINOOK            = 949,
    ABILITY_BITTER_ELEGY       = 950,
    ABILITY_SONIC_BUFFET       = 951,
    ABILITY_TORNADO_II         = 952,
    ABILITY_WINDS_BLESSING     = 953,
    ABILITY_HYSTERIC_ASSAULT   = 954
};

#define MAX_ABILITY_ID  955

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
