-- Loads the real lottery helper, mob scripts, and module with mocked engine bindings.
describe('Module: timed NM persistence - Fraelissa and Fradubio', function()
    local function enum()
        return setmetatable({},
        {
            __index = function(_, key)
                return key
            end,
        })
    end

    local function newWorld(stored, clock)
        local world = { vars = stored or {}, now = clock or 1000000, win = false, trace = {}, mobs = {} }
        local env = setmetatable({}, { __index = _G })
        local xi = { zone = enum(), zones = { Jugner_Forest = { mobs = {}, Zone = {} } },
            mod = enum(), mobMod = enum(), element = enum(), effect = enum(), subEffect = enum(),
            msg = { basic = enum() }, vanaTime = { DAY = 86400, HOUR = 3600 },
            settings = { main = { NM_LOTTERY_CHANCE = 1, NM_LOTTERY_COOLDOWN = 1 } } }
        env.xi = xi
        local unrelatedMobs = setmetatable({ ODQAN = { 1, 2 } },
        {
            __index = function()
                return 1
            end,
        })
        env.zones = setmetatable({ JUGNER_FOREST = { mob = { FRAELISSA = 17203447, FRADUBIO = 17203448 } } },
        {
            __index = function()
                return { mob = unrelatedMobs }
            end,
        })
        env.require = function()
        end

        env.utils =
        {
            randomEntry = function(values)
                return values[1]
            end,
        }
        env.math = setmetatable(
        {
            randomInt = function(low, high)
                if low == 1 and high == 1000 then
                    return world.win and 1 or 1000
                end

                if low == 3600 and high == 4500 then
                    return world.window or low
                end

                return low
            end,
        }, { __index = math })

        env.GetSystemTime = function()
            return world.now
        end

        env.VanadielTime = function()
            return world.now
        end

        env.VanadielHour = function()
            return 12
        end

        env.GetServerVariable = function(key)
            return world.vars[key] or 0
        end

        env.SetServerVariable = function(key, value)
            world.vars[key] = value
        end

        env.GetMobByID = function(id)
            return world.mobs[id]
        end

        env.GetMobRespawnTime = function(id)
            return assert(world.mobs[id]).base
        end

        env.DisallowRespawn = function(id, disallow)
            assert(world.mobs[id]).allowed = not disallow
        end

        local methods = {}
        function methods:getID()
            return self.id
        end

        function methods:getName()
            return self.name
        end

        function methods:getZoneName()
            return 'Jugner_Forest'
        end

        function methods:getLocalVar(key)
            return self.vars[key] or 0
        end

        function methods:setLocalVar(key, value)
            self.vars[key] = value
        end

        function methods:setMod(key, value)
            self.mods[key] = value
        end

        function methods:setMobMod(key, value)
            self.mods[key] = value
        end

        function methods:getMobMod(key)
            return self.mods[key] or 0
        end

        function methods:isSpawned()
            return self.spawned
        end

        function methods:isAlive()
            return self.spawned
        end

        function methods:getSpawnSlotMobs()
            return {}
        end

        function methods:setSpawn(...)
            self.position = { ... }
        end

        function methods:getRespawnTime()
            return self.pending and math.max(0, self.pending - world.now) or 0
        end

        function methods:setRespawnTime(seconds)
            self.base = seconds
            self.allowed = seconds > 0
            if seconds == 0 then
                self.pending = nil
            elseif not self.spawned then
                self.pending = world.now + seconds
            end
        end

        function methods:removeListener(name)
            if self.triggering then
                self.deferred[name] = true
                return
            end

            for _, list in pairs(self.listeners) do
                for index = #list, 1, -1 do
                    if list[index].name == name then
                        table.remove(list, index)
                    end
                end
            end
        end

        function methods:addListener(event, name, callback)
            self:removeListener(name)
            self.listeners[event] = self.listeners[event] or {}
            table.insert(self.listeners[event], { name = name, callback = callback })
        end

        function methods:trigger(event)
            self.triggering = true
            for _, item in ipairs(self.listeners[event] or {}) do
                table.insert(world.trace, self.name .. ':' .. event .. ':' .. item.name)
                item.callback(self)
            end

            self.triggering = false
            for name in pairs(self.deferred) do
                self:removeListener(name)
            end

            self.deferred = {}
        end

        function methods:spawn()
            self.pending = nil
            self.spawned = true
            local handler = xi.zones.Jugner_Forest.mobs[self.name].onMobSpawn
            if handler then
                handler(self)
            end

            self:trigger('SPAWN')
        end

        function methods:despawn()
            -- CDespawnState::init queues base respawn before the three-second fade.
            self.spawned = false
            if self.allowed then
                self.pending = world.now + self.base
            end

            world.now = world.now + 3
            local handler = xi.zones.Jugner_Forest.mobs[self.name].onMobDespawn
            if handler then
                handler(self)
            end

            self:trigger('DESPAWN')
        end

        for _, pair in ipairs({ { 17203447, 'Fraelissa', 3600 }, { 17203448, 'Fradubio', 0 } }) do
            world.mobs[pair[1]] = setmetatable({ id = pair[1], name = pair[2], base = pair[3],
                vars = {}, mods = {}, listeners = {}, deferred = {}, spawned = false, allowed = pair[2] == 'Fraelissa' }, { __index = methods })
        end

        env.SpawnMob = function(id)
            local mob = assert(world.mobs[id])
            mob:spawn()
            return mob
        end

        world.env, world.xi = env, xi
        world.ph, world.nm = world.mobs[17203447], world.mobs[17203448]
        setfenv(assert(loadfile('scripts/globals/mobs.lua')), env)()
        for _, name in ipairs({ 'Fraelissa', 'Fradubio' }) do
            xi.zones.Jugner_Forest.mobs[name] = setfenv(assert(loadfile('scripts/zones/Jugner_Forest/mobs/' .. name .. '.lua')), env)()
        end

        xi.zones.Jugner_Forest.Zone.onInitialize = setfenv(function()
        end, env)

        setfenv(assert(loadfile('modules/module_utils.lua')), env)()
        setfenv(assert(loadfile('modules/phoenix/lua/custom/pxi_timed_nm_respawn_persistence.lua')), env)()
        for _, module in ipairs(xi.module.registry) do
            for _, override in ipairs(module.overrides) do
                if override.name:find('^xi%.zones%.Jugner_Forest%.') and not override.name:find('Meteormauler') then
                    local target, parts = env, {}
                    for part in override.name:gmatch('[^.]+') do
                        table.insert(parts, part)
                    end

                    for index = 1, #parts - 1 do
                        target = assert(target[parts[index]], override.name)
                    end

                    local name = parts[#parts]
                    target[name] = target[name] or setfenv(function()
                    end, env)

                    env.applyOverride(target, name, override.func)
                end
            end
        end

        world.boot = function()
            for _, mob in ipairs({ world.ph, world.nm }) do
                xi.zones.Jugner_Forest.mobs[mob.name].onMobInitialize(mob)
                mob.allowed = mob == world.ph
            end

            for _, mob in ipairs({ world.ph, world.nm }) do
                if not mob.pending and mob.allowed then
                    mob:spawn()
                end
            end

            xi.zones.Jugner_Forest.Zone.onInitialize({})
        end

        function world:tick()
            for _, mob in ipairs({ self.ph, self.nm }) do
                if mob.pending and mob.pending <= self.now and mob.allowed then
                    mob:spawn()
                end
            end
        end

        return world
    end

    local fraelissaId, fradubioId = 17203447, 17203448
    local deadlineVar, nextVar, popVar = '[PXI][TNM]Fraelissa', '[PXI][TNM]Fraelissa_Next', '[PXI][TNM]Fradubio_Pop'
    local function equal(actual, expected, message)
        assert(actual == expected, (message or 'unexpected value') .. ': expected ' .. tostring(expected) .. ', got ' .. tostring(actual))
    end

    local function world(vars, now)
        local state = newWorld(vars, now)
        state.boot()
        return state
    end

    local function spawnPh(state)
        state.now = assert(state.ph.pending)
        state:tick()
        assert(state.ph.spawned and not state.nm.spawned)
    end

    local function pickNm(state)
        spawnPh(state)
        state.win = true
        state.ph:despawn()
        equal(state.vars[nextVar], fradubioId, 'saved NM selection')
        equal(state.vars[deadlineVar], state.nm.pending, 'saved NM deadline')
        assert(not state.ph.allowed and state.nm.allowed)
    end

    local function spawnNm(state)
        state.now = assert(state.nm.pending)
        state:tick()
        assert(state.nm.spawned and not state.ph.spawned)
        equal(state.vars[deadlineVar], 0, 'consumed deadline')
        equal(state.vars[nextVar], 0, 'consumed selection')
        equal(state.nm.base, 0, 'NM must not auto-respawn')
    end

    local function finishNm(state)
        state.now = state.now + 600
        state.nm:despawn()
        assert(state.ph.allowed and not state.nm.allowed and not state.nm.pending)
        equal(state.ph:getRespawnTime(), 3600, 'full PH window after NM')
        equal(state.vars[deadlineVar], state.ph.pending, 'updated PH deadline')
        equal(state.vars[nextVar], fraelissaId, 'updated PH selection')
        equal(state.vars[popVar], state.now + 75600, 'normal 21h cooldown')
        equal(state.nm:getLocalVar('pop'), state.vars[popVar], 'local/persistent cooldown agreement')
        for _, entry in ipairs(state.trace) do
            assert(not entry:find(':DESPAWN:DESPAWN_' .. fradubioId, 1, true), 'base helper cleanup ran after custom return')
        end
    end

    it('no-save boot keeps normal Fraelissa initialization', function()
        local state = world({}, 2000000)
        equal(state.ph:getRespawnTime(), 3600)
        assert(state.ph.allowed and not state.nm.allowed and not state.nm.pending)
    end)

    it('losing roll saves PH; pending PH survives repeated restarts and keeps its normal next window', function()
        local state = world({}, 2000000)
        spawnPh(state)
        state.win = false
        state.ph:despawn()
        equal(state.vars[nextVar], fraelissaId)
        local deadline = state.ph.pending
        equal(state.vars[deadlineVar], deadline)
        state = world(state.vars, state.now + 600)
        equal(state.ph.pending, deadline)
        state = world(state.vars, state.now + 200)
        equal(state.ph.pending, deadline)
        spawnPh(state)
        equal(state.ph.base, 3600, 'restored remainder must not replace full window')
        equal(state.vars[deadlineVar], 0)
        equal(state.vars[nextVar], 0)
    end)

    it('restores a partial PH wait without shortening a later PH or NM window', function()
        local state = newWorld({}, 2000000)
        state.window = 4200
        state.boot()
        spawnPh(state)
        state.ph:despawn()
        local deadline = state.ph.pending
        state = newWorld(state.vars, state.now + 1200)
        state.window = 4500
        state.boot()
        equal(state.ph.pending, deadline)
        spawnPh(state)
        equal(state.ph.base, 4500)
        state.win = true
        state.ph:despawn()
        equal(state.nm:getRespawnTime(), 4500)
        spawnNm(state)
        state.nm:despawn()
        equal(state.ph:getRespawnTime(), 4500)
        equal(state.vars[deadlineVar], state.ph.pending)
    end)

    it('winning roll saves NM and preserves the same deadline over repeated restarts', function()
        local state = world({}, 2000000)
        pickNm(state)
        local deadline = state.nm.pending
        state = world(state.vars, state.now + 600)
        equal(state.nm.pending, deadline)
        assert(not state.ph.allowed and state.nm.allowed)
        state = world(state.vars, state.now + 200)
        equal(state.nm.pending, deadline)
        assert(not state.ph.allowed and state.nm.allowed)
        spawnNm(state)
    end)

    for _, selected in ipairs({ fraelissaId, fradubioId }) do
        it('expired saved ' .. (selected == fraelissaId and 'PH' or 'NM') .. ' restores only the selected mob with the 60-second floor', function()
            local state = world({ [deadlineVar] = 1999000, [nextVar] = selected }, 2000000)
            local picked = state.mobs[selected]
            equal(picked.pending, 2000060)
            assert(picked.allowed)
            if selected == fradubioId then
                assert(not state.ph.allowed)
            else
                assert(not state.nm.allowed)
            end

            state.now = 2000060
            state:tick()
            assert(picked.spawned)
            assert(not state.mobs[selected == fraelissaId and fradubioId or fraelissaId].spawned)
        end)
    end

    it('fresh NM winner returns PH once and saves correct deadline/cooldown without later base-listener overwrite', function()
        local state = world({}, 2000000)
        pickNm(state)
        assert(#(state.nm.listeners.DESPAWN or {}) > 0, 'real helper must have attached NM return listener')
        spawnNm(state)
        finishNm(state)
    end)

    it('restored NM winner returns PH without relying on a lost dynamic helper listener', function()
        local state = world({}, 2000000)
        pickNm(state)
        state = world(state.vars, state.now + 600)
        spawnNm(state)
        finishNm(state)
    end)

    it('post-NM PH deadline and 21h lottery cooldown both survive restart; forced wins stay blocked until eligible', function()
        local state = world({}, 2000000)
        pickNm(state)
        spawnNm(state)
        finishNm(state)
        local deadline, cooldown = state.ph.pending, state.vars[popVar]
        state = world(state.vars, state.now + 600)
        equal(state.ph.pending, deadline)
        equal(state.nm:getLocalVar('pop'), cooldown)
        spawnPh(state)
        state.win = true
        state.ph:despawn()
        equal(state.vars[nextVar], fraelissaId, 'lottery was not yet eligible')
        state = world(state.vars, cooldown + 1)
        equal(state.nm:getLocalVar('pop'), cooldown)
        spawnPh(state)
        state.win = true
        state.ph:despawn()
        equal(state.vars[nextVar], fradubioId, 'lottery should win after cooldown')
    end)

    for _, multiplier in ipairs({ 0.5, 0, -1 }) do
        it('NM return honors NM_LOTTERY_COOLDOWN=' .. multiplier, function()
            local state = world({}, 2000000)
            state.xi.settings.main.NM_LOTTERY_COOLDOWN = multiplier
            pickNm(state)
            spawnNm(state)
            state.nm:despawn()
            local seconds = multiplier >= 0 and 75600 * multiplier or 75600
            equal(state.nm:getLocalVar('pop'), state.now + seconds)
            equal(state.vars[popVar], state.now + seconds)
        end)
    end

    it('uses the normal cooldown when the multiplier setting is absent', function()
        local state = world({}, 2000000)
        state.xi.settings.main.NM_LOTTERY_COOLDOWN = nil
        pickNm(state)
        spawnNm(state)
        state.nm:despawn()
        equal(state.nm:getLocalVar('pop'), state.now + 75600)
        equal(state.vars[popVar], state.now + 75600)
    end)

    it('doNotInvokeCooldown preserves the existing cooldown', function()
        local state = world({}, 2000000)
        pickNm(state)
        spawnNm(state)
        local cooldown = state.now + 12345
        state.nm:setLocalVar('pop', cooldown)
        state.nm:setLocalVar('doNotInvokeCooldown', 1)
        state.nm:despawn()
        equal(state.nm:getLocalVar('pop'), cooldown)
        equal(state.vars[popVar], cooldown)
    end)

    it('legacy save with no selected ID is discarded instead of guessing a winner', function()
        local state = world({ [deadlineVar] = 2000200 }, 2000000)
        equal(state.ph.pending, 2003600)
        equal(state.vars[deadlineVar], 0)
        equal(state.vars[nextVar] or 0, 0)
        assert(not state.nm.allowed)
    end)

    it('invalid selected ID is discarded safely', function()
        local state = world({ [deadlineVar] = 2000200, [nextVar] = 999 }, 2000000)
        equal(state.ph.pending, 2003600)
        equal(state.vars[deadlineVar], 0)
        equal(state.vars[nextVar], 0)
        assert(not state.nm.allowed)
    end)

    it('restart while NM alive follows existing no-alive-resurrection policy', function()
        local state = world({}, 2000000)
        pickNm(state)
        spawnNm(state)
        state = world(state.vars, state.now + 100)
        assert(not state.nm.allowed and not state.nm.pending)
        equal(state.ph:getRespawnTime(), 3600)
    end)
end)
