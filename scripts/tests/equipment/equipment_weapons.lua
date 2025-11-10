-----------------------------------
-- Equipment Weapon TP Reset Tests
-- Tests that TP is reset when equipping/unequipping weapons from various slots
-----------------------------------

describe('Equipment Weapons - Verify TP reset on weapon slot changes', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({
            level = 50,
            job = xi.job.WAR,
            zone = xi.zone.WEST_RONFAURE
        })
    end)

    it('should reset TP when unequipping main hand weapon', function()
        player:addItem(xi.item.BRONZE_DAGGER)
        player:equipItem(xi.item.BRONZE_DAGGER, nil, xi.slot.MAIN)
        player:setTP(2500)

        player:unequipItem(xi.slot.MAIN)

        assert(player:getTP() == 0, 'TP should reset to 0 when unequipping main hand weapon')
    end)

    it('should reset TP when swapping main hand weapon', function()
        player:addItem(xi.item.BRONZE_DAGGER)
        player:addItem(xi.item.BRASS_DAGGER)
        player:equipItem(xi.item.BRONZE_DAGGER, nil, xi.slot.MAIN)
        player:setTP(1800)

        -- Swap main hand weapon (triggers unequip + equip)
        player:equipItem(xi.item.BRASS_DAGGER, nil, xi.slot.MAIN)

        assert(player:getTP() == 0, 'TP should reset to 0 when swapping main hand weapon')
    end)

    it('should reset TP when unequipping ranged weapon', function()
        player:addItem(xi.item.LONGBOW)
        player:equipItem(xi.item.LONGBOW, nil, xi.slot.RANGED)
        player:setTP(2200)

        player:unequipItem(xi.slot.RANGED)

        assert(player:getTP() == 0, 'TP should reset to 0 when unequipping ranged weapon')
    end)
end)
