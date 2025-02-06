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

#include "char_status.h"

#include "common/logging.h"
#include "common/socket.h"
#include "common/vana_time.h"

#include <cstring>

#include "ai/ai_container.h"
#include "ai/states/death_state.h"
#include "entities/charentity.h"
#include "item_container.h"
#include "status_effect_container.h"
#include "utils/itemutils.h"

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0037

// Namespace to avoid compilation units using the same structs twice with different definitions
namespace charStatusFlags
{
    struct flags0_t
    {
        uint32_t HideFlag : 1;
        uint32_t SleepFlag : 1;
        uint32_t GroundFlag : 1;
        uint32_t CliPosInitFlag : 1;
        uint32_t LfgFlag : 1;
        uint32_t AnonymousFlag : 1;
        uint32_t CfhFlag : 1;
        uint32_t AwayFlag : 1;
        uint32_t Gender : 1;
        uint32_t unknown_1_9 : 1;
        uint32_t unknown_1_10 : 1;
        uint32_t GraphSize : 2;
        uint32_t Chocobo_Index : 3;
        uint32_t hpp : 8;
        uint32_t PlayOnelineFlag : 1;
        uint32_t LinkShellFlag : 1;
        uint32_t LinkDeadFlag : 1;
        uint32_t TargetOffFlag : 1;
        uint32_t unknown_3_28 : 1;
        uint32_t GmLevel : 3;
    };

    struct flags1_t
    {
        uint32_t Speed : 12;
        uint32_t Hackmove : 1;
        uint32_t FreezeFlag : 1;
        uint32_t unknown_1_14 : 1;
        uint32_t InvisFlag : 1;
        uint32_t unknown_2_16 : 1;
        uint32_t SpeedBase : 8;
        uint32_t unknown_3_25 : 4;
        uint32_t BazaarFlag : 1;
        uint32_t CharmFlag : 1;
        uint32_t GmIconFlag : 1;
    };

    struct flags2_t
    {
        uint32_t NamedFlag : 1;
        uint32_t SingleFlag : 1;
        uint32_t AutoPartyFlag : 1;
        uint32_t PetIndex : 16;
        uint32_t MotStopFlag : 1;
        uint32_t CliPriorityFlag : 1;
        uint32_t BallistaFlg : 8;
        uint32_t unknown_3_29 : 3;
    };

    struct flags3_t
    {
        uint32_t LfgMasterFlag : 1;
        uint32_t TrialFlag : 1;
        uint32_t SilenceFlag : 1;
        uint32_t NewCharacterFlag : 1;
        uint32_t MentorFlag : 1;
        uint32_t unknown_0_5 : 1;
        uint32_t unknown_0_6 : 1;
        uint32_t unknown_0_7 : 1;
        uint32_t BallistaTeam : 8;
        uint32_t unknown_2_16 : 16;
    };

    struct flags4_t
    {
        uint8_t GeoIndiElement : 4;
        uint8_t GeoIndiSize : 2;
        uint8_t GeoIndiFlag : 1;
        uint8_t JobMasterFlag : 1;
    };

    struct flags5_t
    {
        uint8_t unknown_0_0 : 2;
        uint8_t unknown_0_2 : 2;
        uint8_t unknown_0_4 : 4;
    };

    struct flags6_t
    {
        uint32_t unknown_0_0 : 1;
        uint32_t unknown_0_1 : 1;
        uint32_t unknown_0_2 : 1;
        uint32_t unknown_0_3 : 1;
        uint32_t unknown_0_4 : 1;
        uint32_t unknown_0_5 : 1;
        uint32_t unknown_0_6 : 1;
        uint32_t unknown_0_7 : 25;
    };
} // namespace charStatusFlags

struct status_bits_t
{
    uint8_t Status1 : 2;
    uint8_t Status2 : 2;
    uint8_t Status3 : 2;
    uint8_t Status4 : 2;
    uint8_t Status5 : 2;
    uint8_t Status6 : 2;
    uint8_t Status7 : 2;
    uint8_t Status8 : 2;
    uint8_t Status9 : 2;
    uint8_t Status10 : 2;
    uint8_t Status11 : 2;
    uint8_t Status12 : 2;
    uint8_t Status13 : 2;
    uint8_t Status14 : 2;
    uint8_t Status15 : 2;
    uint8_t Status16 : 2;
    uint8_t Status17 : 2;
    uint8_t Status18 : 2;
    uint8_t Status19 : 2;
    uint8_t Status20 : 2;
    uint8_t Status21 : 2;
    uint8_t Status22 : 2;
    uint8_t Status23 : 2;
    uint8_t Status24 : 2;
    uint8_t Status25 : 2;
    uint8_t Status26 : 2;
    uint8_t Status27 : 2;
    uint8_t Status28 : 2;
    uint8_t Status29 : 2;
    uint8_t Status30 : 2;
    uint8_t Status31 : 2;
    uint8_t Status32 : 2;
};

// PS2: GP_SERV_SERVERSTATUS
struct GP_SERV_SERVERSTATUS
{
    uint16_t                  id : 9;
    uint16_t                  size : 7;
    uint16_t                  sync;
    uint8_t                   BufStatus[32];        // PS2: BufStatus
    uint32_t                  UniqueNo;             // PS2: UniqueNo
    charStatusFlags::flags0_t Flags0;               // PS2: <bits> (Nameless bitfield.)
    charStatusFlags::flags1_t Flags1;               // PS2: <bits> (Nameless bitfield.)
    uint8_t                   server_status;        // PS2: server_status
    uint8_t                   r;                    // PS2: r
    uint8_t                   g;                    // PS2: g
    uint8_t                   b;                    // PS2: b
    charStatusFlags::flags2_t Flags2;               // PS2: <bits> (Nameless bitfield.)
    charStatusFlags::flags3_t Flags3;               // PS2: <bits> (New; did not exist.)
    uint32_t                  dead_counter1;        // PS2: (New; did not exist.)
    uint32_t                  dead_counter2;        // PS2: (New; did not exist.)
    uint16_t                  costume_id;           // PS2: (New; did not exist.)
    uint16_t                  warp_target_index;    // PS2: (New; did not exist.)
    uint16_t                  fellow_target_index;  // PS2: (New; did not exist.)
    uint8_t                   fishing_timer;        // PS2: (New; did not exist.)
    uint8_t                   padding00;            // PS2: (New; did not exist.)
    status_bits_t             BufStatusBits;        // PS2: (New; did not exist.)
    uint16_t                  monstrosity_info;     // PS2: (New; did not exist.)
    uint8_t                   monstrosity_name_id1; // PS2: (New; did not exist.)
    uint8_t                   monstrosity_name_id2; // PS2: (New; did not exist.)
    charStatusFlags::flags4_t Flags4;               // PS2: (New; did not exist.)
    uint8_t                   model_hitbox_size;    // PS2: (New; did not exist.)
    charStatusFlags::flags5_t Flags5;               // PS2: (New; did not exist.)
    uint8_t                   mount_id;             // PS2: (New; did not exist.)
    charStatusFlags::flags6_t Flags6;               // PS2: (New; did not exist.)
};

CCharStatusPacket::CCharStatusPacket(CCharEntity* PChar)
{
    this->setType(0x37);
    this->setSize(0x60);

    GP_SERV_SERVERSTATUS packet = {};
    std::memset(&packet, 0, sizeof(packet));

    packet.id   = 0x037;
    packet.size = roundUpToNearestFour(sizeof(GP_SERV_SERVERSTATUS)) / 4;

    std::memcpy(packet.BufStatus, PChar->StatusEffectContainer->m_StatusIcons, 32);
    std::memcpy(&packet.BufStatusBits, &PChar->StatusEffectContainer->m_Flags, sizeof(status_bits_t));

    packet.UniqueNo      = PChar->id;
    packet.server_status = PChar->isInEvent() ? static_cast<uint8>(ANIMATION_EVENT) : PChar->animation;

    CItemLinkshell* linkshell = (CItemLinkshell*)PChar->getEquip(SLOT_LINK1);

    if (linkshell && linkshell->isType(ITEM_LINKSHELL))
    {
        lscolor_t LSColor = linkshell->GetLSColor();

        // This seems wrong, but displays correctly?
        packet.r = (LSColor.R << 4) + 15;
        packet.g = (LSColor.G << 4) + 15;
        packet.b = (LSColor.B << 4) + 15;
    }

    packet.dead_counter1     = PChar->GetTimeRemainingUntilDeathHomepoint();
    packet.dead_counter2     = CVanaTime::getInstance()->getVanaTime() + packet.dead_counter1 / 60;
    packet.costume_id        = PChar->m_Costume;
    packet.model_hitbox_size = 4; // TODO: verify this
    packet.mount_id          = 0;

    if (PChar->animation == ANIMATION_FISHING_START)
    {
        packet.fishing_timer = PChar->hookDelay;
    }

    // flags 0 starts at 0x28
    charStatusFlags::flags0_t flags0 = {};

    flags0.HideFlag        = false; // This hides your UI. Probably used for the Live Vanadiel streams.
    flags0.SleepFlag       = false; // Hides the player, probably also used for Live Vanadiel
    flags0.GroundFlag      = false; // Do not ignore collision
    flags0.CliPosInitFlag  = false; // Ready to render?
    flags0.LfgFlag         = PChar->isSeekingParty();
    flags0.CfhFlag         = false; // Orange name for CFH, players don't currently use this?
    flags0.AwayFlag        = PChar->isAway();
    flags0.AnonymousFlag   = PChar->isAnon();
    flags0.Gender          = PChar->GetGender();
    flags0.unknown_1_9     = PChar->loc.zone ? PChar->loc.zone->CanUseMisc(MISC_TREASURE) : 0; // Set global treasure pool;
    flags0.unknown_1_10    = 0;
    flags0.GraphSize       = PChar->look.size;
    flags0.Chocobo_Index   = 0;
    flags0.hpp             = PChar->GetHPP();
    flags0.PlayOnelineFlag = false; // Deprecated POL icon from /pol command that was removed.
    flags0.LinkShellFlag   = linkshell ? true : false;
    flags0.LinkDeadFlag    = PChar->isLinkDead;
    flags0.TargetOffFlag   = false; // Players are currently always targetable
    flags0.unknown_3_28    = 0;     // Unknown
    flags0.GmLevel         = PChar->visibleGmLevel;

    if (auto* effect = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_MOUNTED))
    {
        packet.mount_id      = effect->GetPower();
        flags0.Chocobo_Index = effect->GetSubPower();
    }

    // flags 1 starts at 0x2C
    charStatusFlags::flags1_t flags1 = {};

    flags1.Speed        = PChar->UpdateSpeed();
    flags1.Hackmove     = PChar->wallhackEnabled; // GM wallhack, walk through walls
    flags1.FreezeFlag   = 0;                      // Freeze client in place. Is this used?
    flags1.unknown_1_14 = 0;                      // Unknown.
    flags1.InvisFlag    = PChar->m_isGMHidden || PChar->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_INVISIBLE);
    flags1.unknown_2_16 = 0; // Unknown.
    flags1.SpeedBase    = PChar->animationSpeed;
    flags1.unknown_3_25 = 0; // Unknown
    flags1.BazaarFlag   = PChar->hasBazaar();
    flags1.CharmFlag    = PChar->isCharmed;
    flags1.GmIconFlag   = false; // If set, allows other icon flags to be shown in addition to the GM red/pink text for the name.

    charStatusFlags::flags2_t flags2 = {};

    flags2.NamedFlag       = false; // disable "The"
    flags2.SingleFlag      = false; // singular entity
    flags2.AutoPartyFlag   = false; // Not implemented.
    flags2.MotStopFlag     = PChar->StatusEffectContainer->HasStatusEffect(EFFECT_TERROR);
    flags2.CliPriorityFlag = PChar->priorityRender;
    flags2.BallistaFlg     = static_cast<uint8>(PChar->allegiance);
    flags2.unknown_3_29    = 0; // Unknown, one of three bits appears to be campaign battle Sword & Shield Icon?

    if (PChar->PPet != nullptr)
    {
        flags2.PetIndex = PChar->PPet->targid;
    }

    // Flags3 starts at 0x38
    charStatusFlags::flags3_t flags3 = {};

    flags3.LfgMasterFlag    = false; // /inv icon WITH mastery star. Not currently implemented, this is set with the "Request" button in the Party menu.
    flags3.TrialFlag        = false; // Trial account icon flag
    flags3.SilenceFlag      = PChar->m_isGMHidden || PChar->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK);
    flags3.NewCharacterFlag = PChar->isNewPlayer();
    flags3.MentorFlag       = PChar->isMentor();
    flags3.unknown_0_5      = 0; // unknown
    flags3.unknown_0_6      = 0; // unknown
    flags3.unknown_0_7      = 0;
    flags3.BallistaTeam     = static_cast<uint8_t>(PChar->allegiance); // Different values used for Ballista
    flags3.unknown_2_16     = 0;                                       // Unused

    // Flags4 starts at 0x058
    charStatusFlags::flags4_t flags4 = {};

    flags4.GeoIndiElement = 0;
    flags4.GeoIndiSize    = 1;
    flags4.GeoIndiFlag    = 0;
    flags4.JobMasterFlag  = PChar->getMod(Mod::SUPERIOR_LEVEL) == 5 && PChar->m_jobMasterDisplay;

    // GEO bubble effects, changes bubble effect depending on what effect is activated.
    if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_COLURE_ACTIVE))
    {
        flags4.GeoIndiElement = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_COLURE_ACTIVE)->GetPower();
        flags4.GeoIndiFlag    = 1;
    }

    // Size shouldn't change until the bubble is re-casted, but currently WIDENED COMPASS will widen the size of the bubble on the effect instantly, so this aligns with the code.
    // TODO: fix the discrepancy with retail.
    if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_WIDENED_COMPASS))
    {
        flags4.GeoIndiSize = 2;
    }

    // flags5 starts at 0x5A
    charStatusFlags::flags5_t flags5 = {}; // All unknown, see https://github.com/atom0s/XiPackets/tree/main/world/server/0x0037

    // flags6 starts at 0x5C
    charStatusFlags::flags6_t flags6 = {}; // All unknown, see https://github.com/atom0s/XiPackets/tree/main/world/server/0x0037

    if (PChar->m_PMonstrosity != nullptr)
    {
        // NOTE: Changing this 0x8000 to 0xC000 will hide the species name.
        //     : This looks to be a quirk of the client and not intended.
        packet.monstrosity_info     = 0x8000 | PChar->m_PMonstrosity->Species;
        packet.monstrosity_name_id1 = PChar->m_PMonstrosity->NamePrefix1;
        packet.monstrosity_name_id2 = PChar->m_PMonstrosity->NamePrefix2;

        // Sword & Shield icon only shows outside of the Feretory
        if (PChar->m_PMonstrosity->Belligerency && PChar->loc.zone->GetID() != ZONE_FERETORY)
        {
            packet.Flags2.BallistaFlg |= 0x08; // 0x18?
        }
    }

    packet.Flags0 = flags0;
    packet.Flags1 = flags1;
    packet.Flags2 = flags2;
    packet.Flags3 = flags3;
    packet.Flags4 = flags4;
    packet.Flags5 = flags5;
    packet.Flags6 = flags6;

    std::memcpy(&buffer_.data()[0], &packet, sizeof(packet));

    // Mog wardrobe enabled bits (apparently used by windower in get_bag_info(N).enabled):
    // 0x01 = Wardrobe 3
    // 0x02 = Wardrobe 4
    // 0x04 = Unknown (not set in retail?)
    // 0x08 = Wardrobe 5
    // 0x10 = Wardrobe 6
    // 0x20 = Wardrobe 7
    // 0x40 = Wardrobe 8
    ref<uint8>(0x5C) = 0x7B;
    // This field is probably deprecated because the client reads it in and doesn't use it.
}
