-- Test ensures item level pets do not dirty EXP calculations for their masters.
describe('item level pets do not dirty EXP', function()
    ---@type CClientEntityPair
    local player

    ---@type CTestEntity
    local mob

    before_each(function()
        player = xi.test.world:spawnPlayer(
            {
                job   = xi.job.PUP,
                level = 99,
                zone  = xi.zone.CEIZAK_BATTLEGROUNDS,
            })

        mob = player.entities:moveTo('Blanched_Mandragora')
        mob:setLevelRange(100, 100)
        mob:respawn()
        player:setUnkillable(true)
    end)

    it('survives a pet that outlevels its master', function()
        player:addItem(xi.item.MAGNETO)
        player:equipItem(xi.item.MAGNETO, nil, xi.slot.RANGED)
        player:spawnPet(xi.petId.AUTOMATON)

        local pet = player:getPet()
        assert(pet)
        assert(pet:getMainLvl() == 117,
            string.format('expected a level 117 automaton, got %d', pet:getMainLvl()))

        stub('xi.combat.physicalHitRate.getPhysicalHitRate', 1) -- Sets the hit rate to 100%

        pet:engage(mob:getTargID())

        for _ = 1, 4 do
            xi.test.world:tickEntity(pet)
            xi.test.world:skipTime(5)
        end

        assert(player:checkKillCredit(mob), 'master still gets credit for defeating the mob')
    end)
end)
