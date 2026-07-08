describe('SynthTransaction', function()
    ---@type CClientEntityPair
    local player

    local crystal    = xi.item.WIND_CRYSTAL
    local ingredient = xi.item.ARROWWOOD_LOG
    local resultItem = xi.item.PIECE_OF_ARROWWOOD_LUMBER

    before_each(function()
        player = xi.test.world:spawnPlayer(
            {
                zone = xi.zone.SOUTHERN_SAN_DORIA,
            })
        player:setSkillLevel(xi.skill.WOODWORKING, 200)
    end)

    it('crystal and ingredient are InTransaction during the animation', function()
        player:addItem(crystal)
        player:addItem(ingredient)

        local crystalItem = player:findItem(crystal)
        local ingItem     = player:findItem(ingredient)
        assert(crystalItem and ingItem, 'expected crystal and ingredient in inventory')
        assert(crystalItem:state() == xi.itemState.FREE)
        assert(ingItem:state() == xi.itemState.FREE)

        player.actions:craft(crystal, { ingredient })

        local midSynth = player:findItem(ingredient)
        assert(midSynth, 'ingredient should still be in inventory mid-synth')
        assert(midSynth:state() == xi.itemState.IN_TRANSACTION,
            'expected IN_TRANSACTION mid-synth, got ' .. tostring(midSynth:state()))
    end)

    it('successful synth consumes ingredients and yields the result', function()
        player:setSkillLevel(xi.skill.WOODWORKING, 10)

        local maxAttempts = 10
        local succeeded   = false
        for _ = 1, maxAttempts do
            player:addItem(crystal)
            player:addItem(ingredient)

            player.actions:craft(crystal, { ingredient })
            xi.test.world:skipTime(17)
            xi.test.world:skipTime(15)

            if player:hasItem(resultItem) then
                succeeded = true
                break
            end

            player:delContainerItems(xi.inv.INVENTORY)
        end

        assert(succeeded, 'synth did not succeed within ' .. maxAttempts .. ' attempts')

        player.assert.no:hasItem(crystal)
        player.assert.no:hasItem(ingredient)
        player.assert:hasItem(resultItem)
        -- Exactly one result delivered (no double-commit / pendingResult leak).
        assert(player:getItemCount(resultItem) == 1, 'expected exactly 1 result, got ' .. tostring(player:getItemCount(resultItem)))
    end)

    it('stack ingredient consumes exactly N from one inventory slot', function()
        local stackQty    = 3
        local maxAttempts = 10
        local succeeded   = false
        for _ = 1, maxAttempts do
            player:addItem(crystal)
            player:addItem(ingredient, stackQty)

            player.actions:craft(crystal, { ingredient })
            xi.test.world:skipTime(17)
            xi.test.world:skipTime(15)

            if player:hasItem(resultItem) then
                succeeded = true
                break
            end

            player:delContainerItems(xi.inv.INVENTORY)
        end

        assert(succeeded, 'synth did not succeed within ' .. maxAttempts .. ' attempts')

        assert(player:getItemCount(ingredient) == stackQty - 1,
            string.format('expected %d remaining, got %d', stackQty - 1, player:getItemCount(ingredient)))
    end)

    it('NO_LOSS recipe fail preserves ingredient', function()
        -- Recipe 3049: Light Crystal + Broken Lu Shang's -> Lu Shang's. Wood 70, NO_LOSS.
        local lightCrystal = xi.item.LIGHT_CRYSTAL
        local brokenRod    = xi.item.BROKEN_LU_SHANGS_FISHING_ROD
        local luShangs     = xi.item.LU_SHANGS_FISHING_ROD

        player:setSkillLevel(xi.skill.WOODWORKING, 550)

        local sawFail = false
        for i = 1, 20 do
            player:addItem(lightCrystal)
            player:addItem(brokenRod)
            player.actions:craft(lightCrystal, { brokenRod })
            xi.test.world:skipTime(17)
            xi.test.world:skipTime(15)

            player.assert.no:hasItem(lightCrystal)

            if player:hasItem(luShangs) then
                assert(not player:hasItem(brokenRod), 'success should consume ingredient')
                player:delContainerItems(xi.inv.INVENTORY)
            else
                assert(player:hasItem(brokenRod), 'NO_LOSS fail must preserve ingredient')
                sawFail = true
                break
            end
        end

        assert(sawFail, 'expected at least one fail in 20 attempts at min skill')
    end)

    it('bad recipe leaves items Free and unconsumed', function()
        player:addItem(crystal)
        player:addItem(xi.item.CHUNK_OF_IRON_ORE)

        player.actions:craft(crystal, { xi.item.CHUNK_OF_IRON_ORE })

        local crystalItem = player:findItem(crystal)
        local ore         = player:findItem(xi.item.CHUNK_OF_IRON_ORE)
        assert(crystalItem, 'crystal should not be consumed on bad recipe')
        assert(ore, 'ingredient should not be consumed on bad recipe')
        assert(crystalItem:state() == xi.itemState.FREE)
        assert(ore:state() == xi.itemState.FREE)
    end)

    it('moving an InTransaction ingredient is rejected', function()
        player:addItem(crystal)
        player:addItem(ingredient)

        local ingItem = player:findItem(ingredient, xi.inventoryLocation.INVENTORY)
        assert(ingItem, 'expected ingredient in inventory')
        local srcSlot = ingItem:getSlotID()

        player.actions:craft(crystal, { ingredient })
        assert(ingItem:state() == xi.itemState.IN_TRANSACTION)

        player.actions:moveItem(xi.inventoryLocation.INVENTORY, srcSlot, xi.inventoryLocation.MOGSAFE, 1)

        local stillInInv = player:findItem(ingredient, xi.inventoryLocation.INVENTORY)
        assert(stillInInv, 'ingredient should still be in inventory')
        assert(stillInInv:getSlotID() == srcSlot, 'ingredient slot must not change')
        assert(stillInInv:state() == xi.itemState.IN_TRANSACTION, 'state must still be IN_TRANSACTION')

        local inMogSafe = player:findItem(ingredient, xi.inventoryLocation.MOGSAFE)
        assert(not inMogSafe, 'ingredient must not have moved to mog safe')
    end)

    it('zoning mid-synth consumes claimed ingredients', function()
        player:addItem(crystal)
        player:addItem(ingredient)

        player.actions:craft(crystal, { ingredient })

        local midSynth = player:findItem(ingredient)
        assert(midSynth and midSynth:state() == xi.itemState.IN_TRANSACTION)

        player:gotoZone(xi.zone.NORTHERN_SAN_DORIA)
        xi.test.world:skipTime(2)

        player.assert.no:hasItem(crystal)
        player.assert.no:hasItem(ingredient)
    end)
end)
