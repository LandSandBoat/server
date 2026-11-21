-----------------------------------
-- Monarch Linn ENM entry cooldown
-----------------------------------
require('scripts/globals/enm')
-----------------------------------

local cooldownVar = xi.enm.monarchBeardCooldownVar
local keyItem     = xi.keyItem.MONARCH_BEARD
local entryNpc    = 'SD_Entrance'
local issuer      = 'Morangeart'

local encounters =
{
    { name = 'Fire in the Sky',         id = xi.battlefield.id.FIRE_IN_THE_SKY          },
    { name = 'Bugard in the Clouds',    id = xi.battlefield.id.BUGARD_IN_THE_CLOUDS    },
    { name = 'Beloved of the Atlantes', id = xi.battlefield.id.BELOVED_OF_THE_ATLANTES },
}

---@param players CClientEntityPair[]
---@return CClientEntityPair
local function spawnEligiblePlayer(players)
    local player = xi.test.world:spawnPlayer({ zone = xi.zone.TAVNAZIAN_SAFEHOLD })
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.ANCIENT_VOWS)
    table.insert(players, player)

    return player
end

describe('Monarch Linn ENM cooldown', function()
    ---@type CClientEntityPair[]
    local players
    local now

    before_each(function()
        players = {}
        now     = VanadielTime()
        stub('VanadielTime', function()
            return now
        end)
    end)

    after_each(function()
        for _, player in ipairs(players) do
            if player:getBattlefield() then
                player:leaveBattlefield(xi.battlefield.leaveCode.EXIT)
            end
        end

        for _ = 1, 3 do
            xi.test.world:skipTime(11)
            xi.test.world:tick()
        end
    end)

    for _, encounter in ipairs(encounters) do
        it('starts the shared cooldown on entry to ' .. encounter.name, function()
            local player = spawnEligiblePlayer(players)
            player:setCharVar(cooldownVar, now - 1)

            player.entities:gotoAndTrigger(issuer, { eventId = 521 })
            player.assert:hasKI(keyItem)
            assert(player:getCharVar(cooldownVar) == now - 1, 'issuance must preserve the previous timestamp')

            player.entities:gotoAndTrigger(issuer, { eventId = 520 })
            assert(player:getCharVar(cooldownVar) == now - 1, 'holding the Monarch Beard must not start a cooldown')

            player:gotoZone(xi.zone.MONARCH_LINN)
            player.bcnm:enter(entryNpc, encounter.id)
            local deadline = now + xi.settings.main.ENM_COOLDOWN * 3600
            assert(not player:hasKeyItem(keyItem), 'entry must consume the Monarch Beard')
            assert(player:getCharVar(cooldownVar) == deadline, 'entry must start the configured cooldown')

            -- The test harness does not tick empty zones.
            player:leaveBattlefield(xi.battlefield.leaveCode.EXIT)
            xi.test.world:skipTime(11)
            xi.test.world:tick()
            player:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
            now = deadline - 1
            player.entities:gotoAndTrigger(issuer, { eventId = 522 })
            assert(not player:hasKeyItem(keyItem), 'a replacement must be blocked before the deadline')

            now = deadline
            player.entities:gotoAndTrigger(issuer, { eventId = 521 })
            player.assert:hasKI(keyItem)
            assert(player:getCharVar(cooldownVar) == deadline, 'replacement issuance must not restart the cooldown')
        end)
    end

    it('starts a member cooldown only on entry and preserves it on reinsertion', function()
        local leader = spawnEligiblePlayer(players)
        local member = spawnEligiblePlayer(players)
        for _, player in ipairs(players) do
            player.entities:gotoAndTrigger(issuer, { eventId = 521 })
            player:gotoZone(xi.zone.MONARCH_LINN)
        end

        leader.actions:inviteToParty(member)
        member.actions:acceptPartyInvite()
        leader.bcnm:enter(entryNpc, xi.battlefield.id.BUGARD_IN_THE_CLOUDS)
        assert(member:hasStatusEffect(xi.effect.BATTLEFIELD), 'the member must have clearance')
        assert(not member:getBattlefield(), 'clearance alone must not enter the member')
        assert(member:getCharVar(cooldownVar) == 0, 'clearance alone must not start the member cooldown')
        member.assert:hasKI(keyItem)

        now = now + 60
        member.bcnm:enter(entryNpc, xi.battlefield.id.BUGARD_IN_THE_CLOUDS)
        local deadline = now + xi.settings.main.ENM_COOLDOWN * 3600
        assert(not member:hasKeyItem(keyItem), 'entry must consume the member Monarch Beard')
        assert(member:getCharVar(cooldownVar) == deadline, 'entry must start the member cooldown')

        member:leaveBattlefield(xi.battlefield.leaveCode.WARPDC)
        assert(not member:getBattlefield(), 'the member must leave before reinsertion')
        now = now + 60
        assert(member:enterBattlefield(), 'the member must reenter the occupied instance')
        assert(member:getBattlefield() == leader:getBattlefield(), 'reinsertion must restore the same battlefield')
        assert(member:getCharVar(cooldownVar) == deadline, 'reinsertion must preserve the original deadline')
    end)

    it('rechecks the cooldown when the issuance event finishes', function()
        local player = spawnEligiblePlayer(players)
        player.entities:gotoAndTrigger(issuer)
        player:setCharVar(cooldownVar, now + 60)
        player.events:expect({ eventId = 521 })
        assert(not player:hasKeyItem(keyItem), 'a newly active cooldown must block the pending issue')
        player.entities:gotoAndTrigger(issuer, { eventId = 522 })
    end)
end)
