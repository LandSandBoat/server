-----------------------------------
-- Dual Wield Trait tests
--
-- These tests verify that TP is reset when appropriate, but
-- preserved when it should be (i.e. when offhand equip fails due to the lack of the Dual Wield trait)
-----------------------------------

describe('Dual Wield Trait - TP Reset on equipment change success or failure', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        -- Spawn NIN5 (before DW unlocks at level 10)
        player = xi.test.world:spawnPlayer({
            level = 5,
            job = xi.job.NIN,
            zone = xi.zone.WEST_RONFAURE
        })
    end)

    it('should preserve TP when offhand equip fails without Dual Wield trait', function()
        player:addItem(xi.item.BRONZE_DAGGER)
        player:addItem(xi.item.BRASS_DAGGER)
        player:equipItem(xi.item.BRONZE_DAGGER, nil, xi.slot.MAIN)
        player:setTP(1500)

        -- Try to equip offhand weapon without Dual Wield trait
        -- This should fail validation and NOT change TP
        player:equipItem(xi.item.BRASS_DAGGER, nil, xi.slot.SUB)

        assert(player:getTP() == 1500, 'TP should be preserved when offhand equip fails without Dual Wield trait')
    end)

    it('should preserve shield and TP when offhand weapon equip fails without Dual Wield trait', function()
        player:changeJob(xi.job.WAR)
        player:setLevel(50)

        player:addItem(xi.item.BRONZE_SWORD)
        player:addItem(xi.item.BUCKLER)
        player:addItem(xi.item.LONGSWORD)
        player:equipItem(xi.item.BRONZE_SWORD, nil, xi.slot.MAIN)
        player:equipItem(xi.item.BUCKLER, nil, xi.slot.SUB)
        player:setTP(2000)

        -- Verify shield is equipped before test action
        local shieldBefore = player:getEquippedItem(xi.slot.SUB)
        assert(shieldBefore ~= nil, 'Shield should be equipped before weapon equip attempt')
        assert(shieldBefore:getID() == xi.item.BUCKLER, 'Buckler should be equipped in SUB slot')

        -- Try to equip offhand weapon without Dual Wield trait (WAR can't dual wield)
        player:equipItem(xi.item.LONGSWORD, nil, xi.slot.SUB)

        local shieldAfter = player:getEquippedItem(xi.slot.SUB)
        assert(shieldAfter ~= nil, 'Shield should still be equipped after failed weapon equip')
        assert(shieldAfter:getID() == xi.item.BUCKLER, 'Buckler should remain equipped in SUB slot')
        assert(player:getTP() == 2000, 'TP should be preserved')
    end)

    it('should reset TP when dual wield equip succeeds with Dual Wield trait', function()
        player:setLevel(10)
        player:addItem(xi.item.BRONZE_DAGGER)
        player:addItem(xi.item.BRASS_DAGGER)
        player:equipItem(xi.item.BRONZE_DAGGER, nil, xi.slot.MAIN)
        player:setTP(1500)

        -- This should succeed and reset TP
        player:equipItem(xi.item.BRASS_DAGGER, nil, xi.slot.SUB)

        assert(player:getTP() == 0, 'TP should be reset to 0 when offhand weapon equip succeeds with Dual Wield')
    end)


    it('should reset TP when unequipping offhand weapon', function()
        player:setLevel(10)
        player:addItem(xi.item.BRONZE_DAGGER)
        player:addItem(xi.item.BRASS_DAGGER)
        player:equipItem(xi.item.BRONZE_DAGGER, nil, xi.slot.MAIN)
        player:equipItem(xi.item.BRASS_DAGGER, nil, xi.slot.SUB)
        player:setTP(3000)

        player:unequipItem(xi.slot.SUB)

        assert(player:getTP() == 0, 'TP should reset to 0 when unequipping offhand weapon')
    end)
end)
