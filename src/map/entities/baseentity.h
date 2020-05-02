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

#ifndef _BASEENTITY_H
#define _BASEENTITY_H

#include <memory>
#include <map>
#include "../../common/cbasetypes.h"
#include "../../common/mmo.h"
#include "../packets/message_basic.h"

enum ENTITYTYPE
{
    TYPE_NONE    = 0x00,
    TYPE_PC      = 0x01,
    TYPE_NPC     = 0x02,
    TYPE_MOB     = 0x04,
    TYPE_PET     = 0x08,
    TYPE_SHIP    = 0x10,
    TYPE_TRUST   = 0x20,
    TYPE_FELLOW  = 0x40
};

enum STATUSTYPE
{
    STATUS_NORMAL        = 0,
    STATUS_MOB           = 1,
  //STATUS_UPDATE        = 1,
    STATUS_DISAPPEAR     = 2,
    STATUS_INVISIBLE     = 3,
    STATUS_4             = 4,
    STATUS_CUTSCENE_ONLY = 6,
    STATUS_18            = 18,
    STATUS_SHUTDOWN      = 20
};

enum ANIMATIONTYPE
{
    ANIMATION_NONE               = 0,
    ANIMATION_ATTACK             = 1,
    ANIMATION_DESPAWN            = 2,
    ANIMATION_DEATH              = 3,
    ANIMATION_EVENT              = 4,
    ANIMATION_CHOCOBO            = 5,
    ANIMATION_FISHING            = 6,
    // Healing                      = 7,
    ANIMATION_OPEN_DOOR          = 8,
    ANIMATION_CLOSE_DOOR         = 9,
    ANIMATION_ELEVATOR_UP        = 10,
    ANIMATION_ELEVATOR_DOWN      = 11,
    // seems to be WALLHACK                     = 28,
    // seems to be WALLHACK also..              = 31,
    ANIMATION_HEALING            = 33,
    ANIMATION_FISHING_FISH       = 38,
    ANIMATION_FISHING_CAUGHT     = 39,
    ANIMATION_FISHING_ROD_BREAK  = 40,
    ANIMATION_FISHING_LINE_BREAK = 41,
    ANIMATION_FISHING_MONSTER    = 42,
    ANIMATION_FISHING_STOP       = 43,
    ANIMATION_SYNTH              = 44,
    ANIMATION_SIT                = 47,
    ANIMATION_RANGED             = 48,
    ANIMATION_FISHING_START_OLD  = 50,
    ANIMATION_FISHING_START      = 56,
    // 63 through 72 are used with /sitchair
    ANIMATION_SITCHAIR_0 = 63,
    ANIMATION_SITCHAIR_1 = 64,
    ANIMATION_SITCHAIR_2 = 65,
    ANIMATION_SITCHAIR_3 = 66,
    ANIMATION_SITCHAIR_4 = 67,
    ANIMATION_SITCHAIR_5 = 68,
    ANIMATION_SITCHAIR_6 = 69,
    ANIMATION_SITCHAIR_7 = 70,
    ANIMATION_SITCHAIR_8 = 71,
    ANIMATION_SITCHAIR_9 = 72,
    ANIMATION_SITCHAIR_10 = 73,
    // 74 through 83 sitting on air (guessing future use for more chairs..)
    ANIMATION_MOUNT              = 85,
    // ANIMATION_TRUST              = 90 // This is the animation for a trust NPC spawning in.
};

enum MOUNTTYPE
{
    MOUNT_CHOCOBO        = 0,
    MOUNT_QUEST_RAPTOR   = 1,
    MOUNT_RAPTOR         = 2,
    MOUNT_TIGER          = 3,
    MOUNT_CRAB           = 4,
    MOUNT_RED_CRAB       = 5,
    MOUNT_BOMB           = 6,
    MOUNT_RAM            = 7,
    MOUNT_MORBOL         = 8,
    MOUNT_CRAWLER        = 9,
    MOUNT_FENRIR         = 10,
    MOUNT_BEETLE         = 11,
    MOUNT_MOOGLE         = 12,
    MOUNT_MAGIC_POT      = 13,
    MOUNT_TULFAIRE       = 14,
    MOUNT_WARMACHINE     = 15,
    MOUNT_XZOMIT         = 16,
    MOUNT_HIPPOGRYPH     = 17,
    MOUNT_SPECTRAL_CHAIR = 18,
    MOUNT_SPHEROID       = 19,
    MOUNT_OMEGA          = 20,
    MOUNT_COEURL         = 21,
    MOUNT_GOOBBUE        = 22,
    MOUNT_RAAZ           = 23,
    MOUNT_LEVITUS        = 24,
    MOUNT_ADAMANTOISE    = 25,
    MOUNT_DHAMEL         = 26,
    MOUNT_DOLL           = 27,
};

enum ALLEGIANCETYPE
{
    ALLEGIANCE_MOB       = 0,
    ALLEGIANCE_PLAYER    = 1,
    ALLEGIANCE_SAN_DORIA = 2,
    ALLEGIANCE_BASTOK    = 3,
    ALLEGIANCE_WINDURST  = 4
};

enum UPDATETYPE
{
    UPDATE_NONE     = 0x00,
    UPDATE_POS      = 0x01,
    UPDATE_STATUS   = 0x02,
    UPDATE_HP       = 0x04,
    UPDATE_COMBAT   = 0x07,
    UPDATE_NAME     = 0x08,
    UPDATE_LOOK     = 0x10,
    UPDATE_ALL_MOB  = 0x0F,
    UPDATE_ALL_CHAR = 0x1F
};

enum ENTITYFLAGS
{
    FLAG_NONE          = 0x000,
    FLAG_HIDE_NAME     = 0x008,
    FLAG_CALL_FOR_HELP = 0x020,
    FLAG_HIDE_HP       = 0x100,
    FLAG_UNTARGETABLE  = 0x800,
};

// TODO: возможо стоит сделать эту структуру частью класса, взамен нынешних id и targid, но уже без метода clean

struct EntityID_t
{
    void clean()
    {
        id = 0;
        targid = 0;
    }

    uint32 id;
    uint16 targid;
};

class CZone;

struct location_t
{
    position_t  p;              // позиция сущности
    uint16      destination;    // текущая зона
    CZone*      zone;           // текущая зона
    uint16      prevzone;       // предыдущая зона (для монстров и npc не используется)
    bool        zoning;         // флаг сбрасывается при каждом входе в новую зону. необходим для реализации логики игровых задач ("quests")
    uint16      boundary;       // определенная область в зоне, в которой находится сущность (используется персонажами и транспортом)
};

class CAIContainer;
class CInstance;
class CBattlefield;

/************************************************************************
*                                                                       *
*  Базовый класс для всех сущностей в игре                              *
*                                                                       *
************************************************************************/

class CBaseEntity
{
public:

    CBaseEntity();                      // конструктор
    virtual ~CBaseEntity();             // деструктор

    virtual void    Spawn();
    virtual void    FadeOut();
    virtual const int8* GetName();      // имя сущности
    uint16          getZone();          // текущая зона
    float           GetXPos();          // позиция по координате X
    float           GetYPos();          // позиция по координате Y
    float           GetZPos();          // позиция по координате Z
    uint8           GetRotPos();
    void            HideName(bool hide); // hide / show name
    bool            IsNameHidden();     // checks if name is hidden

    CBaseEntity*    GetEntity(uint16 targid, uint8 filter = -1);

    void            ResetLocalVars();
    uint32          GetLocalVar(const char* var);
    void            SetLocalVar(const char* var, uint32 val);

    //pre-tick update
    virtual void    Tick(time_point) = 0;
    //post-tick update
    virtual void    PostTick() = 0;

    void            SetModelId(uint16 modelId);     // Set new modelid
    uint16          GetModelId();                   // Get the modelid

    virtual void    HandleErrorMessage(std::unique_ptr<CBasicPacket>&) {};

    uint32          id;                 // global identifier unique on the server
    uint16          targid;             // local identifier unique to the zone
    ENTITYTYPE      objtype;            // тип сущности
    STATUSTYPE      status;             // статус сущности (разные сущности - разные статусы)
    uint16          m_TargID;           // targid объекта, на который смотрит сущность
    string_t        name;               // имя сущности
    look_t          look;               // внешний вид всех сущностей
    look_t          mainlook;           // only used if mob use changeSkin() or player /lockstyle
    location_t      loc;                // местоположение сущности
    uint8           animation;          // анимация
    uint8           animationsub;       // дополнительный параметры анимации
    uint8           speed;              // скорость передвижения
    uint8           speedsub;           // подолнительный параметр скорости передвижения
    uint8           namevis;
    uint8           allegiance;         // what types of targets the entity can fight
    uint8           updatemask;         // what to update next server tick to players nearby

    std::unique_ptr<CAIContainer> PAI;       // AI container
    CBattlefield* PBattlefield;            // pointer to battlefield (if in one)
    CInstance*		PInstance;
protected:
    std::map<std::string, uint32> m_localVars;
};

#endif

