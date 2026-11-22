describe('Interaction Framework', function()
    it('completes Shady Business quest with zinc ore trade', function()
        ---@type CClientEntityPair
        local player = xi.test.world:spawnPlayer()

        -- Set prerequisite: Beauty and the Galka quest must be completed
        player:addQuest(xi.questLog.BASTOK, xi.quest.id.bastok.BEAUTY_AND_THE_GALKA)
        player:completeQuest(xi.questLog.BASTOK, xi.quest.id.bastok.BEAUTY_AND_THE_GALKA)

        -- Go to Port Bastok and talk to Talib
        player:gotoZone(xi.zone.PORT_BASTOK)
        player.entities:gotoAndTrigger('Talib', { eventId = 90 })

        -- Verify quest was started
        player.assert:hasQuest(xi.questLog.BASTOK, xi.quest.id.bastok.SHADY_BUSINESS)

        -- Add 4 chunks of zinc ore to inventory
        player:addItem(xi.item.CHUNK_OF_ZINC_ORE, 4)

        -- Trade the zinc ore to complete the quest
        player.actions:tradeNpc('Talib',
            {
                {
                    itemId = xi.item.CHUNK_OF_ZINC_ORE,
                    quantity = 4,
                }
            },
            { eventId = 91 })

        -- Verify quest completion and rewards
        player.assert
            :hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.SHADY_BUSINESS)
            :hasGil(350) -- Quest reward is 350 gil

        -- Verify the zinc ore was consumed
        player.assert.no:hasItem(xi.item.CHUNK_OF_ZINC_ORE)
    end)

    describe('tied actions', function()
        local containers = {}

        -- Registers a container whose only handler returns the given action for Bodaway
        local function addTiedAction(containerId, makeAction)
            local container = Container:new(containerId)
            container.sections =
            {
                {
                    check = function()
                        return true
                    end,

                    [xi.zone.PORT_BASTOK] =
                    {
                        ['Bodaway'] =
                        {
                            onTrigger = function()
                                return makeAction()
                            end,
                        },
                    },
                },
            }

            InteractionGlobal.lookup:addContainer(container)
            table.insert(containers, container)
        end

        local function countErrors(source)
            local count = 0
            for _, line in ipairs(xi.test.world:getLogs()) do
                if string.find(line, source, 1, true) then
                    count = count + 1
                end
            end

            return count
        end

        after_each(function()
            for _, container in ipairs(containers) do
                InteractionGlobal.lookup:removeContainer(container)
            end

            containers = {}
        end)

        it('takes turns between a noAction and an action with a string id', function()
            local performed = 0

            addTiedAction('TiedNoAction', function()
                return NoAction:new()
            end)

            addTiedAction('TiedLambda', function()
                return LambdaAction:new(function()
                    performed = performed + 1
                end, Action.Priority.Progress):progress()
            end)

            ---@type CClientEntityPair
            local player = xi.test.world:spawnPlayer({ zone = xi.zone.PORT_BASTOK })

            for _ = 1, 4 do
                player.entities:gotoAndTrigger('Bodaway')
            end

            assert(performed == 2, string.format('Expected the tied action to run on 2 of 4 triggers, ran on %d', performed))
            assert(countErrors('luautils::onTrigger') == 0, 'Expected no onTrigger errors')
        end)

        it('takes turns between three tied actions', function()
            local performed = { 0, 0, 0 }

            for index = 1, 3 do
                addTiedAction('TiedLambda' .. index, function()
                    return LambdaAction:new(function()
                        performed[index] = performed[index] + 1
                    end, Action.Priority.Progress):progress()
                end)
            end

            ---@type CClientEntityPair
            local player = xi.test.world:spawnPlayer({ zone = xi.zone.PORT_BASTOK })

            for _ = 1, 6 do
                player.entities:gotoAndTrigger('Bodaway')
            end

            for index = 1, 3 do
                assert(performed[index] == 2, string.format('Expected action %d to run on 2 of 6 triggers, ran on %d', index, performed[index]))
            end

            assert(countErrors('luautils::onTrigger') == 0, 'Expected no onTrigger errors')
        end)

        it('opens a chest that two quests both want a key item from', function()
            ---@type CClientEntityPair
            local player = xi.test.world:spawnPlayer({ zone = xi.zone.ORDELLES_CAVES })

            -- Signed in Blood and The Goblin Tailor both answer a key traded to this chest
            player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.SIGNED_IN_BLOOD)
            xi.quest.setVar(player, xi.questLog.SANDORIA, xi.quest.id.sandoria.SIGNED_IN_BLOOD, 'Prog', 2)
            player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_GOBLIN_TAILOR)
            stub('VanadielRSELocation', 0)
            stub('VanadielRSERace', player:getRace())

            -- skipTime ticks once after the jump, so the first call fires the chest's brief hide and the second outlasts it.
            xi.test.world:skipTime(10)
            xi.test.world:skipTime(10)

            player:addItem(xi.item.ORDELLE_CHEST_KEY)
            player.actions:tradeNpc('Treasure_Chest', { xi.item.ORDELLE_CHEST_KEY })
            xi.test.world:skipTime(5)

            local gotPattern = player:hasKeyItem(xi.keyItem.MAGICAL_PATTERN)
            local gotPages   = player:hasKeyItem(xi.keyItem.TORN_OUT_PAGES)

            player.assert.no:hasItem(xi.item.ORDELLE_CHEST_KEY)
            assert(gotPattern ~= gotPages, 'Expected the key to serve exactly one of the two quests')
            assert(countErrors('luautils::onTrade') == 0, 'Expected no onTrade errors')

            -- Outlast the chest's move and respawn so later cases find it closed and visible.
            xi.test.world:skipTime(10)
            xi.test.world:skipTime(200)
            xi.test.world:skipTime(10)
        end)
    end)
end)
