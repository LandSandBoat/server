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

#include "common/types/hash_map.h"

#include <set>
#include <type_traits>
#include <vector>

#include "alliance.h"
#include "base_entity.h"
#include "enums/msg_basic.h"
#include "modifier.h"

#include "data/enums/attack_type.h"
#include "data/enums/damage_type.h"
#include "data/enums/ecosystem.h"
#include "data/enums/immunity.h"
#include "data/enums/skill_type.h"
#include "party.h"
#include "trait.h"

#include <map/entities/types/health.h>

enum class DEATH_TYPE : uint8
{
    NONE        = 0,
    PHYSICAL    = 1,
    MAGICAL     = 2,
    WS_PHYSICAL = 3,
    WS_MAGICAL  = 4,
};
DECLARE_FORMAT_AS_UNDERLYING(DEATH_TYPE);

enum JOBTYPE : uint8
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

#define MAX_SKILLTYPE 64

enum SUBSKILLTYPE : uint8
{
    SUBSKILL_XBOW_SHORTBOW = 0,
    SUBSKILL_GUN           = 1,
    SUBSKILL_CANNON        = 2,
    SUBSKILL_SHURIKEN      = 3,
    SUBSKILL_LONGBOW       = 4,

    SUBSKILL_ANIMATOR    = 10,
    SUBSKILL_ANIMATOR_II = 11,

    // Ammo subskill types can map to jug pets, this is handled completely in lua
};

DECLARE_FORMAT_AS_UNDERLYING(SUBSKILLTYPE);

enum SLOTTYPE : uint8
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

enum TARGETTYPE : uint16
{
    TARGET_NONE                    = 0x0000,
    TARGET_SELF                    = 0x0001,
    TARGET_PLAYER_PARTY            = 0x0002,
    TARGET_ENEMY                   = 0x0004,
    TARGET_PLAYER_ALLIANCE         = 0x0008,
    TARGET_PLAYER                  = 0x0010,
    TARGET_PLAYER_DEAD             = 0x0020,
    TARGET_NPC                     = 0x0040, // an npc is a mob that looks like an npc and fights on the side of the character
    TARGET_PLAYER_PARTY_PIANISSIMO = 0x0080,
    TARGET_PET                     = 0x0100,
    TARGET_PLAYER_PARTY_ENTRUST    = 0x0200,
    TARGET_IGNORE_BATTLEID         = 0x0400, // Can hit targets that do not have the same battle ID
    TARGET_ANY_ALLEGIANCE          = 0x0800, // Can hit targets from any allegiance simultaneously. To be used with other flags above and only makes sense for non-single-target skills
};

DECLARE_FORMAT_AS_UNDERLYING(TARGETTYPE);

enum SKILLCHAIN_ELEMENT : uint8
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

DECLARE_FORMAT_AS_UNDERLYING(SKILLCHAIN_ELEMENT);

struct battlehistory_t
{
    xi::AttackType lastHitTaken_atkType;
};

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
    ~CBattleEntity() override;

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
    auto   RATT(uint16 bonusAtt = 0) -> uint16;
    auto   RACC(uint16 bonusAcc = 0) -> uint16;

    auto isDead() const -> bool;
    bool isAlive();
    bool isFullyHealed();
    bool isInAdoulin();
    bool isInAssault();
    bool isInDynamis();
    bool isInGarrison();
    bool inMogHouse();
    bool hasImmunity(xi::Immunity imID);
    bool isAsleep();
    auto isMounted() const -> bool;
    bool isSitting();

    JOBTYPE GetMJob() const;
    JOBTYPE GetSJob(bool ignoreRestriction = false) const;
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

    bool          IsDualWielding();
    auto          GetWeaponDelay(bool tp) -> uint32;                // returns delay of combined weapons
    float         GetMeleeRange(const CBattleEntity* Target) const; // returns the distance considered to be within melee range of the entity
    virtual float GetRangedAttackRange();                           // returns the maximum valid distance for a ranged attack
    int16         GetRangedWeaponDelay(bool forTPCalc);             // returns delay of ranged weapon + ammo where applicable
    int16         GetAmmoDelay();                                   // returns delay of ammo (for cooldown between shots)
    uint16        GetMainWeaponDmg();                               // returns total main hand DMG
    uint16        GetSubWeaponDmg();                                // returns total sub weapon DMG
    uint16        GetRangedWeaponDmg();                             // returns total ranged weapon DMG
    uint16        GetMainWeaponRank();                              // returns total main hand DMG Rank
    uint16        GetSubWeaponRank();                               // returns total sub weapon DMG Rank
    uint16        GetRangedWeaponRank();                            // returns total ranged weapon DMG Rank

    uint16 GetSkill(xi::SkillType SkillID); // the current value of the skill (not the maximum, but limited by the level)

    virtual int16 addTP(int16 tp); // increase/decrease the amount of tp
    virtual int32 addHP(int32 hp); // increase/decrease the amount of hp
    virtual int32 addMP(int32 mp); // increase/decrease the amount of mp

    // Deals damage and updates the last attacker which is used when sending a player death message
    virtual auto takeDamage(int32 amount, CBattleEntity* attacker = nullptr, xi::AttackType attackType = xi::AttackType::None, xi::DamageType damageType = xi::DamageType::None, bool isSkillchainDamage = false) -> int32;

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
    void savePetModifiers(); // saves dynamic pet modifiers

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

    void SetBattleTargetID(uint16 id)
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
    virtual void OnCastInterrupted(CMagicState&, action_t&, MsgBasic msg, bool blockedCast);
    /* Weaponskill */
    virtual void OnWeaponSkillFinished(CWeaponSkillState& state, action_t& action);
    virtual void OnMobSkillFinished(CMobSkillState& state, action_t& action);
    virtual void OnChangeTarget(CBattleEntity* PTarget);

    virtual void OnAbility(CAbilityState&, action_t&);
    virtual void OnRangedAttack(CRangeState&, action_t&);
    void         processActionEffectFlags(const action_t& action) const; // Drops status effects whose flags are tied to action emit/receive.
    virtual void OnDeathTimer();

    virtual void OnRaise()
    {
    }

    virtual void TryHitInterrupt(CBattleEntity* PAttacker);
    virtual void OnDespawn(CDespawnState&);

    void            SetBattleStartTime(timer::time_point);
    timer::duration GetBattleTime();

    void   setBattleID(uint16 battleID);
    uint16 getBattleID();

    virtual auto Tick(timer::time_point) -> Task<void> override;
    virtual void PostTick() override;

    Health       health{}; // hp, mp, tp, etc.
    stats_t      stats{};
    skills_t     WorkingSkills{};
    xi::Immunity m_Immunity;     // Mob immunity
    uint16       m_magicEvasion; // store this so it can be removed easily
    bool         m_unkillable;   // entity is not able to die (probably until some action removes this flag)

    timer::time_point charmTime; // to hold the time entity is charmed
    bool              isCharmed; // is the battle entity charmed?

    xi::Ecosystem   m_EcoSystem{};  // Entity eco system
    CItemEquipment* m_Weapons[4]{}; // Four main slots used to store weapons (weapons only)
    bool            m_dualWield;    // True/false depending on if the entity is using two weapons
    DEATH_TYPE      m_DeathType;

    TraitList_t TraitList;

    EntityID_t m_OwnerID{}; // ID of the attacking entity (after death will store the ID of the entity that dealt the final blow)

    CParty*           PParty;
    CBattleEntity*    PPet;
    CBattleEntity*    PMaster; // Owner/owner of the entity (applies to all combat entities)
    EntityID_t        lastAttackerId_{};
    timer::time_point LastAttacked;
    timer::time_point m_LastRangedAttackTime{}; // Used to track ranged attack delay and prevent attacks that are too close together
    battlehistory_t   BattleHistory{};          // Stores info related to most recent combat actions taken towards this entity.

    std::unique_ptr<CStatusEffectContainer> StatusEffectContainer;
    std::unique_ptr<CRecastContainer>       PRecastContainer;
    std::unique_ptr<CNotorietyContainer>    PNotorietyContainer;

private:
    JOBTYPE           m_mjob;
    JOBTYPE           m_sjob;
    uint8             m_mlvl; // CURRENT level of the main job
    uint8             m_slvl; // CURRENT level of the sub job
    uint16            m_battleTarget{ 0 };
    timer::time_point m_battleStartTime;
    uint16            m_battleID = 0; // Current battle the entity is participating in. Battle ID must match in order for entities to interact with each other.

    HashMap<Mod, int16, EnumClassHash>                                     m_modStat;     // array of modifiers
    HashMap<Mod, int16, EnumClassHash>                                     m_modStatSave; // saved state
    HashMap<PetModType, HashMap<Mod, int16, EnumClassHash>, EnumClassHash> m_petMod;

    // The mod maps MUST be node-based (HashMap): references into them are held while
    // other entries are inserted, and a flat/dense map relocates its storage on growth.
    static_assert(std::is_same_v<decltype(m_modStat), HashMap<Mod, int16, EnumClassHash>>);
    static_assert(std::is_same_v<decltype(m_modStatSave), HashMap<Mod, int16, EnumClassHash>>);
    static_assert(std::is_same_v<decltype(m_petMod), HashMap<PetModType, HashMap<Mod, int16, EnumClassHash>, EnumClassHash>>);
};

#endif
