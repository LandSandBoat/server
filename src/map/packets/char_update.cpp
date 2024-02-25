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

#include "char_update.h"

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
    uint32_t unknown_2_21 : 8;
    uint32_t unknown_3_29 : 3;
};

struct flags3_t
{
    uint32_t LfgMasterFlag : 1;
    uint32_t TrialFlag : 1;
    uint32_t unknown_0_2 : 1;
    uint32_t NewCharacterFlag : 1;
    uint32_t MentorFlag : 1;
    uint32_t unknown_0_5 : 1;
    uint32_t unknown_0_6 : 1;
    uint32_t unknown_0_7 : 1;
    uint32_t unknown_1_8 : 8;
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

CCharUpdatePacket::CCharUpdatePacket(CCharEntity* PChar)
{
    this->setType(0x37);
    this->setSize(0x60);

    // uint8_t         BufStatus[32];
    memcpy(data + (0x04), PChar->StatusEffectContainer->m_StatusIcons, 32);

    // uint32_t        UniqueNo;
    ref<uint32>(0x24) = PChar->id;

    // flags 0 starts at 0x28
    // ref<uint8>(0x29) |= 0x02; // this will display the old-style zone-wide treasure pool. All claimed mobs will show red name regardless of which party has claim.
    flags0_t flags0 = {};

    flags0.HideFlag        = false; // This hides your UI. Probably used for the Live Vanadiel streams.
    flags0.SleepFlag       = false; // Hides the player, probably also used for Live Vanadiel
    flags0.GroundFlag      = false; // Do not ignore collision
    flags0.CliPosInitFlag  = false; // Ready to render?
    flags0.LfgFlag         = PChar->isSeekingParty;
    flags0.CfhFlag         = false; // Orange name for CFH, players don't currently use this?
    flags0.AwayFlag        = PChar->isAway;
    flags0.AnonymousFlag   = PChar->isAnon;
    flags0.Gender          = PChar->GetGender();
    flags0.unknown_1_9     = 0; // If this flag is set, it will cause the entities ZoneNo field to be set with the current pGlobalNowZone->ZoneNo value.
    flags0.unknown_1_10    = 0; // This value is used with the main GC_ZONE object. (It is assumed that this is the new MonStat value that was used in this packet previously.)
    flags0.GraphSize       = PChar->look.size;
    flags0.Chocobo_Index   = 0;
    flags0.hpp             = PChar->GetHPP();
    flags0.PlayOnelineFlag = false; // Deprecated POL icon from /pol command that was removed.
    flags0.LinkShellFlag   = (PChar->equipLoc[SLOT_LINK1] != 0);
    flags0.LinkDeadFlag    = PChar->isLinkDead;
    flags0.TargetOffFlag   = false; // Players are currently always targetable
    flags0.unknown_3_28    = 0;     // Unknown
    flags0.GmLevel         = PChar->visibleGmLevel;

    if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_MOUNTED))
    {
        flags0.Chocobo_Index = static_cast<uint8>(PChar->StatusEffectContainer->GetStatusEffect(EFFECT_MOUNTED)->GetSubPower());
    }

    // flags 1 starts at 0x2C
    flags1_t flags1 = {};

    flags1.Speed        = PChar->GetSpeed();
    flags1.Hackmove     = PChar->wallhackEnabled; // GM wallhack, walk through walls
    flags1.FreezeFlag   = 0;                      // Freeze client in place. Is this used?
    flags1.unknown_1_14 = 0;                      // Unknown.
    flags1.InvisFlag    = PChar->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_INVISIBLE);
    flags1.unknown_2_16 = 0; // Unknown.
    flags1.SpeedBase    = PChar->speedsub;
    flags1.unknown_3_25 = 0; // Unknown
    flags1.BazaarFlag   = PChar->hasBazaar();
    flags1.CharmFlag    = PChar->isCharmed;
    flags1.GmIconFlag   = false; // If set, allows other icon flags to be shown in addition to the GM red/pink text for the name.

    if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK))
    {
        ref<uint8>(0x38) = 0x04;
    }

    ref<uint8>(0x30) = PChar->isInEvent() ? (uint8)ANIMATION_EVENT : PChar->animation;

    CItemLinkshell* linkshell = (CItemLinkshell*)PChar->getEquip(SLOT_LINK1);

    if (linkshell && linkshell->isType(ITEM_LINKSHELL))
    {
        lscolor_t LSColor = linkshell->GetLSColor();

        ref<uint8>(0x31) = (LSColor.R << 4) + 15;
        ref<uint8>(0x32) = (LSColor.G << 4) + 15;
        ref<uint8>(0x33) = (LSColor.B << 4) + 15;
    }

    flags2_t flags2 = {};

    flags2.NamedFlag       = false; // disable "The"
    flags2.SingleFlag      = true;  // singular entity
    flags2.AutoPartyFlag   = false; // Not implemented.
    flags2.MotStopFlag     = PChar->StatusEffectContainer->HasStatusEffect(EFFECT_TERROR);
    flags2.CliPriorityFlag = PChar->priorityRender;
    flags2.unknown_2_21    = static_cast<uint8>(PChar->allegiance);
    flags2.unknown_3_29    = 0; // Unknown, one of three bits appears to be campaign battle Sword & Shield Icon?

    if (PChar->PPet != nullptr)
    {
        flags2.PetIndex = PChar->PPet->targid;
    }

    // Flags3 starts at 0x38
    flags3_t flags3 = {};

    flags3.LfgMasterFlag    = false; // /inv icon WITH mastery star. Not currently implemented, this is set with the "Request" button in the Party menu.
    flags3.TrialFlag        = false; // Trial account icon flag
    flags3.unknown_0_2      = 0;     // Unknown.
    flags3.NewCharacterFlag = PChar->isNewPlayer();
    flags3.MentorFlag       = PChar->isMentor;
    flags3.unknown_0_5      = 0; // unknown
    flags3.unknown_0_6      = 0; // unknown
    flags3.unknown_0_7      = 0;
    flags3.unknown_1_8      = 0; // Unknown, but probably Ballista and Pankration related.
    flags3.unknown_2_16     = 0; // Unused

    uint32 timeRemainingToForcedHomepoint = PChar->GetTimeRemainingUntilDeathHomepoint();
    ref<uint32>(0x3C)                     = timeRemainingToForcedHomepoint;

    // Vanatime at which the player should be forced back to homepoint while dead. Vanatime is in seconds so we must convert the time remaining to seconds.
    ref<uint32>(0x40) = CVanaTime::getInstance()->getVanaTime() + timeRemainingToForcedHomepoint / 60;
    ref<uint16>(0x44) = PChar->m_Costume;
    // ref<uint16>(0x42) = cutscene warp NPC targid used in events
    // ref<uint16>(0x44) = Fellow target index

    if (PChar->animation == ANIMATION_FISHING_START)
    {
        ref<uint8>(0x4A) = PChar->hookDelay;
    }

    ref<uint64>(0x4C) = PChar->StatusEffectContainer->m_Flags;

    if (PChar->m_PMonstrosity != nullptr)
    {
        ref<uint32>(0x54) = monstrosity::GetPackedMonstrosityName(PChar);

        // Sword & Shield icon only shows outside of the Feretory
        if (PChar->m_PMonstrosity->Belligerency && PChar->loc.zone->GetID() != ZONE_FERETORY)
        {
            flags2.unknown_3_29 |= 0x01; // Broken?
        }
    }

    // Flags4 starts at 0x058
    flags4_t flags4 = {};

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

    ref<uint8>(0x59) = 0; // model_hitbox_size... does this ever change from 0?

    // flags5 starts at 0x5A
    flags5_t flags5 = {}; // All unknown, see https://github.com/atom0s/XiPackets/tree/main/world/server/0x0037

    if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_MOUNTED))
    {
        ref<uint8>(0x5B) = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_MOUNTED)->GetPower();
    }

    // flags6 starts at 0x5C
    flags6_t flags6 = {}; // All unknown, see https://github.com/atom0s/XiPackets/tree/main/world/server/0x0037

    std::memcpy(&data[0x28], &flags0, sizeof(flags0_t));
    std::memcpy(&data[0x2C], &flags1, sizeof(flags1_t));
    std::memcpy(&data[0x34], &flags2, sizeof(flags2_t));
    std::memcpy(&data[0x38], &flags3, sizeof(flags3_t));
    std::memcpy(&data[0x58], &flags4, sizeof(flags4_t));
    std::memcpy(&data[0x5A], &flags5, sizeof(flags5_t));
    std::memcpy(&data[0x5C], &flags6, sizeof(flags6_t));
}
