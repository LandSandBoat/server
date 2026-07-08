describe('AoE Listeners', function()
    ---@type CClientEntityPair
    local player

    ---@type CTestEntity
    local mob1

    ---@type CTestEntity
    local mob2

    before_each(function()
        player = xi.test.world:spawnPlayer(
        {
            zone  = xi.zone.WEST_RONFAURE,
            job   = xi.job.BLM,
            level = 99,
        })

        mob1 = player.entities:moveTo('Wild_Rabbit')
        mob2 = player.entities:moveTo('Wild_Sheep')

        local pos = player:getPos()
        mob1:setPos(pos.x, pos.y, pos.z)
        mob2:setPos(pos.x, pos.y, pos.z)
    end)

    it('fires MAGIC_TAKE on all targets of an AoE spell', function()
        local mob1Hit = false
        local mob2Hit = false

        mob1:addListener('MAGIC_TAKE', 'TEST_MAGIC_TAKE_1', function()
            mob1Hit = true
        end)

        mob2:addListener('MAGIC_TAKE', 'TEST_MAGIC_TAKE_2', function()
            mob2Hit = true
        end)

        player:addSpell(xi.magic.spell.FIRAGA)
        player.actions:useSpell(mob1, xi.magic.spell.FIRAGA)
        xi.test.world:tickEntity(player)
        xi.test.world:skipTime(10)

        assert(mob1Hit, 'MAGIC_TAKE should fire on primary target')
        assert(mob2Hit, 'MAGIC_TAKE should fire on AoE subtarget')

        mob1:removeListener('TEST_MAGIC_TAKE_1')
        mob2:removeListener('TEST_MAGIC_TAKE_2')
    end)
end)
