describe('Pet cleanup', function()
    it('handles a pending area attack when the pet owner zones out', function()
        -- Keep the zone active after the owner leaves.
        local observer = xi.test.world:spawnPlayer(
            {
                zone  = xi.zone.DRAGONS_AERY,
                job   = xi.job.WAR,
                level = 1,
            })
        observer:setUnkillable(true)

        local player = xi.test.world:spawnPlayer(
            {
                zone  = xi.zone.DRAGONS_AERY,
                job   = xi.job.DRG,
                level = 1,
            })
        player:setUnkillable(true)
        player.actions:useAbility(player, xi.jobAbility.CALL_WYVERN)
        xi.test.world:tickEntity(player)

        local pet = player:getPet()
        assert(pet, 'Call Wyvern did not create a pet')
        local petId = pet:getID()

        local fafnir = player.entities:moveTo('Fafnir')
        pet:setPos(player:getPos())
        fafnir:spawn()
        fafnir:updateClaim(player)
        fafnir:setTP(3000)
        fafnir:useMobAbility(952, pet, 2000) -- Spike Flail
        xi.test.world:tickEntity(fafnir)
        assert(fafnir:getCurrentAction() == xi.action.category.MOBABILITY_USING,
            'Fafnir did not ready Spike Flail')

        player:gotoZone(xi.zone.GM_HOME)
        assert(player:getPet() == nil, 'Player still has a pet after zoning')
        assert(GetEntityByID(petId, nil, true) == nil, 'Old pet is still registered')

        xi.test.world:skipTime(10)
        assert(fafnir:getCurrentAction() ~= xi.action.category.MOBABILITY_USING,
            'Spike Flail did not finish')
        fafnir:despawn()
    end)
end)
