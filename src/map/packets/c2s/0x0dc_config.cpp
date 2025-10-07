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

#include "0x0dc_config.h"

#include "aman.h"
#include "entities/charentity.h"
#include "packets/char_status.h"
#include "packets/char_sync.h"
#include "packets/message_standard.h"
#include "packets/message_system.h"
#include "packets/s2c/0x051_grap_list.h"
#include "packets/s2c/0x0b4_config.h"
#include "utils/charutils.h"

auto GP_CLI_COMMAND_CONFIG::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .oneOf<GP_CLI_COMMAND_CONFIG_SETFLG>(SetFlg);
}

void GP_CLI_COMMAND_CONFIG::process(MapSession* PSession, CCharEntity* PChar) const
{
    const bool value = SetFlg == static_cast<uint8_t>(GP_CLI_COMMAND_CONFIG_SETFLG::On);

    bool updated = false;

    // Flag set if the client is looking for party. (/invite)
    if (InviteFlg && PChar->playerConfig.InviteFlg != value)
    {
        updated                       = true;
        PChar->playerConfig.InviteFlg = value;
    }

    // Flag set if the client is away. (/away)
    if (AwayFlg && PChar->playerConfig.AwayFlg != value)
    {
        updated                     = true;
        PChar->playerConfig.AwayFlg = value;
    }

    // Flag set if the client is anon. (/anon)
    if (AnonymityFlg && PChar->playerConfig.AnonymityFlg != value)
    {
        updated                          = true;
        PChar->playerConfig.AnonymityFlg = value;
        PChar->pushPacket<CMessageSystemPacket>(0, 0, value ? MsgStd::CharacterInfoHidden : MsgStd::CharacterInfoShown);
    }

    // Flag set if the client has auto-target disabled. (/autotarget)
    if (AutoTargetOffFlg && PChar->playerConfig.AutoTargetOffFlg != value)
    {
        updated                              = true;
        PChar->playerConfig.AutoTargetOffFlg = value;
    }

    // Flag set if the client is looking for party using the auto-group system. (/autogroup)
    if (AutoPartyFlg && PChar->playerConfig.AutoPartyFlg != value)
    {
        updated                          = true;
        PChar->playerConfig.AutoPartyFlg = value;
    }

    // Flag set if the client has enabled mentor status. (/mentor)
    if (MentorFlg && PChar->playerConfig.MentorFlg != value)
    {
        if (PChar->aman().hasMentorUnlocked())
        {
            updated                       = true;
            PChar->playerConfig.MentorFlg = value;
        }
    }

    // Flag set if the client has disabled the 'New Adventurer' status. (Red question mark.)
    if (NewAdventurerOffFlg && PChar->playerConfig.NewAdventurerOffFlg != value)
    {
        if (PChar->playerConfig.NewAdventurerOffFlg) // Can only turn it off, not on.
        {
            updated                                 = true;
            PChar->playerConfig.NewAdventurerOffFlg = value;
        }
    }

    // Flag set if the client has disabled displaying headgear. (/displayhead)
    if (DisplayHeadOffFlg && PChar->playerConfig.DisplayHeadOffFlg != value)
    {
        updated                               = true;
        PChar->playerConfig.DisplayHeadOffFlg = value;

        if (PChar->getEquip(SLOT_HEAD))
        {
            // Only blink if you have headgear
            PChar->pushPacket<GP_SERV_COMMAND_GRAP_LIST>(PChar);
        }

        PChar->pushPacket<CMessageStandardPacket>(value ? MsgStd::HeadgearHide : MsgStd::HeadgearShow);
    }

    // Flag set if the client has enabled recruitment requests. (/rec)
    if (RecruitFlg && PChar->playerConfig.RecruitFlg != value)
    {
        updated                        = true;
        PChar->playerConfig.RecruitFlg = value;
    }

    // Retail replies with these packets even if no changes were made.
    PChar->pushPacket<GP_SERV_COMMAND_CONFIG>(PChar);
    PChar->pushPacket<CCharStatusPacket>(PChar);

    if (updated)
    {
        // This packet is often sent even if no changes were made, but not always.
        PChar->pushPacket<CCharSyncPacket>(PChar);

        PChar->updatemask |= UPDATE_HP;
        charutils::SaveCharStats(PChar);
        charutils::SavePlayerSettings(PChar);
    }
}
