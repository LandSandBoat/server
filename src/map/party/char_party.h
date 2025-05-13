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
#include "common/ipc.h"
#include "common/party/base.h"

class CCharEntity;
class CBattleEntity;
enum class PartyFlag : uint16;

// This is a read-only view of a party of CCharEntity (and CTrustEntity) members.
// Updates are only permitted through the IPC interface
// Keep in mind that several map processes _may_ be performing similar operations.
// Therefore, operations should be strictly limited to players on this process.
// Nevertheless, the underlying data has knowledge of all members across all processes and can be used to make decisions.
class CCharParty : public PartyBase
{
public:
    DISALLOW_COPY_AND_MOVE(CCharParty);

    static std::unique_ptr<CCharParty> Create(const PartyFullUpdateMessage& message)
    {
        return std::unique_ptr<CCharParty>(new CCharParty(message));
    }

    static std::unique_ptr<CCharParty> Create(const uint32 leaderId)
    {
        return std::unique_ptr<CCharParty>(new CCharParty(leaderId));
    }

    ~CCharParty();
    void refreshSync(CCharEntity* PChar) const;
    void refreshSync() const;

    // Helpers
    bool hasJob(uint8 job, std::optional<uint16> zoneId = std::nullopt) const;
    bool isAllianced(CCharParty& other) const;
    bool isPartOfAlliance() const;
    auto getMemberCountOnSelf() const -> size_t;

    // Packets
    void broadcastPartyPackets(const CCharEntity* PSingle = nullptr);
    void chatMessage(const ipc::ChatMessageParty& message) const;
    void chatMessage(const ipc::ChatMessageAlliance& message) const;

    void pushPacket(uint32 senderID, uint16 ZoneID, const std::unique_ptr<CBasicPacket>& packet) const;
    void pushEffectsPacket(CCharEntity* PChar) const;

    // Members retrieval
    auto getMembers(PartyMemberFilter filter = {}) const -> std::vector<CBattleEntity*>;
    auto getPlayers(PartyMemberFilter filter = {}) const -> std::vector<CCharEntity*>;
    auto getLeader() const -> CCharEntity*;
    auto getSyncTarget() const -> CCharEntity*;
    auto getQuartermaster() const -> CCharEntity*;
    auto getMemberByName(const std::string& memberName) const -> CCharEntity*;
    auto getMemberById(uint32 charId) const -> CCharEntity*;

    // Iterators
    void ForEveryMember(const std::function<void(CCharEntity*)>& func) const;
    void ForEveryMemberWithTrusts(const std::function<void(CBattleEntity*)>& func) const;
    void ForEveryAllianceMember(std::function<void(CCharEntity*)> func);

    // IPC driven updates
    void setLeader(uint32 UniqueNo) const;
    void setLeader(const std::string& charName) const;
    void setSyncTarget(const std::string& charName) const;
    void setSyncTarget(uint32 UniqueNo) const;
    void clearSyncTarget(MsgStd Reason) const;
    void setQuartermaster(uint32 UniqueNo) const;
    void setQuartermaster(const std::string& charName) const;
    void addMember(uint32 UniqueNo, PartyMemberType Type) const;
    void removeMember(uint32 UniqueNo) const;
    void removeMember(const std::string& charName) const;
    void disband() const;

private:
    CCharParty(uint32 leaderId);
    CCharParty(const PartyFullUpdateMessage& message);

    void setPartyId(uint32 partyId);

    void applySync(CCharEntity* PChar) const;
    void disableSync(const CCharEntity* PChar) const;

    void update(const PartyFullUpdateMessage& message);
    void addMember(const PartyMember& member);
    void delMember(const PartyMember& member);

    // Allow only PartyContainer to call update() to enforce the read-only nature
    friend class PartyContainer;
};
