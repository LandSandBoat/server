-----------------------------------
-- Tests GM tiers and targeting.
-- See: modules/phoenix/lua/commands/gm_command_tiers.lua
-- See: modules/phoenix/lua/commands/th.lua
-- See: modules/phoenix/lua/commands/treants.lua
-----------------------------------
describe('Module: phoenix_gm_command_tiers', function()
    local function newPlayer(level, name, id)
        return
        {
            level    = level,
            name     = name or 'Caller',
            id       = id or 1,
            messages = {},
            getGMLevel = function(self)
                return self.level
            end,

            getName = function(self)
                return self.name
            end,

            getID = function(self)
                return self.id
            end,

            getCursorTarget = function(self)
                return self.target
            end,

            getZoneID = function()
                return xi.zone.WEST_RONFAURE
            end,

            getZone = function(self)
                return self.zone
            end,

            setCostume = function(self, costumeId)
                self.costume = costumeId
            end,

            printToPlayer = function(self, message, channel)
                table.insert(self.messages, { message, channel })
            end,
        }
    end

    local function newTarget(objType, alive, thLevel)
        return
        {
            reads = 0,
            getObjType = function()
                return objType
            end,

            isAlive = function()
                return alive
            end,

            getName = function()
                return 'Goblin Thug'
            end,

            getTHlevel = function(self)
                self.reads = self.reads + 1
                return thLevel
            end,
        }
    end

    local function fixture()
        local actual = { starts = 0, calls = {}, players = {}, vars = {}, writes = {}, sends = {}, spawns = 0, moogles = 0 }
        local testXi = { objType = xi.objType, msg = xi.msg, status = xi.status, zone = xi.zone, server = {} }
        local env = setmetatable({ xi = testXi }, { __index = _G })
        env.require = function()
        end

        testXi.commands = setmetatable({},
        {
            __index = function(commands, name)
                local command =
                {
                    cmdprops = { permission = -1, parameters = '' },
                    onTrigger = setfenv(function()
                        actual.calls[name] = (actual.calls[name] or 0) + 1
                    end, env),
                }
                rawset(commands, name, command)
                return command
            end,
        })
        testXi.server.onServerStart = setfenv(function()
            actual.starts = actual.starts + 1
        end, env)

        testXi.treantEvent =
        {
            zones =
            {
                [xi.zone.WEST_RONFAURE] = { zone = 'West_Ronfaure', cap = 20, hp = 100 },
            },
            cityTeleporters = { [xi.zone.SOUTHERN_SAN_DORIA] = true },
            spots = function()
                return { {} }
            end,

            currentSpot = function()
                return {}, 1
            end,

            spawnMoogles = function()
                actual.moogles = actual.moogles + 1
            end,

            spawnTreant = function()
                actual.spawns = actual.spawns + 1
            end,
        }
        env.GetPlayerByName = function(name)
            return actual.players[string.lower(name)]
        end

        env.GetServerVariable = function(name)
            return actual.vars[name] or 0
        end

        env.SetServerVariable = function(name, value)
            actual.vars[name] = value
            table.insert(actual.writes, { name, value })
        end

        env.GetSystemTime = function()
            return 1000
        end

        env.SendLuaFuncStringToZone = function(...)
            table.insert(actual.sends, { ... })
        end

        actual.zone =
        {
            getID = function()
                return xi.zone.WEST_RONFAURE
            end,

            getLocalVar = function()
                return 0
            end,
        }
        setfenv(assert(loadfile('modules/module_utils.lua')), env)()
        testXi.commands.costume = setfenv(assert(loadfile('scripts/commands/costume.lua')), env)()
        setfenv(assert(loadfile('modules/phoenix/lua/commands/th.lua')), env)()
        setfenv(assert(loadfile('modules/phoenix/lua/commands/treants.lua')), env)()
        for _, entry in ipairs(testXi.module.commandRegistry) do
            testXi.commands[entry.name] = entry.command
        end

        setfenv(assert(loadfile('modules/phoenix/lua/commands/gm_command_tiers.lua')), env)()
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

                env.applyOverride(target, parts[#parts], override.func)
            end
        end

        return testXi, actual
    end

    it('applies permissions at server start and preserves the original startup hook', function()
        local testXi, actual = fixture()
        assert(testXi.commands.costume.cmdprops.parameters == 'i')
        assert(testXi.commands.uptime.cmdprops.permission == -1)
        assert(testXi.commands.treants.cmdprops.permission == 5)
        testXi.server.onServerStart()
        assert(actual.starts == 1)
        assert(testXi.commands.costume.cmdprops.parameters == 'is')
        assert(testXi.commands.uptime.cmdprops.permission == 0)
        assert(testXi.commands.debuginfo.cmdprops.permission == 0)
        assert(testXi.commands.TH.cmdprops.permission == 0)
        assert(testXi.commands.th.cmdprops.permission == 0)
        assert(testXi.commands.treants.cmdprops.permission == 5)
        assert(testXi.commands.jail.cmdprops.permission == 2)
        assert(testXi.commands.additem.cmdprops.permission == 4)
        assert(testXi.commands.exec.cmdprops.permission == 5)
        for _, name in ipairs({ 'delkeyitem', 'delmission', 'delquest', 'dynaplayer', 'rdyna' }) do
            assert(testXi.commands[name].cmdprops.permission == 3, name)
        end
    end)

    it('reapplies startup metadata without losing the original startup hook', function()
        local testXi, actual = fixture()
        testXi.server.onServerStart()
        testXi.commands.uptime.cmdprops.permission = 1
        testXi.commands.costume.cmdprops.parameters = 'i'
        testXi.server.onServerStart()
        assert(actual.starts == 2)
        assert(testXi.commands.uptime.cmdprops.permission == 0)
        assert(testXi.commands.costume.cmdprops.parameters == 'is')
    end)

    it('rejects all lower tiers even if permission metadata becomes less restrictive', function()
        local testXi, actual = fixture()
        testXi.server.onServerStart()
        for name, command in pairs(testXi.commands) do
            local permission = command.cmdprops.permission
            command.cmdprops.permission = 0
            for level = 0, permission - 1 do
                local player = newPlayer(level)
                command.onTrigger(player)
                assert(not actual.calls[name], name)
                assert(#player.messages == 1, name)
                assert(player.messages[1][1] == string.format('Tier %i is required to use !%s.', permission, name), name)
            end
        end
    end)

    it('allows every command at its assigned tier and all higher tiers', function()
        local testXi, actual = fixture()
        testXi.server.onServerStart()
        for name, command in pairs(testXi.commands) do
            if name ~= 'costume' and command ~= testXi.commands.TH and name ~= 'treants' then
                for level = command.cmdprops.permission, 5 do
                    command.onTrigger(newPlayer(level))
                end

                assert(actual.calls[name] == 6 - command.cmdprops.permission, name)
            end
        end
    end)

    it('keeps unnamed costume calls on the caller regardless of cursor target', function()
        local testXi = fixture()
        for level = 1, 5 do
            local player = newPlayer(level)
            local other = newPlayer(0, 'Other', 2)
            player.target = other
            testXi.commands.costume.onTrigger(player, 123)
            assert(player.costume == 123 and other.costume == nil)
        end
    end)

    it('allows an explicit own name at every staff tier', function()
        local testXi, actual = fixture()
        for level = 1, 5 do
            local player = newPlayer(level)
            actual.players.caller = player
            testXi.commands.costume.onTrigger(player, 123, 'cAlLeR')
            assert(player.costume == 123)
        end
    end)

    it('allows named costume targets only at T3 and above', function()
        local testXi, actual = fixture()
        for level = 1, 5 do
            local player = newPlayer(level)
            local other = newPlayer(0, 'Other', 2)
            actual.players.other = other
            testXi.commands.costume.onTrigger(player, 123, 'Other')
            assert(player.costume == nil)
            if level < 3 then
                assert(other.costume == nil and #player.messages > 0)
            else
                assert(other.costume == 123)
            end
        end
    end)

    it('rejects invalid costume IDs and missing named players without changing anyone', function()
        local testXi, actual = fixture()
        local player = newPlayer(5)
        local other = newPlayer(0, 'Other', 2)
        actual.players.other = other
        testXi.commands.costume.onTrigger(player, nil, 'Other')
        testXi.commands.costume.onTrigger(player, -1, 'Other')
        testXi.commands.costume.onTrigger(player, 123, 'Offline')
        assert(player.costume == nil and other.costume == nil and #player.messages >= 3)
        testXi.commands.costume.onTrigger(player, 0, 'Other')
        assert(other.costume == 0)
    end)

    it('reports current TH with either spelling including zero privately to an ordinary player', function()
        local testXi = fixture()
        for _, name in ipairs({ 'TH', 'th' }) do
            for _, thLevel in ipairs({ 0, 3, 8 }) do
                local player = newPlayer(0)
                player.target = newTarget(xi.objType.MOB, true, thLevel)
                testXi.commands[name].onTrigger(player)
                assert(#player.messages == 1 and player.target.reads == 1)
                assert(player.messages[1][1] == 'Goblin Thug: Treasure Hunter ' .. thLevel)
                assert(player.messages[1][2] == xi.msg.channel.SYSTEM_3)
            end
        end
    end)

    it('requires a living mob before reading TH', function()
        local testXi = fixture()
        local player = newPlayer(0)
        testXi.commands.TH.onTrigger(player)
        assert(#player.messages == 1)
        for _, target in ipairs(
        {
            newTarget(xi.objType.MOB, false, 3),
            newTarget(xi.objType.PC, true, 3),
            newTarget(xi.objType.NPC, true, 3),
            newTarget(xi.objType.PET, true, 3),
        }) do
            player.target = target
            testXi.commands.TH.onTrigger(player)
            assert(target.reads == 0)
        end

        assert(#player.messages == 5)
        for _, message in ipairs(player.messages) do
            assert(message[1] == 'Target a living mob to check its Treasure Hunter level.')
            assert(message[2] == xi.msg.channel.SYSTEM_3)
        end
    end)

    it('lets T5 read treant status without changing the event', function()
        local testXi, actual = fixture()
        local player = newPlayer(5)
        testXi.server.onServerStart()
        assert(testXi.commands.treants.cmdprops.permission == 5)
        testXi.commands.treants.onTrigger(player)
        testXi.commands.treants.onTrigger(player, 'status')
        assert(#player.messages == 4)
        assert(#actual.writes == 0 and #actual.sends == 0 and actual.spawns == 0 and actual.moogles == 0)
    end)

    it('blocks all treant actions below T5 without side effects', function()
        local testXi, actual = fixture()
        actual.vars['[TreantEvent]Started'] = 100
        testXi.commands.treants.cmdprops.permission = 0
        for level = 0, 4 do
            local player = newPlayer(level)
            player.zone = actual.zone
            testXi.commands.treants.onTrigger(player)
            for _, action in ipairs({ 'status', 'spawn', 'start', 'reset', 'complete', 'START', 'spawn extra', 'reset;complete' }) do
                testXi.commands.treants.onTrigger(player, action)
            end

            assert(#player.messages == 9)
            for _, message in ipairs(player.messages) do
                assert(message[1] == 'Tier 5 is required to use !treants.')
            end
        end

        assert(actual.vars['[TreantEvent]Started'] == 100)
        assert(#actual.writes == 0 and #actual.sends == 0 and actual.spawns == 0 and actual.moogles == 0)
    end)

    it('allows T5 to spawn a treant during a running event', function()
        local testXi, actual = fixture()
        local player = newPlayer(5)
        player.zone = actual.zone
        actual.vars['[TreantEvent]Started'] = 100
        testXi.commands.treants.onTrigger(player, 'spawn')
        assert(actual.spawns == 1 and actual.moogles == 1)
    end)

    it('allows T5 to start reset and complete the treant event', function()
        local testXi, actual = fixture()
        local player = newPlayer(5)
        testXi.commands.treants.onTrigger(player, 'start')
        assert(actual.vars['[TreantEvent]Started'] == 1000 and #actual.sends == 2)
        testXi.commands.treants.onTrigger(player, 'reset')
        assert(actual.vars['[TreantEvent]Started'] == 0 and actual.vars['[TreantEvent]Complete'] == 0)
        assert(#actual.sends == 4)
        testXi.commands.treants.onTrigger(player, 'complete')
        assert(actual.vars['[TreantEvent]Started'] == 1000 and actual.vars['[TreantEvent]Complete'] == 1000)
        assert(actual.vars['[TreantEvent]Dead_' .. xi.zone.WEST_RONFAURE] == 1000 and #actual.sends == 5)
    end)

    it('rejects unknown treant actions without changing the event', function()
        local testXi, actual = fixture()
        for _, action in ipairs({ 'START', 'spawn extra', 'reset;complete' }) do
            local player = newPlayer(5)
            testXi.commands.treants.onTrigger(player, action)
            assert(#player.messages == 1 and player.messages[1][1]:find('Usage:', 1, true))
        end

        assert(#actual.writes == 0 and #actual.sends == 0 and actual.spawns == 0 and actual.moogles == 0)
    end)
end)
