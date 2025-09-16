describe('Test lifecycle', function()
    describe('setup()', function()
        ---@type CClientEntityPair
        local player

        setup(function()
            player = xi.test.world:spawnPlayer(
                {
                    zone = xi.zone.WEST_RONFAURE,
                    job = xi.job.WHM,
                })
        end)

        describe('executes', function()
            setup(function()
                player:setLevel(99)
            end)

            it('top-level executed', function()
                assert(player:getMainJob() == xi.job.WHM, 'Expected job to be WHM')
            end)

            it('inner-level executed', function()
                assert(player:getMainLvl() == 99, 'Expected level to be 99')
                -- Prepare for next test
                player:setLevel(75)
            end)

            it('setup did not re-execute', function()
                assert(player:getMainLvl() == 75, 'Expected level to be 75')
            end)
        end)
    end)

    describe('teardown()', function()
        ---@type CClientEntityPair
        local player

        setup(function()
            player = xi.test.world:spawnPlayer(
                {
                    zone = xi.zone.WEST_RONFAURE,
                    job = xi.job.WHM,
                })
        end)

        it('runs', function()
        end)

        teardown(function()
            -- Can't really assert at that point
            player:changeJob(xi.job.WAR)
        end)
    end)

    describe('before_each()', function()
        ---@type CClientEntityPair
        local player
        local currentLevel
        local currentJob

        before_each(function()
            player = xi.test.world:spawnPlayer(
                {
                    zone  = xi.zone.WEST_RONFAURE,
                    job   = xi.job.WHM,
                    level = math.random(1, 99),
                })

            if currentLevel and player:getMainLvl() == currentLevel then
                player:setLevel(math.min((currentLevel + 1) % 99, 1)) -- Change level if same as last time
            end
        end)

        describe('executes', function()
            before_each(function()
                while true do
                    player:changeJob(utils.randomEntry(xi.job))
                    if player:getMainJob() ~= currentJob then
                        break
                    end
                end
            end)

            it('first case job/level', function()
                currentLevel = player:getMainLvl()
                currentJob = player:getMainJob()
                assert(currentLevel)
                assert(currentJob)
            end)

            it('is different from second case', function()
                assert(player:getMainLvl() ~= currentLevel)
                assert(player:getMainJob() ~= currentJob)
            end)
        end)
    end)

    describe('after_each()', function()
        ---@type CClientEntityPair
        local player

        setup(function()
            player = xi.test.world:spawnPlayer(
                {
                    zone  = xi.zone.WEST_RONFAURE,
                    job   = xi.job.WHM,
                    level = 99,
                })
        end)

        after_each(function()
            player:setLevel(player:getMainLvl() - 1)
        end)

        describe('executes', function()
            after_each(function()
                player:setLevel(player:getMainLvl() - 1)
            end)

            it('has not executed yet', function()
                assert(player:getMainLvl() == 99, 'Expected to be level 99')
            end)

            it('has executed', function()
                assert(player:getMainLvl() == 97, 'Expected to be level 97')
            end)
        end)
    end)
end)
