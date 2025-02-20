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

#ifndef _CCHARUPDATEPACKET_H
#define _CCHARUPDATEPACKET_H

#include "common/cbasetypes.h"

#include "basic.h"

class CCharEntity;

// Namespace to avoid compilation units using the same structs twice with different definitions
namespace charUpdateFlags
{
    // PS2: (Non-defined bitfield type.)
    struct sendflags_t
    {
        uint8_t Position : 1;
        uint8_t ClaimStatus : 1;
        uint8_t General : 1;
        uint8_t Name : 1;
        uint8_t Model : 1;
        uint8_t Despawn : 1;
        uint8_t unused : 2;
    };

    // PS2: (Unnamed bitfield struct.)
    struct flags0_t
    {
        uint32_t MovTime : 13;    // PS2: MovTime
        uint32_t RunMode : 1;     // PS2: RunMode
        uint32_t unknown_1_6 : 1; // PS2: TargetMode
        uint32_t GroundFlag : 1;  // PS2: GroundFlag
        uint32_t KingFlag : 1;    // PS2: KingFlag
        uint32_t facetarget : 15; // PS2: facetarget
    };

    // PS2: (Unnamed bitfield struct.)
    struct flags1_t
    {
        uint32_t MonsterFlag : 1;     // PS2: MonsterFlag
        uint32_t HideFlag : 1;        // PS2: HideFlag
        uint32_t SleepFlag : 1;       // PS2: SleepFlag
        uint32_t unknown_0_3 : 1;     // PS2: MonStat
        uint32_t unknown_0_4 : 1;     // PS2: (unknown)
        uint32_t ChocoboIndex : 3;    // PS2: ChocoboIndex
        uint32_t CliPosInitFlag : 1;  // PS2: CliPosInitFlag
        uint32_t GraphSize : 2;       // PS2: GraphSize
        uint32_t LfgFlag : 1;         // PS2: LfgFlag
        uint32_t AnonymousFlag : 1;   // PS2: AnonymousFlag
        uint32_t YellFlag : 1;        // PS2: YellFlag
        uint32_t AwayFlag : 1;        // PS2: AwayFlag
        uint32_t Gender : 1;          // PS2: Gender
        uint32_t PlayOnelineFlag : 1; // PS2: PlayOnelineFlag
        uint32_t LinkShellFlag : 1;   // PS2: LinkShellFlag
        uint32_t LinkDeadFlag : 1;    // PS2: LinkDeadFlag
        uint32_t TargetOffFlag : 1;   // PS2: TargetOffFlag
        uint32_t TalkUcoffFlag : 1;   // PS2: TalkUcoffFlag
        uint32_t unknown_2_5 : 1;     // PS2: PartyLeaderFlg
        uint32_t unknown_2_6 : 1;     // PS2: AllianceLeaderFlg
        uint32_t unknown_2_7 : 1;     // PS2: DebugClientFlg
        uint32_t GmLevel : 3;         // PS2: GmLevel
        uint32_t HackMove : 1;        // PS2: HackMove
        uint32_t unknown_3_4 : 1;     // PS2: GMInvisFlag
        uint32_t InvisFlag : 1;       // PS2: InvisFlag
        uint32_t TurnFlag : 1;        // PS2: TurnFlag
        uint32_t BazaarFlag : 1;      // PS2: BazaarFlag
    };

    // PS2: (Unnamed bitfield struct.)
    struct flags2_t
    {
        uint32_t r : 8;             // PS2: r
        uint32_t g : 8;             // PS2: g
        uint32_t b : 8;             // PS2: b
        uint32_t PvPFlag : 1;       // PS2: PvPFlag
        uint32_t ShadowFlag : 1;    // PS2: ShadowFlag
        uint32_t ShipStartMode : 1; // PS2: ShipStartMode
        uint32_t CharmFlag : 1;     // PS2: CharmFlag
        uint32_t GmIconFlag : 1;    // PS2: GmIconFlag
        uint32_t NamedFlag : 1;     // PS2: NamedFlag
        uint32_t SingleFlag : 1;    // PS2: SingleFlag
        uint32_t AutoPartyFlag : 1; // PS2: AutoPartyFlag
    };

    // PS2: (Unnamed bitfield struct. This has been fully repurposed.)
    struct flags3_t
    {
        uint32_t TrustFlag : 1;        // PS2: (New; replaced 'PetMode'.)
        uint32_t LfgMasterFlag : 1;    // PS2: (New; replaced 'PetMode'.)
        uint32_t PetNewFlag : 1;       // PS2: PetNewFlag
        uint32_t unknown_0_3 : 1;      // PS2: PetKillFlag
        uint32_t MotStopFlag : 1;      // PS2: MotStopFlag
        uint32_t CliPriorityFlag : 1;  // PS2: CliPriorityFlag
        uint32_t PetFlag : 1;          // PS2: NpcPetFlag
        uint32_t OcclusionoffFlag : 1; // PS2: OcclusionoffFlag
        uint32_t BallistaTeam : 8;     // PS2: (New; did not exist.)
        uint32_t MonStat : 3;          // PS2: (New; did not exist.)
        uint32_t unknown_2_3 : 1;      // PS2: (New; did not exist.)
        uint32_t unknown_2_4 : 1;      // PS2: (New; did not exist.)
        uint32_t SilenceFlag : 1;      // PS2: (New; did not exist.)
        uint32_t unknown_2_6 : 1;      // PS2: (New; did not exist.)
        uint32_t NewCharacterFlag : 1; // PS2: (New; did not exist.)
        uint32_t MentorFlag : 1;       // PS2: (New; did not exist.)
        uint32_t unknown_3_1 : 1;      // PS2: (New; did not exist.)
        uint32_t unknown_3_2 : 1;      // PS2: (New; did not exist.)
        uint32_t unknown_3_3 : 1;      // PS2: (New; did not exist.)
        uint32_t unknown_3_4 : 1;      // PS2: (New; did not exist.)
        uint32_t unknown_3_5 : 1;      // PS2: (New; did not exist.)
        uint32_t unknown_3_6 : 1;      // PS2: (New; did not exist.)
        uint32_t unknown_3_7 : 1;      // PS2: (New; did not exist.)
    };

    // PS2: (New; did not exist.)
    struct flags4_t
    {
        uint8_t unknown_0_0 : 1;   // PS2: (New; did not exist.)
        uint8_t TrialFlag : 1;     // PS2: (New; did not exist.)
        uint8_t unknown_0_2 : 2;   // PS2: (New; did not exist.)
        uint8_t unknown_0_4 : 2;   // PS2: (New; did not exist.)
        uint8_t JobMasterFlag : 1; // PS2: (New; did not exist.)
        uint8_t unknown_0_7 : 1;   // PS2: (New; did not exist.)
    };

    // PS2: (New; did not exist.)
    struct flags5_t
    {
        uint8_t GeoIndiElement : 4; // PS2: (New; did not exist.)
        uint8_t GeoIndiSize : 2;    // PS2: (New; did not exist.)
        uint8_t GeoIndiFlag : 1;    // PS2: (New; did not exist.)
        uint8_t unknown_0_7 : 1;    // PS2: (New; did not exist.)
    };

    // PS2: (New; did not exist.)
    struct flags6_t
    {
        uint32_t GateId : 4;       // PS2: (New; did not exist.)
        uint32_t MountIndex : 8;   // PS2: (New; did not exist.)
        uint32_t unknown_1_3 : 20; // PS2: (New; did not exist.)
    };
} // namespace charUpdateFlags

// PS2: GP_SERV_CHAR_PC
struct GP_SERV_CHAR_PC
{
    uint16_t id : 9;
    uint16_t size : 7;
    uint16_t sync;

    // PS2: GP_SERV_POS_HEAD
    uint32_t                     UniqueNo;      // PS2: UniqueNo
    uint16_t                     ActIndex;      // PS2: ActIndex
    charUpdateFlags::sendflags_t SendFlg;       // PS2: SendFlg
    uint8_t                      dir;           // PS2: dir
    float                        x;             // PS2: x
    float                        z;             // PS2: z
    float                        y;             // PS2: y
    charUpdateFlags::flags0_t    Flags0;        // PS2: <bits> (Nameless bitfield.)
    uint8_t                      Speed;         // PS2: Speed
    uint8_t                      SpeedBase;     // PS2: SpeedBase
    uint8_t                      Hpp;           // PS2: HpMax
    uint8_t                      server_status; // PS2: server_status
    charUpdateFlags::flags1_t    Flags1;        // PS2: <bits> (Nameless bitfield.)
    charUpdateFlags::flags2_t    Flags2;        // PS2: <bits> (Nameless bitfield.)
    charUpdateFlags::flags3_t    Flags3;        // PS2: <bits> (Nameless bitfield.)
    uint32_t                     BtTargetID;    // PS2: BtTargetID

    // PS2: GP_SERV_CHAR_PC remaining fields.
    uint16_t                  CostumeId;           // PS2: (New; did not exist.)
    uint8_t                   BallistaInfo;        // PS2: (New; did not exist.)
    charUpdateFlags::flags4_t Flags4;              // PS2: (New; did not exist.)
    uint32_t                  CustomProperties[2]; // PS2: (New; did not exist.)
    uint16_t                  PetActIndex;         // PS2: (New; did not exist.)
    uint16_t                  MonstrosityFlags;    // PS2: (New; did not exist.)
    uint8_t                   MonstrosityNameId1;  // PS2: (New; did not exist.)
    uint8_t                   MonstrosityNameId2;  // PS2: (New; did not exist.)
    charUpdateFlags::flags5_t Flags5;              // PS2: (New; did not exist.)
    uint8_t                   ModelHitboxSize;     // PS2: (New; did not exist.)
    charUpdateFlags::flags6_t Flags6;              // PS2: (New; did not exist.)
    uint16_t                  GrapIDTbl[9];        // PS2: GrapIDTbl
    uint8_t                   name[16];            // PS2: name
};

class CCharUpdatePacket : public CBasicPacket
{
public:
    CCharUpdatePacket(CCharEntity* PChar, ENTITYUPDATE type, uint8 updatemask);
    void updateWith(CCharEntity* PChar, ENTITYUPDATE type, uint8 updatemask);

private:
    GP_SERV_CHAR_PC packet;
};

#endif
