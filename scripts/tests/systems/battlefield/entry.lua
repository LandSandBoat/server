-----------------------------------
-- Battlefield entry and clearance
-- Entry event options are (menu index << 4) + arena, asked one arena at a time.
-- Clearance is the Battlefield effect, which names the battlefield and arena it was granted for.
-----------------------------------
local entryEventId = 32000
local exitEventId  = 32003
local entryNpc     = 'SD_Entrance'
local exitNpc      = 'SD_BCNM_Exit_1'

-- Distinct per arena so position requests can be told apart
local arenaX = { -600, 0, 600, 0 }

local function arenaOption(arena, battlefieldId)
    local content = xi.battlefield.contents[battlefieldId or xi.battlefield.id.ANCIENT_VOWS]

    return bit.lshift(content.index, 4) + arena
end

local function spawnCandidate(params)
    params      = params or {}
    params.zone = xi.zone.MONARCH_LINN

    local player = xi.test.world:spawnPlayer(params)
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.ANCIENT_VOWS)
    player:setCharVar('Mission[6][248]Status', 2)

    return player
end

-- Returns the reply code (0 when the server sent none) and whether the player was moved
local function requestArena(player, arena, battlefieldId)
    local reply, moved = player.events:updateWithPosition(entryEventId, arenaOption(arena, battlefieldId), { x = arenaX[arena], y = 0, z = 0 })

    return reply or 0, moved
end

-- Next arena on WAIT or silence, stop on a message code. Returns the granted arena.
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

local function formParty(leader, member)
    leader.actions:inviteToParty(member)
    member.actions:acceptPartyInvite()
end

describe('Battlefield entry', function()
    local players

    before_each(function()
        players = {}
    end)

    after_each(function()
        leaveBattlefields(players)
    end)

    it('registers the initiator into the first free arena', function()
        local player = spawnCandidate()
        table.insert(players, player)

        player.entities:gotoAndTrigger(entryNpc, { eventId = entryEventId, updates = { arenaOption(1) } })

        local battlefield = player:getBattlefield()
        assert(battlefield, 'player did not enter a battlefield')
        assert(battlefield:getID() == xi.battlefield.id.ANCIENT_VOWS, 'wrong battlefield registered')
        assert(battlefield:getArea() == 1, 'the first free arena should be granted')
        assert(battlefield:getInitiator() == player:getID(), 'the registrant should be the initiator')
        assert(player:hasStatusEffect(xi.effect.BATTLEFIELD), 'the initiator should hold clearance')
        assert(player:hasEnteredBattlefield(), 'closing the menu should mark the player as entered')
    end)

    it('sends the player to the arena the server registered after a menu that granted no arena', function()
        local occupant = spawnCandidate()
        table.insert(players, occupant)
        occupant.bcnm:enter(entryNpc, xi.battlefield.id.ANCIENT_VOWS)

        local player = spawnCandidate()
        table.insert(players, player)

        -- Arena 1 is taken, the menu closes without an entry
        player.entities:gotoAndTrigger(entryNpc)
        local reply, moved = requestArena(player, 1)
        assert(reply == xi.battlefield.returnCode.WAIT and not moved, 'an occupied arena should answer WAIT')
        player.events:finish(entryEventId, 0)
        assert(not player:hasStatusEffect(xi.effect.BATTLEFIELD), 'a declined request must not leave clearance behind')

        -- The granted arena must be the one the battlefield lives in
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

    it('refuses a battlefield the menu did not offer', function()
        local player = spawnCandidate()
        table.insert(players, player)

        -- Menu offered Ancient Vows only, no Monarch Beard for Fire in the Sky
        player.entities:gotoAndTrigger(entryNpc)
        local reply, moved = requestArena(player, 1, xi.battlefield.id.FIRE_IN_THE_SKY)
        player.events:finish(entryEventId, 0)

        assert(reply == xi.battlefield.returnCode.REQS_NOT_MET and not moved, 'a battlefield outside the menu must be refused')
        assert(not player:getBattlefield() and not player:hasStatusEffect(xi.effect.BATTLEFIELD), 'no battlefield may be created for it')
    end)

    it('does not open the menu for a player who qualifies for nothing', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.MONARCH_LINN })
        table.insert(players, player)

        player.entities:gotoAndTrigger(entryNpc)
        player.events:expectNotInEvent()
        assert(not player:getBattlefield(), 'no battlefield may be created')
    end)

    it('does not open the menu for a level synced party', function()
        local leader = spawnCandidate()
        local member = spawnCandidate({ level = 30 })
        table.insert(players, leader)
        table.insert(players, member)

        formParty(leader, member)
        leader.actions:setLevelSync(member)
        assert(leader:hasStatusEffect(xi.effect.LEVEL_SYNC), 'leader should be level synced')

        leader.entities:gotoAndTrigger(entryNpc)
        leader.events:expectNotInEvent()
        assert(not leader:getBattlefield(), 'no battlefield may be created')
    end)

    it('leaving through the exit circle frees the arena', function()
        local player = spawnCandidate()
        table.insert(players, player)
        player.bcnm:enter(entryNpc, xi.battlefield.id.ANCIENT_VOWS)

        player.entities:gotoAndTrigger(exitNpc, { eventId = exitEventId, finishOption = 4 })
        assert(not player:getBattlefield(), 'player should have left the battlefield')
        assert(player:hasStatusEffect(xi.effect.BATTLEFIELD), 'leaving an open fight keeps clearance so the player can walk back in')

        -- Empty battlefield is destroyed and takes the clearance with it
        settleBattlefields()
        assert(not player:hasStatusEffect(xi.effect.BATTLEFIELD), 'cleanup should drop the clearance')

        local next = spawnCandidate()
        table.insert(players, next)
        next.bcnm:enter(entryNpc, xi.battlefield.id.ANCIENT_VOWS)
        assert(next:getBattlefield():getArea() == 1, 'the arena should be free again')
    end)

    it('opens the entry for the battlefield an orb is traded for', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.HORLAIS_PEAK })
        table.insert(players, player)
        player:addItem(xi.item.CLOUDY_ORB)

        player.bcnm:enter('BC_Entrance', xi.battlefield.id.SHOOTING_FISH, { xi.item.CLOUDY_ORB })

        local battlefield = player:getBattlefield()
        assert(battlefield and battlefield:getID() == xi.battlefield.id.SHOOTING_FISH, 'player did not enter the orb battlefield')
        assert(player:hasItem(xi.item.CLOUDY_ORB), 'the orb is only worn on a win, not taken at the door')
    end)
end)

describe('Battlefield clearance', function()
    local players

    before_each(function()
        players = {}
    end)

    after_each(function()
        leaveBattlefields(players)
    end)

    it('is copied onto party members in the zone, who then enter the same arena', function()
        local leader = spawnCandidate()
        local member = spawnCandidate()
        table.insert(players, leader)
        table.insert(players, member)

        formParty(leader, member)
        leader.bcnm:enter(entryNpc, xi.battlefield.id.ANCIENT_VOWS)
        assert(member:hasStatusEffect(xi.effect.BATTLEFIELD), 'party member should have been given clearance')
        assert(not member:getBattlefield(), 'clearance alone does not put the member inside')

        member.entities:gotoAndTrigger(entryNpc, { eventId = entryEventId, updates = { arenaOption(1) } })

        local battlefield = member:getBattlefield()
        assert(battlefield, 'member did not enter a battlefield')
        assert(battlefield:getInitiator() == leader:getID(), 'member should have joined the leader')
        assert(battlefield:getArea() == leader:getBattlefield():getArea(), 'member should share the leader arena')
    end)

    it('is not handed to a member who joined the party after registration', function()
        local leader   = spawnCandidate()
        local latecomer = spawnCandidate()
        table.insert(players, leader)
        table.insert(players, latecomer)

        leader.bcnm:enter(entryNpc, xi.battlefield.id.ANCIENT_VOWS)
        formParty(leader, latecomer)
        assert(not latecomer:hasStatusEffect(xi.effect.BATTLEFIELD), 'joining later should not grant clearance')

        latecomer.entities:gotoAndTrigger(entryNpc)
        latecomer.events:expectNotInEvent()
        assert(not latecomer:getBattlefield(), 'latecomer must stay outside')
    end)

    it('is handed back to a member who zones out and back while the fight is open', function()
        local leader = spawnCandidate()
        local member = spawnCandidate()
        table.insert(players, leader)
        table.insert(players, member)

        formParty(leader, member)
        leader.bcnm:enter(entryNpc, xi.battlefield.id.ANCIENT_VOWS)

        member:gotoZone(xi.zone.RIVERNE_SITE_A01)
        member:gotoZone(xi.zone.MONARCH_LINN)
        assert(member:hasStatusEffect(xi.effect.BATTLEFIELD), 'clearance should return with the member')

        member.entities:gotoAndTrigger(entryNpc, { eventId = entryEventId, updates = { arenaOption(1) } })

        local battlefield = member:getBattlefield()
        assert(battlefield, 'member did not enter a battlefield')
        assert(battlefield:getInitiator() == leader:getID(), 'member should have joined the leader')
    end)

    it('is not handed back once the fight is locked', function()
        local leader = spawnCandidate()
        local member = spawnCandidate()
        table.insert(players, leader)
        table.insert(players, member)

        formParty(leader, member)
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
        formParty(leader, member)
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

        formParty(firstLeader, drifter)
        firstLeader.bcnm:enter(entryNpc, xi.battlefield.id.ANCIENT_VOWS)
        assert(drifter:hasStatusEffect(xi.effect.BATTLEFIELD), 'party member should have been given clearance')

        -- Locking takes the clearance of members outside, then the drifter moves to a new party
        lockBattlefield(firstLeader)
        assert(not drifter:hasStatusEffect(xi.effect.BATTLEFIELD), 'locking should drop the clearance of members outside')

        drifter.actions:leaveParty()
        assert(drifter:getPartySize() == 1, 'drifter should have left the first party')

        local secondLeader = spawnCandidate()
        table.insert(players, secondLeader)
        formParty(secondLeader, drifter)

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

        -- Cleaning up the first party's fight must not strip clearance held for the second one
        firstLeader.bcnm:killMobs()
        firstLeader.bcnm:expectWin({ finishOption = 2 })
        settleBattlefields()

        assert(drifter:hasStatusEffect(xi.effect.BATTLEFIELD), 'drifter lost clearance when the first battlefield was cleaned up')
        assert(drifter:getBattlefield() and drifter:getBattlefield():getArea() == 2, 'drifter was removed from the second battlefield')
    end)
end)
