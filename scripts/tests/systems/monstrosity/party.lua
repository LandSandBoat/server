-----------------------------------
-- JP wiki: a Monipulator cannot party.
-----------------------------------
local helpers = require('scripts.tests.systems.monstrosity.helpers')

describe('Monstrosity parties', function()
    local function spawnAdventurer()
        return xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, job = xi.job.WAR, level = 10 })
    end

    local function invite(leader, member)
        leader.actions:inviteToParty(member)
        member.actions:acceptPartyInvite()
    end

    it('refuses a party of Monipulators', function()
        local first  = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
        local second = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)

        invite(first, second)

        assert(second:getPartySize() == 1, 'two Monipulators formed a party')
    end)

    it('never mixes Monipulators and adventurers', function()
        local monipulator = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
        local adventurer  = spawnAdventurer()

        invite(adventurer, monipulator)
        assert(monipulator:getPartySize() == 1, 'an adventurer invited a Monipulator')

        invite(monipulator, adventurer)
        assert(adventurer:getPartySize() == 1, 'a Monipulator invited an adventurer')
    end)

    -- An invite sent before the inviter became a Monipulator is still pending on the other side.
    it('refuses an invite whose sender has since become a Monipulator', function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        local inviter = spawnAdventurer()
        local invitee = spawnAdventurer()

        inviter.actions:inviteToParty(invitee)
        inviter:changeJob(xi.job.MON)
        invitee.actions:acceptPartyInvite()

        assert(invitee:getPartySize() == 1, 'joined a Monipulator through a stale invite')
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

-- FFXIclopedia: Monipulators and adventurers cannot cure or buff each other.
describe('Monstrosity assistance', function()
    local function spawnCurer(target)
        local curer = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, job = xi.job.WHM, level = 99 })
        curer:addSpell(xi.magic.spell.CURE)

        local pos = target:getPos()
        curer:setPos(pos.x, pos.y, pos.z)

        return curer
    end

    local function cure(curer, target)
        target:setHP(1)
        curer.actions:useSpell(target, xi.magic.spell.CURE)
        xi.test.world:skipTime(10)
    end

    it('stops an adventurer curing a Monipulator', function()
        local monipulator = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
        monipulator:delStatusEffect(xi.effect.GESTATION)
        helpers.engageDummy(monipulator)
        cure(spawnCurer(monipulator), monipulator)

        assert(monipulator:getHP() == 1, string.format('an adventurer cured a Monipulator to %d HP', monipulator:getHP()))
    end)

    it('lets an adventurer cure another adventurer', function()
        local target = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, job = xi.job.WAR, level = 10 })
        cure(spawnCurer(target), target)

        assert(target:getHP() > 1, 'Cure did not land on an adventurer')
    end)
end)
