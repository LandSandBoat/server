describe('ASA M5 - Enemy of the Empire I', function()
    ---@type CClientEntityPair
    local player

    -- Mob list indices and the plate signatures the Soultrapper writes for them.
    local grottoPugil  = 7
    local bigclaw      = 1
    local brookSahagin = 2
    local mousse       = 21

    local function assignMobs(mobOne, mobTwo, mobThree, plates)
        player:setCharVar('Mission[11][4]MobOne', mobOne)
        player:setCharVar('Mission[11][4]MobTwo', mobTwo)
        player:setCharVar('Mission[11][4]MobThree', mobThree)
        player:setCharVar('Mission[11][4]Plates', plates)
    end

    before_each(function()
        player = xi.test.world:spawnPlayer({ level = 75 })
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.ENEMY_OF_THE_EMPIRE_I)
    end)

    describe('Andrause', function()
        before_each(function()
            player:gotoZone(xi.zone.NORG)
        end)

        it('names three different mobs on the first talk', function()
            player.entities:gotoAndTrigger('Andrause', { eventId = 237 })

            local picked = {}
            for _, var in ipairs({ 'MobOne', 'MobTwo', 'MobThree' }) do
                local index = player:getCharVar(string.format('Mission[11][4]%s', var))
                assert(index >= 1 and index <= 23, string.format('Expected a mob index, got %d', index))
                assert(not picked[index], 'Expected three different mobs')
                picked[index] = true
            end

            player.entities:gotoAndTrigger('Andrause', { eventId = 238 })
        end)

        it('sells the Soultrapper and twelve plates once a day for 800 gil', function()
            assignMobs(grottoPugil, bigclaw, mousse, 0)
            player:setGil(1000)

            player.entities:gotoAndTrigger('Andrause', { eventId = 238, updates = { 5 } })
            player.assert:hasItem(xi.item.SOULTRAPPER)
            assert(player:getItemCount(xi.item.BLANK_SOUL_PLATE) == 12, 'Expected twelve blank plates')
            assert(player:getGil() == 200, string.format('Expected 200 gil left, got %d', player:getGil()))

            player.entities:gotoAndTrigger('Andrause', { eventId = 238, updates = { 5 } })
            assert(player:getItemCount(xi.item.SOULTRAPPER) == 1, 'Expected the shop to be sold out')
            assert(player:getGil() == 200, 'Expected no second charge')
        end)

        it('does not sell without the gil', function()
            assignMobs(grottoPugil, bigclaw, mousse, 0)
            player:setGil(799)

            player.entities:gotoAndTrigger('Andrause', { eventId = 238, updates = { 5 } })
            player.assert.no:hasItem(xi.item.SOULTRAPPER)
        end)

        it('takes a plate of a wanted mob', function()
            assignMobs(grottoPugil, bigclaw, mousse, 0)
            player:addItem({ id = xi.item.SOUL_PLATE, exdata = { signature = 'GrottoPugil' } })

            player.actions:tradeNpc('Andrause', { xi.item.SOUL_PLATE }, { eventId = 241 })
            player.assert.no:hasItem(xi.item.SOUL_PLATE)
            assert(player:getCharVar('Mission[11][4]MobOne') == 99, 'Expected the first mob to be marked delivered')
            assert(player:getCharVar('Mission[11][4]Plates') == 1, 'Expected one plate counted')
            player.assert.no:hasKI(xi.keyItem.BLACK_BOOK)
        end)

        it('hands back a plate of the wrong mob', function()
            assignMobs(grottoPugil, bigclaw, brookSahagin, 0)
            player:addItem({ id = xi.item.SOUL_PLATE, exdata = { signature = 'Mousse' } })

            player.actions:tradeNpc('Andrause', { xi.item.SOUL_PLATE }, { eventId = 242 })
            player.assert:hasItem(xi.item.SOUL_PLATE)
            assert(player:getCharVar('Mission[11][4]Plates') == 0, 'Expected no plate counted')
        end)

        it('hands over the black book with the third plate', function()
            assignMobs(99, 99, mousse, 2)
            player:addItem({ id = xi.item.SOUL_PLATE, exdata = { signature = 'Mousse' } })

            player.actions:tradeNpc('Andrause', { xi.item.SOUL_PLATE }, { eventId = 241 })
            player.assert:hasKI(xi.keyItem.BLACK_BOOK)
            assert(player:getCharVar('Mission[11][4]MobOne') == 0, 'Expected the mob list to be cleared')
            assert(player:getCharVar('Mission[11][4]Plates') == 0, 'Expected the plate count to be cleared')

            player.entities:gotoAndTrigger('Andrause', { eventId = 240 })
        end)
    end)

    it('completes at the Outcropping with the black book', function()
        player:addKeyItem(xi.keyItem.BLACK_BOOK)
        player:gotoZone(xi.zone.GUSTAV_TUNNEL)

        player.entities:gotoAndTrigger('Outcropping', { eventId = 13 })
        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.ENEMY_OF_THE_EMPIRE_II)
        player.assert:hasKI(xi.keyItem.BLACK_BOOK)
    end)

    it('is silent at the Outcropping without the black book', function()
        player:gotoZone(xi.zone.GUSTAV_TUNNEL)

        player.entities:gotoAndTrigger('Outcropping')
        player.events:expectNotInEvent()
        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.ENEMY_OF_THE_EMPIRE_I)
    end)
end)
