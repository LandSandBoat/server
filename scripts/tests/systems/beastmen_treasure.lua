local hunts =
{
    {
        name       = 'Elshimo Lowlands',
        zone       = xi.zone.YUHTUNGA_JUNGLE,
        map        = xi.ki.MAP_OF_THE_ELSHIMO_REGIONS,
        statusVar  = 'BMT_Lowlands_Status',
        digsiteVar = 'BMT_Lowlands_Digsite',
        maxGil     = 5000,
        items      = { xi.item.MERMAID_HEAD, xi.item.MERMAID_BODY, xi.item.MERMAID_HANDS, xi.item.MERMAID_TAIL },
    },
    {
        name       = 'Elshimo Uplands',
        zone       = xi.zone.YHOATOR_JUNGLE,
        map        = xi.ki.MAP_OF_THE_ELSHIMO_REGIONS,
        statusVar  = 'BMT_Uplands_Status',
        digsiteVar = 'BMT_Uplands_Digsite',
        maxGil     = 7000,
        items      = { xi.item.RANCOR_MANTLE, xi.item.RANCOR_GLOBE, xi.item.RANCOR_TANK, xi.item.RANCOR_HANDLE },
    },
    {
        name       = 'Kuzotz',
        zone       = xi.zone.WESTERN_ALTEPA_DESERT,
        map        = xi.ki.MAP_OF_THE_KUZOTZ_REGION,
        statusVar  = 'BMT_Kuzotz_Status',
        digsiteVar = 'BMT_Kuzotz_Digsite',
        maxGil     = 10000,
        items      = { xi.item.BAG_OF_XHIFHUT_STRINGS, xi.item.XHIFHUT_BODY, xi.item.XHIFHUT_BOW, xi.item.XHIFHUT_HEAD },
    },
}

local chipWeights =
{
    [xi.item.CLEAR_CHIP]  = 3,
    [xi.item.BLUE_CHIP]   = 2,
    [xi.item.GREEN_CHIP]  = 1,
    [xi.item.RED_CHIP]    = 2,
    [xi.item.YELLOW_CHIP] = 1,
}

---@param player CClientEntityPair
---@param itemId integer?
---@return integer
local function countItems(player, itemId)
    local count = 0

    for _, item in ipairs(player:getItems()) do
        local inventoryItemId = item:getID()
        if
            inventoryItemId ~= xi.item.GIL and
            (not itemId or inventoryItemId == itemId)
        then
            count = count + item:getQuantity()
        end
    end

    local pool = player:getTreasurePool()
    assert(pool, 'player has no treasure pool')

    for _, item in ipairs(pool:getItems()) do
        if item.id ~= 0 and (not itemId or item.id == itemId) then
            count = count + 1
        end
    end

    return count
end

---@param player CClientEntityPair
---@param messageId integer
---@param param0 integer?
local function expectMessage(player, messageId, param0)
    for _, packet in ipairs(player.packets:getIncoming()) do
        if packet.type == 0x02A then
            -- TALKNUMWORK stores the message and its display flag at 0x1A.
            if bit.band(packet.data[0x1A] + packet.data[0x1B] * 256, 0x7FFF) == messageId then
                if param0 then
                    assert(packet.data[0x08] + packet.data[0x09] * 256 + packet.data[0x0A] * 65536 + packet.data[0x0B] * 16777216 == param0, 'zone message has the wrong amount')
                end

                return
            end
        end
    end

    assert(false, 'expected zone message ' .. tostring(messageId))
end

describe('Beastmen Treasure', function()
    for _, hunt in ipairs(hunts) do
        describe(hunt.name, function()
            ---@type CClientEntityPair
            local player
            ---@type CTestEntity
            local peddlestox
            local originalStatus
            local rewardRolls

            before_each(function()
                player = xi.test.world:spawnPlayer()
                player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.BURGEONING_DREAD)
                player:addMission(xi.mission.log_id.ACP, xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN)
                player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.A_RHAPSODY_FOR_THE_AGES)
                player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.ABOMINATION)
                player:gotoZone(hunt.zone)

                peddlestox = player.entities:get('Peddlestox')
                originalStatus = peddlestox:getStatus()
                peddlestox:setStatus(xi.status.NORMAL)

                rewardRolls = { gil = 4000, chipChance = 26, chipIndex = 1 }

                -- Set reward rolls without changing background AI.
                local finishingExcavation = false
                local originalRandomInt = math.randomInt
                stub('math.randomInt', function(low, high)
                    if finishingExcavation then
                        if low == 4000 then
                            assert(high == hunt.maxGil, 'incorrect regional gil limit')
                            return rewardRolls.gil
                        elseif low == 1 and high == 100 then
                            return rewardRolls.chipChance
                        elseif low == 1 and high == 9 then
                            return rewardRolls.chipIndex
                        end
                    end

                    return originalRandomInt(low, high)
                end)

                local originalEventFinish = xi.beastmenTreasure.handleQmOnEventFinish
                stub('xi.beastmenTreasure.handleQmOnEventFinish', function(rewardPlayer, csid)
                    finishingExcavation = true
                    originalEventFinish(rewardPlayer, csid)
                    finishingExcavation = false
                end)
            end)

            after_each(function()
                peddlestox:setStatus(originalStatus)
            end)

            it('allows players to target Peddlestox when visible', function()
                assert(not peddlestox:getUntargetable(), 'visible Peddlestox is untargetable')
            end)

            it('requires the regional map before offering the hunt', function()
                player.entities:gotoAndTrigger(peddlestox, { eventId = 102 })
                assert(player:getCharVar(hunt.statusVar) == xi.questStatus.QUEST_AVAILABLE, 'offered a hunt without its map')
            end)

            it('takes the components, saves the site, pays the reward, and offers another hunt', function()
                player:addKeyItem(hunt.map)
                player.entities:gotoAndTrigger(peddlestox, { eventId = 100 })
                assert(player:getCharVar(hunt.statusVar) == xi.questStatus.QUEST_ACCEPTED, 'hunt was not accepted')

                for _, itemId in ipairs(hunt.items) do
                    player:addItem(itemId)
                end

                player.actions:tradeNpc(peddlestox, hunt.items)

                local pendingSite = player:getLocalVar(hunt.digsiteVar)
                assert(pendingSite >= 1 and pendingSite <= 8, 'trade did not choose a valid pending site')
                assert(player:getCharVar(hunt.digsiteVar) == 0, 'site was saved before payment')
                assert(player:getCharVar(hunt.statusVar) == xi.questStatus.QUEST_ACCEPTED, 'hunt advanced before payment')

                for _, itemId in ipairs(hunt.items) do
                    player.assert:hasItem(itemId)
                end

                player.events:expect({ eventId = 101 })

                for _, itemId in ipairs(hunt.items) do
                    player.assert.no:hasItem(itemId)
                end

                assert(player:getCharVar(hunt.statusVar) == xi.questStatus.QUEST_COMPLETED, 'payment did not unlock excavation')
                assert(player:getCharVar(hunt.digsiteVar) == pendingSite, 'payment saved a different site')
                assert(player:getLocalVar(hunt.digsiteVar) == 0, 'payment left a pending site')
                player.entities:gotoAndTrigger(peddlestox, { eventId = 103 })

                local digsiteId = zones[hunt.zone].npc.BEASTMEN_TREASURE_OFFSET + pendingSite - 1
                player.packets:clear()
                player.entities:gotoAndTrigger(digsiteId)
                player.events:expectNotInEvent()
                expectMessage(player, zones[hunt.zone].text.SOMETHING_IS_BURIED_HERE)

                player:addItem(xi.item.PICKAXE)
                local gilBefore = player:getGil()
                local itemsBefore = countItems(player)

                player.actions:tradeNpc(digsiteId, { xi.item.PICKAXE }, { eventId = 105 })

                player.assert.no:hasItem(xi.item.PICKAXE)
                assert(player:getGil() == gilBefore + 4000, 'excavation did not pay 4000 gil')
                expectMessage(player, zones[hunt.zone].text.GIL_OBTAINED, 4000)
                assert(countItems(player) == itemsBefore + 3, 'excavation did not exchange one pickaxe for four rewards')
                assert(player:getCharVar(hunt.statusVar) == xi.questStatus.QUEST_AVAILABLE, 'excavation did not reset the hunt')
                assert(player:getCharVar(hunt.digsiteVar) == 0, 'excavation left an assigned site')

                player.entities:gotoAndTrigger(peddlestox, { eventId = 100 })
                assert(player:getCharVar(hunt.statusVar) == xi.questStatus.QUEST_ACCEPTED, 'hunt could not be accepted again')
            end)

            for _, outcome in ipairs(
                {
                    { name = 'minimum gil without a chip', maximumGil = false, chipChance = 26, chipCount = 0 },
                    { name = 'maximum gil without a chip', maximumGil = true,  chipChance = 26, chipCount = 0 },
                    { name = 'minimum gil with a chip',    maximumGil = false, chipChance = 25, chipCount = 1 },
                    { name = 'maximum gil with a chip',    maximumGil = true,  chipChance = 25, chipCount = 1 },
                }) do
                it('pays ' .. outcome.name, function()
                    player:setCharVar(hunt.statusVar, xi.questStatus.QUEST_COMPLETED)
                    player:setCharVar(hunt.digsiteVar, 1)
                    player:addItem(xi.item.PICKAXE)
                    local gilBefore = player:getGil()
                    local itemsBefore = countItems(player)
                    rewardRolls.gil = outcome.maximumGil and hunt.maxGil or 4000
                    rewardRolls.chipChance = outcome.chipChance

                    player.actions:tradeNpc(zones[hunt.zone].npc.BEASTMEN_TREASURE_OFFSET, { xi.item.PICKAXE }, { eventId = 105 })

                    local chips = 0
                    for itemId, _ in pairs(chipWeights) do
                        chips = chips + countItems(player, itemId)
                    end

                    player.assert.no:hasItem(xi.item.PICKAXE)
                    assert(player:getGil() == gilBefore + rewardRolls.gil, 'excavation paid the wrong gil amount')
                    expectMessage(player, zones[hunt.zone].text.GIL_OBTAINED, rewardRolls.gil)
                    assert(countItems(player) == itemsBefore + 3 + outcome.chipCount, 'excavation awarded the wrong number of items')
                    assert(chips == outcome.chipCount, 'chip chance boundary awarded the wrong number of chips')
                    assert(player:getCharVar(hunt.statusVar) == xi.questStatus.QUEST_AVAILABLE, 'excavation did not reset the hunt')
                    assert(player:getCharVar(hunt.digsiteVar) == 0, 'excavation left an assigned site')
                end)
            end

            it('leaves a pickaxe free when the player has no paid hunt', function()
                player:setCharVar(hunt.digsiteVar, 1)
                player:addItem(xi.item.PICKAXE)
                local gilBefore = player:getGil()

                player.actions:tradeNpc(zones[hunt.zone].npc.BEASTMEN_TREASURE_OFFSET, { xi.item.PICKAXE })
                player.events:expectNotInEvent()

                local pickaxe = player:findItem(xi.item.PICKAXE, xi.inventoryLocation.INVENTORY)
                assert(pickaxe, 'rejected excavation consumed the pickaxe')
                assert(pickaxe:state() == xi.itemState.FREE, 'rejected excavation left the pickaxe claimed')
                assert(player:getGil() == gilBefore, 'rejected excavation paid gil')
                assert(player:getCharVar(hunt.statusVar) == xi.questStatus.QUEST_AVAILABLE, 'rejected excavation changed the hunt')
            end)

            it('leaves a pickaxe free at the wrong site', function()
                player:setCharVar(hunt.statusVar, xi.questStatus.QUEST_COMPLETED)
                player:setCharVar(hunt.digsiteVar, 1)
                player:addItem(xi.item.PICKAXE)
                local gilBefore = player:getGil()

                player.actions:tradeNpc(zones[hunt.zone].npc.BEASTMEN_TREASURE_OFFSET + 1, { xi.item.PICKAXE })
                player.events:expectNotInEvent()

                local pickaxe = player:findItem(xi.item.PICKAXE, xi.inventoryLocation.INVENTORY)
                assert(pickaxe, 'wrong-site excavation consumed the pickaxe')
                assert(pickaxe:state() == xi.itemState.FREE, 'wrong-site excavation left the pickaxe claimed')
                assert(player:getGil() == gilBefore, 'wrong-site excavation paid gil')
                assert(player:getCharVar(hunt.statusVar) == xi.questStatus.QUEST_COMPLETED, 'wrong-site excavation changed the hunt')
                assert(player:getCharVar(hunt.digsiteVar) == 1, 'wrong-site excavation changed the assigned site')
            end)

            it('keeps all eight dig points visible without advertising an unpaid site', function()
                player:setCharVar(hunt.statusVar, xi.questStatus.QUEST_ACCEPTED)
                player:setCharVar(hunt.digsiteVar, 1)

                for offset = 0, 7 do
                    local digsite = player.entities:get(zones[hunt.zone].npc.BEASTMEN_TREASURE_OFFSET + offset)
                    assert(digsite:getStatus() == xi.status.NORMAL, 'dig point is hidden: ' .. tostring(digsite:getID()))

                    player.packets:clear()
                    player.entities:gotoAndTrigger(digsite)
                    player.events:expectNotInEvent()
                    expectMessage(player, zones[hunt.zone].text.NOTHING_OUT_OF_ORDINARY)
                end
            end)

            if hunt.zone == xi.zone.YUHTUNGA_JUNGLE then
                it('uses the five chip colors with their assigned weights', function()
                    player:changeContainerSize(xi.inventoryLocation.INVENTORY, 80)
                    rewardRolls.chipChance = 25

                    -- The weighted entries can appear in any order.
                    for chipIndex = 1, 9 do
                        rewardRolls.chipIndex = chipIndex
                        player:setCharVar(hunt.statusVar, xi.questStatus.QUEST_COMPLETED)
                        player:setCharVar(hunt.digsiteVar, 1)
                        player:addItem(xi.item.PICKAXE)
                        player.actions:tradeNpc(zones[hunt.zone].npc.BEASTMEN_TREASURE_OFFSET, { xi.item.PICKAXE }, { eventId = 105 })
                    end

                    for itemId, weight in pairs(chipWeights) do
                        assert(countItems(player, itemId) == weight, 'incorrect chip weight for item ' .. tostring(itemId))
                    end
                end)

                it('keeps the hunt unpaid if a component disappears before the event finishes', function()
                    player:addKeyItem(hunt.map)
                    player.entities:gotoAndTrigger(peddlestox, { eventId = 100 })

                    for _, itemId in ipairs(hunt.items) do
                        player:addItem(itemId)
                    end

                    player.actions:tradeNpc(peddlestox, hunt.items)

                    -- Removing the offered item makes payment fail.
                    assert(player:delItem(xi.item.MERMAID_TAIL, 1), 'could not remove the offered component')
                    player.events:expect({ eventId = 101 })

                    assert(player:getCharVar(hunt.statusVar) == xi.questStatus.QUEST_ACCEPTED, 'failed payment advanced the hunt')
                    assert(player:getCharVar(hunt.digsiteVar) == 0, 'failed payment saved a dig site')
                    assert(player:getLocalVar(hunt.digsiteVar) == 0, 'failed payment left a pending dig site')

                    for _, itemId in ipairs({ xi.item.MERMAID_HEAD, xi.item.MERMAID_BODY, xi.item.MERMAID_HANDS }) do
                        local item = player:findItem(itemId, xi.inventoryLocation.INVENTORY)
                        assert(item, 'failed payment consumed another component')
                        assert(item:state() == xi.itemState.FREE, 'failed payment left a component claimed')
                    end

                    player:addItem(xi.item.MERMAID_TAIL)
                    player.actions:tradeNpc(peddlestox, hunt.items, { eventId = 101 })
                    assert(player:getCharVar(hunt.statusVar) == xi.questStatus.QUEST_COMPLETED, 'failed payment could not be retried')
                end)

                it('keeps the reward available if the pickaxe disappears before the event finishes', function()
                    rewardRolls.gil = hunt.maxGil
                    rewardRolls.chipChance = 25
                    player:setCharVar(hunt.statusVar, xi.questStatus.QUEST_COMPLETED)
                    player:setCharVar(hunt.digsiteVar, 1)
                    player:addItem(xi.item.PICKAXE)
                    local gilBefore = player:getGil()
                    player.packets:clear()

                    player.actions:tradeNpc(zones[hunt.zone].npc.BEASTMEN_TREASURE_OFFSET, { xi.item.PICKAXE })

                    -- Removing the offered item makes payment fail.
                    assert(player:delItem(xi.item.PICKAXE, 1), 'could not remove the offered pickaxe')
                    local itemsBefore = countItems(player)
                    player.events:expect({ eventId = 105 })

                    for _, packet in ipairs(player.packets:getIncoming()) do
                        if packet.type == 0x02A then
                            assert(bit.band(packet.data[0x1A] + packet.data[0x1B] * 256, 0x7FFF) ~= zones[hunt.zone].text.GIL_OBTAINED, 'failed pickaxe payment displayed a gil reward')
                        end
                    end

                    assert(player:getGil() == gilBefore, 'failed pickaxe payment awarded gil')
                    assert(countItems(player) == itemsBefore, 'failed pickaxe payment awarded items')
                    assert(player:getCharVar(hunt.statusVar) == xi.questStatus.QUEST_COMPLETED, 'failed payment reset the hunt')
                    assert(player:getCharVar(hunt.digsiteVar) == 1, 'failed payment cleared the assigned site')

                    player:addItem(xi.item.PICKAXE)
                    local retryItemsBefore = countItems(player)
                    player.actions:tradeNpc(zones[hunt.zone].npc.BEASTMEN_TREASURE_OFFSET, { xi.item.PICKAXE }, { eventId = 105 })
                    assert(player:getGil() == gilBefore + hunt.maxGil, 'failed excavation could not be retried')
                    expectMessage(player, zones[hunt.zone].text.GIL_OBTAINED, hunt.maxGil)
                    assert(countItems(player) == retryItemsBefore + 4, 'retried excavation did not award five items')
                    assert(player:getCharVar(hunt.statusVar) == xi.questStatus.QUEST_AVAILABLE, 'retried excavation did not reset the hunt')
                end)
            end
        end)
    end
end)
