-----------------------------------
-- Battlefield entry isolation
--
-- Players from different parties ended up inside the same Monarch Linn arena when the
-- entry NPC was spammed. Two paths led there:
--  1. The server picked the arena from its own count of declined requests instead of the
--     arena in the request, and that count survived a menu that granted no arena, so the
--     next attempt registered area N+1 while the client was still asking for arena 1.
--  2. A registration left behind by an earlier party outlived the clearance (Battlefield
--     effect) and was matched again when the player returned with a new party.
--
-- Clearance itself is meant to survive zoning out and back while the fight is still open.
-----------------------------------
---@diagnostic disable: inject-field
local ffi = require('ffi')

ffi.cdef [[
    typedef struct {
        uint16_t id : 9;
        uint16_t size : 7;
        uint16_t sync;
    } BF_TEST_CLI_HEADER;

    // 0x05C - event update carrying the position the client wants to move to
    typedef struct {
        BF_TEST_CLI_HEADER header;
        float    x;
        float    y;
        float    z;
        uint32_t UniqueNo;
        uint32_t EndPara;
        uint16_t EventNum;
        uint16_t EventPara;
        uint16_t ActIndex;
        uint8_t  Mode;
        int8_t   dir;
    } BF_TEST_EVENTENDXZY;

    // 0x06F - leave party
    typedef struct {
        BF_TEST_CLI_HEADER header;
        uint8_t Kind;
        uint8_t padding[3];
    } BF_TEST_GROUP_LEAVE;
]]

local entryEventId = 32000
local entryNpc     = 'SD_Entrance'

-- The client asks for each arena in turn with (menu index << 4) + arena
local function arenaOption(arena)
    local content = xi.battlefield.contents[xi.battlefield.id.ANCIENT_VOWS]

    return bit.lshift(content.index, 4) + arena
end

-- Only used to tell the emulated client's arena requests apart
local arenaX = { -600, 0, 600, 0 }

local function spawnCandidate()
    local player = xi.test.world:spawnPlayer({ zone = xi.zone.MONARCH_LINN })
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.ANCIENT_VOWS)
    player:setCharVar('Mission[6][248]Status', 2)

    return player
end

-- Emulates the client asking for one arena. Returns the reply code the server put in the
-- event work parameters (0 when it sent none) and whether it moved the player there.
local function requestArena(player, arena)
    player.packets:clear()

    local p     = ffi.new('BF_TEST_EVENTENDXZY')
    p.x         = arenaX[arena]
    p.y         = 0
    p.z         = 0
    p.UniqueNo  = player:getID()
    p.EndPara   = arenaOption(arena)
    p.EventNum  = 0
    p.EventPara = entryEventId
    p.ActIndex  = player:getTargID()
    p.Mode      = 1
    p.dir       = 0
    player.packets:send(0x05C, p, ffi.sizeof(p))

    local reply = 0
    local moved = false

    for _, packet in pairs(player.packets:getIncoming()) do
        if packet.type == 0x05C then
            reply = packet.data[4] + packet.data[5] * 256
        elseif packet.type == 0x05B then
            moved = true
        end
    end

    return reply, moved
end

-- Walks the arenas the way the client's entry event does: on to the next arena on WAIT or
-- silence, stop on a message code, and never the restart code. Returns the granted arena.
local function requestArenas(player)
    local arena = 1

    while arena <= 3 do
        local reply, moved = requestArena(player, arena)

        if reply == xi.battlefield.returnCode.CUTSCENE then
            assert(moved, string.format('granted arena %d but the client was not moved there', arena))

            return arena
        end

        assert(not moved, string.format('client was moved into arena %d without being granted it', arena))
        assert(reply ~= xi.battlefield.returnCode.INCREMENT_REQUEST, 'the restart code must never reach the client')

        if reply ~= xi.battlefield.returnCode.WAIT and reply ~= 0 then
            return nil
        end

        arena = arena + 1
    end

    return nil
end

-- A mob with anyone on its hate list locks the battlefield on the next handler pass
local function lockBattlefield(player)
    local battlefield = player:getBattlefield()
    local mobs        = battlefield:getMobs(true, true)
    mobs[1]:updateEnmity(player)
    xi.test.world:tick()
    assert(battlefield:getStatus() == xi.battlefield.status.LOCKED, 'battlefield did not lock')
end

local function leaveParty(player)
    local p = ffi.new('BF_TEST_GROUP_LEAVE')
    p.Kind  = 0
    player.packets:send(0x06F, p, ffi.sizeof(p))
end

-- An empty battlefield is destroyed on the handler pass after a 10 second grace
local function settleBattlefields()
    for _ = 1, 3 do
        xi.test.world:skipTime(11)
        xi.test.world:tick()
    end
end

local function leaveBattlefields(players)
    for _, player in ipairs(players) do
        if player:getBattlefield() then
            player:leaveBattlefield(xi.battlefield.leaveCode.EXIT)
        end
    end

    settleBattlefields()
end

describe('Battlefield entry', function()
    local players

    before_each(function()
        players = {}
    end)

    after_each(function()
        leaveBattlefields(players)
    end)

    it('sends the player to the arena the server registered after a menu that granted no arena', function()
        local occupant = spawnCandidate()
        table.insert(players, occupant)
        occupant.bcnm:enter(entryNpc, xi.battlefield.id.ANCIENT_VOWS)

        local player = spawnCandidate()
        table.insert(players, player)

        -- Arena 1 is taken, the client is told to try the next one, and the menu closes without an entry
        player.entities:gotoAndTrigger(entryNpc)
        local reply, moved = requestArena(player, 1)
        assert(reply == xi.battlefield.returnCode.WAIT and not moved, 'an occupied arena should answer WAIT')
        player.events:finish(entryEventId, 0)
        assert(not player:hasStatusEffect(xi.effect.BATTLEFIELD), 'a declined request must not leave clearance behind')

        -- Whichever arena the client is granted now must be the one the battlefield lives in
        player.entities:gotoAndTrigger(entryNpc)
        local granted = requestArenas(player)
        player.events:finish(entryEventId, 0)

        local battlefield = player:getBattlefield()
        assert(battlefield, 'player did not enter a battlefield')
        assert(granted == battlefield:getArea(),
            string.format('client was granted arena %s but the battlefield is in area %d', tostring(granted), battlefield:getArea()))
    end)

    it('refuses an arena the zone does not have', function()
        local player = spawnCandidate()
        table.insert(players, player)

        player.entities:gotoAndTrigger(entryNpc)
        local reply, moved = requestArena(player, 4)
        player.events:finish(entryEventId, 0)

        assert(reply == xi.battlefield.returnCode.REQS_NOT_MET and not moved, 'a fourth arena must be refused')
        assert(not player:getBattlefield() and not player:hasStatusEffect(xi.effect.BATTLEFIELD), 'no battlefield may be created for it')
    end)

    it('hands clearance back to a member who zones out and back while the fight is open', function()
        local leader = spawnCandidate()
        local member = spawnCandidate()
        table.insert(players, leader)
        table.insert(players, member)

        leader.actions:inviteToParty(member)
        member.actions:acceptPartyInvite()
        leader.bcnm:enter(entryNpc, xi.battlefield.id.ANCIENT_VOWS)

        member:gotoZone(xi.zone.RIVERNE_SITE_A01)
        member:gotoZone(xi.zone.MONARCH_LINN)
        assert(member:hasStatusEffect(xi.effect.BATTLEFIELD), 'clearance should return with the member')

        member.entities:gotoAndTrigger(entryNpc, { eventId = entryEventId, updates = { arenaOption(1) } })

        local battlefield = member:getBattlefield()
        assert(battlefield, 'member did not enter a battlefield')
        assert(battlefield:getInitiator() == leader:getID(), 'member should have joined the leader')
    end)

    it('does not hand clearance back once the fight is locked', function()
        local leader = spawnCandidate()
        local member = spawnCandidate()
        table.insert(players, leader)
        table.insert(players, member)

        leader.actions:inviteToParty(member)
        member.actions:acceptPartyInvite()
        leader.bcnm:enter(entryNpc, xi.battlefield.id.ANCIENT_VOWS)
        lockBattlefield(leader)

        member:gotoZone(xi.zone.RIVERNE_SITE_A01)
        member:gotoZone(xi.zone.MONARCH_LINN)
        assert(not member:hasStatusEffect(xi.effect.BATTLEFIELD), 'a locked fight must not hand clearance back')

        member.entities:gotoAndTrigger(entryNpc)
        member.events:expectNotInEvent()
        assert(not member:getBattlefield(), 'member must stay outside')
    end)

    it('answers WAIT for other arenas and LOCKED for the party arena once the fight is locked', function()
        local occupant = spawnCandidate()
        local leader   = spawnCandidate()
        local member   = spawnCandidate()
        table.insert(players, occupant)
        table.insert(players, leader)
        table.insert(players, member)

        occupant.bcnm:enter(entryNpc, xi.battlefield.id.ANCIENT_VOWS)
        leader.actions:inviteToParty(member)
        member.actions:acceptPartyInvite()
        leader.entities:gotoAndTrigger(entryNpc, { eventId = entryEventId, updates = { arenaOption(1), arenaOption(2) } })
        assert(leader:getBattlefield() and leader:getBattlefield():getArea() == 2, 'leader should hold area 2')

        -- The member opens the menu with clearance, then the fight locks under it
        member.entities:gotoAndTrigger(entryNpc)
        lockBattlefield(leader)
        assert(not member:hasStatusEffect(xi.effect.BATTLEFIELD), 'locking should drop the clearance of members outside')

        local reply = requestArena(member, 1)
        assert(reply == xi.battlefield.returnCode.WAIT, 'an arena that is not the party arena should answer WAIT')
        reply = requestArena(member, 2)
        assert(reply == xi.battlefield.returnCode.LOCKED, 'the party arena should answer LOCKED')
        member.events:finish(entryEventId, 0)

        assert(not member:getBattlefield(), 'member must stay outside')
    end)

    it('does not admit a player into the locked battlefield of a party they left', function()
        local firstLeader = spawnCandidate()
        local drifter     = spawnCandidate()
        table.insert(players, firstLeader)
        table.insert(players, drifter)

        firstLeader.actions:inviteToParty(drifter)
        drifter.actions:acceptPartyInvite()

        firstLeader.bcnm:enter(entryNpc, xi.battlefield.id.ANCIENT_VOWS)
        assert(drifter:hasStatusEffect(xi.effect.BATTLEFIELD), 'party member should have been given clearance')

        -- The fight locks before the drifter goes in, which takes their clearance, then they move to a new party
        lockBattlefield(firstLeader)
        assert(not drifter:hasStatusEffect(xi.effect.BATTLEFIELD), 'locking should drop the clearance of members outside')

        leaveParty(drifter)
        assert(drifter:getPartySize() == 1, 'drifter should have left the first party')

        local secondLeader = spawnCandidate()
        table.insert(players, secondLeader)
        secondLeader.actions:inviteToParty(drifter)
        drifter.actions:acceptPartyInvite()

        -- Arena 1 is occupied, so the second leader is granted arena 2 on the second request
        secondLeader.entities:gotoAndTrigger(entryNpc, { eventId = entryEventId, updates = { arenaOption(1), arenaOption(2) } })
        local secondBattlefield = secondLeader:getBattlefield()
        assert(secondBattlefield and secondBattlefield:getArea() == 2, 'second leader should hold area 2')

        drifter.entities:gotoAndTrigger(entryNpc, { eventId = entryEventId, updates = { arenaOption(1), arenaOption(2) } })

        local battlefield = drifter:getBattlefield()
        assert(battlefield, 'drifter did not enter a battlefield')

        local initiatorId, initiatorName = battlefield:getInitiator()
        assert(initiatorId == secondLeader:getID(),
            string.format('drifter entered the battlefield of %s instead of %s', initiatorName, secondLeader:getName()))

        -- Finishing the first party's fight must not strip the drifter's clearance in the second one
        firstLeader.bcnm:killMobs()
        firstLeader.bcnm:expectWin({ finishOption = 2 })
        settleBattlefields()

        assert(drifter:hasStatusEffect(xi.effect.BATTLEFIELD), 'drifter lost clearance when the first battlefield was cleaned up')
        assert(drifter:getBattlefield() and drifter:getBattlefield():getArea() == 2, 'drifter was removed from the second battlefield')
    end)
end)
