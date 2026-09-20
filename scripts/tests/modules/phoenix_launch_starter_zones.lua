-----------------------------------
-- Tests the starter module and the original mob scripts with mock mobs and players.
-- Check reward timing and the full 15-second respawn cycle in game.
-----------------------------------
describe('Module: pxi_launch_names', function()
    local donors =
    {
        { xi.zone.WEST_RONFAURE,     'West_Ronfaure',     'Wild_Rabbit',     'Field Rabbit',    824 },
        { xi.zone.WEST_RONFAURE,     'West_Ronfaure',     'Tunnel_Worm',     'Burrowing Worm',  924, 1,  1 },
        { xi.zone.EAST_RONFAURE,     'East_Ronfaure',     'Wild_Rabbit',     'Field Rabbit',    824 },
        { xi.zone.EAST_RONFAURE,     'East_Ronfaure',     'Tunnel_Worm',     'Burrowing Worm',  924 },
        { xi.zone.NORTH_GUSTABERG,   'North_Gustaberg',   'Huge_Hornet',     'Large Hornet',    824 },
        { xi.zone.NORTH_GUSTABERG,   'North_Gustaberg',   'Tunnel_Worm',     'Burrowing Worm',  924, 16, 1 },
        { xi.zone.SOUTH_GUSTABERG,   'South_Gustaberg',   'Huge_Hornet',     'Large Hornet',    824, 76, 1 },
        { xi.zone.SOUTH_GUSTABERG,   'South_Gustaberg',   'Tunnel_Worm',     'Burrowing Worm',  924 },
        { xi.zone.WEST_SARUTABARUTA, 'West_Sarutabaruta', 'Tiny_Mandragora', 'Baby Mandragora', 824, 26, 1 },
        { xi.zone.WEST_SARUTABARUTA, 'West_Sarutabaruta', 'Bumblebee',       'Fuzzy Bumblebee', 924, 61, 2 },
        { xi.zone.EAST_SARUTABARUTA, 'East_Sarutabaruta', 'Tiny_Mandragora', 'Baby Mandragora', 824, 89, 1 },
        { xi.zone.EAST_SARUTABARUTA, 'East_Sarutabaruta', 'Bumblebee',       'Fuzzy Bumblebee', 924, 90, 1 },
    }

    local function fixture()
        local actual = { regimes = {}, gameIns = 0, overrides = 0, despawns = 0 }
        local testXi =
        {
            zone   = xi.zone,
            mod    = xi.mod,
            mobMod = xi.mobMod,
            zones  = {},
            player = {},
            regime =
            {
                type        = { FIELDS = 1 },
                checkRegime = function(player, mob, regime, count, regimeType)
                    table.insert(actual.regimes, { player, mob, regime, count, regimeType })
                end,
            },
        }

        local env   = setmetatable({ xi = testXi }, { __index = _G })
        env.require = function()
        end

        testXi.player.onGameIn = setfenv(function(player, firstLogin, zoning)
            actual.gameIns    = actual.gameIns + 1
            actual.gameInArgs = { player, firstLogin, zoning }
        end, env)

        for _, donor in ipairs(donors) do
            testXi.zones[donor[2]]                = testXi.zones[donor[2]] or { mobs = {} }
            testXi.zones[donor[2]].mobs[donor[3]] = setfenv(assert(loadfile(string.format('scripts/zones/%s/mobs/%s.lua', donor[2], donor[3]))), env)()
        end

        testXi.zones.West_Ronfaure.mobs.Wild_Rabbit.onMobDespawn = setfenv(function(mob)
            actual.despawns   = actual.despawns + 1
            actual.despawnMob = mob
        end, env)

        setfenv(assert(loadfile('modules/module_utils.lua')), env)()
        setfenv(assert(loadfile('modules/phoenix/lua/custom/pxi_launch_names.lua')), env)()

        for _, module in ipairs(testXi.module.registry) do
            assert(module.enabled)
            for _, override in ipairs(module.overrides) do
                local target = env
                local parts  = {}
                for part in override.name:gmatch('[^.]+') do
                    table.insert(parts, part)
                end

                for index = 1, #parts - 1 do
                    target = assert(target[parts[index]], override.name)
                end

                local name = parts[#parts]
                if not target[name] then
                    target[name] = setfenv(function()
                    end, env)
                end

                env.applyOverride(target, name, override.func)
                actual.overrides = actual.overrides + 1
            end
        end

        return testXi, actual
    end

    local function newMob(donor, offset)
        return
        {
            zoneId  = donor[1],
            id      = 0x1000000 + donor[1] * 0x1000 + offset,
            hp      = 10,
            spawned = true,
            spawns  = 0,
            timers  = {},
            mods    = {},
            mobMods = {},
            vars    = {},
            getID   = function(self)
                return self.id
            end,

            getZoneID = function(self)
                return self.zoneId
            end,

            isMob = function()
                return true
            end,

            getHP = function(self)
                return self.hp
            end,

            getLocalVar = function(self, name)
                return self.vars[name] or 0
            end,

            setLocalVar = function(self, name, value)
                self.vars[name] = value
            end,

            setMod = function(self, name, value)
                self.mods[name] = value
            end,

            setMobMod = function(self, name, value)
                self.mobMods[name] = value
            end,

            renameEntity = function(self, name, silent)
                self.name   = name
                self.silent = silent
            end,

            setRespawnTime = function(self, seconds)
                self.respawn = seconds
            end,

            timer = function(self, delay, callback)
                table.insert(self.timers, { delay, callback })
            end,

            isSpawned = function(self)
                return self.spawned
            end,

            spawn = function(self)
                self.spawned = true
                self.spawns  = self.spawns + 1
            end,
        }
    end

    local function newPlayer(zoneId, id)
        return
        {
            zoneId    = zoneId,
            id        = id,
            listeners = {},
            getID     = function(self)
                return self.id
            end,

            getZoneID = function(self)
                return self.zoneId
            end,

            addListener = function(self, event, name, callback)
                assert(not self.listeners[name])
                self.listeners[name] = { event, callback }
            end,

            removeListener = function(self, name)
                self.listeners[name] = nil
            end,
        }
    end

    it('preserves every donor script and names both ends of each extra block', function()
        local testXi, actual = fixture()
        assert(actual.overrides == 37)

        for _, donor in ipairs(donors) do
            local hooks = testXi.zones[donor[2]].mobs[donor[3]]
            for _, offset in ipairs({ donor[5], donor[5] + 99 }) do
                local mob = newMob(donor, offset)
                if hooks.onMobInitialize then
                    hooks.onMobInitialize(mob)
                    assert(mob.mobMods[xi.mobMod.CANNOT_GUARD] == 1)
                    assert(mob.mobMods[xi.mobMod.NO_H2H_PENALTY] == 1)
                end

                hooks.onMobSpawn(mob)
                assert(mob.name == donor[4] and mob.silent)
                assert(mob.mods[xi.mod.ATT] == 1 and mob.mods[xi.mod.EXP_LVL_MOD] == -2)
                assert(mob.mods[xi.mod.DESPAWN_TIME_REDUCTION] == 3 and mob.respawn == 0)
                assert(mob.mobMods[xi.mobMod.NO_DROPS] == 1)
                assert(mob.mobMods[xi.mobMod.NO_MOVE] == (donor[3] == 'Tunnel_Worm' and 1 or nil))

                local player        = newPlayer(donor[1], 123)
                local regimesBefore = #actual.regimes
                hooks.onMobDeath(mob, player, { isKiller = true })
                assert(mob:getLocalVar('[PXI]LaunchKiller') == 123)
                if donor[6] then
                    assert(#actual.regimes == regimesBefore + 1)
                    local regime = actual.regimes[#actual.regimes]
                    assert(regime[1] == player and regime[2] == mob)
                    assert(regime[3] == donor[6] and regime[4] == donor[7] and regime[5] == testXi.regime.type.FIELDS)
                else
                    assert(#actual.regimes == regimesBefore)
                end
            end
        end
    end)

    it('leaves native mobs and the neighboring extra block to their donor scripts', function()
        local testXi, actual = fixture()
        for _, donor in ipairs(donors) do
            local hooks = testXi.zones[donor[2]].mobs[donor[3]]
            for _, offset in ipairs({ 100, donor[5] - 1, donor[5] + 100 }) do
                local mob                               = newMob(donor, offset)
                mob.mobMods[xi.mobMod.NO_DROPS]         = 7
                mob.mobMods[xi.mobMod.NO_MOVE]          = 7
                mob.mods[xi.mod.DESPAWN_TIME_REDUCTION] = 2
                mob.respawn                             = 60
                hooks.onMobSpawn(mob)
                assert(not mob.name and mob.respawn == 60)
                assert(mob.mobMods[xi.mobMod.NO_DROPS] == 7 and mob.mods[xi.mod.DESPAWN_TIME_REDUCTION] == 2)
                assert(mob.mobMods[xi.mobMod.NO_MOVE] == 7)
                assert(mob.mods[xi.mod.ATT] == 1 and mob.mods[xi.mod.EXP_LVL_MOD] == -2)

                local regimesBefore = #actual.regimes
                hooks.onMobDeath(mob, newPlayer(donor[1], 123), { isKiller = true })
                assert(mob:getLocalVar('[PXI]LaunchKiller') == 0)
                assert(#actual.regimes == regimesBefore + (donor[6] and 1 or 0))
                mob.hp = 0
                hooks.onMobDespawn(mob)
                assert(#mob.timers == 0)
            end
        end
    end)

    it('enables loot only for the credited killer with positive combat EXP', function()
        local testXi = fixture()
        for _, donor in ipairs(donors) do
            local hooks  = testXi.zones[donor[2]].mobs[donor[3]]
            local mob    = newMob(donor, donor[5])
            local killer = newPlayer(donor[1], 123)
            local member = newPlayer(donor[1], 456)
            testXi.player.onGameIn(killer, false, true)
            local award = killer.listeners.PXI_LAUNCH_EXP[2]
            hooks.onMobSpawn(mob)
            award(killer, mob, 100)
            assert(mob.mobMods[xi.mobMod.NO_DROPS] == 1)

            hooks.onMobDeath(mob, member, { isKiller = false })
            hooks.onMobDeath(mob, killer, { isKiller = true })
            hooks.onMobDeath(mob, member, { isKiller = false })
            award(member, mob, 100)
            assert(mob.mobMods[xi.mobMod.NO_DROPS] == 1)
            award(killer, mob, 0)
            assert(mob.mobMods[xi.mobMod.NO_DROPS] == 1)
            award(killer, mob, 1)
            assert(mob.mobMods[xi.mobMod.NO_DROPS] == 0)

            hooks.onMobSpawn(mob)
            assert(mob.mobMods[xi.mobMod.NO_DROPS] == 1 and mob:getLocalVar('[PXI]LaunchKiller') == 0)
            hooks.onMobDeath(mob, nil, { noKiller = true })
            assert(mob.mobMods[xi.mobMod.NO_DROPS] == 1)
        end
    end)

    it('keeps separate killers and rewards for overlapping kills', function()
        local testXi       = fixture()
        local donor        = donors[1]
        local hooks        = testXi.zones[donor[2]].mobs[donor[3]]
        local first        = newMob(donor, 824)
        local second       = newMob(donor, 825)
        local firstKiller  = newPlayer(donor[1], 123)
        local secondKiller = newPlayer(donor[1], 456)
        testXi.player.onGameIn(firstKiller, false, true)
        local award = firstKiller.listeners.PXI_LAUNCH_EXP[2]
        hooks.onMobSpawn(first)
        hooks.onMobSpawn(second)
        hooks.onMobDeath(first, firstKiller, { isKiller = true })
        hooks.onMobDeath(second, secondKiller, { isKiller = true })
        award(firstKiller, second, 100)
        award(secondKiller, first, 100)
        assert(first.mobMods[xi.mobMod.NO_DROPS] == 1 and second.mobMods[xi.mobMod.NO_DROPS] == 1)
        award(firstKiller, first, 100)
        assert(first.mobMods[xi.mobMod.NO_DROPS] == 0 and second.mobMods[xi.mobMod.NO_DROPS] == 1)
        award(secondKiller, second, 100)
        assert(second.mobMods[xi.mobMod.NO_DROPS] == 0)
    end)

    it('ignores script EXP, non-mobs, native offsets, and other zones', function()
        local testXi = fixture()
        local donor  = donors[1]
        local player = newPlayer(donor[1], 123)
        testXi.player.onGameIn(player, false, true)
        local award = player.listeners.PXI_LAUNCH_EXP[2]
        award(player, nil, 100)
        award(player,
            {
                isMob = function()
                    return false
                end,
            }, 100)

        for _, offset in ipairs({ 823, 1024 }) do
            local mob = newMob(donor, offset)
            mob:setLocalVar('[PXI]LaunchKiller', player.id)
            award(player, mob, 100)
            assert(not mob.mobMods[xi.mobMod.NO_DROPS])
        end

        local mob  = newMob(donor, 824)
        mob.zoneId = xi.zone.GM_HOME
        mob:setLocalVar('[PXI]LaunchKiller', player.id)
        award(player, mob, 100)
        assert(not mob.mobMods[xi.mobMod.NO_DROPS])
    end)

    it('keeps one listener through starter-zone travel and removes it when leaving', function()
        local testXi, actual = fixture()
        local player = newPlayer(xi.zone.WEST_RONFAURE, 123)
        for _, donor in ipairs(donors) do
            player.zoneId = donor[1]
            testXi.player.onGameIn(player, false, true)
            testXi.player.onGameIn(player, false, true)
            assert(player.listeners.PXI_LAUNCH_EXP[1] == 'EXPERIENCE_POINTS')
            local count = 0
            for _ in pairs(player.listeners) do
                count = count + 1
            end

            assert(count == 1)
        end

        player.zoneId = xi.zone.GM_HOME
        testXi.player.onGameIn(player, true, false)
        assert(not next(player.listeners))
        assert(actual.gameIns == 25)
        assert(actual.gameInArgs[1] == player and actual.gameInArgs[2] and not actual.gameInArgs[3])
    end)

    it('queues respawn after death and leaves live administrative despawns alone', function()
        local testXi, actual = fixture()
        for _, donor in ipairs(donors) do
            local hooks = testXi.zones[donor[2]].mobs[donor[3]]
            local mob   = newMob(donor, donor[5])
            mob.spawned = false
            hooks.onMobDespawn(mob)
            assert(#mob.timers == 0 and mob.spawns == 0)

            mob.hp = 0
            hooks.onMobDespawn(mob)
            assert(#mob.timers == 1 and mob.spawns == 0)
            assert(mob.timers[1][1] == 1)
            mob.timers[1][2](mob)
            assert(mob.spawns == 1 and mob.spawned)
            mob.timers[1][2](mob)
            assert(mob.spawns == 1)
        end

        assert(actual.despawns == 2)
        assert(actual.despawnMob:getZoneID() == xi.zone.WEST_RONFAURE)
    end)
end)
