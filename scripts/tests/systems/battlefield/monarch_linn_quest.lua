-----------------------------------
-- Uninvited Guests quest and battlefield
-----------------------------------
require('scripts/globals/interaction/quest')
-----------------------------------
local questId = xi.quest.id.otherAreas.UNINVITED_GUESTS
local questPrefix = Quest.getVarPrefix(xi.questLog.OTHER_AREAS, questId)

---@param player CClientEntityPair
local function countRewardItems(player)
    local count = 0
    for _, item in ipairs(player:getItems()) do
        local itemId = item:getID()
        if itemId ~= xi.item.GIL and itemId ~= xi.item.BOTTLE_OF_YELLOW_LIQUID then
            count = count + item:getQuantity()
        end
    end

    return count
end

---@param player CClientEntityPair
local function isPatrolInCurrentQuestLog(player)
    local current
    for _, packet in ipairs(player.packets:getIncoming()) do
        -- 0x70 is the Current tab for Other Areas within the 0x056 quest log packet.
        if
            packet.type == 0x056 and
            packet.data[36] == 0x70 and
            packet.data[37] == 0
        then
            local questBits = packet.data[4 + math.floor(questId / 8)]
            current = bit.band(questBits, bit.lshift(1, questId % 8)) ~= 0
        end
    end

    return current
end

---@param player CClientEntityPair
local function winPatrol(player)
    player:gotoZone(xi.zone.MONARCH_LINN)
    player.bcnm:enter('SD_Entrance', xi.battlefield.id.UNINVITED_GUESTS)

    local battlefield = assert(player:getBattlefield())
    local mammet = player.entities:moveTo(zones[xi.zone.MONARCH_LINN].mob.MAMMET_800 + (battlefield:getArea() - 1) * 10)
    mammet:updateEnmity(player)
    xi.test.world:tick()
    assert(mammet:isEngaged(), 'the Mammet must engage before the test kills it')

    player.bcnm:killMobs()
    player.bcnm:expectWin({ finishOption = 2 })
    xi.test.world:skipTime(11)
    player:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
end

describe('Monarch Linn Uninvited Guests quest', function()
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer()
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.DESIRES_OF_EMPTINESS)
        player:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
        player.entities:gotoAndTrigger('Justinius', { eventId = 570, finishOption = 1 })
        player.assert:hasKI(xi.keyItem.MONARCH_LINN_PATROL_PERMIT)
    end)

    after_each(function()
        if player:getBattlefield() then
            player:leaveBattlefield(xi.battlefield.leaveCode.EXIT)
        end

        xi.test.world:skipTime(11)
    end)

    it('recovers an accepted patrol with missing progress', function()
        player:setCharVar(questPrefix .. 'Prog', 0)
        player.entities:gotoAndTrigger('Justinius', { eventId = 571 })
        assert(player:getCharVar(questPrefix .. 'Prog') == 1)
        player.assert:hasKI(xi.keyItem.MONARCH_LINN_PATROL_PERMIT)

        -- Without the old permit, the initial offer returns after any stored wait.
        player:delKeyItem(xi.keyItem.MONARCH_LINN_PATROL_PERMIT)
        player:setCharVar(questPrefix .. 'Prog', 0)
        player:setCharVar(questPrefix .. 'Wait', NextConquestTally())
        player.entities:gotoAndTrigger('Justinius')

        -- Let the tally pass while talking. Accepting an early patrol offer would now grant the permit.
        player:setCharVar(questPrefix .. 'Wait', NextConquestTally() - 1)
        player.events:finish(nil, 1)
        assert(player:getCharVar(questPrefix .. 'Prog') == 0)
        assert(not player:hasKeyItem(xi.keyItem.MONARCH_LINN_PATROL_PERMIT))

        player.entities:gotoAndTrigger('Justinius', { eventId = 570, finishOption = 1 })
        assert(player:getCharVar(questPrefix .. 'Prog') == 1)
        player.assert:hasKI(xi.keyItem.MONARCH_LINN_PATROL_PERMIT)
    end)

    it('gives no quest credit after a patrol defeat and a Bugard in the Clouds victory', function()
        player:gotoZone(xi.zone.MONARCH_LINN)
        player.bcnm:enter('SD_Entrance', xi.battlefield.id.UNINVITED_GUESTS)
        local patrol = assert(player:getBattlefield())
        patrol:setTimeLimit(0)
        xi.test.world:skipTime(2)
        player.events:expect({ eventId = 32002 })
        xi.test.world:skipTime(11)

        player:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
        player.entities:gotoAndTrigger('Morangeart', { eventId = 521 })
        player:gotoZone(xi.zone.MONARCH_LINN)
        player.bcnm:enter('SD_Entrance', xi.battlefield.id.BUGARD_IN_THE_CLOUDS)
        local enm = assert(player:getBattlefield())
        player.bcnm:killMobs()
        player.entities:gotoAndTrigger(enm:getArmouryCrate())

        for _ = 1, xi.battlefield.contents[xi.battlefield.id.BUGARD_IN_THE_CLOUDS].delayToExit do
            xi.test.world:skipTime(2)
        end

        player.bcnm:expectWin({ finishOption = 2 })
        xi.test.world:skipTime(11)

        assert(player:getCharVar(questPrefix .. 'Prog') == 1, 'the unrelated win must leave the patrol unresolved')
        player:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
        local gil = player:getGil()
        local items = countRewardItems(player)
        player.entities:gotoAndTrigger('Justinius', { eventId = 575 })
        assert(player:getGil() == gil and countRewardItems(player) == items)
        assert(not player:hasCompletedQuest(xi.questLog.OTHER_AREAS, questId))
        assert(player:getCharVar(questPrefix .. 'Wait') == NextConquestTally())

        player:setCharVar(questPrefix .. 'Wait', NextConquestTally() - 1)
        player.entities:gotoAndTrigger('Justinius')
        player:setCharVar(questPrefix .. 'Wait', NextConquestTally())
        player.events:expect({ eventId = 574 })
        assert(not player:hasKeyItem(xi.keyItem.MONARCH_LINN_PATROL_PERMIT))

        player:setCharVar(questPrefix .. 'Wait', NextConquestTally() - 1)
        player.entities:gotoAndTrigger('Justinius', { eventId = 574 })
        player.assert:hasKI(xi.keyItem.MONARCH_LINN_PATROL_PERMIT)
    end)

    it('pays the item and first-clear gil after a patrol victory', function()
        winPatrol(player)

        local gil = player:getGil()
        local items = countRewardItems(player)
        player.entities:gotoAndTrigger('Justinius', { eventId = 572 })
        player.assert:hasCompletedQuest(xi.questLog.OTHER_AREAS, questId)
        assert(player:hasTitle(xi.title.MONARCH_LINN_PATROL_GUARD))
        assert(player:getGil() == gil + 10000 * xi.settings.main.GIL_RATE)
        assert(countRewardItems(player) == items + 1)
        assert(player:getCharVar(questPrefix .. 'Wait') == NextConquestTally())
    end)

    it('retries a blocked reward without completing the patrol or changing the reward', function()
        winPatrol(player)

        local reward = xi.item.MIRATETES_MEMOIRS
        local gil = player:getGil()
        player:addItem(reward)
        player:setCharVar('UninvitedGuestsReward', reward)
        player.entities:gotoAndTrigger('Justinius', { eventId = 572 })
        assert(player:getCharVar('UninvitedGuestsReward') == reward)
        assert(player:getGil() == gil)
        assert(not player:hasCompletedQuest(xi.questLog.OTHER_AREAS, questId))

        assert(player:delItem(reward, 1))
        player.entities:gotoAndTrigger('Justinius', { eventId = 572 })
        player.assert:hasItem(reward)
        player.assert:hasCompletedQuest(xi.questLog.OTHER_AREAS, questId)
        assert(player:getCharVar('UninvitedGuestsReward') == 0)
        assert(player:getGil() == gil + 10000 * xi.settings.main.GIL_RATE)
    end)

    it('lets a completed player finish a repeat patrol and collect the item once', function()
        winPatrol(player)
        player.entities:gotoAndTrigger('Justinius', { eventId = 572 })

        if player:hasItem(xi.item.MIRATETES_MEMOIRS) then
            assert(player:delItem(xi.item.MIRATETES_MEMOIRS, 1))
        end

        -- Simulate an elapsed conquest tally for this player.
        player:setCharVar(questPrefix .. 'Wait', NextConquestTally() - 1)
        player.entities:gotoAndTrigger('Justinius')
        player:setCharVar(questPrefix .. 'Wait', NextConquestTally())
        player.events:expect({ eventId = 573, finishOption = 1 })
        assert(not player:hasKeyItem(xi.keyItem.MONARCH_LINN_PATROL_PERMIT))

        player:setCharVar(questPrefix .. 'Wait', NextConquestTally() - 1)
        player.packets:clear()
        player.entities:gotoAndTrigger('Justinius', { eventId = 573, finishOption = 1 })
        assert(isPatrolInCurrentQuestLog(player) == true)
        player.assert:hasCompletedQuest(xi.questLog.OTHER_AREAS, questId)
        player.assert:hasKI(xi.keyItem.MONARCH_LINN_PATROL_PERMIT)

        winPatrol(player)
        assert(not player:hasKeyItem(xi.keyItem.MONARCH_LINN_PATROL_PERMIT))
        player:setCharVar('UninvitedGuestsReward', xi.item.MIRATETES_MEMOIRS)
        local gil = player:getGil()
        local items = countRewardItems(player)
        player.packets:clear()
        player.entities:gotoAndTrigger('Justinius', { eventId = 572 })
        assert(isPatrolInCurrentQuestLog(player) == false)
        player.assert:hasCompletedQuest(xi.questLog.OTHER_AREAS, questId)
        assert(player:getGil() == gil and countRewardItems(player) == items + 1)
        assert(player:getCharVar(questPrefix .. 'Wait') == NextConquestTally())

        player.entities:gotoAndTrigger('Justinius')
        assert(player:getGil() == gil and countRewardItems(player) == items + 1)
    end)
end)
