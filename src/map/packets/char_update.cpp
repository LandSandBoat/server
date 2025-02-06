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

#include "common/socket.h"

#include <cstring>

#include "char_update.h"

#include "entities/charentity.h"
#include "status_effect_container.h"
#include "utils/itemutils.h"

constexpr uint32_t nonspecific_size = offsetof(GP_SERV_CHAR_PC, MonstrosityFlags);
constexpr uint32_t general_size     = offsetof(GP_SERV_CHAR_PC, GrapIDTbl[0]);
constexpr uint32_t model_size       = offsetof(GP_SERV_CHAR_PC, name[0]);
constexpr uint32_t name_size        = offsetof(GP_SERV_CHAR_PC, name[0]);

// This packet should only be constructed in CCharEntity::updateEntityPacket()!
CCharUpdatePacket::CCharUpdatePacket(CCharEntity* PChar, ENTITYUPDATE type, uint8 updatemask)
: packet{}
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
    ref<uint32>(0x04) = PChar->id;

    packet.id       = 0x0D;
    packet.size     = roundUpToNearestFour(nonspecific_size) / 4; // Client recieves this and multiplies by 4
    packet.UniqueNo = PChar->id;
    packet.ActIndex = PChar->targid;

    if (type == ENTITY_SPAWN)
    {
        packet.SendFlg.Position    = true;
        packet.SendFlg.ClaimStatus = true;
        packet.SendFlg.General     = true;
        packet.SendFlg.Name        = true;
        packet.SendFlg.Model       = true;
    }
    else if (type == ENTITY_DESPAWN)
    {
        packet.SendFlg.Despawn = true;
    }
    else // Update and OR the flags together
    {
        // static_cast doesn't set the bits the way we need it to, so do some std::memcpy
        uint8 tempSendFlg = {};
        std::memcpy(&tempSendFlg, &packet.SendFlg, sizeof(charUpdateFlags::sendflags_t));

        // OR the update mask with the previously-calculated mask...
        tempSendFlg |= updatemask;

        // set the flags back
        std::memcpy(&packet.SendFlg, &tempSendFlg, sizeof(charUpdateFlags::sendflags_t));
    }

    if (packet.SendFlg.Position)
    {
        packet.dir = PChar->loc.p.rotation;
        packet.x   = PChar->loc.p.x;
        packet.y   = PChar->loc.p.z; // Intentionally Swapped, apparently internal x/y/z is not FFXI x/y/z
        packet.z   = PChar->loc.p.y; // Intentionally Swapped

        packet.Speed     = PChar->UpdateSpeed();
        packet.SpeedBase = PChar->animationSpeed;

        packet.Flags0.MovTime     = PChar->loc.p.moving;
        packet.Flags0.RunMode     = 0;                      // Unknown
        packet.Flags0.unknown_1_6 = 0;                      // Unknown
        packet.Flags0.RunMode     = 0;                      // Used within events. // TODO: verify usage in events
        packet.Flags0.GroundFlag  = PChar->wallhackEnabled; // Is this the same as HackMove?
        packet.Flags0.KingFlag    = 0;                      // Unused
        packet.Flags0.facetarget  = PChar->m_TargID;
    }

    if (packet.SendFlg.ClaimStatus)
    {
        packet.BtTargetID = 0; // TODO: What should this be set to? This is "claim status", not sure we keep track of that for players.
    }

    if (packet.SendFlg.General)
    {
        packet.Hpp             = PChar->GetHPP();
        packet.server_status   = PChar->animation;
        packet.ModelHitboxSize = 4; // TODO: verify this value and if it changes (Monstrosity?)

        packet.Flags1.MonsterFlag = false; // TODO: Is this ever set for Monstrosity PVP?
        packet.Flags1.HideFlag    = false;
        packet.Flags1.SleepFlag   = 0;                                                                // Something to do with events. // TODO: figure out when/if this is set. Probably when you're in a cutscene?
        packet.Flags1.unknown_0_3 = PChar->loc.zone ? PChar->loc.zone->CanUseMisc(MISC_TREASURE) : 0; // Set global treasure pool
        packet.Flags1.unknown_0_4 = 0;

        if (auto* effect = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_MOUNTED))
        {
            packet.Flags1.ChocoboIndex = effect->GetSubPower();
        }

        CItemLinkshell* linkshell = (CItemLinkshell*)PChar->getEquip(SLOT_LINK1);

        packet.Flags1.CliPosInitFlag  = 0; // Unused
        packet.Flags1.GraphSize       = PChar->look.size;
        packet.Flags1.LfgFlag         = PChar->playerConfig.InviteFlg;
        packet.Flags1.AnonymousFlag   = PChar->playerConfig.AnonymityFlg;
        packet.Flags1.YellFlag        = 0; // 1 sets player name to yellow, unused.
        packet.Flags1.AwayFlag        = PChar->playerConfig.AwayFlg;
        packet.Flags1.Gender          = PChar->GetGender();
        packet.Flags1.PlayOnelineFlag = 0; // POL icon, currently unused
        packet.Flags1.LinkShellFlag   = linkshell ? true : false;
        packet.Flags1.LinkDeadFlag    = PChar->isLinkDead;
        packet.Flags1.TargetOffFlag   = 0; // Untargetable player, not sure if this is ever used.
        packet.Flags1.TalkUcoffFlag   = 0; // Unknown, but used with events. // TOOD: verify how/when this is used.
        packet.Flags1.GmLevel         = PChar->visibleGmLevel;
        packet.Flags1.HackMove        = PChar->wallhackEnabled;
        packet.Flags1.InvisFlag       = PChar->m_isGMHidden || PChar->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_INVISIBLE);
        packet.Flags1.TurnFlag        = 0; // I do not believe we currently use this. // TOOD: get the lerp values from retail somehow.
        packet.Flags1.BazaarFlag      = PChar->hasBazaar();

        if (linkshell && linkshell->isType(ITEM_LINKSHELL))
        {
            lscolor_t LSColor = linkshell->GetLSColor();

            // This seems wrong, but displays correctly?
            packet.Flags2.r = (LSColor.R << 4) + 15;
            packet.Flags2.g = (LSColor.G << 4) + 15;
            packet.Flags2.b = (LSColor.B << 4) + 15;
        }

        packet.Flags2.PvPFlag       = 0; // Gate breach status in ballista, apparently.
        packet.Flags2.ShadowFlag    = 0; // Hides player shadow if set to 1. Is this used?
        packet.Flags2.CharmFlag     = PChar->isCharmed;
        packet.Flags2.GmIconFlag    = false; // If set, allows other icon flags to be shown in addition to the GM red/pink text for the name.
        packet.Flags2.NamedFlag     = 0;     // Players never need "the" set for referencing their names.
        packet.Flags2.SingleFlag    = 0;     // Player is a singular thing
        packet.Flags2.AutoPartyFlag = false; // Not implemented.

        packet.Flags3.TrustFlag        = 0;
        packet.Flags3.LfgMasterFlag    = 0; // Not implemented. This is LFP while job mastered when seeking a master party. (job master star next to inv icon)
        packet.Flags3.PetNewFlag       = 0;
        packet.Flags3.MotStopFlag      = PChar->StatusEffectContainer->HasStatusEffect(EFFECT_TERROR);
        packet.Flags3.CliPriorityFlag  = PChar->priorityRender;
        packet.Flags3.PetFlag          = 0;
        packet.Flags3.BallistaTeam     = static_cast<uint8_t>(PChar->allegiance); // Also used during Ballista with slightly different values.
        packet.Flags3.MonStat          = 0;                                       // Some monstrosity flag. // TODO: verify if we already use this.
        packet.Flags3.SilenceFlag      = PChar->m_isGMHidden || PChar->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK);
        packet.Flags3.NewCharacterFlag = !PChar->playerConfig.NewAdventurerOffFlg;
        packet.Flags3.MentorFlag       = PChar->playerConfig.MentorFlg;

        packet.Flags5.GeoIndiSize    = 1;
        packet.Flags5.GeoIndiFlag    = 0;
        packet.Flags5.GeoIndiElement = 0;

        // GEO bubble effects, changes bubble effect depending on what effect is activated.
        if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_COLURE_ACTIVE))
        {
            packet.Flags5.GeoIndiElement = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_COLURE_ACTIVE)->GetPower();
            packet.Flags5.GeoIndiFlag    = 1;
        }

        // Size shouldn't change until the bubble is re-casted, but currently WIDENED COMPASS will widen the size of the bubble on the effect instantly, so this aligns with the code.
        // TODO: fix the discrepancy with retail.
        if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_WIDENED_COMPASS))
        {
            packet.Flags5.GeoIndiSize = 2;
        }

        packet.Flags6.GateId = 0; // Set as "Confrontation" sub power? This will make other players invisible that dont also have this status.
        if (PChar->StatusEffectContainer->GetStatusEffect(EFFECT_MOUNTED))
        {
            packet.Flags6.MountIndex = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_MOUNTED)->GetPower();
        }

        packet.size = roundUpToNearestFour(general_size) / 4;
    }

    if (packet.SendFlg.Model)
    {
        look_t* look = (PChar->getStyleLocked() ? &PChar->mainlook : &PChar->look);

        packet.GrapIDTbl[0] = look->modelid;
        packet.GrapIDTbl[1] = PChar->playerConfig.DisplayHeadOffFlg ? 0x0 : look->head + 0x1000;
        packet.GrapIDTbl[2] = look->body + 0x2000;
        packet.GrapIDTbl[3] = look->hands + 0x3000;
        packet.GrapIDTbl[4] = look->legs + 0x4000;
        packet.GrapIDTbl[5] = look->feet + 0x5000;
        packet.GrapIDTbl[6] = look->main + 0x6000;
        packet.GrapIDTbl[7] = look->sub + 0x7000;
        packet.GrapIDTbl[8] = look->ranged + 0x8000;

        if (PChar->m_Costume2 != 0)
        {
            packet.GrapIDTbl[0] = look->race << 8 | PChar->m_Costume2;
            packet.GrapIDTbl[8] = 0xFFFF;
        }

        if (PChar->m_PMonstrosity != nullptr)
        {
            // NOTE: Changing this 0x8000 to 0xC000 will hide the species name.
            //     : This looks to be a quirk of the client and not intended.
            packet.MonstrosityFlags   = 0x8000 | PChar->m_PMonstrosity->Species;
            packet.MonstrosityNameId1 = PChar->m_PMonstrosity->NamePrefix1;
            packet.MonstrosityNameId2 = PChar->m_PMonstrosity->NamePrefix2;

            packet.GrapIDTbl[0] = PChar->m_PMonstrosity->Look;
            packet.GrapIDTbl[8] = 0xFFFF;
            // Sword & Shield icon only shows outside of the Feretory
            if (PChar->m_PMonstrosity->Belligerency && PChar->loc.zone->GetID() != ZONE_FERETORY)
            {
                packet.Flags3.BallistaTeam |= 0x08; // 0x18?
            }
        }

        packet.size = roundUpToNearestFour(model_size) / 4;
    }

    if (packet.SendFlg.Name)
    {
        const char* charName     = PChar->getName().c_str();
        size_t      charNameSize = strlen(charName); // Don't use string.size() because it may not account for the null terminator. c_str() guarantees a null terminator
        std::memcpy(packet.name, charName, std::min(sizeof(packet.name), charNameSize));

        // For some reason, if you align the Name's null terminator on the edge of the packet, it cuts off the last character of the name.
        // Add 4 for this alignment issue, even if overkill sometimes.
        packet.size = roundUpToNearestFour(name_size + static_cast<uint32>(charNameSize) + 4) / 4;
    }

    // Fields that are always checked if this isnt a despawn packet
    if (type != ENTITY_DESPAWN)
    {
        packet.CostumeId = PChar->m_Costume;

        if (PChar->PPet)
        {
            packet.PetActIndex = PChar->PPet->targid;
        }

        packet.Flags4.TrialFlag     = 0; // Trial accounts not implemented.
        packet.Flags4.JobMasterFlag = PChar->getMod(Mod::SUPERIOR_LEVEL) == 5 && PChar->m_jobMasterDisplay;
    }

    std::memcpy(&buffer_.data()[0], &packet, sizeof(packet));
}
