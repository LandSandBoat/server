/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "base.h"

enum class GP_CLI_COMMAND_ACTION_BLOCKAID : uint32_t
{
    Disable = 0,
    Enable  = 1,
    Toggle  = 2,
};

enum class GP_CLI_COMMAND_ACTION_HOMEPOINTMENU : uint32_t
{
    Accept            = 0,
    MonstrosityCancel = 1,
    MonstrosityRetry  = 2,
};

enum class GP_CLI_COMMAND_ACTION_RAISEMENU : uint32_t
{
    Accept = 0,
    Reject = 1,
};

enum class GP_CLI_COMMAND_ACTION_TRACTORMENU : uint32_t
{
    Accept = 0,
    Reject = 1,
};

enum class GP_CLI_COMMAND_ACTION_ACTIONID : uint16_t
{
    Talk          = 0x00, // Interact with NPC/Trust
    Attack        = 0x02,
    CastMagic     = 0x03,
    AttackOff     = 0x04,
    Help          = 0x05,
    Weaponskill   = 0x07,
    JobAbility    = 0x09,
    HomepointMenu = 0x0B,
    Assist        = 0x0C,
    RaiseMenu     = 0x0D,
    Fish          = 0x0E,
    ChangeTarget  = 0x0F,
    Shoot         = 0x10,
    ChocoboDig    = 0x11,
    Dismount      = 0x12,
    TractorMenu   = 0x13,
    SendResRdy    = 0x14, // Request character update?
    Quarry        = 0x15,
    Sprint        = 0x16,
    Scout         = 0x17,
    Blockaid      = 0x18,
    MonsterSkill  = 0x19,
    Mount         = 0x1A,
};

struct ACTIONBUF_CASTMAGIC
{
    uint32_t SpellId;
    float    PosX;
    float    PosZ;
    float    PosY;
};

struct ACTIONBUF_WEAPONSKILL
{
    uint32_t SkillId;
    uint32_t unused[2];
    uint32_t unknown;
};

// Weapon Skill, Job Ability and Monster Skill use the same structure.
typedef ACTIONBUF_WEAPONSKILL ACTIONBUF_JOBABILITY;
typedef ACTIONBUF_WEAPONSKILL ACTIONBUF_MONSTERSKILL;

struct ACTIONBUF_HOMEPOINTMENU
{
    GP_CLI_COMMAND_ACTION_HOMEPOINTMENU StatusId;
    uint32_t                            unused[2];
    uint32_t                            unknown;
};

struct ACTIONBUF_TRACTORMENU
{
    GP_CLI_COMMAND_ACTION_TRACTORMENU StatusId;
    uint32_t                          unused[2];
    uint32_t                          unknown;
};

struct ACTIONBUF_BLOCKAID
{
    GP_CLI_COMMAND_ACTION_BLOCKAID StatusId;
    uint32_t                       unused[2];
    uint32_t                       unknown;
};

struct ACTIONBUF_MOUNT
{
    uint32_t MountId;
    uint32_t unused[2];
    uint32_t unknown;
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x001A
// This packet is sent by the client when it is requesting to perform an action.
GP_CLI_PACKET(GP_CLI_COMMAND_ACTION,
              uint32_t UniqueNo; // PS2: UniqueNo
              uint16_t ActIndex; // PS2: ActIndex
              uint16_t ActionID; // PS2: ActionID
              union {
                  ACTIONBUF_CASTMAGIC     CastMagic;
                  ACTIONBUF_WEAPONSKILL   Weaponskill;
                  ACTIONBUF_JOBABILITY    JobAbility;
                  ACTIONBUF_MONSTERSKILL  MonsterSkill;
                  ACTIONBUF_HOMEPOINTMENU HomepointMenu;
                  ACTIONBUF_TRACTORMENU   TractorMenu;
                  ACTIONBUF_BLOCKAID      BlockAid;
                  ACTIONBUF_MOUNT         Mount;
                  uint32_t                ActionBuf[4]; // PS2: ActionBuf
              }; // Other actions don't use the array or have fixed values only.
);
