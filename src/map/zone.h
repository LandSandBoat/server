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

#ifndef _CZONE_H
#define _CZONE_H

#include "common/cbasetypes.h"
#include "common/mmo.h"
#include "common/taskmgr.h"
#include "common/vana_time.h"

#include <list>
#include <map>
#include <unordered_map>

#include "battlefield_handler.h"
#include "campaign_handler.h"
#include "los/zone_los.h"
#include "navmesh.h"
#include "packets/weather.h"
#include "trigger_area.h"

enum ZONEID : uint16
{
    // Note: "residential zones" aren't really zones of their own.
    // It's more of a sub zone - the dats for messages and entities will all be from the zone you entered from.
    ZONE_MONORAIL_PRE_RELEASE           = 0, // Old Tech Demonstration zone from pre-release (aka "the monorail place")
    ZONE_PHANAUET_CHANNEL               = 1,
    ZONE_CARPENTERS_LANDING             = 2,
    ZONE_MANACLIPPER                    = 3,
    ZONE_BIBIKI_BAY                     = 4,
    ZONE_ULEGUERAND_RANGE               = 5,
    ZONE_BEARCLAW_PINNACLE              = 6,
    ZONE_ATTOHWA_CHASM                  = 7,
    ZONE_BONEYARD_GULLY                 = 8,
    ZONE_PSOXJA                         = 9,
    ZONE_THE_SHROUDED_MAW               = 10,
    ZONE_OLDTON_MOVALPOLOS              = 11,
    ZONE_NEWTON_MOVALPOLOS              = 12,
    ZONE_MINE_SHAFT_2716                = 13,
    ZONE_HALL_OF_TRANSFERENCE           = 14,
    ZONE_ABYSSEA_KONSCHTAT              = 15,
    ZONE_PROMYVION_HOLLA                = 16,
    ZONE_SPIRE_OF_HOLLA                 = 17,
    ZONE_PROMYVION_DEM                  = 18,
    ZONE_SPIRE_OF_DEM                   = 19,
    ZONE_PROMYVION_MEA                  = 20,
    ZONE_SPIRE_OF_MEA                   = 21,
    ZONE_PROMYVION_VAHZL                = 22,
    ZONE_SPIRE_OF_VAHZL                 = 23,
    ZONE_LUFAISE_MEADOWS                = 24,
    ZONE_MISAREAUX_COAST                = 25,
    ZONE_TAVNAZIAN_SAFEHOLD             = 26,
    ZONE_PHOMIUNA_AQUEDUCTS             = 27,
    ZONE_SACRARIUM                      = 28,
    ZONE_RIVERNE_SITE_B01               = 29,
    ZONE_RIVERNE_SITE_A01               = 30,
    ZONE_MONARCH_LINN                   = 31,
    ZONE_SEALIONS_DEN                   = 32,
    ZONE_ALTAIEU                        = 33,
    ZONE_GRAND_PALACE_OF_HUXZOI         = 34,
    ZONE_THE_GARDEN_OF_RUHMET           = 35,
    ZONE_EMPYREAL_PARADOX               = 36,
    ZONE_TEMENOS                        = 37,
    ZONE_APOLLYON                       = 38,
    ZONE_DYNAMIS_VALKURM                = 39,
    ZONE_DYNAMIS_BUBURIMU               = 40,
    ZONE_DYNAMIS_QUFIM                  = 41,
    ZONE_DYNAMIS_TAVNAZIA               = 42,
    ZONE_DIORAMA_ABDHALJS_GHELSBA       = 43,
    ZONE_ABDHALJS_ISLE_PURGONORGO       = 44,
    ZONE_ABYSSEA_TAHRONGI               = 45,
    ZONE_OPEN_SEA_ROUTE_TO_AL_ZAHBI     = 46,
    ZONE_OPEN_SEA_ROUTE_TO_MHAURA       = 47,
    ZONE_AL_ZAHBI                       = 48,
    ZONE_49                             = 49, // GM Grid test zone
    ZONE_AHT_URHGAN_WHITEGATE           = 50,
    ZONE_WAJAOM_WOODLANDS               = 51,
    ZONE_BHAFLAU_THICKETS               = 52,
    ZONE_NASHMAU                        = 53,
    ZONE_ARRAPAGO_REEF                  = 54,
    ZONE_ILRUSI_ATOLL                   = 55,
    ZONE_PERIQIA                        = 56,
    ZONE_TALACCA_COVE                   = 57,
    ZONE_SILVER_SEA_ROUTE_TO_NASHMAU    = 58,
    ZONE_SILVER_SEA_ROUTE_TO_AL_ZAHBI   = 59,
    ZONE_THE_ASHU_TALIF                 = 60,
    ZONE_MOUNT_ZHAYOLM                  = 61,
    ZONE_HALVUNG                        = 62,
    ZONE_LEBROS_CAVERN                  = 63,
    ZONE_NAVUKGO_EXECUTION_CHAMBER      = 64,
    ZONE_MAMOOK                         = 65,
    ZONE_MAMOOL_JA_TRAINING_GROUNDS     = 66,
    ZONE_JADE_SEPULCHER                 = 67,
    ZONE_AYDEEWA_SUBTERRANE             = 68,
    ZONE_LEUJAOAM_SANCTUM               = 69,
    ZONE_CHOCOBO_CIRCUIT                = 70,
    ZONE_THE_COLOSSEUM                  = 71,
    ZONE_ALZADAAL_UNDERSEA_RUINS        = 72,
    ZONE_ZHAYOLM_REMNANTS               = 73,
    ZONE_ARRAPAGO_REMNANTS              = 74,
    ZONE_BHAFLAU_REMNANTS               = 75,
    ZONE_SILVER_SEA_REMNANTS            = 76,
    ZONE_NYZUL_ISLE                     = 77,
    ZONE_HAZHALM_TESTING_GROUNDS        = 78,
    ZONE_CAEDARVA_MIRE                  = 79,
    ZONE_SOUTHERN_SAN_DORIA_S           = 80,
    ZONE_EAST_RONFAURE_S                = 81,
    ZONE_JUGNER_FOREST_S                = 82,
    ZONE_VUNKERL_INLET_S                = 83,
    ZONE_BATALLIA_DOWNS_S               = 84,
    ZONE_LA_VAULE_S                     = 85,
    ZONE_EVERBLOOM_HOLLOW               = 86,
    ZONE_BASTOK_MARKETS_S               = 87,
    ZONE_NORTH_GUSTABERG_S              = 88,
    ZONE_GRAUBERG_S                     = 89,
    ZONE_PASHHOW_MARSHLANDS_S           = 90,
    ZONE_ROLANBERRY_FIELDS_S            = 91,
    ZONE_BEADEAUX_S                     = 92,
    ZONE_RUHOTZ_SILVERMINES             = 93,
    ZONE_WINDURST_WATERS_S              = 94,
    ZONE_WEST_SARUTABARUTA_S            = 95,
    ZONE_FORT_KARUGO_NARUGO_S           = 96,
    ZONE_MERIPHATAUD_MOUNTAINS_S        = 97,
    ZONE_SAUROMUGUE_CHAMPAIGN_S         = 98,
    ZONE_CASTLE_OZTROJA_S               = 99,
    ZONE_WEST_RONFAURE                  = 100,
    ZONE_EAST_RONFAURE                  = 101,
    ZONE_LA_THEINE_PLATEAU              = 102,
    ZONE_VALKURM_DUNES                  = 103,
    ZONE_JUGNER_FOREST                  = 104,
    ZONE_BATALLIA_DOWNS                 = 105,
    ZONE_NORTH_GUSTABERG                = 106,
    ZONE_SOUTH_GUSTABERG                = 107,
    ZONE_KONSCHTAT_HIGHLANDS            = 108,
    ZONE_PASHHOW_MARSHLANDS             = 109,
    ZONE_ROLANBERRY_FIELDS              = 110,
    ZONE_BEAUCEDINE_GLACIER             = 111,
    ZONE_XARCABARD                      = 112,
    ZONE_CAPE_TERIGGAN                  = 113,
    ZONE_EASTERN_ALTEPA_DESERT          = 114,
    ZONE_WEST_SARUTABARUTA              = 115,
    ZONE_EAST_SARUTABARUTA              = 116,
    ZONE_TAHRONGI_CANYON                = 117,
    ZONE_BUBURIMU_PENINSULA             = 118,
    ZONE_MERIPHATAUD_MOUNTAINS          = 119,
    ZONE_SAUROMUGUE_CHAMPAIGN           = 120,
    ZONE_THE_SANCTUARY_OF_ZITAH         = 121,
    ZONE_ROMAEVE                        = 122,
    ZONE_YUHTUNGA_JUNGLE                = 123,
    ZONE_YHOATOR_JUNGLE                 = 124,
    ZONE_WESTERN_ALTEPA_DESERT          = 125,
    ZONE_QUFIM_ISLAND                   = 126,
    ZONE_BEHEMOTHS_DOMINION             = 127,
    ZONE_VALLEY_OF_SORROWS              = 128,
    ZONE_GHOYUS_REVERIE                 = 129,
    ZONE_RUAUN_GARDENS                  = 130,
    ZONE_MORDION_GAOL                   = 131,
    ZONE_ABYSSEA_LA_THEINE              = 132,
    ZONE_OUTER_RAKAZNAR_U2              = 133,
    ZONE_DYNAMIS_BEAUCEDINE             = 134,
    ZONE_DYNAMIS_XARCABARD              = 135,
    ZONE_BEAUCEDINE_GLACIER_S           = 136,
    ZONE_XARCABARD_S                    = 137,
    ZONE_CASTLE_ZVAHL_BAILEYS_S         = 138,
    ZONE_HORLAIS_PEAK                   = 139,
    ZONE_GHELSBA_OUTPOST                = 140,
    ZONE_FORT_GHELSBA                   = 141,
    ZONE_YUGHOTT_GROTTO                 = 142,
    ZONE_PALBOROUGH_MINES               = 143,
    ZONE_WAUGHROON_SHRINE               = 144,
    ZONE_GIDDEUS                        = 145,
    ZONE_BALGAS_DAIS                    = 146,
    ZONE_BEADEAUX                       = 147,
    ZONE_QULUN_DOME                     = 148,
    ZONE_DAVOI                          = 149,
    ZONE_MONASTIC_CAVERN                = 150,
    ZONE_CASTLE_OZTROJA                 = 151,
    ZONE_ALTAR_ROOM                     = 152,
    ZONE_THE_BOYAHDA_TREE               = 153,
    ZONE_DRAGONS_AERY                   = 154,
    ZONE_CASTLE_ZVAHL_KEEP_S            = 155,
    ZONE_THRONE_ROOM_S                  = 156,
    ZONE_MIDDLE_DELKFUTTS_TOWER         = 157,
    ZONE_UPPER_DELKFUTTS_TOWER          = 158,
    ZONE_TEMPLE_OF_UGGALEPIH            = 159,
    ZONE_DEN_OF_RANCOR                  = 160,
    ZONE_CASTLE_ZVAHL_BAILEYS           = 161,
    ZONE_CASTLE_ZVAHL_KEEP              = 162,
    ZONE_SACRIFICIAL_CHAMBER            = 163,
    ZONE_GARLAIGE_CITADEL_S             = 164,
    ZONE_THRONE_ROOM                    = 165,
    ZONE_RANGUEMONT_PASS                = 166,
    ZONE_BOSTAUNIEUX_OUBLIETTE          = 167,
    ZONE_CHAMBER_OF_ORACLES             = 168,
    ZONE_TORAIMARAI_CANAL               = 169,
    ZONE_FULL_MOON_FOUNTAIN             = 170,
    ZONE_CRAWLERS_NEST_S                = 171,
    ZONE_ZERUHN_MINES                   = 172,
    ZONE_KORROLOKA_TUNNEL               = 173,
    ZONE_KUFTAL_TUNNEL                  = 174,
    ZONE_THE_ELDIEME_NECROPOLIS_S       = 175,
    ZONE_SEA_SERPENT_GROTTO             = 176,
    ZONE_VELUGANNON_PALACE              = 177,
    ZONE_THE_SHRINE_OF_RUAVITAU         = 178,
    ZONE_STELLAR_FULCRUM                = 179,
    ZONE_LALOFF_AMPHITHEATER            = 180,
    ZONE_THE_CELESTIAL_NEXUS            = 181,
    ZONE_WALK_OF_ECHOES                 = 182,
    ZONE_MAQUETTE_ABDHALJS_LEGION_A     = 183,
    ZONE_LOWER_DELKFUTTS_TOWER          = 184,
    ZONE_DYNAMIS_SAN_DORIA              = 185,
    ZONE_DYNAMIS_BASTOK                 = 186,
    ZONE_DYNAMIS_WINDURST               = 187,
    ZONE_DYNAMIS_JEUNO                  = 188,
    ZONE_OUTER_RAKAZNAR_U3              = 189,
    ZONE_KING_RANPERRES_TOMB            = 190,
    ZONE_DANGRUF_WADI                   = 191,
    ZONE_INNER_HORUTOTO_RUINS           = 192,
    ZONE_ORDELLES_CAVES                 = 193,
    ZONE_OUTER_HORUTOTO_RUINS           = 194,
    ZONE_THE_ELDIEME_NECROPOLIS         = 195,
    ZONE_GUSGEN_MINES                   = 196,
    ZONE_CRAWLERS_NEST                  = 197,
    ZONE_MAZE_OF_SHAKHRAMI              = 198,
    ZONE_199                            = 199,
    ZONE_GARLAIGE_CITADEL               = 200,
    ZONE_CLOISTER_OF_GALES              = 201,
    ZONE_CLOISTER_OF_STORMS             = 202,
    ZONE_CLOISTER_OF_FROST              = 203,
    ZONE_FEIYIN                         = 204,
    ZONE_IFRITS_CAULDRON                = 205,
    ZONE_QUBIA_ARENA                    = 206,
    ZONE_CLOISTER_OF_FLAMES             = 207,
    ZONE_QUICKSAND_CAVES                = 208,
    ZONE_CLOISTER_OF_TREMORS            = 209,
    ZONE_GM_HOME                        = 210, // Name comes from leaked official documentation
    ZONE_CLOISTER_OF_TIDES              = 211,
    ZONE_GUSTAV_TUNNEL                  = 212,
    ZONE_LABYRINTH_OF_ONZOZO            = 213,
    ZONE_214                            = 214,
    ZONE_ABYSSEA_ATTOHWA                = 215,
    ZONE_ABYSSEA_MISAREAUX              = 216,
    ZONE_ABYSSEA_VUNKERL                = 217,
    ZONE_ABYSSEA_ALTEPA                 = 218,
    ZONE_219                            = 219,
    ZONE_SHIP_BOUND_FOR_SELBINA         = 220,
    ZONE_SHIP_BOUND_FOR_MHAURA          = 221,
    ZONE_PROVENANCE                     = 222,
    ZONE_SAN_DORIA_JEUNO_AIRSHIP        = 223,
    ZONE_BASTOK_JEUNO_AIRSHIP           = 224,
    ZONE_WINDURST_JEUNO_AIRSHIP         = 225,
    ZONE_KAZHAM_JEUNO_AIRSHIP           = 226,
    ZONE_SHIP_BOUND_FOR_SELBINA_PIRATES = 227,
    ZONE_SHIP_BOUND_FOR_MHAURA_PIRATES  = 228,
    ZONE_THRONE_ROOM_V                  = 229,
    ZONE_SOUTHERN_SANDORIA              = 230,
    ZONE_NORTHERN_SANDORIA              = 231,
    ZONE_PORT_SANDORIA                  = 232,
    ZONE_CHATEAU_DORAGUILLE             = 233,
    ZONE_BASTOK_MINES                   = 234,
    ZONE_BASTOK_MARKETS                 = 235,
    ZONE_PORT_BASTOK                    = 236,
    ZONE_METALWORKS                     = 237,
    ZONE_WINDURST_WATERS                = 238,
    ZONE_WINDURST_WALLS                 = 239,
    ZONE_PORT_WINDURST                  = 240,
    ZONE_WINDURST_WOODS                 = 241,
    ZONE_HEAVENS_TOWER                  = 242,
    ZONE_RULUDE_GARDENS                 = 243,
    ZONE_UPPER_JEUNO                    = 244,
    ZONE_LOWER_JEUNO                    = 245,
    ZONE_PORT_JEUNO                     = 246,
    ZONE_RABAO                          = 247,
    ZONE_SELBINA                        = 248,
    ZONE_MHAURA                         = 249,
    ZONE_KAZHAM                         = 250,
    ZONE_HALL_OF_THE_GODS               = 251,
    ZONE_NORG                           = 252,
    ZONE_ABYSSEA_ULEGUERAND             = 253,
    ZONE_ABYSSEA_GRAUBERG               = 254,
    ZONE_ABYSSEA_EMPYREAL_PARADOX       = 255,
    ZONE_WESTERN_ADOULIN                = 256,
    ZONE_EASTERN_ADOULIN                = 257,
    ZONE_RALA_WATERWAYS                 = 258,
    ZONE_RALA_WATERWAYS_U               = 259,
    ZONE_YAHSE_HUNTING_GROUNDS          = 260,
    ZONE_CEIZAK_BATTLEGROUNDS           = 261,
    ZONE_FORET_DE_HENNETIEL             = 262,
    ZONE_YORCIA_WEALD                   = 263,
    ZONE_YORCIA_WEALD_U                 = 264,
    ZONE_MORIMAR_BASALT_FIELDS          = 265,
    ZONE_MARJAMI_RAVINE                 = 266,
    ZONE_KAMIHR_DRIFTS                  = 267,
    ZONE_SIH_GATES                      = 268,
    ZONE_MOH_GATES                      = 269,
    ZONE_CIRDAS_CAVERNS                 = 270,
    ZONE_CIRDAS_CAVERNS_U               = 271,
    ZONE_DHO_GATES                      = 272,
    ZONE_WOH_GATES                      = 273,
    ZONE_OUTER_RAKAZNAR                 = 274,
    ZONE_OUTER_RAKAZNAR_U1              = 275,
    ZONE_RAKAZNAR_INNER_COURT           = 276,
    ZONE_RAKAZNAR_TURRIS                = 277,
    ZONE_GWORA_CORRIDOR                 = 278,
    ZONE_WALK_OF_ECHOES_P2              = 279,
    ZONE_MOG_GARDEN                     = 280,
    ZONE_LEAFALLIA                      = 281,
    ZONE_MOUNT_KAMIHR                   = 282,
    ZONE_SILVER_KNIFE                   = 283,
    ZONE_CELENNIA_MEMORIAL_LIBRARY      = 284,
    ZONE_FERETORY                       = 285,
    ZONE_286                            = 286,
    ZONE_MAQUETTE_ABDHALJS_LEGION_B     = 287,
    ZONE_ESCHA_ZITAH                    = 288,
    ZONE_ESCHA_RUAUN                    = 289,
    ZONE_DESUETIA_EMPYREAL_PARADOX      = 290,
    ZONE_REISENJIMA                     = 291,
    ZONE_REISENJIMA_HENGE               = 292,
    ZONE_REISENJIMA_SANCTORIUM          = 293,
    ZONE_DYNAMIS_SAN_DORIA_D            = 294,
    ZONE_DYNAMIS_BASTOK_D               = 295,
    ZONE_DYNAMIS_WINDURST_D             = 296,
    ZONE_DYNAMIS_JEUNO_D                = 297,
    ZONE_WALK_OF_ECHOES_P1              = 298,
    ZONE_GWORA_THRONE_ROOM              = 299,
    MAX_ZONEID                          = 300,
};
DECLARE_FORMAT_AS_UNDERLYING(ZONEID);

enum NATION_TYPE : uint8
{
    NATION_SANDORIA = 0x00,
    NATION_BASTOK   = 0x01,
    NATION_WINDURST = 0x02,
    NATION_BEASTMEN = 0x03,
    NATION_NEUTRAL  = 0xFF,
};
DECLARE_FORMAT_AS_UNDERLYING(NATION_TYPE);

enum class REGION_TYPE : uint8
{
    RONFAURE         = 0,
    ZULKHEIM         = 1,
    NORVALLEN        = 2,
    GUSTABERG        = 3,
    DERFLAND         = 4,
    SARUTABARUTA     = 5,
    KOLSHUSHU        = 6,
    ARAGONEU         = 7,
    FAUREGANDI       = 8,
    VALDEAUNIA       = 9,
    QUFIMISLAND      = 10,
    LITELOR          = 11,
    KUZOTZ           = 12,
    VOLLBOW          = 13,
    ELSHIMOLOWLANDS  = 14,
    ELSHIMOUPLANDS   = 15,
    TULIA            = 16,
    MOVALPOLOS       = 17,
    TAVNAZIA         = 18,
    SANDORIA         = 19,
    BASTOK           = 20,
    WINDURST         = 21,
    JEUNO            = 22,
    DYNAMIS          = 23,
    TAVNAZIAN_MARQ   = 24,
    PROMYVION        = 25,
    LUMORIA          = 26,
    LIMBUS           = 27,
    WEST_AHT_URHGAN  = 28,
    MAMOOL_JA_SAVAGE = 29,
    HALVUNG          = 30,
    ARRAPAGO         = 31,
    ALZADAAL         = 32,
    RONFAURE_FRONT   = 33,
    NORVALLEN_FRONT  = 34,
    GUSTABERG_FRONT  = 35,
    DERFLAND_FRONT   = 36,
    SARUTA_FRONT     = 37,
    ARAGONEAU_FRONT  = 38,
    FAUREGANDI_FRONT = 39,
    VALDEAUNIA_FRONT = 40,
    ABYSSEA          = 41,
    THE_THRESHOLD    = 42,
    ABDHALJS         = 43,
    ADOULIN_ISLANDS  = 44,
    EAST_ULBUKA      = 45,

    UNKNOWN = 255
};
DECLARE_FORMAT_AS_UNDERLYING(REGION_TYPE);

enum class CONTINENT_TYPE : uint8
{
    THE_MIDDLE_LANDS       = 1,
    THE_ARADJIAH_CONTINENT = 2,
    THE_SHADOWREIGN_ERA    = 3,
    OTHER_AREAS            = 4
};
DECLARE_FORMAT_AS_UNDERLYING(CONTINENT_TYPE);

enum ZONE_TYPE : uint16
{
    UNKNOWN   = 0x0000,
    CITY      = 0x0001,
    OUTDOORS  = 0x0002,
    DUNGEON   = 0x0004,
    SIGNET    = 0x0008,
    SANCTION  = 0x0010, // 16
    SIGIL     = 0x0020, // 32
    IONIS     = 0x0040, // 64
    DYNAMIS   = 0x0080, // 128
    INSTANCED = 0x0100, // 256
};
DECLARE_FORMAT_AS_UNDERLYING(ZONE_TYPE);

enum GLOBAL_MESSAGE_TYPE
{
    CHAR_INRANGE,
    CHAR_INRANGE_SELF,
    CHAR_INSHOUT,
    CHAR_INZONE
};
DECLARE_FORMAT_AS_UNDERLYING(GLOBAL_MESSAGE_TYPE);

enum class TELEPORT_TYPE : uint8
{
    OUTPOST_SANDY   = 0,
    OUTPOST_BASTOK  = 1,
    OUTPOST_WINDY   = 2,
    RUNIC_PORTAL    = 3,
    PAST_MAW        = 4,
    ABYSSEA_CONFLUX = 5,
    CAMPAIGN_SANDY  = 6,
    CAMPAIGN_BASTOK = 7,
    CAMPAIGN_WINDY  = 8,
    HOMEPOINT       = 9,
    SURVIVAL        = 10,
    WAYPOINT        = 11,
    ESCHAN_PORTAL   = 12,
};
DECLARE_FORMAT_AS_UNDERLYING(TELEPORT_TYPE);

enum ZONEMISC
{
    MISC_NONE             = 0x0000, // Able to be used in any area
    MISC_ESCAPE           = 0x0001, // Ability to use Escape Spell
    MISC_FELLOW           = 0x0002, // Ability to summon Fellow NPC
    MISC_MOUNT            = 0x0004, // Ability to use Chocobos and mounts
    MISC_MAZURKA          = 0x0008, // Ability to use Mazurka Spell
    MISC_TRACTOR          = 0x0010, // Ability to use Tractor Spell
    MISC_MOGMENU          = 0x0020, // Ability to communicate with Nomad Moogle (menu access mog house)
    MISC_COSTUME          = 0x0040, // Ability to use a Costumes
    MISC_PET              = 0x0080, // Ability to summon Pets
    MISC_TREASURE         = 0x0100, // Presence in the global zone TreasurePool
    MISC_AH               = 0x0200, // Ability to use the auction house
    MISC_YELL             = 0x0400, // Send and receive /yell commands
    MISC_TRUST            = 0x0800, // Ability to summon Trust NPC
    MISC_LOS_PLAYER_BLOCK = 0x1000, // Players can't use magic/JAs through walls if this is set
    MISC_LOS_OFF          = 0x2000, // Zone should not have LoS checks
};
DECLARE_FORMAT_AS_UNDERLYING(ZONEMISC);

struct zoneMusic_t
{
    uint16 m_songDay;   // music (daytime)
    uint16 m_songNight; // music (nighttime)
    uint16 m_bSongS;    // battle music (solo)
    uint16 m_bSongM;    // battle music (party)
};

struct zoneWeather_t
{
    uint8 normal; // Normal Weather
    uint8 common; // Common Weather
    uint8 rare;   // Rare Weather

    zoneWeather_t(uint8 _normal, uint8 _common, uint8 _rare)
    : normal(_normal)
    , common(_common)
    , rare(_rare){};
};

/************************************************************************
 *                                                                       *
 *  zoneLine - unique identifier of a path from one point in a zone to   *
 *  another point in another zone. The departure area is the area,       *
 *  storing zoneLineID data. Arrival area and exact destination area     *
 *  defined in the structure.                                            *
 *                                                                       *
 ************************************************************************/

struct zoneLine_t
{
    uint32     m_zoneLineID;
    uint16     m_toZone;
    position_t m_toPos;
};

class CBasicPacket;
class CBaseEntity;
class CCharEntity;
class CMobEntity;
class CNpcEntity;
class CPetEntity;
class CBattleEntity;
class CTrustEntity;
class CTreasurePool;
class CZoneEntities;

typedef std::list<std::unique_ptr<ITriggerArea>> triggerAreaList_t;

typedef std::list<zoneLine_t*> zoneLineList_t;

typedef std::map<uint16, zoneWeather_t> weatherVector_t;

typedef std::map<uint16, CBaseEntity*> EntityList_t;

using QueryByNameResult_t = std::vector<CBaseEntity*>;

int32 zone_update_weather(uint32 tick, CTaskMgr::CTask* PTask);

class CZone
{
public:
    DISALLOW_COPY_AND_MOVE(CZone);

    ZONEID             GetID();
    ZONE_TYPE          GetTypeMask();
    REGION_TYPE        GetRegionID();
    CONTINENT_TYPE     GetContinentID();
    uint8              getLevelRestriction();
    uint32             GetIP() const;
    uint16             GetPort() const;
    uint16             GetTax() const;
    WEATHER            GetWeather();
    uint32             GetWeatherChangeTime() const;
    const std::string& getName();
    zoneLine_t*        GetZoneLine(uint32 zoneLineID);

    uint16 GetSoloBattleMusic() const;
    uint16 GetPartyBattleMusic() const;
    uint16 GetBackgroundMusicDay() const;
    uint16 GetBackgroundMusicNight() const;

    void SetSoloBattleMusic(uint16 music);
    void SetPartyBattleMusic(uint16 music);
    void SetBackgroundMusicDay(uint16 music);
    void SetBackgroundMusicNight(uint16 music);

    auto queryEntitiesByName(std::string const& pattern) -> QueryByNameResult_t const&;

    uint32 GetLocalVar(const char* var);
    void   SetLocalVar(const char* var, uint32 val);
    void   ResetLocalVars();

    virtual CCharEntity* GetCharByName(std::string const& name);
    virtual CCharEntity* GetCharByID(uint32 id);

    // Gets an entity - ignores instances (use CBaseEntity->GetEntity if possible)
    virtual CBaseEntity* GetEntity(uint16 targid, uint8 filter = -1); // Get a pointer to any entity in the zone

    bool IsWeatherStatic() const;
    bool CanUseMisc(uint16 misc) const;
    void SetWeather(WEATHER weatherCondition);
    void UpdateWeather();

    virtual void SpawnPCs(CCharEntity* PChar);
    virtual void SpawnMOBs(CCharEntity* PChar);
    virtual void SpawnPETs(CCharEntity* PChar);
    virtual void SpawnNPCs(CCharEntity* PChar);
    virtual void SpawnTRUSTs(CCharEntity* PChar);
    virtual void SpawnConditionalNPCs(CCharEntity* PChar); // Spawn Moogle in Moghouse in zone (if applicable)
    virtual void SpawnTransport(CCharEntity* PChar);       // Spawn ships/boats in the zone
    void         SavePlayTime();

    virtual void WideScan(CCharEntity* PChar, uint16 radius);

    virtual void DecreaseZoneCounter(CCharEntity* PChar); // Remove a character to the zone
    virtual void IncreaseZoneCounter(CCharEntity* PChar); // Add a character from the zone

    virtual void InsertNPC(CBaseEntity* PNpc);
    virtual void InsertMOB(CBaseEntity* PMob);
    virtual void InsertPET(CBaseEntity* PPet);
    virtual void InsertTRUST(CBaseEntity* PTrust);

    virtual void FindPartyForMob(CBaseEntity* PEntity);
    virtual void TransportDepart(uint16 boundary, uint16 zone);  // Collect passengers if ship/boat is departing
    virtual void updateCharLevelRestriction(CCharEntity* PChar); // Removes the character's level restriction. If the zone has a level restriction, it is applied after it is removed.

    void InsertTriggerArea(std::unique_ptr<ITriggerArea>&& triggerArea); // Add an active area to the zone

    virtual void TOTDChange(TIMETYPE TOTD);
    virtual void PushPacket(CBaseEntity*, GLOBAL_MESSAGE_TYPE, const std::unique_ptr<CBasicPacket>&);

    virtual void UpdateEntityPacket(CBaseEntity* PEntity, ENTITYUPDATE type, uint8 updatemask, bool alwaysInclude = false);

    bool           IsZoneActive() const;
    CZoneEntities* GetZoneEntities();

    weatherVector_t m_WeatherVector; // The probability of each weather type

    virtual void ZoneServer(time_point tick);
    virtual void CheckTriggerAreas();

    virtual void ForEachChar(std::function<void(CCharEntity*)> const& func);
    virtual void ForEachCharInstance(CBaseEntity* PEntity, std::function<void(CCharEntity*)> const& func);
    virtual void ForEachMob(std::function<void(CMobEntity*)> const& func);
    virtual void ForEachMobInstance(CBaseEntity* PEntity, std::function<void(CMobEntity*)> const& func);
    virtual void ForEachNpc(std::function<void(CNpcEntity*)> const& func);
    virtual void ForEachNpcInstance(CBaseEntity* PEntity, std::function<void(CNpcEntity*)> const& func);
    virtual void ForEachTrust(std::function<void(CTrustEntity*)> const& func);
    virtual void ForEachTrustInstance(CBaseEntity* PEntity, std::function<void(CTrustEntity*)> const& func);
    virtual void ForEachPet(std::function<void(CPetEntity*)> const& func);
    virtual void ForEachPetInstance(CBaseEntity* PEntity, std::function<void(CPetEntity*)> const& func);
    virtual void ForEachAlly(std::function<void(CMobEntity*)> const& func);
    virtual void ForEachAllyInstance(CBaseEntity* PEntity, std::function<void(CMobEntity*)> const& func);

    CZone(ZONEID ZoneID, REGION_TYPE RegionID, CONTINENT_TYPE ContinentID, uint8 levelRestriction);
    virtual ~CZone();

    CBattlefieldHandler* m_BattlefieldHandler; // BCNM Instances in this zone
    CCampaignHandler*    m_CampaignHandler;    // WOTG campaign information for this zone

    CNavMesh* m_navMesh   = nullptr;
    ZoneLos*  lineOfSight = nullptr;

    time_point m_LoadedAt; // The time the zone was loaded

    void LoadNavMesh();
    void LoadZoneLos();

private:
    ZONEID         m_zoneID;
    ZONE_TYPE      m_zoneType;
    REGION_TYPE    m_regionID;
    CONTINENT_TYPE m_continentID;
    uint8          m_levelRestriction;
    std::string    m_zoneName;
    uint16         m_zonePort{};
    uint32         m_zoneIP{};
    bool           m_useNavMesh;

    WEATHER m_Weather;
    uint32  m_WeatherChangeTime;

    CZoneEntities* m_zoneEntities;

    uint16 m_tax{};
    uint16 m_miscMask{};

    zoneMusic_t m_zoneMusic{};

    std::unordered_map<std::string, uint32> m_LocalVars;

    zoneLineList_t m_zoneLineList;

    void LoadZoneSettings();
    void LoadZoneLines();
    void LoadZoneWeather();

    CTreasurePool* m_TreasurePool;

    time_point m_timeZoneEmpty; // The time point when the last player left the zone

    std::unordered_map<std::string, QueryByNameResult_t> m_queryByNameResults;

protected:
    CTaskMgr::CTask* ZoneTimer; // The pointer to the created timer is Zoneserver.necessary for the possibility of stopping it
    CTaskMgr::CTask* ZoneTimerTriggerAreas;

    triggerAreaList_t m_triggerAreaList;

    void createZoneTimers();
    void CharZoneIn(CCharEntity* PChar);
    void CharZoneOut(CCharEntity* PChar);

    std::unordered_map<std::string, uint32> m_localVars;
};

#endif
