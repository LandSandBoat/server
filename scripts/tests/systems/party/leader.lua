describe('Party leader zoning', function()
    ---@type CClientEntityPair
    local leader
    ---@type CClientEntityPair
    local member

    before_each(function()
        leader = xi.test.world:spawnPlayer({ zone = xi.zone.GM_HOME })
        member = xi.test.world:spawnPlayer({ zone = xi.zone.GM_HOME })
        member:setPos(leader:getXPos(), leader:getYPos(), leader:getZPos())

        leader.actions:inviteToParty(member)
        member.actions:acceptPartyInvite()
        assert(member:getPartySize() == 2, 'party was not formed')
    end)

    it('does not expose the old leader entity after the leader zones', function()
        leader:gotoZone(xi.zone.NORTHERN_SAN_DORIA)

        local partyLeader = member:getPartyLeader()
        assert(not partyLeader or partyLeader:getID() == leader:getID(), 'stale party leader')
        assert(member:getPartySize() >= 1, 'party lost its remaining member')
    end)
end)
