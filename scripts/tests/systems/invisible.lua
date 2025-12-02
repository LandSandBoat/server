describe('Invisible', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer()
    end)

    local invisibleStatus =
    {
        ['INVISIBLE']  = xi.effect.INVISIBLE,
        ['HIDE']       = xi.effect.HIDE,
        ['CAMOUFLAGE'] = xi.effect.CAMOUFLAGE,
    }

    for sName, sId in pairs(invisibleStatus) do
        it(string.format('breaks on item use (%s)', sName), function()
            player:addStatusEffect(sId, 0, 10, 60)
            player:addItem(xi.item.MEAT_MITHKABOB)
            local kabob = player:findItem(xi.item.MEAT_MITHKABOB)
            assert(kabob)
            player.actions:useItem(player, kabob:getSlotID(), xi.inventoryLocation.INVENTORY)
            xi.test.world:skipTime(5)
            player.assert.no:hasEffect(sId)
                :hasEffect(xi.effect.FOOD)
        end)
    end

    it('cannot be cast on someone with Camouflage/Hide', function()
        local p2 = xi.test.world:spawnPlayer({ job = xi.job.WHM, level = 99 })
        p2:addSpell(xi.magic.spell.INVISIBLE)
        player.actions:inviteToParty(p2)
        p2.actions:acceptPartyInvite()

        player:changeJob(xi.job.THF)
        player:setLevel(99)
        player.actions:useAbility(player, xi.jobAbility.HIDE)
        xi.test.world:tickEntity(player) -- Wait for Hide to apply
        player.assert:hasEffect(xi.effect.HIDE)

        p2.actions:useSpell(player, xi.magic.spell.INVISIBLE)
        xi.test.world:tickEntity(p2) -- Start casting
        xi.test.world:skipTime(10)   -- Wait for completion

        player.assert:hasEffect(xi.effect.HIDE)
            .no:hasEffect(xi.effect.INVISIBLE)
    end)
end)
