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

#include "common/cbasetypes.h"

#include "basic.h"

// Valid MessageIDs for both standard and SYSTEM type messages
// Found in ROM/27/76.dat or 1-27-76.xml if using mass extractor
// Todo: move msg enums to common location out of packet headers
enum class MsgStd
{
    // Used as a sentinel value. This should not be used as part of a packet.
    Unknown = -1,

    // Keep message IDs in order OR ELSE UNSPECIFIED CONSQUENSES SHALL ENSUE

    CouldNotEnter                = 2,   // You could not enter the next area. [0,1,3,4, all same message]
    CouldNotEnterYourRoom        = 5,   // You could not enter your room.
    InvitationDeclined           = 11,  // Your invitation was declined.
    PersonIsPartyMember          = 12,  // That person is a party member.
    CannotPerformJobEmote        = 13,  // You cannot perform that job emote.
    CannotBeProcessed            = 14,  // That request cannot be processed.
    CallPlacedInTheQueue         = 20,  // Your call has been placed in the queue.
    NotPartyLeader               = 21,  // You are not the party leader.
    UnclaimedTreasureWillBeLost  = 22,  // Caution: All unclaimed treasure will be lost if you join a party.
    CannotInvite                 = 23,  // You cannot invite that person at this time.
    UnableToPerformInMoghouse    = 32,  // Unable to perform action in Mog House.
    PersonIsAway                 = 33,  // That person is currently away and cannot respond.
    PersonIsUsingPOL             = 34,  // That person is currently using the PlayOnline Viewer and can only be reached by sending a "knock message" from the Search menu.
    NoPartyMembers               = 36,  // There are no party members.
    NoLinkshellEquipped          = 37,  // You do not have a linkshell item equipped.
    WaitLonger                   = 38,  // You must wait longer to perform that action.
    YouDontHaveAny               = 39,  // You don't have any <item>.
    DiceRoll                     = 88,  // Dice Roll! <player> rolls <roll>.
    Examine                      = 89,  // <name> examines you.
    PollProposalShout            = 100, // Player Name's proposal to all (cast vote with command: "/vote ?"):
    PollProposalParty            = 101, // Player Name's proposal to the party (cast vote with command: "/vote ?"):
    PollProposalLinkshell        = 102, // Player Name's proposal to the linkshell group (cast vote with command: "/vote ?"):
    PollProposalSystem           = 103, // Player Name's proposal to everyone (cast vote with command: "/vote ?"):
    LinkshellEquipBeforeUsing    = 108, // Equip a linkshell, pearlsack, or linkpearl before using that command.
    LinkshellKicked              = 109, // You have been kicked out of the linkshell group.
    LinkshellNoLongerExists      = 110, // That linkshell group no longer exists. This item is unusable.
    LinkshellUnavailable         = 112, // The linkshell name you entered is already in use or otherwise unavailable.
    EventSkipped                 = 117, // Event skipped.
    TellNotReceivedOffline       = 125, // Your tell was not received.  The recipient is currently away.
    MoghouseCantPickUp           = 137, // Kupo... I can't pick anything right now, kupo.
    ChocoboRefusedToEnte         = 138, // The chocobo refused to enter the next area.
    CurrentPollResultsSystem     = 140, // Player Name's proposal - Current poll results:
    FinalPollResultsSystem       = 141, // Player Name's proposal - Final poll results:
    CannotUseCommandAtTheMoment  = 142, // You cannot use that command at the moment. Please try again later.
    PollProposalSay              = 146, // Player Name's proposal to all (cast vote with command: "/vote ?"):
    CurrentPollResultsSay        = 147, // Player Name's proposal - Current poll results:
    FinalPollResultsSay          = 148, // Player Name's proposal - Final poll results:
    CurrentPollResultsShout      = 149, // Player Name's proposal - Current poll results:
    FinalPollResultsShout        = 150, // Player Name's proposal - Final poll results:
    CurrentPollResultsParty      = 151, // Player Name's proposal - Current poll results:
    FinalPollResultsParty        = 152, // Player Name's proposal - Final poll results:
    CurrentPollResultsLinkshell  = 153, // Player Name's proposal - Current poll results:
    FinalPollResultsLinkshell    = 154, // Player Name's proposal - Final poll results:
    LinkshellNoAccess            = 158, // You do not have access to those linkshell commands.
    CannotWhileInvisible         = 172, // You cannot use that command while invisible.
    CharacterInfoHidden          = 175, // Your character information is now hidden.
    CharacterInfoShown           = 176, // Your character information is now shown.
    ThrowAway                    = 180, // You throw away <item>.
    TellNotReceivedAway          = 181, // Your tell was not received.  The recipient is currently away.
    PersonAlreadyInAlliance      = 182, // That person is already in an alliance.
    UnableToProcessRequest       = 183, // Unable to process request.
    ExpansionPackNotRegistered   = 184, // Unable to enter next area. Expansion pack not registered.
    ExpansionPackNotInstalled    = 185, // Unable to enter next area. Expansion pack not installed.
    CannotPerformPetra           = 209, // You cannot perform that action while holding a Petra.
    CannotPerformNoPetra         = 210, // You cannot perform that action without a Petra.
    LostYourPetras               = 211, // You lost your Petras.
    GateBreachDisengaged         = 212, // Gate Breach status has been disengaged.
    ReturningToBattle            = 214, // Returning to battle.
    ReturningToCamp              = 215, // Returning to camp.
    CannotPerformInConflict      = 216, // This action cannot be performed while participating in Conflict.
    CannotPerformPreparingBattle = 216, // This action cannot be performed while preparing for battle.
    ChevronsEarned               = 219, // Chevrons earned: Gold: 0 Mythril: 0 Silver: 0 Bronze: 0 Job: 0
    ItemEx                       = 220, // You cannot possess more than one of that item.
    BlockaidActivated            = 221, // Blockaid activated. Magical assistance, trades, party invites etc. from non-party/alliance characters will be blocked. This effect will continue until changing areas, or executing the "/blockaid off" command.
    BlockaidCanceled             = 222, // Blockaid canceled. Magical assistance, trades, party invites etc. from non-party/alliance characters will be allowed.
    BlockaidCurrentlyActive      = 223, // Blockaid is currently active. ("/blockaid off" to cancel.)
    BlockaidCurrentlyInactive    = 224, // Blockaid is currently inactive.
    TargetIsCurrentlyBlocking    = 225, // Target is currently blocking outside magical assistance, trades, and party invites.
    BlockedByBlockaid            = 226, // Interaction from a non-party character was blocked by /blockaid.
    Sell                         = 232, // You sell <item>.
    SellToShop                   = 233, // You sell <item> to the shop.
    LevelSyncWarning             = 235, // Warning! This is a Level Sync party ...
    CannotInviteLevelSync        = 236, // You cannot invite that person at this time. This player is either undergoing Level Sync...
    CannotJoinLevelSync          = 237, // You cannot join this party.  You are either undergoing Level Sync...
    LevelSyncSet                 = 238, // The party's level has been restricted to <level>.
    Compass                      = 239, // The compass reads: ...
    CannotHere                   = 256, // You cannot use that command in this area.
    HeadgearShow                 = 260,
    HeadgearHide                 = 261,
    MonstrosityCheckOut          = 263, // This monster is currently possessed by <player>!
    MonstrosityCheckIn           = 264, // <player> stares at you intently, evidently aware that you have discovered its true form.
    TrustCannotJoinParty         = 265, // You are unable to join a party whose leader currently has an alter ego present.
    TrustCannotJoinAlliance      = 266, // You are unable to join an alliance whose leader currently has an alter ego present.
    StyleLockOn                  = 267, // Style lock mode enabled.
    StyleLockOff                 = 268, // Style lock mode disabled.
    StyleLockIsOn                = 269, // Style lock mode is enabled.
    StyleLockIsOff               = 270, // Style lock mode is disabled.
    UnityChatFull                = 287, // The maximum number of people are already participating in Unity chat. Please try again later.
    PollProposalLinkshell2       = 289, // Player Name's proposal to the linkshell group (cast vote with command: "/vote ?"):
    CurrentPollResultsLinkshell2 = 290, // Player Name's proposal - Current poll results:
    FinalPollResultsLinkshell2   = 291, // Player Name's proposal - Final poll results:
    TrustCannotLFP               = 296, // You cannot use Trust magic while seeking a party.
    WaitParty                    = 297, // While inviting a party member, you must wait a while before using Trust magic.
    TrustMaximumNumber           = 298, // You have called forth your maximum number of alter egos.
    TrustAlreadyCalled           = 299, // That alter ego has already been called forth.
    TrustEnmity                  = 300, // You cannot use Trust magic while having gained enmity.
    TrustSoloOrLeader            = 301, // You cannot use Trust magic unless you are solo or the party leader.
    AnErrorHasOccured            = 308, // An error has occurred.
    LevelSyncActivated           = 540, // Level Sync activated. Your level has been restricted to <Level>. Equipment effected by the level restriction will be adjusted accordingly. Experience...
    LevelSyncDesigneeBelowMin    = 541, // Level Sync could not be activated. The designated player is below level 10.
    LevelSyncDesigneeInOtherArea = 542, // Level Sync could not be activated. The designated player is in a different area.
    LevelSyncPreventedByStatus   = 543, // Level Sync could not be activated. One or more party members are currently under the effect of a status which prevents synchronization.
    LevelSyncWillBeRemoved       = 544, // Level synchronization will be removed in x seconds.
    LevelSyncNoExpTooFarOrUnc    = 545, // No experience points gained... The Level Sync designee is either too far from the enemy, or unconcious.
    LevelSyncIneligibleForExp    = 548, // The party member you selected is incapable of receiving experience points, and as such cannot be a Level Sync designee.
    LevelSyncNoExpIneligible     = 549, // No experience points gained... The Level Sync designee is incapable of receiving experience points.
    LevelSyncDeactivateForStatus = 550, // Level sync will be deactivated in 30 seconds. One or more party members have received the effect of a status which prevents synchronization.
    LevelSyncDeactivateLeftArea  = 551, // Level sync will be deactivated in 30 seconds. The party leader or the Level Sync designee has left the area.
    LevelSyncRemoveTooFewMembers = 552, // Level sync will be deactivated in 30 seconds. Less than two party members fulfill the requirements for Level Sync.
    LevelSyncRemoveLeftParty     = 553, // Level sync will be deactivated in 30 seconds. The party leader has removed synchronization, or the Level Sync designee has left the party.
    LevelSyncRemoveLowLevel      = 554, // Level sync will be deactivated in 30 seconds. The Level Sync designee has fallen below level 10.
    LevelSyncRemoveJobChange     = 555, // Level sync will be deactivated in 30 seconds. A party member has undergone a job change.
    LevelSyncRemoveIneligibleExp = 556, // Level sync will be deactivated in 30 seconds. The Level Sync designee is incapable of receiving experience points.
    TreasureHunterProc           = 603, // Additional effect: Treasure Hunter effectiveness against <Target> increases to <number>
};

class CCharEntity;

class CMessageStandardPacket : public CBasicPacket
{
public:
    // Debug version of CMessageStandardPacket, it is preferred to use the type-safe versions below
    CMessageStandardPacket(uint16 MessageID);

    CMessageStandardPacket(MsgStd MessageID);
    CMessageStandardPacket(uint32 param0, uint16 MessageID);
    CMessageStandardPacket(uint32 param0, uint32 param1, uint16 MessageID);
    CMessageStandardPacket(CCharEntity* PChar, uint32 param0, MsgStd MessageID);
    CMessageStandardPacket(CCharEntity* PChar, uint32 param0, uint32 param1, MsgStd MessageID);
    CMessageStandardPacket(uint32 param0, uint32 param1, uint32 param2, uint32 param3, MsgStd MessageID);
};

#endif
