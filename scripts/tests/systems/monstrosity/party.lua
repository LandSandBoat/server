local helpers = require('scripts.tests.systems.monstrosity.helpers')

-- JP wiki: a Monipulator cannot party. MONSTROSITY_PARTIES allows parties of Monipulators only.
describe('Monstrosity parties', function()
    local function spawnAdventurer()
        return xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, job = xi.job.WAR, level = 10 })
    end

    local function invite(leader, member)
        leader.actions:inviteToParty(member)
        member.actions:acceptPartyInvite()
    end

    it('refuses any party for a Monipulator by default', function()
        xi.test.world:setSetting('main.MONSTROSITY_PARTIES', 0)
        local first  = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
        local second = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)

        invite(first, second)

        assert(second:getPartySize() == 1, 'two Monipulators formed a party')
    end)

    it('allows a party of Monipulators under the setting', function()
        xi.test.world:setSetting('main.MONSTROSITY_PARTIES', 1)
        local first  = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
        local second = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)

        invite(first, second)

        assert(second:getPartySize() == 2, string.format('party size is %d', second:getPartySize()))
    end)

    it('never mixes Monipulators and adventurers', function()
        xi.test.world:setSetting('main.MONSTROSITY_PARTIES', 1)
        local monipulator = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
        local adventurer  = spawnAdventurer()

        invite(adventurer, monipulator)
        assert(monipulator:getPartySize() == 1, 'an adventurer invited a Monipulator')

        invite(monipulator, adventurer)
        assert(adventurer:getPartySize() == 1, 'a Monipulator invited an adventurer')
    end)

    it('drops a player who leaves MON from a party of Monipulators', function()
        xi.test.world:setSetting('main.MONSTROSITY_PARTIES', 1)
        local first  = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
        local second = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
        invite(first, second)
        assert(second:getPartySize() == 2, 'precondition: the Monipulators did not party')

        second:changeJob(xi.job.WAR)

        assert(first:getPartySize() == 1, 'an adventurer stayed in a party of Monipulators')
    end)

    -- The party is rebuilt on zone-in, after the Feretory has already changed the job.
    it('leaves the party on walking into the Feretory', function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        local leader = spawnAdventurer()
        local member = spawnAdventurer()
        invite(leader, member)

        member:gotoZone(xi.zone.FERETORY)
        xi.test.world:tickEntity(member)
        xi.test.world:skipTime(1)
        xi.test.world:tickEntity(member)

        assert(member:getMainJob() == xi.job.MON, 'precondition: the Feretory did not change the job')
        assert(member:getPartySize() == 1, 'kept the party after walking into the Feretory')
    end)

    it('leaves the party on becoming a Monipulator', function()
        local leader = spawnAdventurer()
        local member = spawnAdventurer()
        invite(leader, member)
        assert(member:getPartySize() == 2, 'precondition: the adventurers did not party')

        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        member:changeJob(xi.job.MON)

        assert(member:getPartySize() == 1, 'kept the party as a Monipulator')
        assert(leader:getPartySize() == 1, 'the leader still counts the Monipulator')
    end)
end)
