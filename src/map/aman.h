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

#include "common/cbasetypes.h"

class CCharEntity;
class CAMANContainer
{
public:
    CAMANContainer(CCharEntity* PChar);

    auto isAssistChannelEligible() const -> bool; // Can the player participate in the Assist Channel?
    auto onZoneIn() const -> void;                // Displays the Assist Channel eligibility message when the player zones in.
    auto isInteractionEligible() const -> bool;   // Can the player messages be interacted with?
    void recordLastMessage() const;               // Sets a charvar indicating the player message can be interacted with, for 10 minutes.

    auto getMentorRank() const -> uint8_t;  // Returns the Mentor rank of the player based on Thumbs Up evaluations.
    auto hasMentorUnlocked() const -> bool; // Has the Mentor role been unlocked for the player?
    void setMentorUnlocked(bool val);       // Sets the Mentor role as (un)locked for the player.
    auto isMentor() const -> bool;          // Is the player currently assuming the Mentor role?

    auto getMasteryRank() const -> uint8_t; // (Unimplemented) Returns the Mastery Rank of the player.

    auto canIssueWarning() const -> bool; // Can the player issue a warning to another player?
    auto canThumbsUp() const -> bool;     // Can the player give a Thumbs Up to a Mentor?
    auto isMuted() const -> bool;         // Is the player currently muted?

    // World -> Map
    // Player is receiving a moderation operation from another player.
    // Originating player may not be on same process.
    void mute(uint32 senderId);                // Mute the player, preventing them from sending messages.
    void unmute(uint32 senderId);              // Unmute the player, allowing them to send messages again.
    void addThumbsDown(uint32 senderId) const; // Send a warning message to the player.
    void recordEvaluation(int8 val) const;     // Record an evaluation of the player, such as a Thumbs Up or Thumbs Down.
    void addThumbsUp(uint32 senderId) const;   // Player is receiving a Thumbs Up!

private:
    bool         m_mentorUnlocked{ false };
    bool         m_isMuted{ false };
    bool         m_assistChannelEligible{ false };
    uint32_t     m_assistChannelPlaytimeExpiry{ 0 };
    bool         m_notifyExpired{ false };
    CCharEntity* m_player;
};
