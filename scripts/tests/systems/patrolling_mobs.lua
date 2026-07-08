describe('Patrolling mobs', function()
    it('does not cast buffs while patrolling', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.CASTLE_OZTROJA })
        local mob    = player.entities:moveTo('Yagudo_Conductor')

        mob:respawn()
        mob:clearPath()
        mob:delStatusEffect(xi.effect.MINNE)
        mob:setSpellList(1) -- Knights Minne

        local mobPosition = mob:getPos()
        mob:pathThrough(
        {
            { x = mobPosition.x + 1, y = mobPosition.y, z = mobPosition.z },
            { x = mobPosition.x,     y = mobPosition.y, z = mobPosition.z },
        }, xi.path.flag.PATROL)

        xi.test.world:skipTime(60)

        assert(not mob:hasStatusEffect(xi.effect.MINNE), 'patrolling mob has not gained Minne')
    end)
end)
