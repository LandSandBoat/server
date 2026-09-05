describe('Alliance formation', function()
    ---@type CClientEntityPair
    local a
    ---@type CClientEntityPair
    local b
    ---@type CClientEntityPair
    local c
    ---@type CClientEntityPair
    local d

    local function spawnNear(anchor)
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        if anchor then
            player:setPos(anchor:getXPos(), anchor:getYPos(), anchor:getZPos())
        end

        return player
    end

    local function formParty(leader, member)
        leader.actions:inviteToParty(member)
        member.actions:acceptPartyInvite()

        assert(leader:getPartySize() == 2, 'party was not formed')
    end

    before_each(function()
        a = spawnNear()
        b = spawnNear(a)
        c = spawnNear(a)
        d = spawnNear(a)

        formParty(a, b)
    end)

    it('refuses a party with trusts joining an existing alliance', function()
        formParty(c, d)
        a.actions:formAlliance(c)
        c.actions:acceptPartyInvite()
        -- alliance size counts members across every party
        assert(a:getAllianceSize() == 4, 'alliance was not formed')

        local e = spawnNear(a)
        e:spawnTrust(xi.magic.spell.SHANTOTTO)
        xi.test.world:skipTime(1)

        a.actions:formAlliance(e)
        e.actions:acceptPartyInvite()

        assert(a:getAllianceSize() == 4, 'a party with trusts joined the alliance')
    end)

    it('does not turn a party invite into an alliance', function()
        a.actions:inviteToParty(c)
        formParty(c, d)

        c.actions:acceptPartyInvite()

        assert(a:getAllianceSize() == 2 and c:getAllianceSize() == 2, 'a party invite formed an alliance')
        assert(c:getPartyLeader():getID() == c:getID(), 'the invitee lost their own party')
    end)
end)
