-----------------------------------
-- A pet left behind by its zoning master
-- The master is freed before the pet's next tick.
-----------------------------------

describe('Pet of a zoning master', function()
    it('lets go of its master and the mobs that hate it', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        local mob    = player.entities:moveTo('Wild_Rabbit')
        mob:respawn()

        player:changeJob(xi.job.BST)
        player:spawnPet(xi.petId.COLDBLOOD_COMO)
        local pet = player:getPet()
        assert(pet, 'precondition: the jug pet was called')

        mob:addEnmity(pet, 1, 1)
        assert(mob:getCE(pet) > 0, 'precondition: the rabbit hates the pet')

        -- An empty zone stops ticking, so the pet outlives its master here.
        player:gotoZone(xi.zone.LA_THEINE_PLATEAU)

        assert(pet:getMaster() == nil, 'the pet still points at its freed master')
        assert(mob:getCE(pet) == 0, 'the rabbit still hates the pet')
    end)
end)
