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

#ifndef _CHARENTITY_H
#define _CHARENTITY_H

#include "../../common/cbasetypes.h"
#include "../../common/mmo.h"

#include <bitset>
#include <deque>
#include <map>
#include <mutex>
#include <unordered_map>

#include "battleentity.h"
#include "petentity.h"

#define MAX_QUESTAREA   11
#define MAX_QUESTID     256
#define MAX_MISSIONAREA 15
#define MAX_MISSIONID   851

class CItemWeapon;
class CTrustEntity;

struct jobs_t
{
    uint32 unlocked;         // a bit field of the jobs unlocked. The bit indices are stored inside of of the JOBTYPE enumeration
    uint8  job[MAX_JOBTYPE]; // the current levels of each of the jobs from above
    uint16 exp[MAX_JOBTYPE]; // the experience points for each of the jobs above
    uint8  genkai;           // the maximum genkai level achieved
};

struct event_t
{
    int32 EventID;
    int32 Option; // dummy return result

    CBaseEntity* Target; // event initiator

    // TODO: Change this to something more descriptive
    string_t Script; // path to the file responsible for handling the event

    void reset()
    {
        EventID = -1;
        Option  = 0;
        Target  = 0;
        Script.clear();
    }
};

struct profile_t
{
    uint8      nation;     // your nation alligeance
    uint8      mhflag;     // флаг выхода из MogHouse
    uint16     title;      // звание
    uint16     fame[15];   // известность
    uint8      rank[3];    // рагн в трех государствах
    uint32     rankpoints; // очки ранга в трех государствах
    location_t home_point; // точка возрождения персонажа
    uint8      campaign_allegiance;
    uint8      unity_leader;
};

struct capacityChain_t
{
    uint16 chainNumber;
    uint32 chainTime;
};

struct expChain_t
{
    uint16 chainNumber;
    uint32 chainTime;
};

struct Telepoint_t
{
    uint32 access[4];
    int32  menu[10];
};

struct Teleport_t
{
    uint32      outpostSandy;
    uint32      outpostBastok;
    uint32      outpostWindy;
    uint32      runicPortal;
    uint32      pastMaw;
    uint32      campaignSandy;
    uint32      campaignBastok;
    uint32      campaignWindy;
    Telepoint_t homepoint;
    Telepoint_t survival;
};

struct PetInfo_t
{
    bool     respawnPet; // used for spawning pet on zone
    uint8    petID;      // id as in wyvern(48) , carbuncle(8) ect..
    PET_TYPE petType;    // type of pet being transfered
    int16    petHP;      // pets hp
    int16    petMP;
    float    petTP; // pets tp
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
    uint8  modNameId;
    Mod    modId;
    uint16 modValue;
};

enum CHAR_SUBSTATE
{
    SUBSTATE_NONE = 0,
    SUBSTATE_IN_CS,
    SUBSTATE_LAST,
};

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

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

typedef std::deque<CBasicPacket*>      PacketList_t;
typedef std::map<uint32, CBaseEntity*> SpawnIDList_t;
typedef std::vector<EntityID_t>        BazaarList_t;

class CCharEntity : public CBattleEntity
{
public:
    jobs_t     jobs;       // доступрые профессии персонажа
    keyitems_t keys;       // таблица ключевых предметов
    event_t    m_event;    // структура для запуска событый
    bool       inSequence; // True if the player is locked in a NPC sequence
    bool       gotMessage; // Used to let the interaction framework know that a message outside of it was triggered.
    skills_t   RealSkills; // структура всех реальных умений персонажа, с точностью до 0.1 и не ограниченных уровнем

    nameflags_t nameflags;           // флаги перед именем персонажа
    nameflags_t menuConfigFlags;     // These flags are used for MenuConfig packets. Some nameflags values are duplicated.
    uint32      lastOnline{ 0 };     // UTC Unix Timestamp of the last time char zoned or logged out
    bool        isNewPlayer() const; // Checks if new player bit is unset.

    profile_t  profile;             // профиль персонажа (все, что связывает города и персонажа)
    capacityChain_t capacityChain;  // Capacity Point Chains
    expChain_t expChain;            // Exp Chains
    search_t   search;              // данные и комментарий, отображаемые в окне поиска
    bazaar_t   bazaar;              // все данные, необходимые для таботы bazaar
    uint16     m_EquipFlag;         // текущие события, обрабатываемые экипировкой (потом упакую в структуру, вместе с equip[])
    uint16     m_EquipBlock;        // заблокированные ячейки экипировки
    uint16     m_StatsDebilitation; // Debilitation arrows
    uint8      equip[18];           //      SlotID where equipment is
    uint8      equipLoc[18];        // ContainerID where equipment is
    uint16     styleItems[16];      // Item IDs for items that are style locked.

    uint8             m_ZonesList[36];        // список посещенных персонажем зон
    std::bitset<1024> m_SpellList;            // список изученных заклинаний
    uint8             m_TitleList[94];        // список заслуженных завний
    uint8             m_Abilities[62];        // список текущих способностей
    uint8             m_LearnedAbilities[49]; // learnable abilities (corsair rolls)
    std::bitset<49>   m_LearnedWeaponskills;  // learnable weaponskills
    uint8             m_TraitList[16];        // список постянно активных способностей в виде битовой маски
    uint8             m_PetCommands[32];      // список доступных команд питомцу
    uint8             m_WeaponSkills[32];
    questlog_t        m_questLog[MAX_QUESTAREA];     // список всех квестов
    missionlog_t      m_missionLog[MAX_MISSIONAREA]; // список миссий
    eminencelog_t     m_eminenceLog;                 // Record of Eminence log
    eminencecache_t   m_eminenceCache;               // Caching data for Eminence lookups
    assaultlog_t      m_assaultLog;                  // список assault миссий
    campaignlog_t     m_campaignLog;                 // список campaign миссий
    uint32            m_lastBcnmTimePrompt;          // the last message prompt in seconds
    PetInfo_t         petZoningInfo;                 // used to repawn dragoons pets ect on zone
    void              setPetZoningInfo();            // set pet zoning info (when zoning and logging out)
    void              resetPetZoningInfo();          // reset pet zoning info (when changing job ect)
    uint8             m_SetBlueSpells[20];           // The 0x200 offsetted blue magic spell IDs which the user has set. (1 byte per spell)

    UnlockedAttachments_t m_unlockedAttachments; // Unlocked Automaton Attachments (1 bit per attachment)
    CAutomatonEntity*     PAutomaton;            // Automaton statistics

    std::vector<CTrustEntity*> PTrusts; // Active trusts
    template <typename F, typename... Args>
    void ForPartyWithTrusts(F func, Args&&... args)
    {
        if (PParty)
        {
            for (auto PMember : PParty->members)
            {
                func(PMember, std::forward<Args>(args)...);
            }
            for (auto PMember : PParty->members)
            {
                for (auto PTrust : static_cast<CCharEntity*>(PMember)->PTrusts)
                {
                    func(PTrust, std::forward<Args>(args)...);
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

    CBattleEntity* PClaimedMob;

    // These missions do not need a list of completed, because client automatically
    // displays earlier missions completed

    uint16 m_copCurrent; // current mission of Chains of Promathia
    uint16 m_acpCurrent; // current mission of A Crystalline Prophecy
    uint16 m_mkeCurrent; // current mission of A Moogle Kupo d'Etat
    uint16 m_asaCurrent; // current mission of A Shantotto Ascension

    // currency_t        m_currency;                 // conquest points, imperial standing points etc
    Teleport_t teleport; // Outposts, Runic Portals, Homepoints, Survival Guides, Maws, etc

    uint8 GetGender(); // узнаем пол персонажа

    void          clearPacketList();                         // отчистка PacketList
    void          pushPacket(CBasicPacket*);                 // добавление копии пакета в PacketList
    void          pushPacket(std::unique_ptr<CBasicPacket>); // push packet to packet list
    bool          isPacketListEmpty();                       // проверка размера PacketList
    CBasicPacket* popPacket();                               // получение первого пакета из PacketList
    PacketList_t  getPacketList();                           // returns a COPY of packet list
    size_t        getPacketCount();
    void          erasePackets(uint8 num); // erase num elements from front of packet list
    virtual void  HandleErrorMessage(std::unique_ptr<CBasicPacket>&) override;

    CLinkshell*    PLinkshell1; // linkshell, в которой общается персонаж
    CLinkshell*    PLinkshell2; // linkshell 2
    CUnityChat*    PUnityChat;
    CTreasurePool* PTreasurePool; // сокровища, добытые с монстров
    CMeritPoints*  PMeritPoints;  //
    CJobPoints*    PJobPoints;
    bool           MeritMode;     // If true then player is meriting

    CLatentEffectContainer* PLatentEffectContainer;

    CItemContainer* PGuildShop;                   // текущий магазин гильдии, в котором персонаж производит закупки
    CItemContainer* getStorage(uint8 LocationID); // получение указателя на соответствующее хранилище

    CTradeContainer* TradeContainer; // Container used specifically for trading.
    CTradeContainer* Container;      // универсальный контейнер для обмена, синтеза, магазина и т.д.
    CUContainer*     UContainer;     // container used for universal actions -- used for trading at least despite the dedicated trading container above
    CTradeContainer* CraftContainer; // Container used for crafting actions.

    CBaseEntity* PWideScanTarget; // wide scane цель

    SpawnIDList_t SpawnPCList;    // list of visible characters
    SpawnIDList_t SpawnMOBList;   // list of visible monsters
    SpawnIDList_t SpawnPETList;   // list of visible pets
    SpawnIDList_t SpawnTRUSTList; // list of visible trust
    SpawnIDList_t SpawnNPCList;   // list of visible npc's

    void SetName(int8* name); // устанавливаем имя персонажа (имя ограничивается 15-ю символами)

    EntityID_t   TradePending;    // ID персонажа, предлагающего обмен
    EntityID_t   InvitePending;   // ID персонажа, отправившего приглашение в группу
    EntityID_t   BazaarID;        // Pointer to the bazaar we are browsing.
    BazaarList_t BazaarCustomers; // Array holding the IDs of the current customers

    uint32     m_InsideRegionID;     // номер региона, в котором сейчас находится персонаж (??? может засунуть в m_event ???)
    uint8      m_LevelRestriction;   // ограничение уровня персонажа
    uint16     m_Costume;            // карнавальный костюм персонажа (модель)
    uint16     m_Monstrosity;        // Monstrosity model ID
    uint32     m_AHHistoryTimestamp; // Timestamp when last asked to view history
    uint32     m_DeathTimestamp;     // Timestamp when death counter has been saved to database
    time_point m_deathSyncTime;      // Timer used for sending an update packet at a regular interval while the character is dead

    uint8      m_hasTractor;     // checks if player has tractor already
    uint8      m_hasRaise;       // checks if player has raise already
    uint8      m_hasAutoTarget;  // возможность использования AutoTarget функции
    position_t m_StartActionPos; // позиция начала действия (использование предмета, начало стрельбы, позиция tractor)

    uint32 m_PlayTime;
    uint32 m_SaveTime;

    uint32 m_LastYell;

    uint8 m_GMlevel;    // Level of the GM flag assigned to this character
    bool  m_isGMHidden; // GM Hidden flag to prevent player updates from being processed.

    bool   m_mentorUnlocked;
    bool   m_jobMasterDisplay; // Job Master Stars display
    uint32 m_moghouseID;
    uint16 m_moghancementID;

    int8 getShieldSize();

    bool getWeaponSkillKill() const;
    void setWeaponSkillKill(bool isWeaponSkillKill);

    bool getStyleLocked() const;
    void setStyleLocked(bool isStyleLocked);
    bool getBlockingAid() const;
    void setBlockingAid(bool isBlockingAid);

    bool       m_EquipSwap; // true if equipment was recently changed
    bool       m_EffectsChanged;
    time_point m_LastSynthTime;

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

    void ReloadPartyInc();
    void ReloadPartyDec();
    bool ReloadParty() const;
    void ClearTrusts();
    void RemoveTrust(CTrustEntity*);

    virtual void Tick(time_point) override;
    void         PostTick() override;

    virtual void addTrait(CTrait*) override;
    virtual void delTrait(CTrait*) override;

    virtual bool ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags) override;
    virtual bool CanUseSpell(CSpell*) override;

    virtual void Die() override;
    void         Die(duration _duration);
    void         Raise();

    static constexpr duration death_duration         = 60min;
    static constexpr duration death_update_frequency = 16s;

    void  SetDeathTimestamp(uint32 timestamp);
    int32 GetSecondsElapsedSinceDeath() const;
    int32 GetTimeRemainingUntilDeathHomepoint() const; // Amount of time remaining before the player should be forced back to homepoint while dead

    int32 GetTimeCreated();

    bool isInEvent();
    bool isNpcLocked();

    void SetMoghancement(uint16 moghancementID);
    bool hasMoghancement(uint16 moghancementID) const;
    void UpdateMoghancement();

    /* State callbacks */
    virtual bool           CanAttack(CBattleEntity* PTarget, std::unique_ptr<CBasicPacket>& errMsg) override;
    virtual bool           OnAttack(CAttackState&, action_t&) override;
    virtual bool           OnAttackError(CAttackState&) override;
    virtual CBattleEntity* IsValidTarget(uint16 targid, uint16 validTargetFlags, std::unique_ptr<CBasicPacket>& errMsg) override;
    virtual void           OnChangeTarget(CBattleEntity* PNewTarget) override;
    virtual void           OnEngage(CAttackState&) override;
    virtual void           OnDisengage(CAttackState&) override;
    virtual void           OnCastFinished(CMagicState&, action_t&) override;
    virtual void           OnCastInterrupted(CMagicState&, action_t&, MSGBASIC_ID msg) override;
    virtual void           OnWeaponSkillFinished(CWeaponSkillState&, action_t&) override;
    virtual void           OnAbility(CAbilityState&, action_t&) override;
    virtual void           OnRangedAttack(CRangeState&, action_t&);
    virtual void           OnDeathTimer() override;
    virtual void           OnRaise() override;
    virtual void           OnItemFinish(CItemState&, action_t&);

    CCharEntity();  // constructor
    ~CCharEntity(); // destructor

protected:
    bool IsMobOwner(CBattleEntity* PTarget);
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

    bool m_isWeaponSkillKill;
    bool m_isStyleLocked;
    bool m_isBlockingAid;
    bool m_reloadParty;

    PacketList_t PacketList; // the list of packets to be sent to the character during the next network cycle

    std::mutex m_PacketListMutex;
};

#endif
