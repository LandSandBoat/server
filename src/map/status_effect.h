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

#ifndef _STATUSEFFECT_H
#define _STATUSEFFECT_H

#include "../common/cbasetypes.h"
#include "../common/mmo.h"

#include <vector>

#include "modifier.h"

enum class EFFECTOVERWRITE : uint8
{
    EQUAL_HIGHER      = 0, // only overwrite if equal or higher (tier, power)
    HIGHER            = 1, // only overwrite if higher (tier, power)
    NEVER             = 2, // never overwrite
    ALWAYS            = 3, // always overwrite no matter
    IGNORE_DUPLICATE  = 4, // ignore dupes
    TIER_HIGHER       = 5  // only overwrite if tier is higher (regardless of power)
};

enum EFFECTFLAG
{
    EFFECTFLAG_NONE            = 0x0000,
    EFFECTFLAG_DISPELABLE      = 0x0001,
    EFFECTFLAG_ERASABLE        = 0x0002,
    EFFECTFLAG_ATTACK          = 0x0004, // исчезает при нанесении урона
    EFFECTFLAG_EMPATHY         = 0X0008, // effect can be copied to wyvern by use of merited Spirit Link
    EFFECTFLAG_DAMAGE          = 0x0010, // исчезает при получении урона
    EFFECTFLAG_DEATH           = 0x0020, // исчезает при смерти
    EFFECTFLAG_MAGIC_BEGIN     = 0x0040, // исчезает перед началом чтения заклинания
    EFFECTFLAG_MAGIC_END       = 0x0080, // исчезает после прочтения заклинания
    EFFECTFLAG_ON_ZONE         = 0x0100,
    EFFECTFLAG_NO_LOSS_MESSAGE = 0x0200, // Suppress effect worn off message.
    EFFECTFLAG_INVISIBLE       = 0x0400, // invisible effect
    EFFECTFLAG_DETECTABLE      = 0x0800, // invisible, sneak, deo
    EFFECTFLAG_NO_REST         = 0x1000, // prevents resting, curse II, plague, disease
    EFFECTFLAG_PREVENT_ACTION  = 0x2000, // sleep, lullaby, stun, petro. Not implemented
    EFFECTFLAG_WALTZABLE       = 0x4000, // for healing waltzable spells
    EFFECTFLAG_FOOD            = 0x8000,
    EFFECTFLAG_SONG            = 0x10000, // bard songs
    EFFECTFLAG_ROLL            = 0x20000, // corsair rolls
    EFFECTFLAG_SYNTH_SUPPORT   = 0x40000, // Synthesis Image Support
    EFFECTFLAG_CONFRONTATION   = 0x80000,
    EFFECTFLAG_LOGOUT          = 0x100000,
    EFFECTFLAG_BLOODPACT       = 0x200000,
    EFFECTFLAG_ON_JOBCHANGE    = 0x400000,  // Removes effect when you change jobs
    EFFECTFLAG_NO_CANCEL       = 0x800000,  // CAN NOT CLICK IT OFF IN CLIENT
    EFFECTFLAG_INFLUENCE       = 0x1000000, // Influence effects - e.g. Signet, Sanction, Sigil, Ionis
    EFFECTFLAG_OFFLINE_TICK    = 0x2000000, // Duration elapses while offline
    EFFECTFLAG_AURA            = 0x4000000, // Is an aura type effect
};

enum EFFECT
{
    EFFECT_KO                    = 0,
    EFFECT_WEAKNESS              = 1,
    EFFECT_SLEEP                 = 2,
    EFFECT_POISON                = 3,
    EFFECT_PARALYSIS             = 4,
    EFFECT_BLINDNESS             = 5,
    EFFECT_SILENCE               = 6,
    EFFECT_PETRIFICATION         = 7,
    EFFECT_DISEASE               = 8,
    EFFECT_CURSE                 = 9,
    EFFECT_STUN                  = 10,
    EFFECT_BIND                  = 11,
    EFFECT_WEIGHT                = 12,
    EFFECT_SLOW                  = 13,
    EFFECT_CHARM                 = 14,
    EFFECT_DOOM                  = 15,
    EFFECT_AMNESIA               = 16,
    EFFECT_CHARM_II              = 17,
    EFFECT_GRADUAL_PETRIFICATION = 18,
    EFFECT_SLEEP_II              = 19,
    EFFECT_CURSE_II              = 20,
    EFFECT_ADDLE                 = 21,
    EFFECT_INTIMIDATE            = 22,
    EFFECT_KAUSTRA               = 23,
    EFFECT_TERROR                = 28,
    EFFECT_MUTE                  = 29,
    EFFECT_BANE                  = 30,
    EFFECT_PLAGUE                = 31,
    EFFECT_FLEE                  = 32,
    EFFECT_HASTE                 = 33,
    EFFECT_BLAZE_SPIKES          = 34,
    EFFECT_ICE_SPIKES            = 35,
    EFFECT_BLINK                 = 36,
    EFFECT_STONESKIN             = 37,
    EFFECT_SHOCK_SPIKES          = 38,
    EFFECT_AQUAVEIL              = 39,
    EFFECT_PROTECT               = 40,
    EFFECT_SHELL                 = 41,
    EFFECT_REGEN                 = 42,
    EFFECT_REFRESH               = 43,
    EFFECT_MIGHTY_STRIKES        = 44,
    EFFECT_BOOST                 = 45,
    EFFECT_HUNDRED_FISTS         = 46,
    EFFECT_MANAFONT              = 47,
    EFFECT_CHAINSPELL            = 48,
    EFFECT_PERFECT_DODGE         = 49,
    EFFECT_INVINCIBLE            = 50,
    EFFECT_BLOOD_WEAPON          = 51,
    EFFECT_SOUL_VOICE            = 52,
    EFFECT_EAGLE_EYE_SHOT        = 53,
    EFFECT_MEIKYO_SHISUI         = 54,
    EFFECT_ASTRAL_FLOW           = 55,
    EFFECT_BERSERK               = 56,
    EFFECT_DEFENDER              = 57,
    EFFECT_AGGRESSOR             = 58,
    EFFECT_FOCUS                 = 59,
    EFFECT_DODGE                 = 60,
    EFFECT_COUNTERSTANCE         = 61,
    EFFECT_SENTINEL              = 62,
    EFFECT_SOULEATER             = 63,
    EFFECT_LAST_RESORT           = 64,
    EFFECT_SNEAK_ATTACK          = 65,
    EFFECT_COPY_IMAGE            = 66,
    EFFECT_COPY_IMAGE_1          = 66,
    EFFECT_THIRD_EYE             = 67,
    EFFECT_WARCRY                = 68,
    EFFECT_INVISIBLE             = 69,
    EFFECT_DEODORIZE             = 70,
    EFFECT_SNEAK                 = 71,
    EFFECT_SHARPSHOT             = 72,
    EFFECT_BARRAGE               = 73,
    EFFECT_HOLY_CIRCLE           = 74,
    EFFECT_ARCANE_CIRCLE         = 75,
    EFFECT_HIDE                  = 76,
    EFFECT_CAMOUFLAGE            = 77,
    EFFECT_DIVINE_SEAL           = 78,
    EFFECT_ELEMENTAL_SEAL        = 79,
    EFFECT_STR_BOOST             = 80,
    EFFECT_DEX_BOOST             = 81,
    EFFECT_VIT_BOOST             = 82,
    EFFECT_AGI_BOOST             = 83,
    EFFECT_INT_BOOST             = 84,
    EFFECT_MND_BOOST             = 85,
    EFFECT_CHR_BOOST             = 86,
    EFFECT_TRICK_ATTACK          = 87,
    EFFECT_MAX_HP_BOOST          = 88,
    EFFECT_MAX_MP_BOOST          = 89,
    EFFECT_ACCURACY_BOOST        = 90,
    EFFECT_ATTACK_BOOST          = 91,
    EFFECT_EVASION_BOOST         = 92,
    EFFECT_DEFENSE_BOOST         = 93,
    EFFECT_ENFIRE                = 94,
    EFFECT_ENBLIZZARD            = 95,
    EFFECT_ENAERO                = 96,
    EFFECT_ENSTONE               = 97,
    EFFECT_ENTHUNDER             = 98,
    EFFECT_ENWATER               = 99,
    EFFECT_BARFIRE               = 100,
    EFFECT_BARBLIZZARD           = 101,
    EFFECT_BARAERO               = 102,
    EFFECT_BARSTONE              = 103,
    EFFECT_BARTHUNDER            = 104,
    EFFECT_BARWATER              = 105,
    EFFECT_BARSLEEP              = 106,
    EFFECT_BARPOISON             = 107,
    EFFECT_BARPARALYZE           = 108,
    EFFECT_BARBLIND              = 109,
    EFFECT_BARSILENCE            = 110,
    EFFECT_BARPETRIFY            = 111,
    EFFECT_BARVIRUS              = 112,
    EFFECT_RERAISE               = 113,
    EFFECT_COVER                 = 114,
    EFFECT_UNLIMITED_SHOT        = 115,
    EFFECT_PHALANX               = 116,
    EFFECT_WARDING_CIRCLE        = 117,
    EFFECT_ANCIENT_CIRCLE        = 118,
    EFFECT_STR_BOOST_2           = 119,
    EFFECT_DEX_BOOST_2           = 120,
    EFFECT_VIT_BOOST_2           = 121,
    EFFECT_AGI_BOOST_2           = 122,
    EFFECT_INT_BOOST_2           = 123,
    EFFECT_MND_BOOST_2           = 124,
    EFFECT_CHR_BOOST_2           = 125,
    EFFECT_SPIRIT_SURGE          = 126,
    EFFECT_COSTUME               = 127,
    EFFECT_BURN                  = 128,
    EFFECT_FROST                 = 129,
    EFFECT_CHOKE                 = 130,
    EFFECT_RASP                  = 131,
    EFFECT_SHOCK                 = 132,
    EFFECT_DROWN                 = 133,
    EFFECT_DIA                   = 134,
    EFFECT_BIO                   = 135,
    EFFECT_STR_DOWN              = 136,
    EFFECT_DEX_DOWN              = 137,
    EFFECT_VIT_DOWN              = 138,
    EFFECT_AGI_DOWN              = 139,
    EFFECT_INT_DOWN              = 140,
    EFFECT_MND_DOWN              = 141,
    EFFECT_CHR_DOWN              = 142,
    EFFECT_LEVEL_RESTRICTION     = 143,
    EFFECT_MAX_HP_DOWN           = 144,
    EFFECT_MAX_MP_DOWN           = 145,
    EFFECT_ACCURACY_DOWN         = 146,
    EFFECT_ATTACK_DOWN           = 147,
    EFFECT_EVASION_DOWN          = 148,
    EFFECT_DEFENSE_DOWN          = 149,
    EFFECT_PHYSICAL_SHIELD       = 150,
    EFFECT_ARROW_SHIELD          = 151,
    EFFECT_MAGIC_SHIELD          = 152,
    EFFECT_DAMAGE_SPIKES         = 153,
    EFFECT_SHINING_RUBY          = 154,
    EFFECT_MEDICINE              = 155,
    EFFECT_FLASH                 = 156,
    EFFECT_SJ_RESTRICTION        = 157,
    EFFECT_PROVOKE               = 158,
    EFFECT_PENALTY               = 159,
    EFFECT_PREPARATIONS          = 160,
    EFFECT_SPRINT                = 161,
    EFFECT_ENCHANTMENT           = 162,
    EFFECT_AZURE_LORE            = 163,
    EFFECT_CHAIN_AFFINITY        = 164,
    EFFECT_BURST_AFFINITY        = 165,
    EFFECT_OVERDRIVE             = 166,
    EFFECT_MAGIC_DEF_DOWN        = 167,
    EFFECT_INHIBIT_TP            = 168,
    EFFECT_POTENCY               = 169,
    EFFECT_REGAIN                = 170,
    EFFECT_PAX                   = 171,
    EFFECT_INTENSION             = 172,
    EFFECT_DREAD_SPIKES          = 173,
    EFFECT_MAGIC_ACC_DOWN        = 174,
    EFFECT_MAGIC_ATK_DOWN        = 175,
    EFFECT_QUICKENING            = 176,
    EFFECT_ENCUMBRANCE_II        = 177,
    EFFECT_FIRESTORM             = 178,
    EFFECT_HAILSTORM             = 179,
    EFFECT_WINDSTORM             = 180,
    EFFECT_SANDSTORM             = 181,
    EFFECT_THUNDERSTORM          = 182,
    EFFECT_RAINSTORM             = 183,
    EFFECT_AURORASTORM           = 184,
    EFFECT_VOIDSTORM             = 185,
    EFFECT_HELIX                 = 186,
    EFFECT_SUBLIMATION_ACTIVATED = 187,
    EFFECT_SUBLIMATION_COMPLETE  = 188,
    EFFECT_MAX_TP_DOWN           = 189,
    EFFECT_MAGIC_ATK_BOOST       = 190,
    EFFECT_MAGIC_DEF_BOOST       = 191,
    EFFECT_REQUIEM               = 192,
    EFFECT_LULLABY               = 193,
    EFFECT_ELEGY                 = 194,
    EFFECT_PAEON                 = 195,
    EFFECT_BALLAD                = 196,
    EFFECT_MINNE                 = 197,
    EFFECT_MINUET                = 198,
    EFFECT_MADRIGAL              = 199,
    EFFECT_PRELUDE               = 200,
    EFFECT_MAMBO                 = 201,
    EFFECT_AUBADE                = 202,
    EFFECT_PASTORAL              = 203,
    EFFECT_HUM                   = 204,
    EFFECT_FANTASIA              = 205,
    EFFECT_OPERETTA              = 206,
    EFFECT_CAPRICCIO             = 207,
    EFFECT_SERENADE              = 208,
    EFFECT_ROUND                 = 209,
    EFFECT_GAVOTTE               = 210,
    EFFECT_FUGUE                 = 211,
    EFFECT_RHAPSODY              = 212,
    EFFECT_ARIA                  = 213,
    EFFECT_MARCH                 = 214,
    EFFECT_ETUDE                 = 215,
    EFFECT_CAROL                 = 216,
    EFFECT_THRENODY              = 217,
    EFFECT_HYMNUS                = 218,
    EFFECT_MAZURKA               = 219,
    EFFECT_SIRVENTE              = 220,
    EFFECT_DIRGE                 = 221,
    EFFECT_SCHERZO               = 222,
    EFFECT_NOCTURNE              = 223,
    EFFECT_STORE_TP              = 227,
    EFFECT_EMBRAVA               = 228,
    EFFECT_MANAWELL              = 229,
    EFFECT_SPONTANEITY           = 230,
    EFFECT_MARCATO               = 231,
    EFFECT_NA                    = 232,
    EFFECT_AUTO_REGEN            = 233,
    EFFECT_AUTO_REFRESH          = 234,
    EFFECT_FISHING_IMAGERY       = 235,
    EFFECT_WOODWORKING_IMAGERY   = 236,
    EFFECT_SMITHING_IMAGERY      = 237,
    EFFECT_GOLDSMITHING_IMAGERY  = 238,
    EFFECT_CLOTHCRAFT_IMAGERY    = 239,
    EFFECT_LEATHERCRAFT_IMAGERY  = 240,
    EFFECT_BONECRAFT_IMAGERY     = 241,
    EFFECT_ALCHEMY_IMAGERY       = 242,
    EFFECT_COOKING_IMAGERY       = 243,
    EFFECT_IMAGERY_1             = 244,
    EFFECT_IMAGERY_2             = 245,
    EFFECT_IMAGERY_3             = 246,
    EFFECT_IMAGERY_4             = 247,
    EFFECT_IMAGERY_5             = 248,
    EFFECT_DEDICATION            = 249,
    EFFECT_EF_BADGE              = 250,
    EFFECT_FOOD                  = 251,
    EFFECT_MOUNTED               = 252,
    EFFECT_SIGNET                = 253,
    EFFECT_BATTLEFIELD           = 254,
    EFFECT_NONE                  = 255,
    EFFECT_SANCTION              = 256,
    EFFECT_BESIEGED              = 257,
    EFFECT_ILLUSION              = 258,
    EFFECT_ENCUMBRANCE           = 259,
    EFFECT_OBLIVISCENCE          = 260,
    EFFECT_IMPAIRMENT            = 261,
    EFFECT_OMERTA                = 262,
    EFFECT_DEBILITATION          = 263,
    EFFECT_PATHOS                = 264,
    EFFECT_FLURRY                = 265,
    EFFECT_CONCENTRATION         = 266,
    EFFECT_ALLIED_TAGS           = 267,
    EFFECT_SIGIL                 = 268,
    EFFECT_LEVEL_SYNC            = 269,
    EFFECT_AFTERMATH_LV1         = 270,
    EFFECT_AFTERMATH_LV2         = 271,
    EFFECT_AFTERMATH_LV3         = 272,
    EFFECT_AFTERMATH             = 273,
    EFFECT_ENLIGHT               = 274,
    EFFECT_AUSPICE               = 275,
    EFFECT_CONFRONTATION         = 276,
    EFFECT_ENFIRE_II             = 277,
    EFFECT_ENBLIZZARD_II         = 278,
    EFFECT_ENAERO_II             = 279,
    EFFECT_ENSTONE_II            = 280,
    EFFECT_ENTHUNDER_II          = 281,
    EFFECT_ENWATER_II            = 282,
    EFFECT_PERFECT_DEFENSE       = 283,
    EFFECT_EGG                   = 284,
    EFFECT_VISITANT              = 285,
    EFFECT_BARAMNESIA            = 286,
    EFFECT_ATMA                  = 287,
    EFFECT_ENDARK                = 288,
    EFFECT_ENMITY_BOOST          = 289,
    EFFECT_SUBTLE_BLOW_PLUS      = 290,
    EFFECT_ENMITY_DOWN           = 291,
    EFFECT_PENNANT               = 292,
    EFFECT_NEGATE_PETRIFY        = 293,
    EFFECT_NEGATE_TERROR         = 294,
    EFFECT_NEGATE_AMNESIA        = 295,
    EFFECT_NEGATE_DOOM           = 296,
    EFFECT_NEGATE_POISON         = 297,
    EFFECT_CRIT_HIT_EVASION_DOWN = 298,
    EFFECT_OVERLOAD              = 299,
    EFFECT_FIRE_MANEUVER         = 300,
    EFFECT_ICE_MANEUVER          = 301,
    EFFECT_WIND_MANEUVER         = 302,
    EFFECT_EARTH_MANEUVER        = 303,
    EFFECT_THUNDER_MANEUVER      = 304,
    EFFECT_WATER_MANEUVER        = 305,
    EFFECT_LIGHT_MANEUVER        = 306,
    EFFECT_DARK_MANEUVER         = 307,
    EFFECT_DOUBLE_UP_CHANCE      = 308,
    EFFECT_BUST                  = 309,
    EFFECT_FIGHTERS_ROLL         = 310,
    EFFECT_MONKS_ROLL            = 311,
    EFFECT_HEALERS_ROLL          = 312,
    EFFECT_WIZARDS_ROLL          = 313,
    EFFECT_WARLOCKS_ROLL         = 314,
    EFFECT_ROGUES_ROLL           = 315,
    EFFECT_GALLANTS_ROLL         = 316,
    EFFECT_CHAOS_ROLL            = 317,
    EFFECT_BEAST_ROLL            = 318,
    EFFECT_CHORAL_ROLL           = 319,
    EFFECT_HUNTERS_ROLL          = 320,
    EFFECT_SAMURAI_ROLL          = 321,
    EFFECT_NINJA_ROLL            = 322,
    EFFECT_DRACHEN_ROLL          = 323,
    EFFECT_EVOKERS_ROLL          = 324,
    EFFECT_MAGUSS_ROLL           = 325,
    EFFECT_CORSAIRS_ROLL         = 326,
    EFFECT_PUPPET_ROLL           = 327,
    EFFECT_DANCERS_ROLL          = 328,
    EFFECT_SCHOLARS_ROLL         = 329,
    EFFECT_BOLTERS_ROLL          = 330,
    EFFECT_CASTERS_ROLL          = 331,
    EFFECT_COURSERS_ROLL         = 332,
    EFFECT_BLITZERS_ROLL         = 333,
    EFFECT_TACTICIANS_ROLL       = 334,
    EFFECT_ALLIES_ROLL           = 335,
    EFFECT_MISERS_ROLL           = 336,
    EFFECT_COMPANIONS_ROLL       = 337,
    EFFECT_AVENGERS_ROLL         = 338,
    EFFECT_NATURALISTS_ROLL      = 339,
    EFFECT_WARRIORS_CHARGE       = 340,
    EFFECT_FORMLESS_STRIKES      = 341,
    EFFECT_ASSASSINS_CHARGE      = 342,
    EFFECT_FEINT                 = 343,
    EFFECT_FEALTY                = 344,
    EFFECT_DARK_SEAL             = 345,
    EFFECT_DIABOLIC_EYE          = 346,
    EFFECT_NIGHTINGALE           = 347,
    EFFECT_TROUBADOUR            = 348,
    EFFECT_KILLER_INSTINCT       = 349,
    EFFECT_STEALTH_SHOT          = 350,
    EFFECT_FLASHY_SHOT           = 351,
    EFFECT_SANGE                 = 352,
    EFFECT_HASSO                 = 353,
    EFFECT_SEIGAN                = 354,
    EFFECT_CONVERGENCE           = 355,
    EFFECT_DIFFUSION             = 356,
    EFFECT_SNAKE_EYE             = 357,
    EFFECT_LIGHT_ARTS            = 358,
    EFFECT_DARK_ARTS             = 359,
    EFFECT_PENURY                = 360,
    EFFECT_PARSIMONY             = 361,
    EFFECT_CELERITY              = 362,
    EFFECT_ALACRITY              = 363,
    EFFECT_RAPTURE               = 364,
    EFFECT_EBULLIENCE            = 365,
    EFFECT_ACCESSION             = 366,
    EFFECT_MANIFESTATION         = 367,
    EFFECT_DRAIN_SAMBA           = 368,
    EFFECT_ASPIR_SAMBA           = 369,
    EFFECT_HASTE_SAMBA           = 370,
    EFFECT_VELOCITY_SHOT         = 371,
    EFFECT_BUILDING_FLOURISH     = 375,
    EFFECT_TRANCE                = 376,
    EFFECT_TABULA_RASA           = 377,
    EFFECT_DRAIN_DAZE            = 378,
    EFFECT_ASPIR_DAZE            = 379,
    EFFECT_HASTE_DAZE            = 380,
    EFFECT_FINISHING_MOVE_1      = 381,
    EFFECT_FINISHING_MOVE_2      = 382,
    EFFECT_FINISHING_MOVE_3      = 383,
    EFFECT_FINISHING_MOVE_4      = 384,
    EFFECT_FINISHING_MOVE_5      = 385,
    EFFECT_LETHARGIC_DAZE_1      = 386,
    EFFECT_LETHARGIC_DAZE_2      = 387,
    EFFECT_LETHARGIC_DAZE_3      = 388,
    EFFECT_LETHARGIC_DAZE_4      = 389,
    EFFECT_LETHARGIC_DAZE_5      = 390,
    EFFECT_SLUGGISH_DAZE_1       = 391,
    EFFECT_SLUGGISH_DAZE_2       = 392,
    EFFECT_SLUGGISH_DAZE_3       = 393,
    EFFECT_SLUGGISH_DAZE_4       = 394,
    EFFECT_SLUGGISH_DAZE_5       = 395,
    EFFECT_WEAKENED_DAZE_1       = 396,
    EFFECT_WEAKENED_DAZE_2       = 397,
    EFFECT_WEAKENED_DAZE_3       = 398,
    EFFECT_WEAKENED_DAZE_4       = 399,
    EFFECT_WEAKENED_DAZE_5       = 400,
    EFFECT_ADDENDUM_WHITE        = 401,
    EFFECT_ADDENDUM_BLACK        = 402,
    EFFECT_REPRISAL              = 403,
    EFFECT_MAGIC_EVASION_DOWN    = 404,
    EFFECT_RETALIATION           = 405,
    EFFECT_FOOTWORK              = 406,
    EFFECT_KLIMAFORM             = 407,
    EFFECT_SEKKANOKI             = 408,
    EFFECT_PIANISSIMO            = 409,
    EFFECT_SABER_DANCE           = 410,
    EFFECT_FAN_DANCE             = 411,
    EFFECT_ALTRUISM              = 412,
    EFFECT_FOCALIZATION          = 413,
    EFFECT_TRANQUILITY           = 414,
    EFFECT_EQUANIMITY            = 415,
    EFFECT_ENLIGHTENMENT         = 416,
    EFFECT_AFFLATUS_SOLACE       = 417,
    EFFECT_AFFLATUS_MISERY       = 418,
    EFFECT_COMPOSURE             = 419,
    EFFECT_YONIN                 = 420,
    EFFECT_INNIN                 = 421,
    EFFECT_CARBUNCLES_FAVOR      = 422,
    EFFECT_IFRITS_FAVOR          = 423,
    EFFECT_SHIVAS_FAVOR          = 424,
    EFFECT_GARUDAS_FAVOR         = 425,
    EFFECT_TITANS_FAVOR          = 426,
    EFFECT_RAMUHS_FAVOR          = 427,
    EFFECT_LEVIATHANS_FAVOR      = 428,
    EFFECT_FENRIRS_FAVOR         = 429,
    EFFECT_DIABOLOSS_FAVOR       = 430,
    EFFECT_AVATARS_FAVOR         = 431,
    EFFECT_MULTI_STRIKES         = 432,
    EFFECT_DOUBLE_SHOT           = 433,
    EFFECT_TRANSCENDENCY         = 434,
    EFFECT_RESTRAINT             = 435,
    EFFECT_PERFECT_COUNTER       = 436,
    EFFECT_MANA_WALL             = 437,
    EFFECT_DIVINE_EMBLEM         = 438,
    EFFECT_NETHER_VOID           = 439,
    EFFECT_SENGIKORI             = 440,
    EFFECT_FUTAE                 = 441,
    EFFECT_PRESTO                = 442,
    EFFECT_CLIMACTIC_FLOURISH    = 443,
    EFFECT_COPY_IMAGE_2          = 444,
    EFFECT_COPY_IMAGE_3          = 445,
    EFFECT_COPY_IMAGE_4          = 446,
    EFFECT_MULTI_SHOTS           = 447,
    EFFECT_BEWILDERED_DAZE_1     = 448,
    EFFECT_BEWILDERED_DAZE_2     = 449,
    EFFECT_BEWILDERED_DAZE_3     = 450,
    EFFECT_BEWILDERED_DAZE_4     = 451,
    EFFECT_BEWILDERED_DAZE_5     = 452,
    EFFECT_DIVINE_CARESS_1       = 453,
    EFFECT_SABOTEUR              = 454,
    EFFECT_TENUTO                = 455,
    EFFECT_SPUR                  = 456,
    EFFECT_EFFLUX                = 457,
    EFFECT_EARTHEN_ARMOR         = 458,
    EFFECT_DIVINE_CARESS_2       = 459,
    EFFECT_BLOOD_RAGE            = 460,
    EFFECT_IMPETUS               = 461,
    EFFECT_CONSPIRATOR           = 462,
    EFFECT_SEPULCHER             = 463,
    EFFECT_ARCANE_CREST          = 464,
    EFFECT_HAMANOHA              = 465,
    EFFECT_DRAGON_BREAKER        = 466,
    EFFECT_TRIPLE_SHOT           = 467,
    EFFECT_STRIKING_FLOURISH     = 468,
    EFFECT_PERPETUANCE           = 469,
    EFFECT_IMMANENCE             = 470,
    EFFECT_MIGAWARI              = 471,
    EFFECT_TERNARY_FLOURISH      = 472, // DNC 93
    EFFECT_MUDDLE                = 473, // MOB EFFECT
    EFFECT_PROWESS               = 474, // GROUNDS OF VALOR
    EFFECT_VOIDWATCHER           = 475, // VOIDWATCH
    EFFECT_ENSPHERE              = 476, // SPHERE
    EFFECT_SACROSANCTITY         = 477, // WHM 95
    EFFECT_PALISADE              = 478, // PLD 95
    EFFECT_SCARLET_DELIRIUM      = 479, // DRK 95
    EFFECT_SCARLET_DELIRIUM_1    = 480, // DRK 95
    // EFFECT_NONE                      = 481, // NONE
    EFFECT_DECOY_SHOT         = 482, // RNG 95
    EFFECT_HAGAKURE           = 483, // SAM 95
    EFFECT_ISSEKIGAN          = 484, // NIN 95
    EFFECT_UNBRIDLED_LEARNING = 485, // BLU 95
    EFFECT_COUNTER_BOOST      = 486, //
    EFFECT_ENDRAIN            = 487, // FENRIR 96
    EFFECT_ENASPIR            = 488, // FENRIR 96
    EFFECT_AFTERGLOW          = 489, // WS AFTEREFFECT
    EFFECT_BRAZEN_RUSH        = 490, //
    EFFECT_INNER_STRENGTH     = 491,
    EFFECT_ASYLUM             = 492,
    EFFECT_SUBTLE_SORCERY     = 493,
    EFFECT_STYMIE             = 494,
    // EFFECT_NONE                     = 495,
    EFFECT_INTERVENE        = 496,
    EFFECT_SOUL_ENSLAVEMENT = 497,
    EFFECT_UNLEASH          = 498,
    EFFECT_CLARION_CALL     = 499,
    EFFECT_OVERKILL         = 500,
    EFFECT_YAEGASUMI        = 501,
    EFFECT_MIKAGE           = 502,
    EFFECT_FLY_HIGH         = 503,
    EFFECT_ASTRAL_CONDUIT   = 504,
    EFFECT_UNBRIDLED_WISDOM = 505,
    // EFFECT_NONE                     = 506,
    EFFECT_GRAND_PAS          = 507,
    EFFECT_WIDENED_COMPASS    = 508,
    EFFECT_ODYLLIC_SUBTERFUGE = 509,
    EFFECT_ERGON_MIGHT        = 510,
    EFFECT_REIVE_MARK         = 511,
    EFFECT_IONIS              = 512,
    EFFECT_BOLSTER            = 513,
    // EFFECT_NONE                     = 514,
    EFFECT_LASTING_EMANATION  = 515,
    EFFECT_ECLIPTIC_ATTRITION = 516,
    EFFECT_COLLIMATED_FERVOR  = 517,
    EFFECT_DEMATERIALIZE      = 518,
    EFFECT_THEURGIC_FOCUS     = 519,
    // EFFECT_NONE                     = 520,
    // EFFECT_NONE                     = 521,
    EFFECT_ELEMENTAL_SFORZO        = 522,
    EFFECT_IGNIS                   = 523,
    EFFECT_GELUS                   = 524,
    EFFECT_FLABRA                  = 525,
    EFFECT_TELLUS                  = 526,
    EFFECT_SULPOR                  = 527,
    EFFECT_UNDA                    = 528,
    EFFECT_LUX                     = 529,
    EFFECT_TENEBRAE                = 530,
    EFFECT_VALLATION               = 531,
    EFFECT_SWORDPLAY               = 532,
    EFFECT_PFLUG                   = 533,
    EFFECT_EMBOLDEN                = 534,
    EFFECT_VALIANCE                = 535,
    EFFECT_GAMBIT                  = 536,
    EFFECT_LIEMENT                 = 537,
    EFFECT_ONE_FOR_ALL             = 538,
    EFFECT_GEO_REGEN               = 539,
    EFFECT_GEO_POISON              = 540,
    EFFECT_GEO_REFRESH             = 541,
    EFFECT_GEO_STR_BOOST           = 542,
    EFFECT_GEO_DEX_BOOST           = 543,
    EFFECT_GEO_VIT_BOOST           = 544,
    EFFECT_GEO_AGI_BOOST           = 545,
    EFFECT_GEO_INT_BOOST           = 546,
    EFFECT_GEO_MND_BOOST           = 547,
    EFFECT_GEO_CHR_BOOST           = 548,
    EFFECT_GEO_ATTACK_BOOST        = 549,
    EFFECT_GEO_DEFENSE_BOOST       = 550,
    EFFECT_GEO_MAGIC_ATK_BOOST     = 551,
    EFFECT_GEO_MAGIC_DEF_BOOST     = 552,
    EFFECT_GEO_ACCURACY_BOOST      = 553,
    EFFECT_GEO_EVASION_BOOST       = 554,
    EFFECT_GEO_MAGIC_ACC_BOOST     = 555,
    EFFECT_GEO_MAGIC_EVASION_BOOST = 556,
    EFFECT_GEO_ATTACK_DOWN         = 557,
    EFFECT_GEO_DEFENSE_DOWN        = 558,
    EFFECT_GEO_MAGIC_ATK_DOWN      = 559,
    EFFECT_GEO_MAGIC_DEF_DOWN      = 560,
    EFFECT_GEO_ACCURACY_DOWN       = 561,
    EFFECT_GEO_EVASION_DOWN        = 562,
    EFFECT_GEO_MAGIC_ACC_DOWN      = 563,
    EFFECT_GEO_MAGIC_EVASION_DOWN  = 564,
    EFFECT_GEO_SLOW                = 565,
    EFFECT_GEO_PARALYSIS           = 566,
    EFFECT_GEO_WEIGHT              = 567,
    EFFECT_FOIL                    = 568,
    EFFECT_BLAZE_OF_GLORY          = 569,
    EFFECT_BATTUTA                 = 570,
    EFFECT_RAYKE                   = 571,
    EFFECT_AVOIDANCE_DOWN          = 572,
    EFFECT_DELUGE_SPIKES           = 573,
    EFFECT_FAST_CAST               = 574,
    EFFECT_GESTATION               = 575,
    EFFECT_DOUBT                   = 576, // Bully: Intimidation Enfeeble status
    EFFECT_CAIT_SITHS_FAVOR        = 577,
    EFFECT_FISHY_INTUITION         = 578,
    EFFECT_COMMITMENT              = 579,
    EFFECT_GEO_HASTE               = 580,
    EFFECT_FLURRY_II               = 581,
    EFFECT_APOGEE                  = 583,
    EFFECT_ENTRUST                 = 584,
    EFFECT_COSTUME_II              = 585,
    EFFECT_CURING_CONDUIT          = 586,
    EFFECT_TP_BONUS                = 587,
    EFFECT_FINISHING_MOVE_6        = 588,
    EFFECT_FIRESTORM_II            = 589,
    EFFECT_HAILSTORM_II            = 590,
    EFFECT_WINDSTORM_II            = 591,
    EFFECT_SANDSTORM_II            = 592,
    EFFECT_THUNDERSTORM_II         = 593,
    EFFECT_RAINSTORM_II            = 594,
    EFFECT_AURORASTORM_II          = 595,
    EFFECT_VOIDSTORM_II            = 596,
    EFFECT_INUNDATION              = 597,
    EFFECT_CASCADE                 = 598,
    EFFECT_CONSUME_MANA            = 599,
    EFFECT_RUNEISTS_ROLL           = 600,
    EFFECT_CROOKED_CARDS           = 601,
    EFFECT_VORSEAL                 = 602,
    EFFECT_ELVORSEAL               = 603,
    EFFECT_MIGHTY_GUARD            = 604,
    EFFECT_GALE_SPIKES             = 605,
    EFFECT_CLOD_SPIKES             = 606,
    EFFECT_GLINT_SPIKES            = 607,
    EFFECT_NEGATE_VIRUS            = 608,
    EFFECT_NEGATE_CURSE            = 609,
    EFFECT_NEGATE_CHARM            = 610,
    EFFECT_MAGIC_EVASION_BOOST_II  = 611,
    EFFECT_COLURE_ACTIVE           = 612,
    EFFECT_MUMORS_RADIANCE         = 613,
    EFFECT_ULLEGORES_GLOOM         = 614,
    EFFECT_BOOST_II                = 615,
    EFFECT_ARTISANAL_KNOWLEDGE     = 616,
    EFFECT_SACRIFICE               = 617,
    EFFECT_EMPOROXS_GIFT           = 618,
    EFFECT_SPIRIT_BOND             = 619,
    EFFECT_AWAKEN                  = 620,
    EFFECT_MAJESTY                 = 621,
    EFFECT_GUARDING_RATE_BOOST     = 622,
    EFFECT_RAMPART                 = 623,
    EFFECT_WINDS_BLESSING          = 624,
    EFFECT_SIRENS_FAVOR            = 625,
    EFFECT_NEGATE_SLEEP            = 626,
    EFFECT_MOBILIZATION            = 627,
    EFFECT_HOVER_SHOT              = 628,
    EFFECT_MOOGLE_AMPLIFIER        = 629,

    // Effect icons in packet can go from 0-767, so no custom effects should go in that range.

    // Purchased from Cruor Prospector
    EFFECT_ABYSSEA_STR = 768,
    EFFECT_ABYSSEA_DEX = 769,
    EFFECT_ABYSSEA_VIT = 770,
    EFFECT_ABYSSEA_AGI = 771,
    EFFECT_ABYSSEA_INT = 772,
    EFFECT_ABYSSEA_MND = 773,
    EFFECT_ABYSSEA_CHR = 774,
    EFFECT_ABYSSEA_HP  = 775,
    EFFECT_ABYSSEA_MP  = 776,

    // *Prowess increases not currently retail accurate.
    // GoV Prowess bonus effects, real effect at ID 474
    EFFECT_PROWESS_CASKET_RATE   = 777, // (Unimplemented)
    EFFECT_PROWESS_SKILL_RATE    = 778, // (Unimplemented)
    EFFECT_PROWESS_CRYSTAL_YIELD = 779, // (Unimplemented)
    EFFECT_PROWESS_TH            = 780, // +1 per tier
    EFFECT_PROWESS_ATTACK_SPEED  = 781, // *flat 4% for now
    EFFECT_PROWESS_HP_MP         = 782, // Base 3% and another 1% per tier.
    EFFECT_PROWESS_ACC_RACC      = 783, // *flat 4% for now
    EFFECT_PROWESS_ATT_RATT      = 784, // *flat 4% for now
    EFFECT_PROWESS_MACC_MATK     = 785, // *flat 4% for now
    EFFECT_PROWESS_CURE_POTENCY  = 786, // *flat 4% for now
    EFFECT_PROWESS_WS_DMG        = 787, // (Unimplemented) 2% per tier.
    EFFECT_PROWESS_KILLER        = 788, // *flat +4 for now
    // End GoV Prowess fakery
    EFFECT_FIELD_SUPPORT_FOOD  = 789, // Used by Fov/GoV food buff.
    EFFECT_MARK_OF_SEED        = 790, // Tracks 30 min timer in ACP mission "Those Who Lurk in Shadows (II)"
    EFFECT_ALL_MISS            = 791, // All attacks miss (ie - Tiamat while flying)
    EFFECT_SUPER_BUFF          = 792, // Boss buff (ie - Nidhogg "2hour")
    EFFECT_NINJUTSU_ELE_DEBUFF = 793,
    EFFECT_HEALING             = 794,
    EFFECT_LEAVEGAME           = 795,
    EFFECT_HASTE_SAMBA_HASTE   = 796, // Small JA Haste given by Haste Samba on hit
    EFFECT_TELEPORT            = 797,
    EFFECT_CHAINBOUND          = 798,
    EFFECT_SKILLCHAIN          = 799,
    EFFECT_DYNAMIS             = 800,
    EFFECT_MEDITATE            = 801, // Dummy effect for SAM Meditate JA
    EFFECT_ELEMENTALRES_DOWN   = 802, // Elemental resistance down
    EFFECT_FULL_SPEED_AHEAD    = 803, // Used to track Full Speed Ahead quest minigame
    // EFFECT_PLACEHOLDER           = 804  // Description
    // 804-1022
    // EFFECT_PLACEHOLDER           = 1023 // The client dat file seems to have only this many "slots", results of exceeding that are untested.
};

#define MAX_EFFECTID 804 // 768 real + 32 custom

/************************************************************************
 *                                                                       *
 *  Нерешенные задачи:                                                   *
 *                                                                       *
 *  - сохранение ID сущности, добавившей эффект                          *
 *  - обновление эффекта (например перезапись protect 1 на protect 2)    *
 *                                                                       *
 ************************************************************************/

class CBattleEntity;

class CStatusEffect
{
public:
    EFFECT GetStatusID();
    uint32 GetSubID() const;
    uint16 GetIcon() const;
    uint16 GetPower() const;
    uint16 GetSubPower() const;
    uint16 GetTier() const;
    uint32 GetFlag() const;
    uint16 GetType() const;
    uint8  GetSlot() const;

    uint32         GetTickTime() const;
    uint32         GetDuration() const;
    int            GetElapsedTickCount() const;
    time_point     GetStartTime();
    CBattleEntity* GetOwner();

    void SetFlag(uint32 Flag);
    void UnsetFlag(uint32 Flag);
    void SetType(uint16 Type);
    void SetSlot(uint8 Slot);
    void SetIcon(uint16 Icon);
    void SetPower(uint16 Power);
    void SetSubPower(uint16 subPower);
    void SetTier(uint16 tier);
    void SetDuration(uint32 Duration);
    void SetOwner(CBattleEntity* Owner);
    void SetTickTime(uint32 tick);

    void IncrementElapsedTickCount();
    void SetStartTime(time_point StartTime);

    void addMod(Mod modType, int16 amount);

    void SetName(string_t name);
    void SetName(const int8* name);

    const int8* GetName();

    std::vector<CModifier> modList; // список модификаторов
    bool                   deleted{ false };

    CStatusEffect(EFFECT id, uint16 icon, uint16 power, uint32 tick, uint32 duration, uint32 subid = 0, uint16 subPower = 0, uint16 tier = 0, uint32 flags = 0);

    ~CStatusEffect();

private:
    CBattleEntity* m_POwner{ nullptr }; // владелец

    EFFECT m_StatusID{ EFFECT_NONE }; // основной тип эффекта
    uint32 m_SubID{ 0 };              // дополнительный тип эффекта
    uint16 m_Icon{ 0 };               // иконка эффекта
    uint16 m_Power{ 0 };              // сила эффекта
    uint16 m_SubPower{ 0 };           // Secondary power of the effect
    uint16 m_Tier{ 0 };               // Tier of the effect
    uint32 m_Flag{ 0 };               // флаг эффекта (условия его исчезновения)
    uint16 m_Type{ 0 };               // used to enforce only one
    uint8  m_Slot{ 0 };               // used to determine slot order for songs/rolls

    uint32     m_TickTime{ 0 };  // время повторения эффекта (млс)
    uint32     m_Duration{ 0 };  // продолжительность эффекта (млс)
    time_point m_StartTime;      // время получения эффекта (млс)
    int        m_tickCount{ 0 }; // премя последнего выполнения эффекта (млс)

    string_t m_Name; // имя эффекта для скриптов
};

#endif
