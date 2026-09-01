-----------------------------------
-- EXP loss is decided by the circumstances of the death
-----------------------------------

describe('EXP loss on death', function()
    ---@type CClientEntityPair
    local player

    local function die(params)
        player:die(params)
        xi.test.world:tickEntity(player)

        assert(player:isDead(), 'precondition: the player should be dead')
    end

    before_each(function()
        -- An operator can switch EXP loss off entirely, which would make every assertion below pass for the wrong reason
        xi.test.world:setSetting('map.EXP_RETAIN', 0)
        xi.test.world:setSetting('map.EXP_LOSS_RATE', 1)
        xi.test.world:setSetting('map.EXP_LOSS_LEVEL', 31)

        player = xi.test.world:spawnPlayer({ zone = xi.zone.IFRITS_CAULDRON, level = 50 })
        player:setCharVar('expLost', 0)
    end)

    it('a normal death costs EXP', function()
        die()

        assert(player:getCharVar('expLost') > 0, 'a normal death should cost EXP')
    end)

    it('a death while charmed is free', function()
        local mob = player.entities:get('Volcanic_Bomb')
        mob:respawn()
        mob:charm(player)

        assert(player:isCharmed(), 'precondition: the player should be charmed')

        die()

        -- "Players will no longer lose experience points if KO'd while charmed." - June 2007 version update
        assert(player:getCharVar('expLost') == 0, 'a death while charmed should not cost EXP')
    end)

    it('a death with expLoss off is free', function()
        die({ expLoss = false })

        assert(player:getCharVar('expLost') == 0, 'a death with expLoss = false should not cost EXP')
    end)
end)
