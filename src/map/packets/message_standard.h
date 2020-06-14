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

#ifndef _CMESSAGESTANDARTPACKET_H
#define _CMESSAGESTANDARTPACKET_H

#include "../../common/cbasetypes.h"

#include "basic.h"

/*
Valid MessageIDs
Complete list at 1/27/76.DAT

NOTE: System messages do not specify the color in the packet explictly. Instead there is a different message ID
for each of the supported chat colors (e.g. say, shout, linkshell). Each of these types have their own colors
as configured by the client.
*/
enum class MsgStd
{
    // Used as a sentinal value. This should not be used as part of a packet.
    Unknown = -1,

    InvitationDeclined             = 11, // Your invitation was declined
    CannotBeProcessed              = 14, // That request cannot be processed
    NotPartyLeader                 = 21, // You are not the party leader.
    CannotInvite                   = 23, // You cannot invite that person at this time.
    NoPartyMembers                 = 36, // There are no party members.
    NoLinkshellEquipped            = 37, // You do not have a linkshell item equipped.
    WaitLonger                     = 38, // You must wait longer to perform that action.
    DiceRoll                       = 88, // Dice Roll! <player> rolls <roll>.
    Examine                        = 89, // <name> examines you.
    PollProposalShout              = 100, // Player Name's proposal to all (cast vote with command: "/vote ?"):
    PollProposalParty              = 101, // Player Name's proposal to the party (cast vote with command: "/vote ?"):
    PollProposalLinkshell          = 102, // Player Name's proposal to the linkshell group (cast vote with command: "/vote ?"):
    PollProposalSystem             = 103, // Player Name's proposal to everyone (cast vote with command: "/vote ?"):
    LinkshellEquipBeforeUsing      = 108, // Equip a linkshell, pearlsack, or linkpearl before using that command.
    LinkshellKicked                = 109, // You have been kicked out of the linkshell group.
    LinkshellNoLongerExists        = 110, // That linkshell group no longer exists. This item is unusable.
    LinkshellUnavailable           = 112, // The linkshell name you entered is already in use or otherwise unavailable.
    TellNotReceivedOffline         = 125, // Your tell was not received.  The recipient is currently away.
    CurrentPollResultsSystem       = 140, // Player Name's proposal - Current poll results:
    FinalPollResultsSystem         = 141, // Player Name's proposal - Final poll results:
    PollProposalSay                = 146, // Player Name's proposal to all (cast vote with command: "/vote ?"):
    CurrentPollResultsSay          = 147, // Player Name's proposal - Current poll results:
    FinalPollResultsSay            = 148, // Player Name's proposal - Final poll results:
    CurrentPollResultsShout        = 149, // Player Name's proposal - Current poll results:
    FinalPollResultsShout          = 150, // Player Name's proposal - Final poll results:
    CurrentPollResultsParty        = 151, // Player Name's proposal - Current poll results:
    FinalPollResultsParty          = 152, // Player Name's proposal - Final poll results:
    CurrentPollResultsLinkshell    = 153, // Player Name's proposal - Current poll results:
    FinalPollResultsLinkshell      = 154, // Player Name's proposal - Final poll results:
    LinkshellNoAccess              = 158, // You do not have access to those linkshell commands.
    ThrowAway                      = 180, // You throw away <item>.
    TellNotReceivedAway            = 181, // Your tell was not received.  The recipient is currently away.
    ItemEx                         = 220, // You cannot possess more than one of that item.
    BlockingAid                    = 225, // Target is currently blocking outside magical assistance
    Sell                           = 232, // You sell <item>.
    SellToShop                     = 233, // You sell <item> to the shop.
    LevelSyncWarning               = 235, // Warning! This is a Level Sync party ...
    CannotInviteLevelSync          = 236, // You cannot invite that person at this time. This player is either undergoing Level Sync...
    CannotJoinLevelSync            = 237, // You cannot join this party.  You are either underoing Level Sync...
    Compass                        = 239, // The compass reads: ...
    CannotHere                     = 256, // You cannot use that command in this area.
    HeadgearShow                   = 260,
    HeadgearHide                   = 261,
    TrustCannotJoinParty           = 265, // You are unable to join a party whose leader currently has an alter ego present.
    TrustCannotJoinAlliance        = 266, // You are unable to join an alliance whose leader currently has an alter ego present.
    StyleLockOn                    = 267, // Style lock mode enabled.
    StyleLockOff                   = 268, // Style lock mode disabled.
    StyleLockIsOn                  = 269, // Style lock mode is enabled.
    StyleLockIsOff                 = 270, // Style lock mode is disabled.
    PollProposalLinkshell2         = 289, // Player Name's proposal to the linkshell group (cast vote with command: "/vote ?"):
    CurrentPollResultsLinkshell2   = 290, // Player Name's proposal - Current poll results:
    FinalPollResultsLinkshell2     = 291, // Player Name's proposal - Final poll results:
    TrustCannotLFP                 = 296, // You cannot use Trust magic while seeking a party.
    WaitParty                      = 297, // While inviting a party member, you must wait a while before using Trust magic.
    TrustLimit                     = 298, // You have called forth your maximum number of alter egos.
    TrustSame                      = 299, // That alter ego has already been called forth.
    TrustEnmity                    = 300, // You cannot use Trust magic while having gained enmity.
    TrustSoloOrLeader              = 301  // You cannot use Trust magic unless you are solo or the party leader.
};

class CCharEntity;

class CMessageStandardPacket : public CBasicPacket
{
public:

    CMessageStandardPacket(MsgStd MessageID);
	CMessageStandardPacket(CCharEntity* PChar, uint32 param0, MsgStd MessageID);
	CMessageStandardPacket(CCharEntity* PChar, uint32 param0, uint32 param1, MsgStd MessageID);
	CMessageStandardPacket(uint32 param0, uint32 param1, uint32 param2, uint32 param3, MsgStd MessageID);
};

#endif
