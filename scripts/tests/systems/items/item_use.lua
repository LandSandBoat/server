describe('Item use', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer(
            {
                job   = xi.job.WAR,
                level = 75,
                zone  = xi.zone.SOUTHERN_SAN_DORIA,
            })
    end)

    it('idle item is in Free state', function()
        player:addItem(xi.item.POTION)
        local potion = player:findItem(xi.item.POTION)
        assert(potion)
        assert(potion:state() == xi.itemState.FREE)
    end)

    it('equipped item is in Equipped state', function()
        player:addItem(xi.item.BRONZE_SWORD)
        player:equipItem(xi.item.BRONZE_SWORD, nil, xi.slot.MAIN)

        local sword = player:findItem(xi.item.BRONZE_SWORD)
        assert(sword)
        assert(sword:state() == xi.itemState.EQUIPPED)
    end)

    it('food is InTransaction during cast then consumed and increases stats', function()
        local playerSTR = player:getStat(xi.mod.STR)

        player:addItem(xi.item.MEAT_MITHKABOB)
        local kabob = player:findItem(xi.item.MEAT_MITHKABOB)
        assert(kabob)
        assert(kabob:state() == xi.itemState.FREE)

        player.actions:useItem(player, kabob:getSlotID(), xi.inventoryLocation.INVENTORY)

        local midUse = player:findItem(xi.item.MEAT_MITHKABOB)
        assert(midUse, 'item should still be in inventory mid-cast')
        assert(midUse:state() == xi.itemState.IN_TRANSACTION,
            'expected InTransaction during cast, got ' .. tostring(midUse:state()))

        xi.test.world:skipTime(5)

        player.assert
            :hasEffect(xi.effect.FOOD)
            .no:hasItem(xi.item.MEAT_MITHKABOB)

        assert((player:getStat(xi.mod.STR) - playerSTR) == 5, 'mithkabob increases STR by 5')
    end)

    it('using charged equipment keeps it in Equipped state', function()
        local ok = player:addUsedItem(xi.item.WARP_RING)
        assert(ok)
        local ring = player:findItem(xi.item.WARP_RING)
        assert(ring)

        player:equipItem(xi.item.WARP_RING, nil, xi.slot.RING1)
        assert(player:getEquippedItem(xi.slot.RING1))

        player.actions:useItem(player, ring:getSlotID(), xi.inventoryLocation.INVENTORY)

        local midUse = player:findItem(xi.item.WARP_RING)
        assert(midUse)
        assert(midUse:state() == xi.itemState.EQUIPPED)
    end)

    it('ring enchantments stack', function()
        assert(player:addItem(xi.item.ARMORED_RING))
        assert(player:addItem(xi.item.ARMORED_RING))

        local armoredRings = player:findItems(xi.item.ARMORED_RING, xi.inv.INVENTORY)
        assert(#armoredRings == 2)

        local defense = player:getMod(xi.mod.DEF)

        player.actions:equipSet({
            { index = armoredRings[1]:getSlotID(), kind = xi.slot.RING1, container = xi.inv.INVENTORY },
            { index = armoredRings[2]:getSlotID(), kind = xi.slot.RING2, container = xi.inv.INVENTORY },
        })

        -- Wait for the enchanted items to become usable
        xi.test.world:skipTime(31)

        -- Each ring carries a base DEF+1 alongside the DEF+8 it grants when used
        assert(player:getMod(xi.mod.DEF) == defense + 2, 'both rings give their base defense')

        local function useRing(ring)
            player.actions:useItem(player, ring:getSlotID(), xi.inv.INVENTORY)
            xi.test.world:skipTime(4)
            xi.test.world:tick()
        end

        useRing(armoredRings[1])
        assert(player:getMod(xi.mod.DEF) == defense + 10, 'first ring grants its enchantment')

        useRing(armoredRings[2])
        assert(player:getMod(xi.mod.DEF) == defense + 18, 'second ring stacks its own enchantment')

        player:unequipItem(xi.slot.RING1)
        assert(player:getMod(xi.mod.DEF) == defense + 9, 'unequipped ring loses its enchantment')
        assert(player:countEffect(xi.effect.ENCHANTMENT) == 1, 'worn ring keeps its enchantment')

        player:unequipItem(xi.slot.RING2)
        assert(player:getMod(xi.mod.DEF) == defense, 'unequipping both rings restores original defense')
        assert(player:countEffect(xi.effect.ENCHANTMENT) == 0, 'unequipping both rings removes enchantments')
    end)
end)
