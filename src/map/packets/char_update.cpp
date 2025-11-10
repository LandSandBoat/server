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

#include <cstring>

#include "char_update.h"

#include "entities/charentity.h"
#include "items/item_linkshell.h"
#include "status_effect_container.h"
#include "utils/itemutils.h"
#include "utils/mountutils.h"

namespace
{

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x000D

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

// PS2: GP_SERV_CHAR_PC
struct GP_SERV_CHAR_PC
{
    uint16_t id : 9;
    uint16_t size : 7;
    uint16_t sync;

    // PS2: GP_SERV_POS_HEAD
    uint32_t    UniqueNo;      // PS2: UniqueNo
    uint16_t    ActIndex;      // PS2: ActIndex
    sendflags_t SendFlg;       // PS2: SendFlg
    uint8_t     dir;           // PS2: dir
    float       x;             // PS2: x
    float       z;             // PS2: z
    float       y;             // PS2: y
    flags0_t    Flags0;        // PS2: <bits> (Nameless bitfield.)
    uint8_t     Speed;         // PS2: Speed
    uint8_t     SpeedBase;     // PS2: SpeedBase
    uint8_t     Hpp;           // PS2: HpMax
    uint8_t     server_status; // PS2: server_status
    flags1_t    Flags1;        // PS2: <bits> (Nameless bitfield.)
    flags2_t    Flags2;        // PS2: <bits> (Nameless bitfield.)
    flags3_t    Flags3;        // PS2: <bits> (Nameless bitfield.)
    uint32_t    BtTargetID;    // PS2: BtTargetID

    // PS2: GP_SERV_CHAR_PC remaining fields.
    uint16_t CostumeId;           // PS2: (New; did not exist.)
    uint8_t  BallistaInfo;        // PS2: (New; did not exist.)
    flags4_t Flags4;              // PS2: (New; did not exist.)
    uint32_t CustomProperties[2]; // PS2: (New; did not exist.)
    uint16_t PetActIndex;         // PS2: (New; did not exist.)
    uint16_t MonstrosityFlags;    // PS2: (New; did not exist.)
    uint8_t  MonstrosityNameId1;  // PS2: (New; did not exist.)
    uint8_t  MonstrosityNameId2;  // PS2: (New; did not exist.)
    flags5_t Flags5;              // PS2: (New; did not exist.)
    uint8_t  ModelHitboxSize;     // PS2: (New; did not exist.)
    flags6_t Flags6;              // PS2: (New; did not exist.)
    uint16_t GrapIDTbl[9];        // PS2: GrapIDTbl
    uint8_t  name[16];            // PS2: name
};

constexpr uint32_t nonspecific_size = offsetof(GP_SERV_CHAR_PC, MonstrosityFlags);
constexpr uint32_t general_size     = offsetof(GP_SERV_CHAR_PC, GrapIDTbl[0]);
constexpr uint32_t model_size       = offsetof(GP_SERV_CHAR_PC, name[0]);
constexpr uint32_t name_size        = offsetof(GP_SERV_CHAR_PC, name[0]);

} // namespace

// This packet should only be constructed in CCharEntity::updateEntityPacket()!
CCharUpdatePacket::CCharUpdatePacket(CCharEntity* PChar, ENTITYUPDATE type, uint8 updatemask)
{
    ref<uint32>(0x04) = PChar->id;
    updateWith(PChar, type, updatemask);
}

void CCharUpdatePacket::updateWith(CCharEntity* PChar, ENTITYUPDATE type, uint8 updatemask)
{
    uint32 currentId = ref<uint32>(0x04); // TODO: replace with a class variable?
    if (currentId != PChar->id)
    {
        // Should only be able to update packets about the same character.
        ShowError("Unable to update char packet for %d with data from %d", currentId, PChar->id);
        return;
    }

    auto packet = this->as<GP_SERV_CHAR_PC>();

    packet->id       = 0x0D;
    packet->size     = roundUpToNearestFour(nonspecific_size) / 4; // Client recieves this and multiplies by 4
    packet->UniqueNo = PChar->id;
    packet->ActIndex = PChar->targid;

    if (type == ENTITY_SPAWN)
    {
        packet->SendFlg.Position    = true;
        packet->SendFlg.ClaimStatus = true;
        packet->SendFlg.General     = true;
        packet->SendFlg.Name        = true;
        packet->SendFlg.Model       = true;
    }
    else if (type == ENTITY_DESPAWN)
    {
        packet->SendFlg.Despawn = true;
    }
    else // Update and OR the flags together
    {
        // sendflags_t is a uint8 under the hood, so we can
        // treat it like one here so we can OR onto it.
        *(::as<uint8>(packet->SendFlg)) |= updatemask;
    }

    if (packet->SendFlg.Position)
    {
        packet->dir = PChar->loc.p.rotation;
        packet->x   = PChar->loc.p.x;
        packet->y   = PChar->loc.p.z; // Intentionally Swapped, apparently internal x/y/z is not FFXI x/y/z
        packet->z   = PChar->loc.p.y; // Intentionally Swapped

        packet->Speed     = PChar->UpdateSpeed();
        packet->SpeedBase = PChar->animationSpeed;

        packet->Flags0.MovTime     = PChar->loc.p.moving;
        packet->Flags0.RunMode     = 0;                      // Unknown
        packet->Flags0.unknown_1_6 = 0;                      // Unknown
        packet->Flags0.RunMode     = 0;                      // Used within events. // TODO: verify usage in events
        packet->Flags0.GroundFlag  = PChar->wallhackEnabled; // Is this the same as HackMove?
        packet->Flags0.KingFlag    = 0;                      // Unused
        packet->Flags0.facetarget  = PChar->m_TargID;
    }

    if (packet->SendFlg.ClaimStatus)
    {
        packet->BtTargetID = 0; // TODO: What should this be set to? This is "claim status", not sure we keep track of that for players.
    }

    if (packet->SendFlg.General)
    {
        const auto [ChocoboIndex, CustomProperties] = mountutils::packetDefinition(PChar);

        packet->Hpp             = PChar->GetHPP();
        packet->server_status   = PChar->animation;
        packet->ModelHitboxSize = 4; // TODO: verify this value and if it changes (Monstrosity?)

        packet->Flags1.MonsterFlag = false; // TODO: Is this ever set for Monstrosity PVP?
        packet->Flags1.HideFlag    = false;
        packet->Flags1.SleepFlag   = 0;                                                                // Something to do with events. // TODO: figure out when/if this is set. Probably when you're in a cutscene?
        packet->Flags1.unknown_0_3 = PChar->loc.zone ? PChar->loc.zone->CanUseMisc(MISC_TREASURE) : 0; // Set global treasure pool
        packet->Flags1.unknown_0_4 = 0;

        // All mounts need a valid ChocoboIndex
        packet->Flags1.ChocoboIndex = ChocoboIndex;
        // Only known to be used by Personal Chocobos at this time.
        packet->CustomProperties[0] = CustomProperties[0];
        // Only known to be used by Noble Chocobo at this time.
        packet->CustomProperties[1] = CustomProperties[1];

        auto* linkshell = reinterpret_cast<CItemLinkshell*>(PChar->getEquip(SLOT_LINK1));

        packet->Flags1.CliPosInitFlag  = 0; // Unused
        packet->Flags1.GraphSize       = PChar->look.size;
        packet->Flags1.LfgFlag         = PChar->playerConfig.InviteFlg;
        packet->Flags1.AnonymousFlag   = PChar->playerConfig.AnonymityFlg;
        packet->Flags1.YellFlag        = 0; // 1 sets player name to yellow, unused.
        packet->Flags1.AwayFlag        = PChar->playerConfig.AwayFlg;
        packet->Flags1.Gender          = PChar->GetGender();
        packet->Flags1.PlayOnelineFlag = 0; // POL icon, currently unused
        packet->Flags1.LinkShellFlag   = linkshell ? true : false;
        packet->Flags1.LinkDeadFlag    = PChar->isLinkDead;
        packet->Flags1.TargetOffFlag   = 0; // Untargetable player, not sure if this is ever used.
        packet->Flags1.TalkUcoffFlag   = 0; // Unknown, but used with events. // TOOD: verify how/when this is used.
        packet->Flags1.GmLevel         = PChar->visibleGmLevel;
        packet->Flags1.HackMove        = PChar->wallhackEnabled;
        packet->Flags1.InvisFlag       = PChar->m_isGMHidden || PChar->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_INVISIBLE);
        packet->Flags1.TurnFlag        = 0; // I do not believe we currently use this. // TOOD: get the lerp values from retail somehow.
        packet->Flags1.BazaarFlag      = PChar->hasBazaar();

        if (linkshell && linkshell->isType(ITEM_LINKSHELL))
        {
            const lscolor_t LSColor = linkshell->GetLSColor();

            // This seems wrong, but displays correctly?
            packet->Flags2.r = (LSColor.R << 4) + 15;
            packet->Flags2.g = (LSColor.G << 4) + 15;
            packet->Flags2.b = (LSColor.B << 4) + 15;
        }

        packet->Flags2.PvPFlag       = 0; // Gate breach status in ballista, apparently.
        packet->Flags2.ShadowFlag    = 0; // Hides player shadow if set to 1. Is this used?
        packet->Flags2.CharmFlag     = PChar->isCharmed;
        packet->Flags2.GmIconFlag    = false; // If set, allows other icon flags to be shown in addition to the GM red/pink text for the name.
        packet->Flags2.NamedFlag     = 0;     // Players never need "the" set for referencing their names.
        packet->Flags2.SingleFlag    = 0;     // Player is a singular thing
        packet->Flags2.AutoPartyFlag = false; // Not implemented.

        packet->Flags3.TrustFlag        = 0;
        packet->Flags3.LfgMasterFlag    = 0; // Not implemented. This is LFP while job mastered when seeking a master party. (job master star next to inv icon)
        packet->Flags3.PetNewFlag       = 0;
        packet->Flags3.MotStopFlag      = PChar->StatusEffectContainer->HasStatusEffect(EFFECT_TERROR);
        packet->Flags3.CliPriorityFlag  = PChar->priorityRender;
        packet->Flags3.PetFlag          = 0;
        packet->Flags3.BallistaTeam     = static_cast<uint8_t>(PChar->allegiance); // Also used during Ballista with slightly different values.
        packet->Flags3.MonStat          = 0;                                       // Some monstrosity flag. // TODO: verify if we already use this.
        packet->Flags3.SilenceFlag      = PChar->m_isGMHidden || PChar->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK);
        packet->Flags3.NewCharacterFlag = !PChar->playerConfig.NewAdventurerOffFlg;
        packet->Flags3.MentorFlag       = PChar->playerConfig.MentorFlg;

        packet->Flags5.GeoIndiSize    = 1;
        packet->Flags5.GeoIndiFlag    = 0;
        packet->Flags5.GeoIndiElement = 0;

        // GEO bubble effects, changes bubble effect depending on what effect is activated.
        if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_COLURE_ACTIVE))
        {
            packet->Flags5.GeoIndiElement = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_COLURE_ACTIVE)->GetPower();
            packet->Flags5.GeoIndiFlag    = 1;
        }

        // Size shouldn't change until the bubble is re-casted, but currently WIDENED COMPASS will widen the size of the bubble on the effect instantly, so this aligns with the code.
        // TODO: fix the discrepancy with retail.
        if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_WIDENED_COMPASS))
        {
            packet->Flags5.GeoIndiSize = 2;
        }

        packet->Flags6.GateId = 0; // Set as "Confrontation" sub power? This will make other players invisible that dont also have this status.
        packet->size          = roundUpToNearestFour(general_size) / 4;
    }

    if (packet->SendFlg.Model)
    {
        look_t* look = (PChar->getStyleLocked() ? &PChar->mainlook : &PChar->look);

        packet->GrapIDTbl[0] = look->modelid;
        packet->GrapIDTbl[1] = PChar->playerConfig.DisplayHeadOffFlg ? 0x0 : look->head + 0x1000;
        packet->GrapIDTbl[2] = look->body + 0x2000;
        packet->GrapIDTbl[3] = look->hands + 0x3000;
        packet->GrapIDTbl[4] = look->legs + 0x4000;
        packet->GrapIDTbl[5] = look->feet + 0x5000;
        packet->GrapIDTbl[6] = look->main + 0x6000;
        packet->GrapIDTbl[7] = look->sub + 0x7000;
        packet->GrapIDTbl[8] = look->ranged + 0x8000;

        if (PChar->m_Costume2 != 0)
        {
            packet->GrapIDTbl[0] = look->race << 8 | PChar->m_Costume2;
            packet->GrapIDTbl[8] = 0xFFFF;
        }

        if (PChar->m_PMonstrosity != nullptr)
        {
            // NOTE: Changing this 0x8000 to 0xC000 will hide the species name.
            //     : This looks to be a quirk of the client and not intended.
            packet->MonstrosityFlags   = 0x8000 | PChar->m_PMonstrosity->Species;
            packet->MonstrosityNameId1 = PChar->m_PMonstrosity->NamePrefix1;
            packet->MonstrosityNameId2 = PChar->m_PMonstrosity->NamePrefix2;

            packet->GrapIDTbl[0] = PChar->m_PMonstrosity->Look;
            packet->GrapIDTbl[8] = 0xFFFF;
            // Sword & Shield icon only shows outside of the Feretory
            if (PChar->m_PMonstrosity->Belligerency && PChar->loc.zone->GetID() != ZONE_FERETORY)
            {
                packet->Flags3.BallistaTeam |= 0x08; // 0x18?
            }
        }

        packet->size = roundUpToNearestFour(model_size) / 4;
    }

    if (packet->SendFlg.Name)
    {
        const char* charName     = PChar->getName().c_str();
        size_t      charNameSize = strlen(charName); // Don't use string.size() because it may not account for the null terminator. c_str() guarantees a null terminator
        std::memcpy(packet->name, charName, std::min(sizeof(packet->name), charNameSize));

        // For some reason, if you align the Name's null terminator on the edge of the packet, it cuts off the last character of the name.
        // Add 4 for this alignment issue, even if overkill sometimes.
        packet->size = roundUpToNearestFour(name_size + static_cast<uint32>(charNameSize) + 4) / 4;
    }

    if (packet->SendFlg.Despawn || packet->SendFlg.General)
    {
        // MountIndex is almost always set, even when character is no longer riding.
        // The client needs it for characters that dismounted out of range, else they become invisible.
        packet->Flags6.MountIndex = PChar->m_mountId;
    }

    // Fields that are always checked if this isnt a despawn packet
    if (type != ENTITY_DESPAWN)
    {
        packet->CostumeId = PChar->m_Costume;

        if (PChar->PPet)
        {
            packet->PetActIndex = PChar->PPet->targid;
        }

        packet->Flags4.TrialFlag     = 0; // Trial accounts not implemented.
        packet->Flags4.JobMasterFlag = PChar->getMod(Mod::SUPERIOR_LEVEL) == 5 && PChar->m_jobMasterDisplay;
    }
}
