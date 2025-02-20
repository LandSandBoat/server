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

#ifndef _FISHINGUTILS_H
#define _FISHINGUTILS_H

#include "common/cbasetypes.h"
#include "items/item_fish.h"

#include <list>
#include <map>
#include <vector>

struct lsbret_t
{ // lose/snap/break return values
    uint8 failReason;
    uint8 chance;

    lsbret_t()
    : failReason(0)
    , chance(0)
    {
    }
};

struct fishresponse_t
{
    bool     hooked;          // Did we hook anything
    uint8    areaid;          // Area caught in
    uint32   catchid;         // ID of fish/item/monster
    uint8    catchtype;       // fish/item/monster
    uint8    catchlevel;      // level of fish
    uint8    catchdifficulty; // size of fish
    uint8    catchsizeType;   // sizeType of fish - small/large/legendary
    bool     legendary;       // is fish legendary?
    uint8    count;           // how many fish
    uint16   stamina;         // fish stamina/maxhp
    uint16   delay;           // arrow mini-game delay
    uint16   regen;           // how fast fish regens - default 128
    uint16   response;        // fish movement - multiplied by 20
    uint16   attackdmg;       // how much damage a successful arrow causes
    uint16   heal;            // how much fish heals from wrong arrows, drops 30% on discernment/critical bite
    uint16   timelimit;       // how much time you have to catch fish - multiplied by 60
    uint8    sense;           // changes: message received/music/animation
    uint8    hooksense;       // determines which animations/music to play
    uint32   special;         // % chance of getting gold arrows/critical attack
    uint8    successtype;     // Successful hooking type
    uint16   length;          // length of fish
    uint16   weight;          // weight of fish
    uint8    ranking;         // ranking of fish
    bool     epic;            // epic catch
    lsbret_t lose;            // chance of losing
    lsbret_t rbreak;          // chance of break
    lsbret_t lsnap;           // chance of snap
    bool     nm;              // is this an NM
    uint32   nmFlags;         // if NM, it's flags
    uint32   fishingToken;    // fishing token
    uint8    distance;        // distance from player (mob/npc)
    int8     angle;           // angle variation from directly behind (mob/npc)

    fishresponse_t()
    : hooked(false)
    , areaid(0)
    , catchid(0)
    , catchtype(0)
    , catchlevel(0)
    , catchdifficulty(0)
    , catchsizeType(0)
    , legendary(false)
    , count(0)
    , stamina(0)
    , delay(0)
    , regen(0)
    , response(0)
    , attackdmg(0)
    , heal(0)
    , timelimit(0)
    , sense(0)
    , hooksense(0)
    , special(0)
    , successtype(0)
    , length(0)
    , weight(0)
    , ranking(0)
    , epic(false)
    , nm(false)
    , nmFlags(0)
    , fishingToken(0)
    , distance(0)
    , angle(0)
    {
    }
};

struct catchresponse_t
{
    bool   caught;       // Were we able to reel in?
    bool   rodbreak;     // Did our Rod break?
    bool   linebreak;    // Did our Line break?
    uint8  failReason;   // Why did either happen?
    uint32 fishingToken; // fishing token

    catchresponse_t()
    : caught(false)
    , rodbreak(false)
    , linebreak(false)
    , failReason(0)
    , fishingToken(0)
    {
    }
};

struct fish_t
{
    uint16               fishID;          // Fish Item ID
    std::string          fishName;        // Fish Name
    uint8                maxSkill;        // Maximum hook skill level
    uint8                difficulty;      // 'Difficulty' of fish, used for most hook/rod calculations
    uint8                baseDelay;       // base hook arrow delay
    uint8                baseMove;        // base hook movement
    uint8                ranking;         // fish ranking
    uint16               minLength;       // minimum fish length (in lms)
    uint16               maxLength;       // maximum fish length (in lms)
    uint8                sizeType;        // small/large
    uint8                waterType;       // fresh/sea
    uint8                log;             // quest/mission log
    uint8                quest;           // quest/mission id
    uint8                quest_status;    // quest/mission status
    uint32               fishFlags;       // fish flags (half size, tropical, bottom dweller)
    uint8                hourPattern;     // hourly catch pattern
    uint8                moonPattern;     // moonphase catch pattern
    uint8                monthPattern;    // season catch pattern
    bool                 legendary;       // is this a legendary fish? (affects certain rod calcs)
    uint32               legendary_flags; // legendary flags (half fish time)
    bool                 item;            // item/fish
    uint8                maxhook;         // maximum that can be hooked (with sabiki rig)
    uint16               rarity;          // [0-1000] : 0 = not rare, 1 = rarest, 1000 = most common
    uint16               baitPower;       // how strong players current lure attracts fish
    uint16               reqKeyItem;      // required key item
    std::vector<uint16>* reqFish;         // list of required catches
    bool                 quest_only;      // is fish/item quest override only
    bool                 contest;         // is a fish ranking contest fish

    fish_t()
    : fishID(0)
    , maxSkill(0)
    , difficulty(0)
    , baseDelay(0)
    , baseMove(0)
    , ranking(0)
    , minLength(0)
    , maxLength(0)
    , sizeType(0)
    , waterType(0)
    , log(0)
    , quest(0)
    , quest_status(0)
    , fishFlags(0)
    , hourPattern(0)
    , moonPattern(0)
    , monthPattern(0)
    , legendary(false)
    , legendary_flags(0)
    , item(false)
    , maxhook(0)
    , rarity(0)
    , baitPower(0)
    , reqKeyItem(0)
    , reqFish(nullptr)
    , quest_only(false)
    , contest(false)
    {
    }
};

struct rod_t
{
    uint16      rodID;
    std::string rodName;      // Rod Name
    uint8       material;     // Rod Material (wood/synthetic/legendary)
    uint8       sizeType;     // small/large
    uint32      rodFlags;     // Rod Flags (large bonus/small penalty)
    uint16      minRank;      // Min rank
    uint16      maxRank;      // Max rod rank
    uint8       fishAttack;   // Fish Attack Multiplier
    uint8       lgdBonusAtk;  // Legendary Fish Bonus Attack (added to fishAttack on legendary fish)
    uint8       fishRecovery; // Fish Recovery Multiplier
    uint8       fishTime;     // Rod base catch time limit
    uint8       lgdBonusTime; // Legendary fish bonus time.
    uint8       smDelayBonus; // Small fish arrow delay bonus
    uint8       smMoveBonus;  // Small fish movement bonus
    uint8       lgDelayBonus; // Large fish arrow delay bonus
    uint8       lgMoveBonus;  // Large fish movement bonus
    uint8       multiplier;   // muliplier used in time formulas, possibly other things
    bool        breakable;    // Is the rod breakable?
    uint16      brokenRodId;  // Replacement broken rod ID
    bool        isMMM;        // Is Moblin Maze Monger rod? (does crazy stat mods)
    bool        legendary;    // Is Rod Legendary

    rod_t()
    : rodID(0)
    , material(0)
    , sizeType(0)
    , rodFlags(0)
    , minRank(0)
    , maxRank(0)
    , fishAttack(0)
    , lgdBonusAtk(0)
    , fishRecovery(0)
    , fishTime(0)
    , lgdBonusTime(0)
    , smDelayBonus(0)
    , smMoveBonus(0)
    , lgDelayBonus(0)
    , lgMoveBonus(0)
    , multiplier(1)
    , breakable(false)
    , brokenRodId(0)
    , isMMM(false)
    , legendary(false)
    {
    }
};

struct bait_t
{
    uint16      baitID;    // Bait Item ID
    std::string baitName;  // Bait Name
    uint8       baitType;  // Type of bait (stackable bait/lure)
    uint8       maxhook;   // Maximum number of fish bait can hook (sabiki rig can hook up to 3 of certain fish)
    uint32      baitFlags; // Bait Flags (sinking, item bonus)
    bool        losable;   // Can the bait be lost?
    bool        isMMM;     // Is Moblin Maze Monger bait? (probably not special, haven't tested)
    uint8       rankMod;   // How much bonus ranking does bait give rod

    bait_t()
    : baitID(0)
    , baitType(0)
    , maxhook(0)
    , baitFlags(0)
    , losable(false)
    , isMMM(false)
    , rankMod(false)
    {
    }
};

struct fishmob_t
{
    uint32      mobId;      // Monster ID
    std::string mobName;    // Monster Name
    uint8       log;        // Log ID
    uint8       quest;      // Quest ID
    bool        nm;         // Notorious Monster, no need to set for quest monsters
    uint32      nmFlags;    // Notorious Monster flags
    uint8       areaId;     // Can this mob only be fished up from a certain area? i.e. PLD NM
    uint16      rarity;     // [0-1000] : 0 = not rare, 1 = rarest, 1000 = most common
    uint16      minRespawn; // minimum amount of time before mob can be hooked again
    uint16      maxRespawn; // maximum amount of time before mob can be hooked again
    uint8       level;      // level of monster (seem to be intervals of 10)
    uint8       difficulty; // mob difficulty
    uint8       baseDelay;  // base hook arrow delay
    uint8       baseMove;   // base hook movement
    uint16      reqBaitId;  // required bait
    uint16      altBaitId;  // alternative required bait
    uint16      reqKeyItem; // required key item
    uint16      zoneId;     // mob zoneId
    uint16      minLength;  // mob min length
    uint16      maxLength;  // mob max length
    uint8       ranking;
    bool        questOnly; // only fishable during quest

    fishmob_t()
    : mobId(0)
    , log(0)
    , quest(0)
    , nm(false)
    , nmFlags(0)
    , areaId(0)
    , rarity(0)
    , minRespawn(0)
    , maxRespawn(0)
    , level(0)
    , difficulty(0)
    , baseDelay(0)
    , baseMove(0)
    , reqBaitId(0)
    , altBaitId(0)
    , reqKeyItem(0)
    , zoneId(0)
    , minLength(0)
    , maxLength(0)
    , ranking(0)
    , questOnly(false)
    {
    }
};

struct fishmob_modifiers_t
{
    uint8 regenBonus;
    uint8 attackPenalty;
    uint8 healBonus;

    fishmob_modifiers_t()
    : regenBonus(0)
    , attackPenalty(0)
    , healBonus(0)
    {
    }
};

struct areavector_t
{
    float x;
    float y;
    float z;

    areavector_t()
    {
        x = 0.f;
        y = 0.f;
        z = 0.f;
    }

    areavector_t(float _x, float _y, float _z)
    {
        x = _x;
        y = _y;
        z = _z;
    }
};

struct boundarydata_t
{
    int           count;
    areavector_t* bounds;

    boundarydata_t()
    : count(0)
    , bounds(nullptr)
    {
    }
};

struct fishingarea_t
{
    uint32        zoneId;     // Zone ID
    uint32        areaId;     // Area ID
    std::string   areaName;   // Area Name
    uint8         areatype;   // What type of bounds checking is done
    areavector_t* areaBounds; // Boundaries
    uint8         numBounds;  // Number of boundary vectors
    uint8         height;     // Height of bounds
    areavector_t  center;     // Center point for radius bound type
    uint8         radius;     // Radius for radial boundary type
    uint8         difficulty; // Difficulty of area to fish in

    fishingarea_t()
    : zoneId(0)
    , areaId(0)
    , areatype(0)
    , areaBounds(nullptr)
    , numBounds(0)
    , height(0)
    , radius(0)
    , difficulty(0)
    {
    }
};

struct fishinggroupitem_t
{
    uint16 rarity;
    uint32 fishId;

    fishinggroupitem_t()
    : rarity(0)
    , fishId(0)
    {
    }
};

struct weights_t
{
    uint16 FishPoolWeight;
    uint16 ItemPoolWeight;
    uint16 MobPoolWeight;
    uint16 ChestPoolWeight;
    uint16 NoCatchWeight;

    weights_t()
    : FishPoolWeight(0)
    , ItemPoolWeight(0)
    , MobPoolWeight(0)
    , ChestPoolWeight(0)
    , NoCatchWeight(0)
    {
    }
};

struct fish_pool
{
    uint16 quantity;
    uint16 maxQuantity;
    uint16 restockRate;

    fish_pool()
    : quantity(0)
    , maxQuantity(0)
    , restockRate(0)
    {
    }
};

struct fishing_catch_pool
{
    std::map<uint16, fish_pool> stock;

    fishing_catch_pool()
    {
    }
};

struct fishing_area_pool
{
    std::map<uint8, fishing_catch_pool> catchPools;

    fishing_area_pool()
    {
    }
};

struct fishing_gear_t
{
    uint32 head;
    uint32 neck;
    uint32 body;
    uint32 hands;
    uint32 waist;
    uint32 legs;
    uint32 feet;
    uint32 ring1;
    uint32 ring2;
    uint32 ranged;
    uint32 ammo;

    fishing_gear_t()
    : head(0)
    , neck(0)
    , body(0)
    , hands(0)
    , waist(0)
    , legs(0)
    , feet(0)
    , ring1(0)
    , ring2(0)
    , ranged(0)
    , ammo(0)
    {
    }
};

struct big_fish_stats_t
{
    uint16 length;
    uint16 weight;
    bool   epic;

    big_fish_stats_t()
    : length(0)
    , weight(0)
    , epic(false)
    {
    }
};

enum FISHPOOLFLAGS : uint32
{
    FISHPOOL_NONE    = 0x00,
    FISHPOOL_ADD     = 0x01,
    FISHPOOL_REPLACE = 0x02,
    FISHPOOL_QUEST   = 0x04,
    FISHPOOL_FISH    = 0x08,
    FISHPOOL_MOB     = 0x10,
    FISHPOOL_ITEM    = 0x20,
    FISHPOOL_CHEST   = 0x40,
    FISHPOOL_FAIL    = 0x80,
    FISHPOOL_WEIGHTS = 0x100,
    FISHPOOL_REMOVE  = 0x200
};

enum FISHACTION : uint8
{
    FISHACTION_CHECK   = 2, // This is always the first 0x110 packet.
    FISHACTION_FINISH  = 3, // This is the next 0x110 after 0x115.
    FISHACTION_END     = 4, // This is sent when the fishing session ends completely
    FISHACTION_WARNING = 5  // This is the 0x110 packet if the time is going on too long.
};

enum FISHMESSAGEOFFSET : uint8
{
    FISHMESSAGEOFFSET_NOROD                    = 0x01, // You can't fish without a rod in your hands.
    FISHMESSAGEOFFSET_NOBAIT                   = 0x02, // You can't fish without bait on the hook.
    FISHMESSAGEOFFSET_CANNOTFISH_MOMENT        = 0x03, // You can't fish at the moment.
    FISHMESSAGEOFFSET_CANNOTFISH_TIME          = 0x5E, // You can't fish at this time
    FISHMESSAGEOFFSET_LINEBREAK                = 0x06, // Your line breaks.
    FISHMESSAGEOFFSET_RODBREAK                 = 0x07, // Your rod breaks.
    FISHMESSAGEOFFSET_RODBREAK_TOOBIG          = 0x11, // Your rod breaks. Whatever caught the hook was pretty big.
    FISHMESSAGEOFFSET_RODBREAK_TOOHEAVY        = 0x12, // Your rod breaks. Whatever caught the hook was too heavy to catch with this rod.
    FISHMESSAGEOFFSET_LOST                     = 0x09, // You lost your catch.
    FISHMESSAGEOFFSET_LOST_TOOSMALL            = 0x13, // You lost your catch. Whatever caught the hook was too small to catch with this rod.
    FISHMESSAGEOFFSET_LOST_LOWSKILL            = 0x14, // You lost your catch due to your lack of skill.
    FISHMESSAGEOFFSET_LOST_TOOBIG              = 0x3C, // You lost your catch. Whatever caught the hook was too large to catch with this rod.
    FISHMESSAGEOFFSET_GIVEUP_BAITLOSS          = 0x24, // You give up and reel in your line.
    FISHMESSAGEOFFSET_GIVEUP                   = 0x25, // You give up.
    FISHMESSAGEOFFSET_CATCH                    = 0x27, // <Player> caught <Fish>
    FISHMESSAGEOFFSET_CATCH_MULTI              = 0x0E, // <Player> caught X <Fish>
    FISHMESSAGEOFFSET_CATCH_INV_FULL           = 0x0A, // <Player> caught <Fish>, but cannot carry any more items. ≺Player≻ regretfully releases the <Fish>
    FISHMESSAGEOFFSET_MONSTER                  = 0x05, // <Player> caught a monster!
    FISHMESSAGEOFFSET_CATCH_CHEST              = 0x40, // <Player> fishes up a large box!
    FISHMESSAGEOFFSET_NOCATCH                  = 0x04, // You didn't catch anything.
    FISHMESSAGEOFFSET_GOLDFISH_PAPER_RIPPED    = 0x17, // The paper on your <itemid> ripped
    FISHMESSAGEOFFSET_GOLDFISH_APPROACHES      = 0x18, // A tiny goldfish approaches!
    FISHMESSAGEOFFSET_PLUMP_BLACK_APPROACHES   = 0x19, // A plump, black goldfish approaches!
    FISHMESSAGEOFFSET_FAT_JUICY_APPROACHES     = 0x1A, // A fat, juicy goldfish approaches!
    FISHMESSAGEOFFSET_NO_GOLDFISH_FOUND        = 0x1B, // There are no goldfish to be found...
    FISHMESSAGEOFFSET_CATCH_GOLDFISH_FULL      = 0x1C, // <Player> caught <Goldfish>, but cannot carry any more items. <Player> regretfully releases it.
    FISHMESSAGEOFFSET_GOLDFISH_SLIPPED_OFF     = 0x1D, // The goldfish slipped off your scoop...
    FISHMESSAGEOFFSET_HURRY_GOLDFISH_WARNING   = 0x3F, // Hurry before the goldfish sees you!
    FISHMESSAGEOFFSET_WARNING                  = 0x28, // You don't know how much longer you can keep this one on the line...
    FISHMESSAGEOFFSET_HOOKED_SMALL_FISH        = 0x08, // Something caught the hook!
    FISHMESSAGEOFFSET_HOOKED_LARGE_FISH        = 0x32, // Something caught the hook!!!
    FISHMESSAGEOFFSET_HOOKED_ITEM              = 0x33, // You feel something pulling at your line.
    FISHMESSAGEOFFSET_HOOKED_MONSTER           = 0x34, // Something clamps onto your line ferociously!
    FISHMESSAGEOFFSET_GOOD_FEELING             = 0x29, // You have a good feeling about this one!
    FISHMESSAGEOFFSET_BAD_FEELING              = 0x2A, // You have a bad feeling about this one.
    FISHMESSAGEOFFSET_TERRIBLE_FEELING         = 0x2B, // You have a terrible feeling about this one...
    FISHMESSAGEOFFSET_NOSKILL_FEELING          = 0x2C, // You don't know if you have enough skill to reel this one in.
    FISHMESSAGEOFFSET_NOSKILL_SURE_FEELING     = 0x2D, // You're fairly sure you don't have enough skill to reel this one in.
    FISHMESSAGEOFFSET_NOSKILL_POSITIVE_FEELING = 0x2E, // You're positive you don't have enough skill to reel this one in!
    FISHMESSAGEOFFSET_KEEN_ANGLERS_SENSE       = 0x35, // Your keen angler's senses tell you that this is the pull of <name of fish>
    FISHMESSAGEOFFSET_EPIC_CATCH               = 0x36, // This strength... You get the sense that you are on the verge of an epic catch! (apparently happens when large fish length is within 90-100% of it's max length)
};

enum FISHINGSENSETYPE : uint8
{
    FISHINGSENSETYPE_NONE                    = 0,
    FISHINGSENSETYPE_GOOD                    = 1,
    FISHINGSENSETYPE_BAD                     = 2,
    FISHINGSENSETYPE_TERRIBLE                = 3,
    FISHINGSENSETYPE_NOSKILL_FEELING         = 4,
    FISHINGSENSETYPE_NOSKILL_SURE_FEELING    = 5,
    FISHINGSENSETYPE_NOSKILL_POSITIVEFEELING = 6,
    FISHINGSENSETYPE_KEEN_ANGLERS_SENSE      = 7,
    FISHINGSENSETYPE_EPIC_CATCH              = 8,
};

enum FISHINGHOOKSENSETYPE : uint8
{
    FISHINGHOOKSENSETYPE_SMALL     = 0,
    FISHINGHOOKSENSETYPE_LARGE     = 1,
    FISHINGHOOKSENSETYPE_KEENSMALL = 2,
    FISHINGHOOKSENSETYPE_KEENLARGE = 3
};

enum FISHINGRODMATERIAL : uint8
{
    FISHINGRODMATERIAL_WOOD      = 0,
    FISHINGRODMATERIAL_SYNTHETIC = 1
};

enum FISHINGWATERTYPE : uint8
{
    FISHINGWATERTYPE_ALL   = 0,
    FISHINGWATERTYPE_FRESH = 1,
    FISHINGWATERTYPE_SALT  = 2
};

enum FISHINGTIMEPREF : uint8
{
    FISHINGTIMEPREF_ALL   = 0,
    FISHINGTIMEPREF_DAY   = 1,
    FISHINGTIMEPREF_NIGHT = 2
};

enum FISHINGMOONPREF : uint8
{
    FISHINGMOONPREF_ALL  = 0,
    FISHINGMOONPREF_FULL = 1,
    FISHINGMOONPREF_NEW  = 2
};

enum FISHINGLOCATIONTYPE : uint8
{
    FISHINGLOCATIONTYPE_ALL     = 0,
    FISHINGLOCATIONTYPE_CITY    = 1,
    FISHINGLOCATIONTYPE_OUTSIDE = 2
};

enum FISHINGCATCHTYPE : uint8
{
    FISHINGCATCHTYPE_NONE         = 0,
    FISHINGCATCHTYPE_SMALLFISH    = 1,
    FISHINGCATCHTYPE_BIGFISH      = 2,
    FISHINGCATCHTYPE_ITEM         = 3,
    FISHINGCATCHTYPE_MOB          = 4,
    FISHINGCATCHTYPE_CHEST        = 5,
    FISHINGCATCHTYPE_SMALL_CUSTOM = 6,
    FISHINGCATCHTYPE_LARGE_CUSTOM = 7,
    FISHINGCATCHTYPE_MOB_CUSTOM   = 8
};

enum FISHINGSUCCESSTYPE : uint8
{
    FISHINGSUCCESSTYPE_NONE              = 0,
    FISHINGSUCCESSTYPE_CATCHITEM         = 1,
    FISHINGSUCCESSTYPE_CATCHSMALL        = 2,
    FISHINGSUCCESSTYPE_CATCHLARGE        = 3,
    FISHINGSUCCESSTYPE_CATCHLEGEND       = 4,
    FISHINGSUCCESSTYPE_CATCHMOB          = 5,
    FISHINGSUCCESSTYPE_LINEBREAK         = 6,
    FISHINGSUCCESSTYPE_RODBREAK          = 7,
    FISHINGSUCCESSTYPE_LOSTCATCH         = 8,
    FISHINGSUCCESSTYPE_CATCHCHEST        = 9,
    FISHINGSUCCESSTYPE_CATCHSMALL_CUSTOM = 10,
    FISHINGSUCCESSTYPE_CATCHLARGE_CUSTOM = 11,
    FISHINGSUCCESSTYPE_CATCHMOB_CUSTOM   = 12
};

enum FISHINGFAILTYPE : uint8
{
    FISHINGFAILTYPE_NONE              = 0,
    FISHINGFAILTYPE_SYSTEM            = 1,
    FISHINGFAILTYPE_LINESNAP          = 2,
    FISHINGFAILTYPE_RODBREAK          = 3,
    FISHINGFAILTYPE_RODBREAK_TOOBIG   = 4,
    FISHINGFAILTYPE_RODBREAK_TOOHEAVY = 5,
    FISHINGFAILTYPE_LOST              = 6,
    FISHINGFAILTYPE_LOST_TOOSMALL     = 7,
    FISHINGFAILTYPE_LOST_LOWSKILL     = 8,
    FISHINGFAILTYPE_LOST_TOOBIG       = 9
};

enum FISHINGSIZETYPE : uint8
{
    FISHINGSIZETYPE_SMALL = 0, // small fish
    FISHINGSIZETYPE_LARGE = 1  // large fish
};

enum FISHINGBAITTYPE : uint8
{
    FISHINGBAITTYPE_BAIT    = 0, // stackable/consumable baits
    FISHINGBAITTYPE_LURE    = 1, // reusable lures
    FISHINGBAITTYPE_SPECIAL = 2  // Used to fish up NM, one time use only
};

enum FISHINGBAITPOWER : uint8
{
    FISHINGBAITPOWER_NONE     = 0, // will not catch
    FISHINGBAITPOWER_RARE     = 1, // rare catches
    FISHINGBAITPOWER_UNCOMMON = 2, // sometimes catches
    FISHINGBAITPOWER_COMMON   = 3  // catches often
};

enum FISHINGBOUNDTYPE : uint8
{
    FISHINGBOUNDTYPE_ZONE   = 0, // entire zone
    FISHINGBOUNDTYPE_RADIUS = 1, // bounding radius/cylinder
    FISHINGBOUNDTYPE_POLY   = 2  // bounding polygon/cube
};

enum FISHFLAG : uint32
{
    FISHFLAG_NORMAL    = 0x00,
    FISHFLAG_SHELLFISH = 0x01
};

enum RODFLAG : uint32
{
    RODFLAG_NORMAL            = 0x00,
    RODFLAG_SMALLPENALTY      = 0x01,
    RODFLAG_LARGEPENALTY      = 0x02,
    RODFLAG_LEGENDARYBONUS    = 0x04,
    RODFLAG_GOLDFISH_SCOOPING = 0x08
};

enum FISHINGLEGENDARY : uint32
{
    FISHINGLEGENDARY_NORMAL                = 0x00,
    FISHINGLEGENDARY_HALFTIME              = 0x01, // cuts base rod fishing time in half
    FISHINGLEGENDARY_NORODTIMEBONUS        = 0x02, // do not add the normal legendary rod bonus
    FISHINGLEGENDARY_EBISU_TIME_BONUS_ONLY = 0x04, // add bonus fishing time if Ebisu equipped
    FISHINGLEGENDARY_ADDTIMEBONUS          = 0x08  // add bonus fishing time based on rod multiplier
};

enum FISHINGNM : uint32
{
    FISHINGNM_NORMAL                  = 0x00,
    FISHINGNM_RANDOM_REGEN_EASY       = 0x01,
    FISHINGNM_RANDOM_REGEN_DIFFICULT  = 0x02,
    FISHINGNM_RANDOM_HEAL_EASY        = 0x04,
    FISHINGNM_RANDOM_HEAL_DIFFICULT   = 0x08,
    FISHINGNM_RANDOM_ATTACK_EASY      = 0x10,
    FISHINGNM_RANDOM_ATTACK_DIFFICULT = 0x20,
    FISHINGNM_RESET_RESPAWN_ON_FAIL   = 0x40
};

enum BAITFLAG : uint32
{
    BAITFLAG_NORMAL             = 0x00,
    BAITFLAG_SINKING            = 0x01,
    BAITFLAG_ITEM_BONUS         = 0x02,
    BAITFLAG_ITEM_MEGA_BONUS    = 0x04,
    BAITFLAG_POOR_FISH          = 0x08,
    BAITFLAG_GOLD_ARROW_BONUS   = 0x10,
    BAITFLAG_GOLDFISH_SCOOPING  = 0x20,
    BAITFLAG_SHELLFISH_AFFINITY = 0X40
};

/*  Key Items  */

enum FISHINGKI : uint32
{
    FISHINGKI_FROG_FISHING   = 1976,
    FISHINGKI_SERPENT_RUMORS = 1977,
    FISHINGKI_MOOCHING       = 1978
};

/* Catch Patterns */

// Hour Bonuses
enum HOURCATCHPATTERNS : uint8
{
    HOURPATTERN_NOBONUS                 = 0,
    HOURPATTERN_NIGHT_MORNING_AFTERNOON = 1, // pattern_1
    HOURPATTERN_HIGH_TIDE               = 2,
    HOURPATTERN_LOW_TIDE                = 3,
    HOURPATTERN_NIGHT                   = 4,
    HOURPATTERN_MORNING_AFTERNOON       = 5, // pattern_2
    HOURPATTERN_DAY_NIGHT               = 6, // pattern_3
    HOURPATTERN_DAY                     = 7  // pattern_4
};

// Moon Bonuses
enum MOONCATCHPATTERNS : uint8
{
    MOONPATTERN_NOBONUS          = 0,
    MOONPATTERN_NEW_FULL         = 1, // pattern_1
    MOONPATTERN_NEW_FULL_PENALTY = 2, // pattern_2
    MOONPATTERN_NEW_SLOPE        = 3, // pattern_3
    MOONPATTERN_FULL             = 4, // pattern_4
    MOONPATTERN_NEW              = 5  // pattern_5
};

// Month Bonuses
enum MONTHCATCHPATTERNS : uint8
{
    MONTHPATTERN_NOBONUS             = 0,
    MONTHPATTERN_SPRING_SUMMER       = 1, // pattern_1
    MONTHPATTERN_SPRING_WINTER       = 2, // pattern_2
    MONTHPATTERN_SUMMER              = 3, // pattern_3
    MONTHPATTERN_WINTER_SUMMER       = 4, // pattern_4
    MONTHPATTERN_SUMMER_FALL         = 5, // pattern_5
    MONTHPATTERN_LATESPRING_LATEFALL = 6, // pattern_6
    MONTHPATTERN_FALL                = 7, // pattern_7
    MONTHPATTERN_SPRING_FALL         = 8, // pattern_8
    MONTHPATTERN_SPRING              = 9, // pattern_9
    MONTHPATTERN_WINTER              = 10 // pattern_10
};

#define HOURPATTERN_1(x) \
    (float)std::clamp(0.5f * std::cos(0.82f * x + 0.16f) + 0.5f, 0.0f, 1.0f)
#define HOURPATTERN_2(x) \
    (float)std::clamp(0.5f * std::cos(0.60f * x + 3.50f) + 0.5f, 0.0f, 1.0f)
#define HOURPATTERN_3(x) \
    (float)std::clamp(0.5f * std::cos(0.53f * x + 0.00f) + 0.5f, 0.0f, 1.0f)
#define HOURPATTERN_4(x) \
    (float)std::clamp(0.5f * std::cos(0.23f * x + 3.53f) + 0.5f, 0.0f, 1.0f)
#define MOONPATTERN_1(x) \
    (float)std::clamp(0.5f * std::cos(1.75f * x + 0.10f) + 0.5f, 0.0f, 1.0f)
#define MOONPATTERN_2(x) \
    (float)std::clamp(0.5f * std::cos(1.75f * x + 3.30f) + 0.5f, 0.0f, 1.0f)
#define MOONPATTERN_3(x) (float)std::clamp(1.0f - (x / 7), 0.0f, 1.0f)
#define MOONPATTERN_4(x) \
    (float)std::clamp(0.5f * std::cos(0.90f * x + 3.14f) + 0.5f, 0.0f, 1.0f)
#define MOONPATTERN_5(x) \
    (float)std::clamp(0.5f * std::cos(0.90f * x + 0.00f) + 0.5f, 0.0f, 1.0f)
#define MONTHPATTERN_1(x) \
    (float)std::clamp(0.5f * std::cos(0.40f * x - 1.60f) + 0.5f, 0.0f, 1.0f)
#define MONTHPATTERN_2(x) \
    (float)std::clamp(0.5f * std::cos(0.60f * x - 1.00f) + 0.5f, 0.0f, 1.0f)
#define MONTHPATTERN_3(x) \
    (float)std::clamp(0.5f * std::cos(0.50f * x + 3.05f) + 0.5f, 0.0f, 1.0f)
#define MONTHPATTERN_4(x) \
    (float)std::clamp(0.5f * std::cos(1.04f * x + 0.00f) + 0.5f, 0.0f, 1.0f)
#define MONTHPATTERN_5(x) \
    (float)std::clamp(0.5f * std::cos(0.40f * x + 3.50f) + 0.5f, 0.0f, 1.0f)
#define MONTHPATTERN_6(x) \
    (float)std::clamp(0.5f * std::cos(0.90f * x - 2.00f) + 0.5f, 0.0f, 1.0f)
#define MONTHPATTERN_7(x) \
    (float)std::clamp(0.5f * std::cos(0.49f * x + 1.63f) + 0.5f, 0.0f, 1.0f)
#define MONTHPATTERN_8(x) \
    (float)std::clamp(0.5f * std::cos(1.04f * x - 2.60f) + 0.5f, 0.0f, 1.0f)
#define MONTHPATTERN_9(x) \
    (float)std::clamp(0.5f * std::cos(0.49f * x - 1.25f) + 0.5f, 0.0f, 1.0f)
#define MONTHPATTERN_10(x) \
    (float)std::clamp(0.5f * std::cos(0.50f * x + 0.53f) + 0.5f, 0.0f, 1.0f)

#define QUEST_AVAILABLE 0
#define QUEST_ACCEPTED  1
#define QUEST_COMPLETED 2

/* Moon Phases */
enum MOONPHASES : uint8
{
    MOONPHASE_NEW             = 0,
    MOONPHASE_WAXING_CRESCENT = 1,
    MOONPHASE_FIRST_QUARTER   = 2,
    MOONPHASE_WAXING_GIBBOUS  = 3,
    MOONPHASE_FULL            = 4,
    MOONPHASE_WANING_GIBBOUS  = 5,
    MOONPHASE_LAST_QUARTER    = 6,
    MOONPHASE_WANING_CRESCENT = 7
};

/* Items */
enum FISHINGGEAR : uint32
{
    // head
    TLAHTLAMAH_GLASSES  = 25608,
    TRAINEES_SPECTACLES = 11499,
    // neck
    FISHERS_TORQUE = 10925,
    // body
    FISHERMANS_TUNICA = 13808,
    ANGLERS_TUNICA    = 13809,
    FISHERMANS_APRON  = 14400,
    FISHERMANS_SMOCK  = 11337,
    // hands
    FISHERMANS_GLOVES = 14070,
    ANGLERS_GLOVES    = 14071,
    // waist
    FISHERS_ROPE    = 11768,
    FISHERMANS_BELT = 15452,
    // legs
    FISHERMANS_HOSE = 14292,
    ANGLERS_HOSE    = 14293,
    // feet
    FISHERMANS_BOOTS = 14171,
    ANGLERS_BOOTS    = 14172,
    WADERS           = 14195
};

enum LIVEFISHINGBAIT : uint32
{
    DRILL_CALAMARY = 17006,
    DWARF_PUGIL    = 17007
};

enum FISHINGRING : uint32
{
    PELICAN   = 15554,
    ALBATROSS = 15554,
    PENGUIN   = 15554,
    NODDY     = 11655,
    PUFFIN    = 11654,
    SEAGULL   = 15845
};

enum FISHINGROD : uint32
{
    WILLOW          = 17391,
    YEW             = 17390,
    BAMBOO          = 17389,
    FASTWATER       = 17388,
    TARUTARU        = 17387,
    LU_SHANG        = 17386,
    GLASS_FIBER     = 17385,
    CARBON          = 17384,
    CLOTHESPOLE     = 17383,
    SINGLE_HOOK     = 17382,
    COMPOSITE       = 17381,
    MITHRAN         = 17380,
    HALCYON         = 17015,
    HUME            = 17014,
    JUDGE           = 17012,
    GOLDFISH_BASKET = 17013,
    EBISU           = 17011,
    MAZE_MONGER     = 19319,
    LU_SHANG_1      = 19320,
    EBISU_1         = 19321,
};

/************************************************************************
 *                                                                       *
 *  All the methods necessary for the implementation of fishing          *
 *                                                                       *
 ************************************************************************/

class CBasicPacket;
class CCharEntity;
class CMobEntity;
class CItemFish;
class CItemWeapon;

namespace fishingutils
{
    // Catch Pools
    void   ReduceFishPool(uint16 zoneId, uint8 areaId, uint16 fishId);
    void   RestockFishingAreas();
    void   CreateFishingPools();
    uint32 HandleFishingAction(CCharEntity* PChar, CBasicPacket& data);

    // Calculations
    uint32              GetSundayMidnightTimestamp();
    uint8               GetMoonPhase();
    uint8               GetHookTime(CCharEntity* PChar);
    float               GetMonthlyTidalInfluence(fish_t* fish);
    float               GetHourlyModifier(fish_t* fish);
    float               GetMoonModifier(fish_t* fish);
    uint8               GetLuckyMoonModifier();
    float               GetWeatherModifier(CCharEntity* PChar);
    uint16              CalculateStamina(int skill, uint8 count);
    uint16              CalculateAttack(bool legendary, uint8 difficulty, rod_t* rod);
    uint16              CalculateHeal(bool legendary, uint8 difficulty, rod_t* rod);
    uint8               CalculateRegen(uint8 fishingSkill, rod_t* rod, FISHINGCATCHTYPE catchType,
                                       uint8 sizeType, uint8 catchSkill, bool legendaryCatch, bool NM);
    uint8               CalculateHookTime(CCharEntity* PChar, bool legendary,
                                          uint32 legendary_flags, uint8 sizeType, rod_t* rod, bait_t* bait);
    uint8               CalculateLuckyTiming(CCharEntity* PChar, uint8 fishingSkill,
                                             uint8 catchSkill, uint8 sizeType, rod_t* rod, bait_t* bait, bool legendary);
    uint16              CalculateHookChance(uint8 fishingSkill, fish_t* fish, bait_t* bait, rod_t* rod);
    uint8               CalculateDelay(CCharEntity* PChar, uint8 baseDelay, uint8 sizeType, rod_t* rod, uint8 count);
    uint8               CalculateMovement(CCharEntity* PChar, uint8 baseMove, uint8 sizeType, rod_t* rod, uint8 count);
    uint8               CalculateFishSense(CCharEntity* PChar, fishresponse_t* response,
                                           uint8 fishingSkill, uint8 catchType, uint8 sizeType,
                                           uint8 maxSkill, bool legendary, uint16 minLength,
                                           uint16 maxLength, uint8 ranking, rod_t* rod);
    uint16              CalculateCriticalBite(uint8 fishingSkill, uint8 fishSkill, rod_t* rod);
    big_fish_stats_t    CalculateBigFishStats(uint16 minLength, uint16 maxLength);
    fishmob_modifiers_t CalculateMobModifiers(fishmob_t* mob);

    // Data Access
    fishing_gear_t            GetFishingGear(CCharEntity* PChar);
    bool                      IsLiveBait(bait_t* bait);
    uint8                     GetFishingSkill(CCharEntity* PChar);
    uint8                     GetBaitPower(bait_t* bait, fish_t* fish);
    std::map<fish_t*, uint16> GetFishPool(uint16 zoneID, uint8 areaID, uint16 BaitID);
    std::vector<fish_t*>      GetItemPool(uint16 zoneID, uint8 areaID);
    std::vector<fishmob_t*>   GetMobPool(uint16 zoneId);
    uint16                    GetMessageOffset(uint16 ZoneID);
    bool                      IsFish(CItem* fish);
    fish_t*                   GetFish(uint32 fishId);

    // Fishing Areas
    bool           onSegment(areavector_t p, areavector_t q, areavector_t r);
    int            orientation(areavector_t p, areavector_t q, areavector_t r);
    bool           doIntersect(areavector_t p1, areavector_t q1, areavector_t p2, areavector_t q2);
    bool           isInsidePoly(areavector_t polygon[], int n, areavector_t p, float posy, uint8 height);
    bool           isInsideCylinder(areavector_t center, areavector_t p, uint16 radius, uint8 height);
    fishingarea_t* GetFishingArea(CCharEntity* PChar);

    // Catching
    bool  BaitLoss(CCharEntity* PChar, bool RemoveFly, bool SendUpdate);
    void  RodBreak(CCharEntity* PChar);
    bool  CanFishMob(CMobEntity* PMob);
    int32 LoseCatch(CCharEntity* PChar, uint8 FailType);
    int32 CatchNothing(CCharEntity* PChar, uint8 FailType);
    int32 CatchFish(CCharEntity* PChar, uint16 FishID, bool BigFish, uint16 length, uint16 weight, uint8 Count);
    int32 CatchItem(CCharEntity* PChar, uint16 ItemID, uint8 Count);
    int32 CatchMonster(CCharEntity* PChar, uint32 MobID);
    int32 CatchChest(CCharEntity* PChar, uint32 NpcID, uint8 distance, int8 angle);

    // Messaging
    void SendSenseMessage(CCharEntity* PChar, fishresponse_t* response);
    bool SendHookResponse(CCharEntity* PChar, fishresponse_t* response, bool cancelOnMobLoadFaibait);

    // Skillup
    void FishingSkillup(CCharEntity* PChar, uint8 catchLevel, uint8 successType);

    // Fishing
    void             InterruptFishing(CCharEntity* PChar);
    void             StartFishing(CCharEntity* PChar);
    void             ReelInCatch(CCharEntity* PChar);
    uint8            UnhookMob(CCharEntity* PChar, bool lost);
    fishresponse_t*  FishingCheck(CCharEntity* PChar, uint8 fishingSkill, rod_t* rod, bait_t* bait, fishingarea_t* area);
    catchresponse_t* ReelCheck(CCharEntity* PChar, fishresponse_t* response, rod_t* rod);
    void             FishingAction(CCharEntity* PChar, FISHACTION action, uint16 stamina, uint32 special);
    CItemFish*       GetFish(uint16 itemid); // creates a `new` CItemFish if possible

    // Initialization
    void LoadFishingMessages();
    void LoadFishingAreas();
    void LoadFishItems();
    void LoadFishMobs();
    void LoadFishingRods();
    void LoadFishingBaits();
    void LoadFishingBaitAffinities();
    void LoadFishGroups();
    void LoadFishingCatchLists();
    void InitializeFishingSystem();
    void CleanupFishing();
}; // namespace fishingutils

#endif // _FISHINGUTILS_H
