describe('BST', function()
    local client, player

    before_each(function()
        client, player = xi.test.world:spawnPlayer({ zone = xi.zone.BUBURIMU_PENINSULA })
        player:changeJob(xi.job.BST)
        player:setLevel(99)
    end)

    describe('charmed mobs', function()
        it('uncharms upon zoning', function()
            local sylvestre = player:getZone():queryEntitiesByName('Sylvestre')[1]

            assert.is_not_nil(sylvestre)
            sylvestre:spawn()

            client:gotoEntity(sylvestre)

            -- TODO: this useAbility does not work
            client:useAbility(sylvestre, xi.jobAbility.CHARM)
            xi.test.world:tick()

            if not sylvestre:isCharmed() then
                player:charm(sylvestre, 100)
            end

            assert.is_true(sylvestre:isCharmed())

            client:gotoZone(xi.zone.TAHRONGI_CANYON)
            assert.is_false(sylvestre:isCharmed())
        end)
    end)
end)
