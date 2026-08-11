describe('Entity data store', function()
    ---@type CClientEntityPair
    local player

    -- Two Wild_Rabbit spawn points in West Ronfaure. Same zone, same script name, so they share a
    -- script object and would share a data table if it were not keyed per entity.
    local firstRabbitId  = 17186822
    local secondRabbitId = 17186823

    local function respawn(mob)
        player:claimAndKillMob(mob)
        xi.test.world:skipTime(305)
        xi.test.world:tick(xi.tick.SPAWN)
        mob.assert:isSpawned()
    end

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
    end)

    it('stores and reads back a value', function()
        local mob = player.entities:moveTo('Forest_Funguar')

        local data    = mob:getData()
        data.duration = 150

        assert(mob:getData().duration == 150, 'expected the stored duration back')
    end)

    it('returns nil for a key that was never written', function()
        local mob  = player.entities:moveTo('Forest_Funguar')
        local data = mob:getData()

        assert(data.neverWritten == nil, 'expected nil for an absent key')
        assert((data.neverWritten or 400) == 400, 'expected the `or default` idiom to work')
    end)

    it('stores values a local var cannot hold', function()
        local mob = player.entities:moveTo('Forest_Funguar')

        local data    = mob:getData()
        data.percent  = 0.02
        data.label    = 'seaspray'
        data.noDispel = true
        data.shuffle  = { 3, 1, 2 }

        local read = mob:getData()

        assert(read.percent == 0.02, 'expected a float back unchanged')
        assert(read.label == 'seaspray', 'expected a string back unchanged')
        assert(read.noDispel == true, 'expected a boolean back unchanged')
        assert(read.shuffle[2] == 1, 'expected a table back unchanged')
    end)

    it('gives a shared script its own sub-table', function()
        local mob = player.entities:moveTo('Forest_Funguar')

        -- How a mob tunes a move it shares with every other user of that move. Two consumers get
        -- their own namespace, so neither has to tag its keys to avoid the other.
        mob:getData().seaspray = { percent = 0.02 }
        mob:getData().batterhorn = { power = 4.0 }

        -- How the shared script reads it. It runs against any mob, most of which will have tuned
        -- nothing, so the empty-table fallback is the normal path rather than an edge case.
        local seaspray = mob:getData().seaspray or {}
        local untuned  = mob:getData().neverTuned or {}

        assert(seaspray.percent == 0.02, 'expected the mob-specific value')
        assert(mob:getData().batterhorn.power == 4.0, 'expected the other group to be untouched')
        assert((untuned.power or 0.125) == 0.125, 'expected an untuned mob to fall back to its default')
    end)

    it('hands back the same table each call', function()
        local mob = player.entities:moveTo('Forest_Funguar')

        mob:getData().stage = 1

        assert(mob:getData() == mob:getData(), 'expected the same table object')
        assert(mob:getData().stage == 1, 'expected a write through one handle to be visible on another')
    end)

    it('keeps separate tables for two mobs sharing a script name', function()
        local first  = player.entities:get(firstRabbitId)
        local second = player.entities:get(secondRabbitId)

        assert(first, 'expected the first Wild_Rabbit')
        assert(second, 'expected the second Wild_Rabbit')
        assert(first:getName() == second:getName(), 'expected both mobs to share a script name')

        first:getData().shared  = 1
        second:getData().shared = 2

        assert(first:getData().shared == 1, 'first mob kept its own value')
        assert(second:getData().shared == 2, 'second mob kept its own value')
        assert(first:getData() ~= second:getData(), 'expected two distinct tables')
    end)

    it('wipes the data on spawn', function()
        local mob = player.entities:moveTo('Forest_Funguar')

        mob:getData().stage = 3
        assert(mob:getData().stage == 3, 'expected the value before the respawn')

        respawn(mob)

        assert(mob:getData().stage == nil, 'a respawned mob must not read its previous life')
    end)

    it('replaces the table on spawn rather than emptying it', function()
        local mob = player.entities:moveTo('Forest_Funguar')

        -- Documents the one rule this API asks of callers: do not hold the table across a spawn.
        -- A captured handle keeps pointing at the table the wipe replaced, so writes to it are
        -- invisible to everyone who asks the entity for its data afterwards.
        local stale = mob:getData()
        stale.stage = 1

        respawn(mob)

        stale.stage = 2

        assert(mob:getData().stage == nil, 'writes through a stale handle must not reach the live table')
        assert(mob:getData() ~= stale, 'expected a different table after the wipe')
    end)

    it('resetData drops everything', function()
        local mob = player.entities:moveTo('Forest_Funguar')

        local data = mob:getData()
        data.a     = 1
        data.b     = 2

        mob:resetData()

        assert(mob:getData().a == nil, 'expected the first key gone')
        assert(mob:getData().b == nil, 'expected the second key gone')
    end)

    it('leaves declared script configuration alone', function()
        local mob = player.entities:moveTo('Forest_Funguar')

        -- Configuration declared by a mob script lives on the script object, beside the handlers,
        -- not in the per-entity data. It has to survive a spawn wipe.
        local scriptObject = xi.zones[mob:getZoneName()].mobs[mob:getName()]
        assert(scriptObject, 'expected a cached script object for the mob')

        scriptObject.declaredConfig = { duration = 150 }
        mob:getData().stage         = 1

        respawn(mob)

        assert(scriptObject.declaredConfig.duration == 150, 'declared config must survive a spawn')
        assert(mob:getData().stage == nil, 'runtime state must not')

        scriptObject.declaredConfig = nil
    end)

    it('keeps separate tables for two concurrent instances', function()
        -- The case that decided the key. Mobs in two runs of the same instance carry identical
        -- long IDs, because instance_loader reads them from mob_spawn_points, so anything keyed on
        -- the ID alone would merge these two tables.
        local playerOne = xi.test.world:spawnPlayer({ zone = xi.zone.ALZADAAL_UNDERSEA_RUINS })
        local playerTwo = xi.test.world:spawnPlayer({ zone = xi.zone.ALZADAAL_UNDERSEA_RUINS })

        -- An instance is not ready until it has been ticked, so tick each one in.
        playerOne:createInstance(7702)
        xi.test.world:tick(xi.tick.TIME)

        playerTwo:createInstance(7702)
        xi.test.world:tick(xi.tick.TIME)

        local instanceOne = playerOne:getInstance()
        local instanceTwo = playerTwo:getInstance()
        assert(instanceOne, 'expected the first player to be in an instance')
        assert(instanceTwo, 'expected the second player to be in an instance')

        local function findAlexander(instance)
            for _, mob in pairs(instance:getMobs()) do
                if mob:getName() == 'Alexander_WTC' then
                    return mob
                end
            end

            return nil
        end

        local mobOne = findAlexander(instanceOne)
        local mobTwo = findAlexander(instanceTwo)
        assert(mobOne and mobTwo, 'expected Alexander_WTC in both instances')
        assert(mobOne:getID() == mobTwo:getID(), 'expected both copies to share a long ID')

        mobOne:getData().stage = 1
        mobTwo:getData().stage = 2

        assert(mobOne:getData().stage == 1, 'first instance kept its own value')
        assert(mobTwo:getData().stage == 2, 'second instance kept its own value')
    end)
end)
