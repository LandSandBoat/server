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

#include "0x04b_fragments.h"

#include "entities/charentity.h"
#include "enums/chat_message_type.h"
#include "fishingcontest.h"
#include "lua/luautils.h"
#include "packets/char_sync.h"
#include "packets/fish_ranking.h"
#include "packets/s2c/0x017_chat_std.h"
#include "packets/server_message.h"

auto GP_CLI_COMMAND_FRAGMENTS::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    // TODO: Document field values and validate.
    return PacketValidator();
}

void GP_CLI_COMMAND_FRAGMENTS::process(MapSession* PSession, CCharEntity* PChar) const
{
    // TODO: Verify all of this
    uint8       msgChunk    = Command; // The current chunk of the message to send (1 = start, 2 = rest of message)
    const uint8 msgType     = value1;  // 1 = Server message, 2 = Fishing Rank
    uint8       msgLanguage = value2;  // Language request id (2 = English, 4 = French)

    if (msgType == 1) // Standard Server Message
    {
        std::string loginMessage = luautils::GetServerMessage(msgLanguage);

        PChar->pushPacket<CServerMessagePacket>(loginMessage, msgLanguage, timestamp, offset);
        PChar->pushPacket<CCharSyncPacket>(PChar);

        // TODO: kill player til theyre dead and bsod
        const auto rset = db::preparedStmt("SELECT version_mismatch FROM accounts_sessions WHERE charid = (?)", PChar->id);
        if (rset && rset->rowsCount() > 0 && rset->next())
        {
            if (rset->get<bool>("version_mismatch"))
            {
                PChar->pushPacket<GP_SERV_COMMAND_CHAT_STD>(PChar, CHAT_MESSAGE_TYPE::MESSAGE_SYSTEM_1, "Server does not support this client version.");
            }
        }
    }
    else if (msgType == 2) // Fish Ranking Packet
    {
        // The Message Chunk acts as a "sub-type" for the request
        // 1 = First packet of ranking table
        // 2 = Subsequent packet of ranking table
        // 10 = ???
        // 11 = ??? Prepare to withdraw?
        // 12 = Response to a fish submission (No ranking or score - both 0) - Before ranking
        // 13 = Fish Rank Self, including the score and rank (???) following fish submission (How is it ranked??)

        // Create a holding vector for entries to be transmitted
        std::vector<FishingContestEntry> entries;

        const int   maxFakes     = settings::get<int>("main.MAX_FAKE_ENTRIES");
        const uint8 realEntries  = fishingcontest::FishingRankEntryCount();
        const uint8 fakeEntries  = realEntries >= maxFakes ? 0 : maxFakes - realEntries;
        uint8       totalEntries = realEntries + fakeEntries;
        uint8       entryVal     = 0;
        const uint8 blockSize    = sizeof(FishingContestEntry); // Should be 36

        FishingContestEntry selfEntry = {};

        // Every packet has 6 blocks in it.  The first is always the "self" block of the requesting player
        // The next five blocks are the next entries in the leaderboard
        // Add the "Self" block for 0x1C - Either player data, or empty, depending on the chunk
        if (msgChunk != 2)
        {
            // Client requesting the fish ranking menu header - All empty timestamps
            // In either case, we need the "Fish Rank Self" block
            const FishingContestEntry* PEntry = fishingcontest::GetPlayerEntry(PChar);

            // For any chunk, we include at least the char name and the total number of entries
            std::strncpy(selfEntry.name, PChar->name.c_str(), PChar->name.size());
            selfEntry.resultCount = totalEntries;

            if (PEntry != nullptr)
            {
                selfEntry.mjob        = PEntry->mjob;
                selfEntry.sjob        = PEntry->sjob;
                selfEntry.mlvl        = PEntry->mlvl;
                selfEntry.slvl        = PEntry->slvl;
                selfEntry.race        = PEntry->race;
                selfEntry.allegiance  = PEntry->allegiance;
                selfEntry.fishRank    = PEntry->fishRank;
                selfEntry.score       = PEntry->score;
                selfEntry.submitTime  = PEntry->submitTime;
                selfEntry.contestRank = PEntry->contestRank;
                selfEntry.share       = PEntry->share;
                selfEntry.dataset_b   = PEntry->dataset_b;
            }
            else // Builds header entry if the player has no submission
            {
                selfEntry.mjob       = static_cast<uint8>(PChar->GetMJob());
                selfEntry.sjob       = static_cast<uint8>(PChar->GetSJob());
                selfEntry.mlvl       = PChar->GetMLevel();
                selfEntry.slvl       = PChar->GetSLevel();
                selfEntry.race       = PChar->mainlook.race;
                selfEntry.allegiance = static_cast<uint8>(PChar->allegiance);
                selfEntry.fishRank   = PChar->RealSkills.rank[SKILLTYPE::SKILL_FISHING];
                selfEntry.submitTime = earth_time::vanadiel_timestamp();
            }
        }

        entries.push_back(selfEntry); // Adds empty entry if this isn't the first packet

        // Add the next five blocks until we are out of entries
        if (msgChunk == 1 || msgChunk == 2)
        {
            while (entries.size() <= (data_size / blockSize))
            {
                // Create a copy of the ranking entry and hold it in the local entry vector
                // This vector is cleared once the packets are sent
                const uint8          position    = offset / blockSize + entryVal++;
                FishingContestEntry* packetEntry = fishingcontest::GetFishRankEntry(position);
                if (packetEntry != nullptr)
                {
                    packetEntry->resultCount = totalEntries;
                    entries.push_back(*packetEntry);
                }
                else
                {
                    entries.emplace_back(FishingContestEntry{}); // Safety if there is no pointer but we need to fill the vector
                }
            }
        }

        PChar->pushPacket<CFishRankingPacket>(entries, msgLanguage, timestamp, offset, totalEntries, msgChunk);
        entries.clear();
    }
}
