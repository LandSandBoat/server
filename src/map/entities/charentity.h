﻿/*
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

#pragma once

#include "event_info.h"
#include "monstrosity.h"
#include "packets/char.h"
#include "packets/entity_update.h"

#include "common/cbasetypes.h"
#include "common/mmo.h"

#include <bitset>
#include <deque>
#include <map>
#include <memory>
#include <unordered_map>
#include <unordered_set>

#include "battleentity.h"
#include "petentity.h"

#include "utils/fishingutils.h"
#include "utils/moduleutils.h"

#define MAX_QUESTAREA    11
#define MAX_QUESTID      256
#define MAX_MISSIONAREA  15
#define MAX_MISSIONID    851
#define MAX_ABYSSEAZONES 9

#define TIME_BETWEEN_PERSIST 2min

//
// Forward declarations
//

class CBasicPacket;
class CCharEntity;
class CItemWeapon;
class CTrustEntity;

namespace moduleutils
{
    void OnPushPacket(CCharEntity* PChar, CBasicPacket* packet);
}

//
// Helper structs
//

struct jobs_t
{
    uint32 unlocked;         // a bit field of the jobs unlocked. The bit indices are stored inside of of the JOBTYPE enumeration
    uint8  job[MAX_JOBTYPE]; // the current levels of each of the jobs from above
    uint16 exp[MAX_JOBTYPE]; // the experience points for each of the jobs above
    uint8  genkai;           // the maximum genkai level achieved

    jobs_t()
    : unlocked(0)
    , genkai(0)
    {
        std::memset(&job, 0, sizeof(job));
        std::memset(&exp, 0, sizeof(exp));
    }
};

struct profile_t
{
    uint8 nation; // Your Nation Allegiance.

    // Moghouse data (bit-packed)
    // 0x0001: SANDORIA exit quest flag
    // 0x0002: BASTOK exit quest flag
    // 0x0004: WINDURST exit quest flag
    // 0x0008: JEUNO exit quest flag
    // 0x0010: WEST_AHT_URHGAN exit quest flag
    // 0x0020: Unlocked Moghouse2F flag
    // 0x0040: Moghouse 2F tracker flag (0: default, 1: using 2F)
    // 0x0080: This bit and the next track which 2F decoration style is being used (0: SANDORIA, 1: BASTOK, 2: WINDURST, 3: PATIO)
    // 0x0100: ^ As above
    uint16 mhflag;

    uint16     title;
    uint16     fame[15];
    uint8      rank[3]; // RANK in three kingdoms
    uint16     rankpoints;
    location_t home_point;
    uint8      campaign_allegiance;
    uint8      unity_leader;

    profile_t()
    : nation(0)
    , mhflag(0)
    , title(0)
    , rankpoints(0)
    , campaign_allegiance(0)
    , unity_leader(0)
    {
        std::memset(&fame, 0, sizeof(fame));
        std::memset(&rank, 0, sizeof(rank));
    }
};

struct capacityChain_t
{
    uint16 chainNumber;
    uint32 chainTime;

    capacityChain_t()
    : chainNumber(0)
    , chainTime(0)
    {
    }
};

struct expChain_t
{
    uint16 chainNumber;
    uint32 chainTime;

    expChain_t()
    : chainNumber(0)
    , chainTime(0)
    {
    }
};

struct telepoint_t
{
    uint32 access[4];
    int32  menu[10];

    telepoint_t()
    {
        std::memset(&access, 0, sizeof(access));
        std::memset(&menu, 0, sizeof(menu));
    }
};

struct waypoint_t
{
    uint32 access[2];
    bool   confirmation;

    waypoint_t()
    {
        std::memset(&access, 0, sizeof(access));
        confirmation = false;
    }
};

struct teleport_t
{
    uint32      outpostSandy;
    uint32      outpostBastok;
    uint32      outpostWindy;
    uint32      runicPortal;
    uint32      pastMaw;
    uint32      campaignSandy;
    uint32      campaignBastok;
    uint32      campaignWindy;
    telepoint_t homepoint;
    telepoint_t survival;
    uint8       abysseaConflux[MAX_ABYSSEAZONES];
    waypoint_t  waypoints;
    uint32      eschanPortal;

    teleport_t()
    : outpostSandy(0)
    , outpostBastok(0)
    , outpostWindy(0)
    , runicPortal(0)
    , pastMaw(0)
    , campaignSandy(0)
    , campaignBastok(0)
    , campaignWindy(0)
    {
        std::memset(&abysseaConflux, 0, sizeof(abysseaConflux));
    }
};

struct PetInfo_t
{
    bool     respawnPet;   // Used for spawning pet on zone
    int32    jugSpawnTime; // Keeps track of original spawn time in seconds since epoch
    int32    jugDuration;  // Number of seconds a jug pet should last after its original spawn time
    uint8    petID;        // ID as in wyvern(48) , carbuncle(8) ect..
    PET_TYPE petType;      // Type of pet being transferred
    uint8    petLevel;     // Level the pet was spawned with
    int16    petHP;
    int16    petMP;
    float    petTP;
};

struct AuctionHistory_t
{
    uint16 itemid;
    uint8  stack;
    uint32 price;
    uint8  status; // e.g. if sold/not sold/on market
};

struct UnlockedAttachments_t
{
    uint8  heads;
    uint8  frames;
    uint32 attachments[8];
};

struct GearSetMod_t
{
    uint8  setId;
    Mod    modId;
    uint16 modValue;
};

enum CHAR_HISTORY
{
    ENEMIES_DEFEATED = 0,
    TIMES_KNOCKED_OUT,
    MH_ENTRANCES,
    JOINED_PARTIES,
    JOINED_ALLIANCES,
    SPELLS_CAST,
    ABILITIES_USED,
    WS_USED,
    ITEMS_USED,
    CHATS_SENT,
    NPC_INTERACTIONS,
    BATTLES_FOUGHT,
    GM_CALLS,
    DISTANCE_TRAVELLED,
};

struct CharHistory_t
{
    uint32 enemiesDefeated   = 0;
    uint32 timesKnockedOut   = 0;
    uint32 mhEntrances       = 0;
    uint32 joinedParties     = 0;
    uint32 joinedAlliances   = 0;
    uint32 spellsCast        = 0;
    uint32 abilitiesUsed     = 0;
    uint32 wsUsed            = 0;
    uint32 itemsUsed         = 0;
    uint32 chatsSent         = 0;
    uint32 npcInteractions   = 0;
    uint32 battlesFought     = 0;
    uint32 gmCalls           = 0;
    uint32 distanceTravelled = 0;
};

enum CHAR_SUBSTATE
{
    SUBSTATE_NONE = 0,
    SUBSTATE_IN_CS,
    SUBSTATE_LAST,
};

enum CHAR_PERSIST : uint8
{
    EQUIP     = 0x01,
    POSITION  = 0x02,
    EFFECTS   = 0x04,
    LINKSHELL = 0x08,
};

class CBasicPacket;
class CLinkshell;
class CUnityChat;
class CJobPoints;
class CMeritPoints;
class CCharRecastContainer;
class CLatentEffectContainer;
class CTradeContainer;
class CItemContainer;
class CUContainer;
class CItemEquipment;
class CAutomatonEntity;
class CAbilityState;
class CRangeState;
class CItemState;
class CItemUsable;

typedef std::deque<std::unique_ptr<CBasicPacket>> PacketList_t;
typedef std::map<uint32, CBaseEntity*>            SpawnIDList_t;
typedef std::vector<EntityID_t>                   BazaarList_t;

class CCharEntity : public CBattleEntity
{
public:
    uint32 accid; // Account ID associated with the character.

    jobs_t     jobs; // Available Character jobs
    keyitems_t keys; // Table key objects

    EventPrep*            eventPreparation; // Information about a potential upcoming event
    EventInfo*            currentEvent;     // The currently ongoing event playing for the player
    std::list<EventInfo*> eventQueue;       // The queued events to play for the player
    bool                  inSequence;       // True if the player is locked in a NPC sequence
    bool                  gotMessage;       // Used to let the interaction framework know that a message outside of it was triggered.

    skills_t RealSkills; // The structure of all the real skills of the character, with an accuracy of 0.1 and not limited by the level

    uint8 visibleGmLevel;        // See GmLevel of flags0_t
    bool  wallhackEnabled;       // GM walk through walls
    bool  isSettingBazaarPrices; // Is setting bazaar prices (temporarily hide bazaar)
    bool  isLinkDead;            // Player is d/cing

    SAVE_CONF playerConfig; // Various settings such as chat filter, display head flag, new adventurer, autotarget, etc.

    uint32 lastOnline{ 0 };              // UTC Unix Timestamp of the last time char zoned or logged out
    bool   isNewPlayer() const;          // Checks if new player bit is unset.
    bool   isSeekingParty() const;       // is seeking party or not
    bool   isAnon() const;               // is /anon
    bool   isAway() const;               // is /away (tells will not go through)
    bool   isMentor() const;             // If player is a mentor or not.
    bool   hasAutoTargetEnabled() const; // has autotarget enabled

    profile_t       profile;
    capacityChain_t capacityChain;
    expChain_t      expChain;
    search_t        search;              // Data and comment displayed in the search box
    bazaar_t        bazaar;              // All the data you need to run bazaar
    uint16          m_EquipFlag;         // Current events handled by the equipment (later it will be packed into a structure, along with equip[])
    uint16          m_EquipBlock;        // Locked equipment slots
    uint16          m_StatsDebilitation; // Debilitation arrows
    uint8           equip[18]{};         // SlotID where equipment is
    uint8           equipLoc[18]{};      // ContainerID where equipment is
    uint16          styleItems[16]{};    // Item IDs for items that are style locked.

    uint8             m_ZonesList[38]{};        // List of zones visited by the character
    std::bitset<1024> m_SpellList;              // List of learned spells
    uint8             m_TitleList[143]{};       // List of obtained titles
    uint8             m_Abilities[64]{};        // List of current abilities
    uint8             m_LearnedAbilities[49]{}; // Learnable abilities (corsair rolls)
    std::bitset<64>   m_LearnedWeaponskills;    // Learnable Weaponskills
    uint8             m_TraitList[18]{};        // List of active job traits in the form of a bit mask
    uint8             m_PetCommands[64]{};
    uint8             m_WeaponSkills[32]{};
    questlog_t        m_questLog[MAX_QUESTAREA];     // Quest List
    missionlog_t      m_missionLog[MAX_MISSIONAREA]; // Mission list
    eminencelog_t     m_eminenceLog;                 // Record of Eminence log
    eminencecache_t   m_eminenceCache;               // Caching data for Eminence lookups
    assaultlog_t      m_assaultLog;                  // Assault mission list
    campaignlog_t     m_campaignLog;                 // Campaign mission list
    uint32            m_lastBcnmTimePrompt;          // The last message prompt in seconds
    PetInfo_t         petZoningInfo{};               // Used to repawn dragoons pets ect on zone

    void setPetZoningInfo();              // Set pet zoning info (when zoning and logging out)
    void resetPetZoningInfo();            // Reset pet zoning info (when changing job ect)
    bool shouldPetPersistThroughZoning(); // If true, zoning should not cause a currently active pet to despawn

    uint8  m_SetBlueSpells[20]{}; // The 0x200 offsetted blue magic spell IDs which the user has set. (1 byte per spell)
    uint32 m_FieldChocobo{};
    uint32 m_claimedDeeds[5]{};
    uint32 m_uniqueEvents[5]{};

    UnlockedAttachments_t m_unlockedAttachments{}; // Unlocked Automaton Attachments (1 bit per attachment)
    CAutomatonEntity*     PAutomaton;              // Automaton statistics

    std::vector<CTrustEntity*> PTrusts; // Active trusts

    template <typename F, typename... Args>
    void ForPartyWithTrusts(F const& func, Args&&... args);

    CBattleEntity* PClaimedMob;

    // These missions do not need a list of completed, because client automatically
    // displays earlier missions completed

    uint16 m_copCurrent; // current mission of Chains of Promathia
    uint16 m_acpCurrent; // current mission of A Crystalline Prophecy
    uint16 m_mkeCurrent; // current mission of A Moogle Kupo d'Etat
    uint16 m_asaCurrent; // current mission of A Shantotto Ascension

    // currency_t        m_currency;                 // conquest points, imperial standing points etc
    teleport_t teleport; // Outposts, Runic Portals, Homepoints, Survival Guides, Maws, etc.

    uint8 GetGender();

    void clearPacketList();

    template <typename T, typename... Args>
    void pushPacket(Args&&... args);

    template <typename T>
    void pushPacket(std::unique_ptr<T>&& packet);

    void updateCharPacket(CCharEntity* PChar, ENTITYUPDATE type, uint8 updatemask);     // Push or update a char packet
    void updateEntityPacket(CBaseEntity* PEntity, ENTITYUPDATE type, uint8 updatemask); // Push or update an entity update packet
    bool isPacketListEmpty();
    auto popPacket() -> std::unique_ptr<CBasicPacket>; // Get first packet from PacketList
    auto getPacketListCopy() -> PacketList_t;          // Return a COPY of packet list
    auto getPacketList() -> PacketList_t&;             // Return a REFERENCE to packet list
    auto getPacketCount() -> size_t;
    void erasePackets(uint8 num); // Erase num elements from front of packet list

    virtual void HandleErrorMessage(std::unique_ptr<CBasicPacket>&) override;

    CLinkshell*    PLinkshell1;
    CLinkshell*    PLinkshell2;
    CUnityChat*    PUnityChat;
    CTreasurePool* PTreasurePool;
    CMeritPoints*  PMeritPoints;
    CJobPoints*    PJobPoints;
    bool           MeritMode;

    CLatentEffectContainer* PLatentEffectContainer;
    bool                    retriggerLatents; // used to retrigger all latent effects if some event requires them to be retriggered

    CItemContainer* PGuildShop;
    CItemContainer* getStorage(uint8 LocationID);

    CTradeContainer* TradeContainer; // Container used specifically for trading.
    CTradeContainer* Container;      // Universal container for exchange, synthesis, store, etc.
    CUContainer*     UContainer;     // Container used for universal actions -- used for trading at least despite the dedicated trading container above
    CTradeContainer* CraftContainer; // Container used for crafting actions.

    CBaseEntity* PWideScanTarget;

    SpawnIDList_t SpawnPCList;    // list of visible characters
    SpawnIDList_t SpawnMOBList;   // list of visible monsters
    SpawnIDList_t SpawnPETList;   // list of visible pets
    SpawnIDList_t SpawnTRUSTList; // list of visible trust
    SpawnIDList_t SpawnNPCList;   // list of visible npcs

    void SetName(const std::string& name); // set the name of character, limited to 15 characters

    time_point   lastTradeInvite;
    EntityID_t   TradePending{};  // Character ID offering trade
    EntityID_t   InvitePending{}; // Character ID sending party invite
    EntityID_t   BazaarID{};      // Pointer to the bazaar we are browsing.
    BazaarList_t BazaarCustomers; // Array holding the IDs of the current customers

    std::unique_ptr<monstrosity::MonstrosityData_t> m_PMonstrosity;

    uint32     m_InsideTriggerAreaID; // The ID of the trigger area the character is inside
    uint8      m_LevelRestriction;    // Character level limit
    uint16     m_Costume;
    uint16     m_Costume2;
    uint32     m_AHHistoryTimestamp;
    uint32     m_DeathTimestamp;
    time_point m_deathSyncTime; // Timer used for sending an update packet at a regular interval while the character is dead

    uint8      m_hasTractor;      // checks if player has tractor already
    uint8      m_hasRaise;        // checks if player has raise already
    uint8      m_weaknessLvl;     // tracks if the player was previously weakend
    bool       m_hasArise;        // checks if the white magic spell arise was cast on the player and a re-raise effect should be applied
    position_t m_StartActionPos;  // action start position (item use, shooting start, tractor position)
    position_t m_ActionOffsetPos; // action offset position from the action packet(currently only used for repositioning of luopans)

    location_t m_previousLocation;

    uint32 m_PlayTime;
    uint32 m_SaveTime;

    uint32 m_LastYell;

    time_point m_LeaderCreatedPartyTime; // Time that a party member joined and this player was leader.

    uint8 m_GMlevel;    // Level of the GM flag assigned to this character
    bool  m_isGMHidden; // GM Hidden flag to prevent player updates from being processed.

    bool   m_mentorUnlocked;
    bool   m_jobMasterDisplay; // Job Master Stars display
    uint32 m_moghouseID;
    uint16 m_moghancementID;

    CharHistory_t m_charHistory;

    int8  getShieldSize();
    int16 getShieldDefense();
    bool  hasBazaar();

    bool getStyleLocked() const;
    void setStyleLocked(bool isStyleLocked);
    bool getBlockingAid() const;
    void setBlockingAid(bool isBlockingAid);

    bool       m_EquipSwap; // true if equipment was recently changed
    bool       m_EffectsChanged;
    time_point m_LastSynthTime;
    time_point m_LastRangedAttackTime;

    CHAR_SUBSTATE m_Substate;

    int16 addTP(int16 tp) override;
    int32 addHP(int32 hp) override;
    int32 addMP(int32 mp) override;

    std::vector<GearSetMod_t>     m_GearSetMods; // The list of gear set mods currently applied to the character.
    std::vector<AuctionHistory_t> m_ah_history;  // AH history list (in the future consider using UContainer)

    std::unordered_map<uint16, uint32> m_PacketRecievedTimestamps;

    void   SetPlayTime(uint32 playTime);        // Set playtime
    uint32 GetPlayTime(bool needUpdate = true); // Get playtime

    CItemEquipment* getEquip(SLOTTYPE slot);

    std::unique_ptr<CBasicPacket> PendingPositionPacket = nullptr;

    bool requestedInfoSync = false;

    fishresponse_t* hookedFish;   // Currently hooked fish/item/monster
    uint32          nextFishTime; // When char is allowed to fish again
    uint32          lastCastTime; // When char last cast their rod
    uint32          fishingToken; // To track fishing process
    uint8           hookDelay;    // How long it takes to hook a fish

    void ReloadPartyInc();
    void ReloadPartyDec();
    bool ReloadParty() const;
    void ClearTrusts();
    void RemoveTrust(CTrustEntity*);

    void RequestPersist(CHAR_PERSIST toPersist);
    bool PersistData();
    bool PersistData(time_point tick);

    virtual void Tick(time_point) override;
    void         PostTick() override;

    virtual void addTrait(CTrait*) override;
    virtual void delTrait(CTrait*) override;

    virtual bool ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags) override;
    virtual bool CanUseSpell(CSpell*) override;
    bool         IsMobOwner(CBattleEntity* PTarget);

    virtual void Die() override;
    void         Die(duration _duration);
    void         Raise();

    static constexpr duration death_duration         = 60min;
    static constexpr duration death_update_frequency = 16s;

    void  SetDeathTimestamp(uint32 timestamp);
    int32 GetSecondsElapsedSinceDeath() const;
    int32 GetTimeRemainingUntilDeathHomepoint() const;

    int32 GetTimeCreated();
    uint8 getHighestJobLevel();

    bool isInEvent();
    bool isNpcLocked();
    void queueEvent(EventInfo* eventToQueue);
    void endCurrentEvent();
    void tryStartNextEvent();
    void skipEvent();
    void setLocked(bool locked);

    void UpdateMoghancement();
    bool hasMoghancement(uint16 moghancementID) const;
    void SetMoghancement(uint16 moghancementID);

    /* State callbacks */
    virtual bool           CanAttack(CBattleEntity* PTarget, std::unique_ptr<CBasicPacket>& errMsg) override;
    virtual bool           OnAttack(CAttackState&, action_t&) override;
    virtual bool           OnAttackError(CAttackState&) override;
    virtual CBattleEntity* IsValidTarget(uint16 targid, uint16 validTargetFlags, std::unique_ptr<CBasicPacket>& errMsg) override;
    virtual void           OnChangeTarget(CBattleEntity* PNewTarget) override;
    virtual void           OnEngage(CAttackState&) override;
    virtual void           OnDisengage(CAttackState&) override;
    virtual void           OnCastFinished(CMagicState&, action_t&) override;
    virtual void           OnCastInterrupted(CMagicState&, action_t&, MSGBASIC_ID msg, bool blockedCast) override;
    virtual void           OnWeaponSkillFinished(CWeaponSkillState&, action_t&) override;
    virtual void           OnAbility(CAbilityState&, action_t&) override;
    virtual void           OnRangedAttack(CRangeState&, action_t&) override;
    virtual void           OnDeathTimer() override;
    virtual void           OnRaise() override;

    virtual void OnItemFinish(CItemState&, action_t&);

    int32 getCharVar(std::string const& varName);
    void  setCharVar(std::string const& varName, int32 value, uint32 expiry = 0);
    void  setVolatileCharVar(std::string const& varName, int32 value, uint32 expiry = 0);
    void  updateCharVarCache(std::string const& varName, int32 value, uint32 expiry = 0);
    void  removeFromCharVarCache(std::string const& varName);

    void clearCharVarsWithPrefix(std::string const& prefix);

    bool m_Locked; // Is the player locked in a cutscene

    CCharEntity();
    ~CCharEntity();

protected:
    void changeMoghancement(uint16 moghancementID, bool isAdding);
    void TrackArrowUsageForScavenge(CItemWeapon* PAmmo);

private:
    std::unique_ptr<CItemContainer> m_Inventory;
    std::unique_ptr<CItemContainer> m_Mogsafe;
    std::unique_ptr<CItemContainer> m_Storage;
    std::unique_ptr<CItemContainer> m_Tempitems;
    std::unique_ptr<CItemContainer> m_Moglocker;
    std::unique_ptr<CItemContainer> m_Mogsatchel;
    std::unique_ptr<CItemContainer> m_Mogsack;
    std::unique_ptr<CItemContainer> m_Mogcase;
    std::unique_ptr<CItemContainer> m_Wardrobe;
    std::unique_ptr<CItemContainer> m_Mogsafe2;
    std::unique_ptr<CItemContainer> m_Wardrobe2;
    std::unique_ptr<CItemContainer> m_Wardrobe3;
    std::unique_ptr<CItemContainer> m_Wardrobe4;
    std::unique_ptr<CItemContainer> m_Wardrobe5;
    std::unique_ptr<CItemContainer> m_Wardrobe6;
    std::unique_ptr<CItemContainer> m_Wardrobe7;
    std::unique_ptr<CItemContainer> m_Wardrobe8;
    std::unique_ptr<CItemContainer> m_RecycleBin;

    bool m_isStyleLocked;
    bool m_isBlockingAid;
    bool m_reloadParty;

    std::unordered_map<std::string, std::pair<int32, uint32>> charVarCache;
    std::unordered_set<std::string>                           charVarChanges;

    uint8      dataToPersist = 0;
    time_point nextDataPersistTime;

    PacketList_t                                                     PacketList;           // The list of packets to be sent to the character during the next network cycle
    std::unordered_map<uint32, std::unique_ptr<CCharPacket>>         PendingCharPackets;   // Keep track of which char packets are queued up for this char, such that they can be updated
    std::unordered_map<uint32, std::unique_ptr<CEntityUpdatePacket>> PendingEntityPackets; // Keep track of which entity update packets are queued up for this char, such that they can be updated
};

//
// Inline functions
//

template <typename F, typename... Args>
void CCharEntity::ForPartyWithTrusts(F const& func, Args&&... args)
{
    if (PParty)
    {
        for (auto* PMember : PParty->members)
        {
            func(PMember, std::forward<Args>(args)...);
        }
        for (auto* PMember : PParty->members)
        {
            if (auto* PCharMember = dynamic_cast<CCharEntity*>(PMember))
            {
                for (auto* PTrust : PCharMember->PTrusts)
                {
                    func(PTrust, std::forward<Args>(args)...);
                }
            }
        }
    }
    else
    {
        func(this, std::forward<Args>(args)...);
        for (auto PTrust : this->PTrusts)
        {
            func(PTrust, std::forward<Args>(args)...);
        }
    }
}

template <typename T, typename... Args>
void CCharEntity::pushPacket(Args&&... args)
{
    TracyZoneScoped;

    pushPacket<T>(std::make_unique<T>(std::forward<Args>(args)...));
}

template <typename T>
void CCharEntity::pushPacket(std::unique_ptr<T>&& packet)
{
    TracyZoneScoped;
    TracyZoneString(this->getName());
    TracyZoneHex16(packet->getType());

    // TODO: Don't use raw ptrs here
    moduleutils::OnPushPacket(this, packet.get());
    if (packet.get() == nullptr)
    {
        return;
    }

    if (packet->getType() == 0x5B)
    {
        if (PendingPositionPacket)
        {
            PendingPositionPacket = std::move(packet);
        }
        else
        {
            PendingPositionPacket = packet->copy();
            PacketList.emplace_back(std::move(packet));
        }
    }
    else
    {
        PacketList.emplace_back(std::move(packet));
    }
}
