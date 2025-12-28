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

#include "aman.h"

#include "common/database.h"
#include "entities/charentity.h"
#include "ipc_client.h"
#include "lua/luautils.h"
#include "packets/s2c/0x02a_talknumwork.h"
#include "roe.h"
#include "utils/charutils.h"
#include "utils/zoneutils.h"

namespace
{

const std::string warningCooldownVar                  = "[ASSIST][Warnings]Cooldown";
const std::string thumbsUpCooldownVar                 = "[ASSIST][ThumbsUp]Cooldown";
const std::string assistChannelInteractionEligibleVar = "[ASSIST][Evaluations]Eligible";
const std::string evaluationsDailyVar                 = "[ASSIST][Evaluations]Today";
const std::string evaluationsCountVar                 = "[ASSIST][Evaluations]Count";
const std::string assistChannelEligibleVar            = "[ASSIST]Eligible";
const std::string mutedExpiryVar                      = "[ASSIST]Muted";

const auto calculateAssistExpiry = [](CCharEntity* PChar, const uint32 playtimeExpiry) -> std::pair<uint32, uint32>
{
    // Important: The message reported by the client states the time is JST, but it appears to be converted by the client to the local timezone.
    // The origin is Jan 01, 2002 00:00 JST
    // The delta observed between the two values in the pair should be about 240 hours converted to seconds, for newly obtained access.
    constexpr std::time_t origin    = 1009810800;
    const auto            timepoint = std::chrono::system_clock::from_time_t(origin);

    // Calculate seconds since origin
    const auto now                = earth_time::now() - timepoint;
    uint32     secondsSinceOrigin = std::chrono::duration_cast<std::chrono::seconds>(now).count();

    // Now calculate the difference between the current playtime and the expiry time.
    // Final value represents the future expiry time as the number of seconds since Jan 01, 2002 00:00 JST
    const auto currentPlaytime   = static_cast<uint32>(timer::count_seconds(PChar->GetPlayTime()));
    const auto remainingPlaytime = playtimeExpiry - currentPlaytime;       // Time left until expiry
    const auto tentativeExpiry   = secondsSinceOrigin + remainingPlaytime; // Future expiry time

    return std::make_pair(tentativeExpiry, secondsSinceOrigin);
};

} // namespace

CAMANContainer::CAMANContainer(CCharEntity* PChar)
: m_player(PChar)
{
    const auto fmtQuery = "SELECT "
                          "mentor, "
                          "DATEDIFF(CURRENT_TIMESTAMP, last_logout) AS days_since_logout, "
                          "muted "
                          "FROM chars "
                          "LEFT JOIN char_flags ON chars.charid = char_flags.charid "
                          "WHERE chars.charid = ?";

    if (const auto rset = db::preparedStmt(fmtQuery, m_player->id); rset && rset->rowsCount() && rset->next())
    {
        const auto logoutDiff = rset->get<uint32>("days_since_logout");
        m_mentorUnlocked      = rset->get<uint32>("mentor") > 0;
        m_isMuted             = rset->get<bool>("muted");

        if (!settings::get<bool>("main.ASSIST_CHANNEL_ENABLED"))
        {
            return;
        }

        // If you're not in an Assist Channel zone, don't bother evaluating membership.
        if (!m_player->loc.zone || !m_player->loc.zone->CanUseMisc(MISC_ASSIST))
        {
            return;
        }

        // Compute Assist Channel eligibility now so we're not checking hundreds of people on chat messages.
        // 1. Must have completed RoE "Assist Channel" (1448).
        if (!roeutils::GetEminenceRecordCompletion(m_player, 1448))
        {
            return;
        }

        const auto currentPlaytime = static_cast<uint32>(timer::count_seconds(m_player->GetPlayTime()));
        // Case 1. Mentors are always eligible.
        if (m_player->playerConfig.MentorFlg)
        {
            m_assistChannelEligible = true;
        }
        // Case 2. You've been previously flagged as eligible.
        else if (m_assistChannelPlaytimeExpiry = m_player->getCharVar(assistChannelEligibleVar); m_assistChannelPlaytimeExpiry > 0)
        {
            if (m_assistChannelPlaytimeExpiry > static_cast<uint32>(timer::count_seconds(m_player->GetPlayTime())))
            {
                m_assistChannelEligible = true;
            }
            else
            {
                // You're no longer eligible!
                m_player->setCharVar(assistChannelEligibleVar, 0);
                m_notifyExpired = true;
            }
        }
        // Case 3. You haven't logged in since more than 48 days.
        else if (logoutDiff >= settings::get<uint16_t>("main.ASSIST_CHANNEL_RETURNEE_LOGIN_GAP"))
        {
            // 240 playtime hours until access expires
            m_assistChannelPlaytimeExpiry = currentPlaytime + settings::get<uint16_t>("main.ASSIST_CHANNEL_MEMBERSHIP_LENGTH") * 3600;

            m_player->setCharVar(assistChannelEligibleVar, m_assistChannelPlaytimeExpiry);
            m_assistChannelEligible = true;
        }
        // Case 4. You have less than 240 playtime hours. Used to flag new characters.
        else if (currentPlaytime <= settings::get<uint32>("main.ASSIST_CHANNEL_MEMBERSHIP_LENGTH") * 3600)
        {
            // 240 playtime hours until access expires
            m_assistChannelPlaytimeExpiry = settings::get<uint16>("main.ASSIST_CHANNEL_MEMBERSHIP_LENGTH") * 3600;

            m_player->setCharVar(assistChannelEligibleVar, m_assistChannelPlaytimeExpiry);
            m_assistChannelEligible = true;
        }

        if (m_assistChannelEligible)
        {
            if (m_isMuted && m_player->getCharVar(mutedExpiryVar) == 0)
            {
                // Mute auto-expired.
                db::preparedStmt("UPDATE char_flags SET muted = false WHERE charid = ?", m_player->id);
                m_isMuted = false;
            }
        }
    }
}

auto CAMANContainer::isAssistChannelEligible() const -> bool
{
    if (!settings::get<bool>("main.ASSIST_CHANNEL_ENABLED"))
    {
        return false;
    }

    if (!m_player->loc.zone->CanUseMisc(MISC_ASSIST))
    {
        return false;
    }

    return m_assistChannelEligible;
}

void CAMANContainer::onZoneIn() const
{
    if (m_notifyExpired)
    {
        m_player->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::AssistChannelExpired);
        return;
    }

    // Message only shown in Assist zones if you're eligible and have some expiry set.
    if (!isAssistChannelEligible() || !m_assistChannelPlaytimeExpiry)
    {
        return;
    }

    if (auto textId = luautils::GetTextIDVariable(m_player->getZone(), "ASSIST_CHANNEL"))
    {
        auto [expiry, current] = calculateAssistExpiry(m_player, m_assistChannelPlaytimeExpiry);
        m_player->pushPacket<GP_SERV_COMMAND_TALKNUMWORK>(m_player, textId, expiry, current, 1, 0, false);

        // TODO: Capture the exact threshold
        if (const auto remaining = expiry - current; remaining < 24 * 3600)
        {
            // TODO: Capture if this shows before or after the Assist Channel message.
            m_player->pushPacket<GP_SERV_COMMAND_MESSAGE>(remaining / 60 / 60, MsgStd::AssistChannelExpiring);
        }
    }
    else
    {
        ShowWarningFmt("Zone {} does not have an ASSIST_CHANNEL text ID set", m_player->getZone());
    }
}

auto CAMANContainer::getMentorRank() const -> uint8_t
{
    // All Mentors start with the Bronze flag. (1)
    // 50 "Thumbs Up" evaluations reward the Silver flag. (2)
    // 50 additional "Thumbs Up" evaluations reward the Gold flag. (3)

    return std::clamp((m_player->getCharVar(evaluationsCountVar) / 50) + 1, 1, 3);
}

auto CAMANContainer::hasMentorUnlocked() const -> bool
{
    return m_mentorUnlocked;
}

void CAMANContainer::setMentorUnlocked(bool val)
{
    m_mentorUnlocked = val;
    db::preparedStmt("UPDATE chars "
                     "SET mentor = ? "
                     "WHERE charid = ?",
                     val,
                     m_player->id);
}

auto CAMANContainer::isMentor() const -> bool
{
    return m_player->playerConfig.MentorFlg;
}

auto CAMANContainer::getMasteryRank() const -> uint8_t
{
    // Not implemented.
    // 1-8, 6+ grants the ability to mute and unmute players.
    // Officially confirmed factors:
    // - Number of days played
    // - Mission progression level
    // - Number of completed quests
    // - Combat Skills / Magic Skills
    // - Synthesis Skill / Fishing Skill
    // - Number of Trusts
    // - Battle Contents. Ex: Dynamis, Nyzul, MMM, Skirmish, Omen, and numerous others.
    // - Non-Battle Contents. Ex: Chocobo Racing, Mog Garden, Home Points, and numerous others

    return 1;
}

auto CAMANContainer::isInteractionEligible() const -> bool
{
    return m_player->getCharVar(assistChannelInteractionEligibleVar) == 1;
}

void CAMANContainer::recordLastMessage() const
{
    // Expire the variable in 10 minutes.
    m_player->setCharVar(assistChannelInteractionEligibleVar, 1, earth_time::timestamp() + 600);
}

auto CAMANContainer::canIssueWarning() const -> bool
{
    return m_player->getCharVar(warningCooldownVar) == 0;
}

auto CAMANContainer::canThumbsUp() const -> bool
{
    return m_player->getCharVar(thumbsUpCooldownVar) == 0;
}

// TODO: Validate the following:
// - Does sender receive a specific message if current char is over cap
// - Is receiver notified if receiving a Thumbs Up when over cap
void CAMANContainer::addThumbsUp(const uint32 senderId) const
{
    // Can only issue a thumbs up within 10 minutes of the last message.
    // Only Mentors can receive Thumbs Up.
    if (!isInteractionEligible() || !hasMentorUnlocked())
    {
        message::send(ipc::MessageStandard{
            .recipientId = senderId,
            .message     = MsgStd::AnErrorHasOccured,
        });
        return;
    }

    recordEvaluation(1);

    // Add cooldown to whoever gave the Thumbs Up and notify them.
    charutils::SetCharVar(senderId, thumbsUpCooldownVar, 1, luautils::JstMidnight());
    message::send(ipc::MessageStandard{
        .recipientId = senderId,
        .message     = MsgStd::GivenThumbsUp,
        .string2     = m_player->getName(),
    });
}

// TODO: Verify the following
// - Can mentors be muted?
// - Can they unmute themselves?
void CAMANContainer::mute(const uint32 senderId)
{
    // Can only issue a mute within 10 minutes of the last message.
    if (!isInteractionEligible())
    {
        message::send(ipc::MessageStandard{
            .recipientId = senderId,
            .message     = MsgStd::AnErrorHasOccured,
        });
        return;
    }

    if (isMuted())
    {
        message::send(ipc::MessageStandard{
            .recipientId = senderId,
            .message     = MsgStd::AlreadyMuted,
        });
        return;
    }

    // Mute player for 24 hours.
    m_isMuted = true;
    db::preparedStmt("UPDATE char_flags SET muted = true WHERE charid = ?", m_player->id);
    m_player->setCharVar(mutedExpiryVar, 1, earth_time::timestamp() + (24 * 60 * 60));
    ShowInfoFmt("{} was muted by player ID {}", m_player->getName(), senderId);
    // TODO: MsgStd::AddedToMuteList is sent to all players in assist.
}

void CAMANContainer::unmute(const uint32 senderId)
{
    if (!isMuted())
    {
        message::send(ipc::MessageStandard{
            .recipientId = senderId,
            .message     = MsgStd::AnErrorHasOccured,
        });
        return;
    }

    m_isMuted = false;
    db::preparedStmt("UPDATE char_flags SET muted = false WHERE charid = ?", m_player->id);
    m_player->setCharVar(mutedExpiryVar, 0);
    ShowInfoFmt("{} was unmuted by player ID {}", m_player->getName(), senderId);
    // TODO: MsgStd::RemovedFromMuteList is sent to all players in assist.
}

auto CAMANContainer::isMuted() const -> bool
{
    return m_isMuted;
}

void CAMANContainer::addThumbsDown(const uint32 senderId) const
{
    // Can only issue a warning within 10 minutes of the last message.
    // Only Mentors can receive warnings.
    if (!isInteractionEligible() || !hasMentorUnlocked())
    {
        message::send(ipc::MessageStandard{
            .recipientId = senderId,
            .message     = MsgStd::AnErrorHasOccured,
        });
        return;
    }

    recordEvaluation(-1);

    // Add cooldown to whoever issued the warning and notify them.
    charutils::SetCharVar(senderId, warningCooldownVar, 1, luautils::JstMidnight());
    message::send(ipc::MessageStandard{
        .recipientId = senderId,
        .message     = MsgStd::GivenWarning,
        .string2     = m_player->getName(),
    });
}

void CAMANContainer::recordEvaluation(const int8 val) const
{
    if (m_player->getCharVar(evaluationsDailyVar) >= 3)
    {
        // Can only receive 3 Evaluations per day.
        return;
    }

    // Track number of evaluations received today. Limited to 3 per day.
    // Done this way to ensure we're not setting the var to a high value after a JP midnight, in between zones.
    m_player->setCharVar(evaluationsDailyVar, m_player->getCharVar(evaluationsDailyVar) + 1, luautils::JstMidnight());

    // Add or substract to their tally.
    charutils::IncrementCharVar(m_player, evaluationsCountVar, val);

    // Notify the player of the evaluation.
    m_player->pushPacket<GP_SERV_COMMAND_MESSAGE>(val < 0 ? MsgStd::ReceivedWarning : MsgStd::ReceivedThumbsUp);
}
