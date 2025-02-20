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

#ifndef _BATTLEENTITY_H
#define _BATTLEENTITY_H

#include <set>
#include <unordered_map>
#include <vector>

#include "alliance.h"
#include "baseentity.h"
#include "map.h"
#include "modifier.h"
#include "party.h"
#include "trait.h"

enum class DEATH_TYPE : uint8
{
    NONE        = 0,
    PHYSICAL    = 1,
    MAGICAL     = 2,
    WS_PHYSICAL = 3,
    WS_MAGICAL  = 4,
};
DECLARE_FORMAT_AS_UNDERLYING(DEATH_TYPE);

enum class ECOSYSTEM : uint8
{
    ECO_ERROR      = 0,
    AMORPH         = 1,
    AQUAN          = 2,
    ARCANA         = 3,
    ARCHAICMACHINE = 4,
    AVATAR         = 5,
    BEAST          = 6,
    BEASTMAN       = 7, // Resolve conflict with conquest_system.h BEASTMEN definition
    BIRD           = 8,
    DEMON          = 9,
    DRAGON         = 10,
    ELEMENTAL      = 11,
    EMPTY          = 12,
    HUMANOID       = 13,
    LIZARD         = 14,
    LUMINIAN       = 15,
    LUMINION       = 16,
    PLANTOID       = 17,
    UNCLASSIFIED   = 18,
    UNDEAD         = 19,
    VERMIN         = 20,
    VORAGEAN       = 21
};
DECLARE_FORMAT_AS_UNDERLYING(ECOSYSTEM);

enum JOBTYPE
{
    JOB_NON = 0,
    JOB_WAR = 1,
    JOB_MNK = 2,
    JOB_WHM = 3,
    JOB_BLM = 4,
    JOB_RDM = 5,
    JOB_THF = 6,
    JOB_PLD = 7,
    JOB_DRK = 8,
    JOB_BST = 9,
    JOB_BRD = 10,
    JOB_RNG = 11,
    JOB_SAM = 12,
    JOB_NIN = 13,
    JOB_DRG = 14,
    JOB_SMN = 15,
    JOB_BLU = 16,
    JOB_COR = 17,
    JOB_PUP = 18,
    JOB_DNC = 19,
    JOB_SCH = 20,
    JOB_GEO = 21,
    JOB_RUN = 22,
    JOB_MON = 23, // NOTE: MON is not a full job
};
#define MAX_JOBTYPE 24
DECLARE_FORMAT_AS_UNDERLYING(JOBTYPE);

enum SKILLTYPE
{
    SKILL_NONE         = 0,
    SKILL_HAND_TO_HAND = 1,
    SKILL_DAGGER       = 2,
    SKILL_SWORD        = 3,
    SKILL_GREAT_SWORD  = 4,
    SKILL_AXE          = 5,
    SKILL_GREAT_AXE    = 6,
    SKILL_SCYTHE       = 7,
    SKILL_POLEARM      = 8,
    SKILL_KATANA       = 9,
    SKILL_GREAT_KATANA = 10,
    SKILL_CLUB         = 11,
    SKILL_STAFF        = 12,
    // 13~21 unused
    SKILL_AUTOMATON_MELEE   = 22,
    SKILL_AUTOMATON_RANGED  = 23,
    SKILL_AUTOMATON_MAGIC   = 24,
    SKILL_ARCHERY           = 25,
    SKILL_MARKSMANSHIP      = 26,
    SKILL_THROWING          = 27,
    SKILL_GUARD             = 28,
    SKILL_EVASION           = 29,
    SKILL_SHIELD            = 30,
    SKILL_PARRY             = 31,
    SKILL_DIVINE_MAGIC      = 32,
    SKILL_HEALING_MAGIC     = 33,
    SKILL_ENHANCING_MAGIC   = 34,
    SKILL_ENFEEBLING_MAGIC  = 35,
    SKILL_ELEMENTAL_MAGIC   = 36,
    SKILL_DARK_MAGIC        = 37,
    SKILL_SUMMONING_MAGIC   = 38,
    SKILL_NINJUTSU          = 39,
    SKILL_SINGING           = 40,
    SKILL_STRING_INSTRUMENT = 41,
    SKILL_WIND_INSTRUMENT   = 42,
    SKILL_BLUE_MAGIC        = 43,
    SKILL_GEOMANCY          = 44,
    SKILL_HANDBELL          = 45,
    // 46-47 unused
    SKILL_FISHING      = 48,
    SKILL_WOODWORKING  = 49,
    SKILL_SMITHING     = 50,
    SKILL_GOLDSMITHING = 51,
    SKILL_CLOTHCRAFT   = 52,
    SKILL_LEATHERCRAFT = 53,
    SKILL_BONECRAFT    = 54,
    SKILL_ALCHEMY      = 55,
    SKILL_COOKING      = 56,
    SKILL_SYNERGY      = 57,
    SKILL_RID          = 58,
    SKILL_DIG          = 59
};
#define MAX_SKILLTYPE 64
DECLARE_FORMAT_AS_UNDERLYING(SKILLTYPE);

enum SUBSKILLTYPE
{
    SUBSKILL_XBO      = 0,
    SUBSKILL_GUN      = 1,
    SUBSKILL_CNN      = 2,
    SUBSKILL_SHURIKEN = 3,

    SUBSKILL_ANIMATOR    = 10,
    SUBSKILL_ANIMATOR_II = 11,

    SUBSKILL_SHEEP      = 21,
    SUBSKILL_HARE       = 22,
    SUBSKILL_CRAB       = 23,
    SUBSKILL_CARRIE     = 24,
    SUBSKILL_HOMUNCULUS = 25,
    SUBSKILL_FLYTRAP    = 26,
    SUBSKILL_TIGER      = 27,
    SUBSKILL_BILL       = 28,
    SUBSKILL_EFT        = 29,
    SUBSKILL_LIZARD     = 30,
    SUBSKILL_MAYFLY     = 31,
    SUBSKILL_FUNGUAR    = 32,
    SUBSKILL_BEETLE     = 33,
    SUBSKILL_ANTLION    = 34,
    SUBSKILL_MITE       = 35,
    SUBSKILL_MELODIA    = 36,
    SUBSKILL_STEFFI     = 37,
    SUBSKILL_BEN        = 38,
    SUBSKILL_SIRAVARDE  = 39,
    SUBSKILL_COMO       = 40,
    SUBSKILL_OROB       = 41,
    SUBSKILL_AUDREY     = 42,
    SUBSKILL_ALLIE      = 43,
    SUBSKILL_LARS       = 44,
    SUBSKILL_GALAHAD    = 45,
    SUBSKILL_CHUCKY     = 46,
    SUBSKILL_SABOTENDER = 47,
    SUBSKILL_CLYVONNE   = 49,
    SUBSKILL_SHASRA     = 50,
    SUBSKILL_LULUSH     = 51,
    SUBSKILL_FARGANN    = 52,
    SUBSKILL_LOUISE     = 53,
    SUBSKILL_SIEGHARD   = 54,
    SUBSKILL_YULY       = 55,
    SUBSKILL_MERLE      = 56,
    SUBSKILL_NAZUNA     = 57,
    SUBSKILL_CETAS      = 58,
    SUBSKILL_ANNA       = 59,
    SUBSKILL_JULIO      = 60,
    SUBSKILL_BRONCHA    = 61,
    SUBSKILL_GERARD     = 62,
    SUBSKILL_HOBS       = 63,
    SUBSKILL_FALCORR    = 64,
    SUBSKILL_RAPHIE     = 65,
    SUBSKILL_MAC        = 66,
    SUBSKILL_SILAS      = 67,
    SUBSKILL_TOLOI      = 68
};
DECLARE_FORMAT_AS_UNDERLYING(SUBSKILLTYPE);

enum SLOTTYPE
{
    SLOT_MAIN   = 0x00,
    SLOT_SUB    = 0x01,
    SLOT_RANGED = 0x02,
    SLOT_AMMO   = 0x03,
    SLOT_HEAD   = 0x04,
    SLOT_BODY   = 0x05,
    SLOT_HANDS  = 0x06,
    SLOT_LEGS   = 0x07,
    SLOT_FEET   = 0x08,
    SLOT_NECK   = 0x09,
    SLOT_WAIST  = 0x0A,
    SLOT_EAR1   = 0x0B,
    SLOT_EAR2   = 0x0C,
    SLOT_RING1  = 0x0D,
    SLOT_RING2  = 0x0E,
    SLOT_BACK   = 0x0F,
    SLOT_LINK1  = 0x10,
    SLOT_LINK2  = 0x11,
};
#define MAX_SLOTTYPE 18
DECLARE_FORMAT_AS_UNDERLYING(SLOTTYPE);

enum class ATTACK_TYPE
{
    NONE     = 0,
    PHYSICAL = 1,
    MAGICAL  = 2,
    RANGED   = 3,
    SPECIAL  = 4,
    BREATH   = 5
};
DECLARE_FORMAT_AS_UNDERLYING(ATTACK_TYPE);

enum class DAMAGE_TYPE : uint16
{
    NONE      = 0,
    PIERCING  = 1,
    SLASHING  = 2,
    IMPACT    = 3,
    HTH       = 4,
    ELEMENTAL = 5,
    FIRE      = 6,
    ICE       = 7,
    WIND      = 8,
    EARTH     = 9,
    LIGHTNING = 10,
    WATER     = 11,
    LIGHT     = 12,
    DARK      = 13
};
DECLARE_FORMAT_AS_UNDERLYING(DAMAGE_TYPE);

// This enum class is a set of bitfields that modify messages sent to the client.
// There are helpers (PARRY/EVADE) because it is not intuitive
// These flag names may not match SE's intent perfectly, but seem to work well.

// For example
// A guard is HIT + GUARDED
// A parry is HIT + MISS + GUARDED
// A block is HIT + BLOCK
// It also seems weaponskills and job abilities set ABILITY in addition to these flags.
// All of these flags are also seen in weaponskills.
enum class REACTION : uint8
{
    NONE    = 0x00, // No Reaction
    MISS    = 0x01, // Miss
    GUARDED = 0x02, // Bit to indicate guard, used individually to indicate guard during WS packet as well
    PARRY   = 0x03, // Block with weapons (MISS + GUARDED)
    BLOCK   = 0x04, // Block with shield, bit to indicate blocked during WS packet as well
    HIT     = 0x08, // Hit
    EVADE   = 0x09, // Evasion (MISS + HIT)
    ABILITY = 0x10, // Observed on JA and WS
};
DECLARE_FORMAT_AS_UNDERLYING(REACTION);

// These operators are used to combine bits that may not have a discrete value upon combining.
inline REACTION operator|(REACTION a, REACTION b)
{
    return (REACTION)((uint8)a | (uint8)b);
}

inline REACTION operator&(REACTION a, REACTION b)
{
    return (REACTION)((uint8)a & (uint8)b);
}

inline REACTION operator|=(REACTION& a, REACTION b)
{
    a = a | b;

    return a;
}

enum class SPECEFFECT
{
    NONE         = 0x00,
    BLOOD        = 0x02,
    HIT          = 0x10,
    RAISE        = 0x11,
    RECOIL       = 0x20,
    CRITICAL_HIT = 0x22
};
DECLARE_FORMAT_AS_UNDERLYING(SPECEFFECT);

enum class MODIFIER
{
    NONE        = 0x00,
    COVER       = 0x01,
    RESIST      = 0x02,
    MAGIC_BURST = 0x04, // Currently known to be used for Swipe/Lunge only
    IMMUNOBREAK = 0x08,
};
DECLARE_FORMAT_AS_UNDERLYING(MODIFIER);

enum SUBEFFECT
{
    // ATTACK
    SUBEFFECT_FIRE_DAMAGE      = 1,  // 110000     3
    SUBEFFECT_ICE_DAMAGE       = 2,  // 1-01000    5
    SUBEFFECT_WIND_DAMAGE      = 3,  // 111000     7
    SUBEFFECT_EARTH_DAMAGE     = 4,  // 1-00100    9
    SUBEFFECT_LIGHTNING_DAMAGE = 5,  // 110100    11
    SUBEFFECT_WATER_DAMAGE     = 6,  // 1-01100   13
    SUBEFFECT_LIGHT_DAMAGE     = 7,  // 111100    15
    SUBEFFECT_DARKNESS_DAMAGE  = 8,  // 1-00010   17
    SUBEFFECT_SLEEP            = 9,  // 110010    19
    SUBEFFECT_POISON           = 10, // 1-01010   21
    SUBEFFECT_ADDLE            = 11, // Verified shared group 1
    SUBEFFECT_AMNESIA          = 11, // Verified shared group 1
    SUBEFFECT_PARALYSIS        = 11, // Verified shared group 1
    SUBEFFECT_BLIND            = 12, // 1-00110   25
    SUBEFFECT_SILENCE          = 13,
    SUBEFFECT_PETRIFY          = 14,
    SUBEFFECT_PLAGUE           = 15,
    SUBEFFECT_STUN             = 16,
    SUBEFFECT_CURSE            = 17,
    SUBEFFECT_DEFENSE_DOWN     = 18, // 1-01001   37
    SUBEFFECT_EVASION_DOWN     = 18, // Verified shared group 2
    SUBEFFECT_ATTACK_DOWN      = 18, // Verified shared group 2
    SUBEFFECT_SLOW             = 18, // Verified shared group 2
    SUBEFFECT_DEATH            = 19,
    SUBEFFECT_SHIELD           = 20,
    SUBEFFECT_HP_DRAIN         = 21, // 1-10101   43  This is retail correct animation
    SUBEFFECT_MP_DRAIN         = 22, // Verified shared group 3
    SUBEFFECT_TP_DRAIN         = 22, // Verified shared group 3
    SUBEFFECT_HASTE            = 23,
    // There are no additional attack effect animations beyond 23. Some effects share subeffect/animations.

    // SPIKES
    SUBEFFECT_BLAZE_SPIKES = 1,  // 01-1000    6
    SUBEFFECT_ICE_SPIKES   = 2,  // 01-0100   10
    SUBEFFECT_DREAD_SPIKES = 3,  // 01-1100   14
    SUBEFFECT_CURSE_SPIKES = 4,  // 01-0010   18
    SUBEFFECT_SHOCK_SPIKES = 5,  // 01-1010   22
    SUBEFFECT_REPRISAL     = 6,  // 01-0110   26
                                 // SUBEFFECT_GLINT_SPIKES = 6,
    SUBEFFECT_GALE_SPIKES   = 7, // Used by enchantment "Cool Breeze" http://www.ffxiah.com/item/22018/
    SUBEFFECT_CLOD_SPIKES   = 8,
    SUBEFFECT_DELUGE_SPIKES = 9,
    SUBEFFECT_DEATH_SPIKES  = 10, // yes really: http://www.ffxiah.com/item/26944/
    SUBEFFECT_COUNTER       = 63, // Also used by Retaliation
                                  // There are no spikes effect animations beyond 63. Some effects share subeffect/animations.
                                  // "Damage Spikes" use the Blaze Spikes animation even though they are different status.

    // SKILLCHAINS
    SUBEFFECT_LIGHT         = 1,
    SUBEFFECT_DARKNESS      = 2,
    SUBEFFECT_GRAVITATION   = 3,
    SUBEFFECT_FRAGMENTATION = 4,
    SUBEFFECT_DISTORTION    = 5,
    SUBEFFECT_FUSION        = 6,
    SUBEFFECT_COMPRESSION   = 7,
    SUBEFFECT_LIQUEFACATION = 8,
    SUBEFFECT_INDURATION    = 9,
    SUBEFFECT_REVERBERATION = 10,
    SUBEFFECT_TRANSFIXION   = 11,
    SUBEFFECT_SCISSION      = 12,
    SUBEFFECT_DETONATION    = 13,
    SUBEFFECT_IMPACTION     = 14,
    SUBEFFECT_RADIANCE      = 15,
    SUBEFFECT_UMBRA         = 16,

    SUBEFFECT_NONE = 0,

    // UNKNOWN
    SUBEFFECT_IMPAIRS_EVASION,
    SUBEFFECT_BIND,
    SUBEFFECT_WEIGHT,
    SUBEFFECT_AUSPICE
};
DECLARE_FORMAT_AS_UNDERLYING(SUBEFFECT);

enum TARGETTYPE
{
    TARGET_NONE                    = 0x00,
    TARGET_SELF                    = 0x01,
    TARGET_PLAYER_PARTY            = 0x02,
    TARGET_ENEMY                   = 0x04,
    TARGET_PLAYER_ALLIANCE         = 0x08,
    TARGET_PLAYER                  = 0x10,
    TARGET_PLAYER_DEAD             = 0x20,
    TARGET_NPC                     = 0x40, // an npc is a mob that looks like an npc and fights on the side of the character
    TARGET_PLAYER_PARTY_PIANISSIMO = 0x80,
    TARGET_PET                     = 0x100,
    TARGET_PLAYER_PARTY_ENTRUST    = 0x200,
    TARGET_IGNORE_BATTLEID         = 0x400, // Can hit targets that do not have the same battle ID
};
DECLARE_FORMAT_AS_UNDERLYING(TARGETTYPE);

enum SKILLCHAIN_ELEMENT
{
    SC_NONE = 0, // Lv0 None

    SC_TRANSFIXION   = 1, // Lv1 Light
    SC_COMPRESSION   = 2, // Lv1 Dark
    SC_LIQUEFACTION  = 3, // Lv1 Fire
    SC_SCISSION      = 4, // Lv1 Earth
    SC_REVERBERATION = 5, // Lv1 Water
    SC_DETONATION    = 6, // Lv1 Wind
    SC_INDURATION    = 7, // Lv1 Ice
    SC_IMPACTION     = 8, // Lv1 Thunder

    SC_GRAVITATION   = 9,  // Lv2 Dark & Earth
    SC_DISTORTION    = 10, // Lv2 Water & Ice
    SC_FUSION        = 11, // Lv2 Fire & Light
    SC_FRAGMENTATION = 12, // Lv2 Wind & Thunder

    SC_LIGHT       = 13, // Lv3 Fire, Light, Wind, Thunder
    SC_DARKNESS    = 14, // Lv3 Dark, Earth, Water, Ice
    SC_LIGHT_II    = 15, // Lv4 Light
    SC_DARKNESS_II = 16, // Lv4 Darkness
};
#define MAX_SKILLCHAIN_LEVEL (4)
#define MAX_SKILLCHAIN_COUNT (5)
DECLARE_FORMAT_AS_UNDERLYING(SKILLCHAIN_ELEMENT);

enum IMMUNITY : uint32
{
    IMMUNITY_NONE        = 0x00000000, //      0
    IMMUNITY_ADDLE       = 0x00000001, //      1
    IMMUNITY_GRAVITY     = 0x00000002, //      2
    IMMUNITY_BIND        = 0x00000004, //      4
    IMMUNITY_STUN        = 0x00000008, //      8
    IMMUNITY_SILENCE     = 0x00000010, //     16
    IMMUNITY_PARALYZE    = 0x00000020, //     32
    IMMUNITY_BLIND       = 0x00000040, //     64
    IMMUNITY_SLOW        = 0x00000080, //    128
    IMMUNITY_POISON      = 0x00000100, //    256
    IMMUNITY_ELEGY       = 0x00000200, //    512
    IMMUNITY_REQUIEM     = 0x00000400, //   1024
    IMMUNITY_LIGHT_SLEEP = 0x00000800, //   2048
    IMMUNITY_DARK_SLEEP  = 0x00001000, //   4096
    IMMUNITY_ASPIR       = 0x00002000, //   8192
    IMMUNITY_TERROR      = 0x00004000, //  16384
    IMMUNITY_DISPEL      = 0x00008000, //  32768
    IMMUNITY_PETRIFY     = 0x00010000, //  65536
    IMMUNITY_PLAGUE      = 0x00020000, // 131064
};
DECLARE_FORMAT_AS_UNDERLYING(IMMUNITY);

struct apAction_t
{
    CBattleEntity* ActionTarget;     // 32 bits
    REACTION       reaction;         //  5 bits
    uint16         animation;        // 12 bits
    SPECEFFECT     speceffect;       // 7 bits
    uint8          knockback;        // 3 bits
    int32          param;            // 17 bits
    uint16         messageID;        // 10 bits
    SUBEFFECT      additionalEffect; // 10 bits
    int32          addEffectParam;   // 17 bits
    uint16         addEffectMessage; // 10 bits
    SUBEFFECT      spikesEffect;     // 10 bits
    uint16         spikesParam;      // 14 bits
    uint16         spikesMessage;    // 10 bits

    apAction_t()
    : ActionTarget(nullptr)
    , reaction(REACTION::NONE)
    , animation(0)
    , speceffect(SPECEFFECT::NONE)
    , knockback(0)
    , param(0)
    , messageID(0)
    , additionalEffect(SUBEFFECT_NONE)
    , addEffectParam(0)
    , addEffectMessage(0)
    , spikesEffect(SUBEFFECT_NONE)
    , spikesParam(0)
    , spikesMessage(0)
    {
    }
};

struct health_t
{
    int16 tp;
    int32 hp, mp;
    int32 maxhp, maxmp;
    int32 modhp, modmp; // modified maximum values
};

struct battlehistory_t
{
    ATTACK_TYPE lastHitTaken_atkType;
};

typedef std::vector<apAction_t> ActionList_t;
class CModifier;
class CParty;
class CStatusEffectContainer;
class CPetEntity;
class CSpell;
class CItemEquipment;
class CAbilityState;
class CAttackState;
class CMobSkillState;
class CWeaponSkillState;
class CMagicState;
class CDespawnState;
class CRangeState;
class CRecastContainer;
class CNotorietyContainer;
struct action_t;

class CBattleEntity : public CBaseEntity
{
public:
    CBattleEntity();
    virtual ~CBattleEntity();

    uint16 STR();
    uint16 DEX();
    uint16 VIT();
    uint16 AGI();
    uint16 INT();
    uint16 MND();
    uint16 CHR();
    uint16 DEF();
    uint16 ATT(SLOTTYPE slot);
    uint16 ACC(uint8 attackNumber, uint16 offsetAccuracy);
    uint16 EVA();
    uint16 RATT(uint8 skill, uint16 bonusSkill = 0);
    uint16 RACC(uint8 skill, uint16 bonusSkill = 0);

    bool isDead();
    bool isAlive();
    bool isInAdoulin();
    bool isInAssault();
    bool isInDynamis();
    bool isInMogHouse();
    bool hasImmunity(uint32 imID);
    bool isAsleep();
    bool isMounted();
    bool isSitting();

    JOBTYPE GetMJob();
    JOBTYPE GetSJob();
    uint8   GetMLevel() const;
    uint8   GetSLevel() const;

    void SetMJob(uint8 mjob);
    void SetSJob(uint8 sjob);
    void SetMLevel(uint8 mlvl);
    void SetSLevel(uint8 slvl);

    void  SetDeathType(uint8 type);
    uint8 GetDeathType();

    uint8 GetHPP() const;
    int32 GetMaxHP() const;
    uint8 GetMPP() const;
    int32 GetMaxMP() const;
    void  UpdateHealth(); // recalculation of the maximum amount of hp and mp, as well as adjusting their current values
    uint8 UpdateSpeed(bool run = false) override;

    int16  GetWeaponDelay(bool tp);              // returns delay of combined weapons
    float  GetMeleeRange() const;                // returns the distance considered to be within melee range of the entity
    int16  GetRangedWeaponDelay(bool forTPCalc); // returns delay of ranged weapon + ammo where applicable
    int16  GetAmmoDelay();                       // returns delay of ammo (for cooldown between shots)
    uint16 GetMainWeaponDmg();                   // returns total main hand DMG
    uint16 GetSubWeaponDmg();                    // returns total sub weapon DMG
    uint16 GetRangedWeaponDmg();                 // returns total ranged weapon DMG
    uint16 GetMainWeaponRank();                  // returns total main hand DMG Rank
    uint16 GetSubWeaponRank();                   // returns total sub weapon DMG Rank
    uint16 GetRangedWeaponRank();                // returns total ranged weapon DMG Rank

    uint16 GetSkill(uint16 SkillID); // the current value of the skill (not the maximum, but limited by the level)

    virtual int16 addTP(int16 tp); // increase/decrease the amount of tp
    virtual int32 addHP(int32 hp); // increase/decrease the amount of hp
    virtual int32 addMP(int32 mp); // increase/decrease the amount of mp

    // Deals damage and updates the last attacker which is used when sending a player death message
    virtual int32 takeDamage(int32 amount, CBattleEntity* attacker = nullptr, ATTACK_TYPE attackType = ATTACK_TYPE::NONE,
                             DAMAGE_TYPE damageType = DAMAGE_TYPE::NONE, bool isSkillchainDamage = false);

    int16 getMod(Mod modID);
    int16 getMaxGearMod(Mod modID);

    bool CanRest();        // checks if able to heal
    bool Rest(float rate); // heal an amount of hp / mp

    void addModifier(Mod type, int16 amount);
    void setModifier(Mod type, int16 amount);
    void delModifier(Mod type, int16 amount);
    void addModifiers(std::vector<CModifier>* modList);
    void addEquipModifiers(std::vector<CModifier>* modList, uint8 itemLevel, uint8 slotid);
    void setModifiers(std::vector<CModifier>* modList);
    void delModifiers(std::vector<CModifier>* modList);
    void delEquipModifiers(std::vector<CModifier>* modList, uint8 itemLevel, uint8 slotid);
    void saveModifiers();    // save current state of modifiers
    void restoreModifiers(); // restore to saved state

    void addPetModifier(Mod type, PetModType, int16 amount);
    void setPetModifier(Mod type, PetModType, int16 amount);
    void delPetModifier(Mod type, PetModType, int16 amount);
    void addPetModifiers(std::vector<CPetModifier>* modList);
    void delPetModifiers(std::vector<CPetModifier>* modList);
    void applyPetModifiers(CPetEntity* PPet);
    void removePetModifiers(CPetEntity* PPet);

    template <typename F, typename... Args>
    void ForParty(F func, Args&&... args)
    {
        if (PParty)
        {
            for (auto PMember : PParty->members)
            {
                func(PMember, std::forward<Args>(args)...);
            }
        }
        else
        {
            func(this, std::forward<Args>(args)...);
        }
    }

    template <typename F, typename... Args>
    void ForAlliance(F func, Args&&... args)
    {
        if (PParty)
        {
            if (PParty->m_PAlliance)
            {
                for (auto PAllianceParty : PParty->m_PAlliance->partyList)
                {
                    for (auto PMember : PAllianceParty->members)
                    {
                        func(PMember, std::forward<Args>(args)...);
                    }
                }
            }
            else
            {
                for (auto PMember : PParty->members)
                {
                    func(PMember, std::forward<Args>(args)...);
                }
            }
        }
        else
        {
            func(this);
        }
    }

    virtual void addTrait(CTrait*);
    virtual void delTrait(CTrait*);
    virtual bool hasTrait(uint16);

    virtual bool ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags);
    virtual bool CanUseSpell(CSpell*);

    virtual void Spawn() override;
    virtual void Die();
    uint16       GetBattleTargetID() const;
    void         SetBattleTargetID(uint16 id)
    {
        m_battleTarget = id;
    }
    CBattleEntity* GetBattleTarget();

    bool hasEnmityEXPENSIVE() const; // Returns true if own notoriety container is not empty or mob in zone has entity listed as battle target

    /* State callbacks */
    /* Auto attack */
    virtual bool OnAttack(CAttackState&, action_t&);
    virtual bool OnAttackError(CAttackState&)
    {
        return false;
    }
    /* Returns whether to call Attack or not (which includes error messages) */
    virtual bool           CanAttack(CBattleEntity* PTarget, std::unique_ptr<CBasicPacket>& errMsg);
    virtual CBattleEntity* IsValidTarget(uint16 targid, uint16 validTargetFlags, std::unique_ptr<CBasicPacket>& errMsg);
    virtual void           OnEngage(CAttackState&);
    virtual void           OnDisengage(CAttackState&);
    /* Casting */
    virtual void OnCastFinished(CMagicState&, action_t&);
    virtual void OnCastInterrupted(CMagicState&, action_t&, MSGBASIC_ID msg, bool blockedCast);
    /* Weaponskill */
    virtual void OnWeaponSkillFinished(CWeaponSkillState& state, action_t& action);
    virtual void OnMobSkillFinished(CMobSkillState& state, action_t& action);
    virtual void OnChangeTarget(CBattleEntity* PTarget);

    // Used to set an action to an "interrupted" state
    void setActionInterrupted(action_t& action, CBattleEntity* PTarget, uint16 messageID, uint16 actionID);

    virtual void OnAbility(CAbilityState&, action_t&)
    {
    }
    virtual void OnRangedAttack(CRangeState&, action_t&)
    {
    }
    virtual void OnDeathTimer();
    virtual void OnRaise()
    {
    }
    virtual void TryHitInterrupt(CBattleEntity* PAttacker);
    virtual void OnDespawn(CDespawnState&);

    void     SetBattleStartTime(time_point);
    duration GetBattleTime();

    void   setBattleID(uint16 battleID);
    uint16 getBattleID();

    virtual void Tick(time_point) override;
    virtual void PostTick() override;

    health_t health{}; // hp,mp,tp
    stats_t  stats{};
    skills_t WorkingSkills{};
    uint32   m_Immunity;     // Mob immunity
    uint16   m_magicEvasion; // store this so it can be removed easily
    bool     m_unkillable;   // entity is not able to die (probably until some action removes this flag)

    time_point charmTime; // to hold the time entity is charmed
    bool       isCharmed; // is the battle entity charmed?

    float           m_ModelRadius;  // The radius of the entity model, for calculating the range of a physical attack
    ECOSYSTEM       m_EcoSystem{};  // Entity eco system
    CItemEquipment* m_Weapons[4]{}; // Four main slots used to store weapons (weapons only)
    bool            m_dualWield;    // True/false depending on if the entity is using two weapons
    DEATH_TYPE      m_DeathType;

    TraitList_t TraitList;

    EntityID_t m_OwnerID{}; // ID of the attacking entity (after death will store the ID of the entity that dealt the final blow)

    ActionList_t m_ActionList{}; // List of actions performed in one attack (you will need to write a structure that includes an ActionList in which there will be categories, animations, etc.)

    CParty*         PParty;
    CBattleEntity*  PPet;
    CBattleEntity*  PMaster; // Owner/owner of the entity (applies to all combat entities)
    CBattleEntity*  PLastAttacker;
    time_point      LastAttacked;
    battlehistory_t BattleHistory{}; // Stores info related to most recent combat actions taken towards this entity.

    std::unique_ptr<CStatusEffectContainer> StatusEffectContainer;
    std::unique_ptr<CRecastContainer>       PRecastContainer;
    std::unique_ptr<CNotorietyContainer>    PNotorietyContainer;

private:
    JOBTYPE    m_mjob;
    JOBTYPE    m_sjob;
    uint8      m_mlvl; // CURRENT level of the main job
    uint8      m_slvl; // CURRENT level of the sub job
    uint16     m_battleTarget{ 0 };
    time_point m_battleStartTime;
    uint16     m_battleID = 0; // Current battle the entity is participating in. Battle ID must match in order for entities to interact with each other.

    std::unordered_map<Mod, int16, EnumClassHash>                                                m_modStat;     // array of modifiers
    std::unordered_map<Mod, int16, EnumClassHash>                                                m_modStatSave; // saved state
    std::unordered_map<PetModType, std::unordered_map<Mod, int16, EnumClassHash>, EnumClassHash> m_petMod;
};

#endif
