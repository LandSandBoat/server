describe('Weapon TP', function()
    ---@type CClientEntityPair
    local player

    it('same single weapon via equipset packet keeps TP', function()
        player = xi.test.world:spawnPlayer({ job = xi.job.WAR, level = 75, zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:addItem(xi.item.BRONZE_SWORD)
        player:equipItem(xi.item.BRONZE_SWORD, nil, xi.slot.MAIN)
        local slot = player:getItemInvSlot(xi.item.BRONZE_SWORD, 1)
        assert(slot, 'sword not in inventory')

        player:setTP(1000)
        player.actions:equipSet({ { index = slot, kind = xi.slot.MAIN, container = xi.inv.INVENTORY } })
        assert(player:getTP() == 1000, string.format('single-copy TP=%d', player:getTP()))
    end)

    it('swapping to a different physical copy resets TP', function()
        player = xi.test.world:spawnPlayer({ job = xi.job.WAR, level = 75, zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:addItem(xi.item.BRONZE_SWORD)
        player:addItem(xi.item.BRONZE_SWORD)

        player:equipItem(xi.item.BRONZE_SWORD, nil, xi.slot.MAIN)
        assert(player:getEquippedItem(xi.slot.MAIN), 'first copy not equipped')

        local secondSlot = player:getItemInvSlot(xi.item.BRONZE_SWORD, 1)
        assert(secondSlot, 'second copy not found')

        player:setTP(1000)
        player.actions:equipSet({ { index = secondSlot, kind = xi.slot.MAIN, container = xi.inv.INVENTORY } })
        assert(player:getTP() == 0, string.format('expected reset, TP=%d', player:getTP()))
    end)

    it('entry resolving to an empty slot keeps TP, weapon stays (sub present)', function()
        player = xi.test.world:spawnPlayer({ job = xi.job.WAR, level = 75, zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:addItem(xi.item.BRONZE_SWORD)
        player:addItem(xi.item.LAUAN_SHIELD)
        player:addItem(xi.item.BRONZE_AXE)
        local emptySlot = player:getItemInvSlot(xi.item.BRONZE_AXE, 1)
        assert(emptySlot, 'filler axe not in inventory')
        player:delItem(xi.item.BRONZE_AXE, 1)

        player:equipItem(xi.item.BRONZE_SWORD, nil, xi.slot.MAIN)
        player:equipItem(xi.item.LAUAN_SHIELD, nil, xi.slot.SUB)
        assert(player:getEquippedItem(xi.slot.MAIN), 'sword not equipped')

        player:setTP(1000)
        player.actions:equipSet({ { index = emptySlot, kind = xi.slot.MAIN, container = xi.inv.INVENTORY } })
        assert(player:getEquippedItem(xi.slot.MAIN), 'weapon should remain equipped')
        assert(player:getTP() == 1000, string.format('TP wiped by empty entry, TP=%d', player:getTP()))
    end)

    it('entry for an unequippable item keeps TP, weapon stays', function()
        player = xi.test.world:spawnPlayer({ job = xi.job.WAR, level = 75, zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:addItem(xi.item.BRONZE_SWORD)
        player:addItem(xi.item.BRONZE_ROD)
        local rodSlot = player:getItemInvSlot(xi.item.BRONZE_ROD, 1)
        assert(rodSlot, 'rod not in inventory')

        player:equipItem(xi.item.BRONZE_SWORD, nil, xi.slot.MAIN)
        assert(player:getEquippedItem(xi.slot.MAIN), 'sword not equipped')

        player:setTP(1000)
        player.actions:equipSet({ { index = rodSlot, kind = xi.slot.MAIN, container = xi.inv.INVENTORY } })
        assert(player:getEquippedItem(xi.slot.MAIN):getID() == xi.item.BRONZE_SWORD, 'sword should remain equipped')
        assert(player:getTP() == 1000, string.format('TP wiped by failed equip, TP=%d', player:getTP()))
    end)

    it('dual wield: re-apply same main+sub keeps TP', function()
        player = xi.test.world:spawnPlayer({ job = xi.job.NIN, level = 75, zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:addItem(xi.item.KUNAI)
        player:addItem(xi.item.BRONZE_KNIFE)
        player:equipItem(xi.item.KUNAI, nil, xi.slot.MAIN)
        player:equipItem(xi.item.BRONZE_KNIFE, nil, xi.slot.SUB)
        assert(player:getEquippedItem(xi.slot.MAIN), 'main not equipped')
        assert(player:getEquippedItem(xi.slot.SUB), 'sub not equipped (DW setup failed)')

        local mainSlot = player:getItemInvSlot(xi.item.KUNAI, 1)
        local subSlot  = player:getItemInvSlot(xi.item.BRONZE_KNIFE, 1)
        assert(mainSlot, 'katana not in inventory')
        assert(subSlot, 'dagger not in inventory')

        player:setTP(1000)
        player.actions:equipSet(
        {
            { index = mainSlot, kind = xi.slot.MAIN, container = xi.inv.INVENTORY },
            { index = subSlot,  kind = xi.slot.SUB,  container = xi.inv.INVENTORY },
        })
        assert(player:getTP() == 1000, string.format('DW re-apply TP=%d', player:getTP()))
    end)

    it('dual wield: swap sub to identical second copy resets TP', function()
        player = xi.test.world:spawnPlayer({ job = xi.job.NIN, level = 75, zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:addItem(xi.item.KUNAI)
        player:addItem(xi.item.BRONZE_KNIFE)
        player:addItem(xi.item.BRONZE_KNIFE)
        player:equipItem(xi.item.KUNAI, nil, xi.slot.MAIN)
        player:equipItem(xi.item.BRONZE_KNIFE, nil, xi.slot.SUB)
        assert(player:getEquippedItem(xi.slot.SUB), 'sub not equipped')

        local secondKnife = player:getItemInvSlot(xi.item.BRONZE_KNIFE, 1)
        assert(secondKnife, 'second dagger not found')

        player:setTP(1000)
        player.actions:equipSet({ { index = secondKnife, kind = xi.slot.SUB, container = xi.inv.INVENTORY } })
        assert(player:getTP() == 0, string.format('expected reset, DW copy TP=%d', player:getTP()))
    end)

    it('offhand weapon without Dual Wield: TP kept, shield stays', function()
        player = xi.test.world:spawnPlayer({ job = xi.job.WAR, level = 75, zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:addItem(xi.item.BRONZE_SWORD)
        player:addItem(xi.item.LAUAN_SHIELD)
        player:addItem(xi.item.BRONZE_KNIFE)
        player:equipItem(xi.item.BRONZE_SWORD, nil, xi.slot.MAIN)
        player:equipItem(xi.item.LAUAN_SHIELD, nil, xi.slot.SUB)
        assert(player:getEquippedItem(xi.slot.SUB):getID() == xi.item.LAUAN_SHIELD, 'shield not equipped')

        local knifeSlot = player:getItemInvSlot(xi.item.BRONZE_KNIFE, 1)
        assert(knifeSlot, 'dagger not in inventory')

        player:setTP(1000)
        player.actions:equipSet({ { index = knifeSlot, kind = xi.slot.SUB, container = xi.inv.INVENTORY } })
        assert(player:getEquippedItem(xi.slot.SUB):getID() == xi.item.LAUAN_SHIELD, 'shield should remain equipped')
        assert(player:getTP() == 1000, string.format('TP wiped by rejected offhand, TP=%d', player:getTP()))
    end)

    it('instrument -> instrument keeps TP', function()
        player = xi.test.world:spawnPlayer({ job = xi.job.BRD, level = 75, zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:addItem(xi.item.CORNETTE)
        player:addItem(xi.item.FLUTE)
        player:equipItem(xi.item.CORNETTE, nil, xi.slot.RANGED)

        player:setTP(1000)
        player:equipItem(xi.item.FLUTE, nil, xi.slot.RANGED)
        assert(player:getTP() == 1000, string.format('instrument swap TP=%d', player:getTP()))
    end)

    it('unequipping an instrument entirely loses TP', function()
        player = xi.test.world:spawnPlayer({ job = xi.job.BRD, level = 75, zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:addItem(xi.item.CORNETTE)
        player:equipItem(xi.item.CORNETTE, nil, xi.slot.RANGED)

        player:setTP(1000)
        player:unequipItem(xi.slot.RANGED)
        assert(player:getTP() == 0, string.format('expected reset, instrument unequip TP=%d', player:getTP()))
    end)

    it('animator -> animator loses TP', function()
        player = xi.test.world:spawnPlayer({ job = xi.job.PUP, level = 75, zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:addItem(xi.item.ANIMATOR)
        player:addItem(xi.item.TURBO_ANIMATOR)
        player:equipItem(xi.item.ANIMATOR, nil, xi.slot.RANGED)

        player:setTP(1000)
        player:equipItem(xi.item.TURBO_ANIMATOR, nil, xi.slot.RANGED)
        assert(player:getTP() == 0, string.format('expected reset, animator swap TP=%d', player:getTP()))
    end)

    it('bell -> bell keeps TP', function()
        player = xi.test.world:spawnPlayer({ job = xi.job.GEO, level = 99, zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:addItem(xi.item.MATRE_BELL)
        player:addItem(xi.item.FILIAE_BELL)
        player:equipItem(xi.item.MATRE_BELL, nil, xi.slot.RANGED)

        player:setTP(1000)
        player:equipItem(xi.item.FILIAE_BELL, nil, xi.slot.RANGED)
        assert(player:getTP() == 1000, string.format('bell swap TP=%d', player:getTP()))
    end)

    it('unequipping a bell entirely loses TP', function()
        player = xi.test.world:spawnPlayer({ job = xi.job.GEO, level = 99, zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:addItem(xi.item.MATRE_BELL)
        player:equipItem(xi.item.MATRE_BELL, nil, xi.slot.RANGED)

        player:setTP(1000)
        player:unequipItem(xi.slot.RANGED)
        assert(player:getTP() == 0, string.format('expected reset, bell unequip TP=%d', player:getTP()))
    end)
end)
