-----------------------------------
-- Exercises the real EXP calculation and module overrides in an isolated Lua
-- environment, without changing the running world's modules or EXP tables.
-----------------------------------
describe('Module: exp_penalties', function()
    local function constant(value)
        return function()
            return value
        end
    end

    local function fixture(useToau)
        local actual = { baseExp = 0, memberLevel = 75, calls = 0 }
        local testXi =
        {
            effect        = xi.effect,
            zone          = xi.zone,
            region        = xi.region,
            mod           = xi.mod,
            mobMod        = xi.mobMod,
            mobDifficulty = xi.mobDifficulty,
            keyItem       = xi.keyItem,
            data          = { experiencePoints = { baseTable = {} } },
        }

        for difference = -44, 15 do
            testXi.data.experiencePoints.baseTable[difference] = setmetatable({},
                {
                    __index = function()
                        return actual.baseExp
                    end,
                })
        end

        local env = setmetatable({ xi = testXi }, { __index = _G })
        env.require = function()
        end

        for _, path in ipairs(
            {
                'modules/module_utils.lua',
                'scripts/globals/experience_points.lua',
                'modules/phoenix/lua/custom/exp_penalties.lua',
            })
        do
            setfenv(assert(loadfile(path)), env)()
        end

        local coreCalculate = testXi.experiencePoints.calculate

        testXi.experiencePoints.calculate = setfenv(function(member, mob, data)
            actual.calls        = actual.calls + 1
            actual.receivedData = data
            return coreCalculate(member, mob, data)
        end, env)

        for _, module in ipairs(testXi.module.registry) do
            if module.enabled then
                for _, override in ipairs(module.overrides) do
                    if override.enabled then
                        local name = override.name:match('%.([^%.]+)$')
                        env.applyOverride(testXi.experiencePoints, name, override.func)
                    end
                end
            end
        end

        testXi.experiencePoints.perMonsterCaps =
        {
            { maxLevel = 50,  cap = 200 },
            { maxLevel = 60,  cap = 250 },
            { maxLevel = 255, cap = 300 },
        }

        if useToau then
            testXi.server            = { onServerStart = setfenv(constant(nil), env) }
            env.ReloadExperienceData = function()
            end

            env.LoadExpDifficultyCurves = function()
            end

            setfenv(assert(loadfile('modules/era/lua/globals/toau_experience_points.lua')), env)()
            local era = testXi.module.registry[#testXi.module.registry]
            env.applyOverride(testXi.server, 'onServerStart', era.overrides[1].func)
            testXi.server.onServerStart()
        end

        local member =
        {
            zoneId      = xi.zone.PROMYVION_HOLLA,
            effects     = {},
            bonus       = 0,
            getMainLvl  = constant(30),
            getMainJob  = constant(1),
            getJobLevel = function()
                return actual.memberLevel
            end,

            hasKeyItem = constant(false),
            getZoneID  = function(self)
                return self.zoneId
            end,

            getStatusEffect = function(self, effect)
                return self.effects[effect]
            end,

            hasStatusEffect = function(self, effect)
                return self.effects[effect] ~= nil
            end,

            delStatusEffect = function(self, effect)
                self.effects[effect] = nil
            end,

            getMod = function(self)
                return self.bonus
            end,
        }
        member.effects[xi.effect.LEVEL_RESTRICTION] = { getSubPower = constant(0) }

        local mob =
        {
            bonus     = 0,
            getMobMod = function(self)
                return self.bonus
            end,

            getMod     = constant(0),
            getMainLvl = constant(40),
            getZoneID  = function()
                return xi.zone.PROMYVION_HOLLA
            end,

            getMaster = function(self)
                return self.master
            end,
        }

        local data =
        {
            baseExp            = 200,
            memberLevel        = 30,
            highestMemberLevel = 30,
            memberTNL          = 5800,
            highestMemberTNL   = 5800,
            partySize          = 1,
            regionId           = xi.region.TAVNAZIA,
            mobDifficulty      = xi.mobDifficulty.EVEN_MATCH,
            chainNumber        = 1,
            chainActive        = false,
        }

        return testXi.experiencePoints.calculate, member, mob, data, actual, testXi
    end

    it('halves the input and leaves the monster cap to core', function()
        local calculate, member, mob, data = fixture()

        data.baseExp = 600
        assert(calculate(member, mob, data).exp == 200)
        assert(data.baseExp == 600 and data.memberLevel == 30)
    end)

    it('delegates the winning actual-level input to core', function()
        local calculate, member, mob, data, actual = fixture()

        actual.baseExp = 240
        assert(calculate(member, mob, data).exp == 240)
    end)

    it('uses the stock actual-level TNL grade', function()
        local calculate, member, mob, data, actual = fixture()

        data.baseExp            = 100
        actual.baseExp          = 100
        actual.memberLevel      = 40
        data.highestMemberLevel = 45
        data.highestMemberTNL   = 7300
        assert(calculate(member, mob, data).exp == 93)
    end)

    it('retains contribution penalties in the actual-level grade', function()
        local calculate, member, mob, data, actual = fixture()

        data.baseExp            = 100
        actual.baseExp          = 120
        actual.memberLevel      = 40
        data.highestMemberLevel = 75
        assert(calculate(member, mob, data).exp == 64)
    end)

    it('preserves chains at the restricted level and consumes Dedication once', function()
        local calculate, member, mob, data = fixture()

        local dedication =
        {
            cap         = 1000,
            writes      = 0,
            getPower    = constant(50),
            getSubPower = function(self)
                return self.cap
            end,

            setSubPower = function(self, value)
                self.cap    = value
                self.writes = self.writes + 1
            end,
        }
        member.effects[xi.effect.DEDICATION] = dedication
        data.chainActive                     = true
        local result = calculate(member, mob, data)
        assert(result.exp == 180 and result.chainActive and result.chainWindow > 0)
        assert(dedication.cap == 940 and dedication.writes == 1)
    end)

    it('does not chain a decent challenge', function()
        local calculate, member, mob, data = fixture()

        data.mobDifficulty = xi.mobDifficulty.DECENT_CHALLENGE
        data.chainActive   = true
        local result = calculate(member, mob, data)
        assert(result.exp == 100 and not result.chainActive and result.chainWindow == 0)
    end)

    it('keeps fractional EXP until final rounding', function()
        local calculate, member, mob, data = fixture()

        data.baseExp = 101
        member.bonus = 10
        assert(calculate(member, mob, data).exp == 55)
    end)

    it('preserves monster bonuses before the cap', function()
        local calculate, member, mob, data = fixture()

        data.baseExp = 150
        mob.bonus    = 100
        assert(calculate(member, mob, data).exp == 150)
    end)

    it('applies CoP restrictions even when Level Sync is also present', function()
        local calculate, member, mob, data = fixture()

        member.effects[xi.effect.LEVEL_RESTRICTION] = nil
        assert(calculate(member, mob, data).exp == 200)
        member.effects[xi.effect.LEVEL_SYNC] = {}
        assert(calculate(member, mob, data).exp == 200)
        member.effects[xi.effect.LEVEL_RESTRICTION] = { getSubPower = constant(0) }
        assert(calculate(member, mob, data).exp == 100)
    end)

    it('leaves unaffected levels alone', function()
        local calculate, member, mob, data, actual = fixture()

        actual.memberLevel = data.memberLevel
        assert(calculate(member, mob, data).exp == 200)
    end)

    it('leaves restrictions outside CoP alone', function()
        local calculate, member, mob, data = fixture()

        member.zoneId = xi.zone.GM_HOME
        assert(calculate(member, mob, data).exp == 200)
    end)

    it('preserves the custom pet deterrent once for every party size', function()
        local expected = { 100, 60, 45, 12, 7, 3, 2 }
        for size = 1, 7 do
            local calculate, member, mob, data = fixture()
            mob.master     = { isMob = constant(true) }
            data.partySize = size
            assert(calculate(member, mob, data).exp == expected[size], string.format('party size %d', size))
        end
    end)

    it('does not penalize wild monsters or player-owned pets', function()
        local calculate, member, mob, data = fixture()

        data.partySize = 6
        assert(calculate(member, mob, data).exp == 35)
        mob.master = { isMob = constant(false) }
        assert(calculate(member, mob, data).exp == 35)
    end)

    it('preserves a higher contribution level supplied by core', function()
        local calculate, member, mob, data, actual = fixture()

        data.baseExp            = 100
        data.highestMemberLevel = 80
        actual.baseExp          = 120
        actual.memberLevel      = 40
        assert(calculate(member, mob, data).exp == 60)
    end)

    it('awards the recipient 105 EXP in the ToAU mixed-party example', function()
        local calculate, member, mob, data, actual, testXi = fixture(true)

        member.getMainLvl       = constant(40)
        mob.getMainLvl          = constant(45)
        actual.memberLevel      = 41
        data.memberLevel        = 40
        data.highestMemberLevel = 40
        data.memberTNL          = 6800
        data.highestMemberTNL   = 6800
        data.partySize          = 6
        data.baseExp            = testXi.data.experiencePoints.baseTable[5][8]

        assert(data.baseExp == 400)
        assert(calculate(member, mob, data).exp == 105 and actual.calls == 1)
        assert(actual.receivedData.baseExp == 300 and actual.receivedData.memberLevel == 41)

        actual.memberLevel = 75
        assert(calculate(member, mob, data).exp == 70)

        actual.memberLevel = 41
        mob.master         = { isMob = constant(true) }
        assert(calculate(member, mob, data).exp == 10)
    end)

    it('uses the live base table, level brackets, clamps and EXP_LVL_MOD', function()
        local calculate, member, mob, data, actual, testXi = fixture()

        data.baseExp                                  = 0
        actual.memberLevel                            = 40
        testXi.data.experiencePoints.baseTable[15][8] = 120
        mob.getMainLvl                                = constant(80)
        assert(calculate(member, mob, data).exp == 120)
        testXi.data.experiencePoints.baseTable[0][8] = 110
        mob.getMainLvl                               = constant(39)
        mob.getMod                                   = constant(1)
        assert(calculate(member, mob, data).exp == 110)
        actual.memberLevel = 99
        testXi.data.experiencePoints.baseTable[-44][20] = 10
        assert(calculate(member, mob, data).exp == 10)
    end)

    it('matches the stock SQL TNL table through level 50', function()
        local tnl = {}
        for line in io.lines('sql/exp_base.sql') do
            local level, exp = line:match('VALUES %((%d+),(%d+)%)')
            if level then
                tnl[tonumber(level) - 1] = tonumber(exp)
            end
        end

        for level = 2, 49 do
            local calculate, member, mob, data, actual = fixture()
            member.getMainLvl       = constant(1)
            data.baseExp            = 0
            data.memberLevel        = 1
            data.highestMemberLevel = level + 1
            data.highestMemberTNL   = tnl[level + 1]
            actual.memberLevel      = level
            actual.baseExp          = 100
            local expected = math.floor(100 * tnl[level] / tnl[level + 1])
            assert(calculate(member, mob, data).exp == expected, string.format('TNL at level %d', level))
        end
    end)

    it('keeps the existing post-bonus pet penalty and Dedication depletion', function()
        local calculate, member, mob, data = fixture()

        data.partySize                       = 4
        mob.master                           = { isMob = constant(true) }
        member.effects[xi.effect.DEDICATION] =
        {
            getPower    = constant(50),
            getSubPower = constant(15),
            setSubPower = function(_, value)
                assert(value == 0)
            end,
        }
        -- 40 restricted EXP + 15 remaining Dedication, then retain 30%.
        assert(calculate(member, mob, data).exp == 16)
        assert(member.effects[xi.effect.DEDICATION] == nil)
    end)

    it('uses one calculation followed by the pet check for every award path', function()
        local calculate, member, mob, data, actual = fixture()

        local result = calculate(member, mob, data)
        assert(result.exp == 100 and actual.calls == 1)
        assert(actual.receivedData ~= data and actual.receivedData.baseExp == 100)
        assert(data.baseExp == 200)
        actual.baseExp = 150
        result         = calculate(member, mob, data)
        assert(result.exp == 150 and actual.calls == 2)
        assert(actual.receivedData.memberLevel == 75 and data.memberLevel == 30)

        data.partySize = 4
        mob.master     = { isMob = constant(true) }
        assert(calculate(member, mob, data).exp == 18 and actual.calls == 3)

        member.effects[xi.effect.LEVEL_SYNC] = {}
        assert(calculate(member, mob, data).exp == 18 and actual.calls == 4)
        member.effects = {}
        assert(calculate(member, mob, data).exp == 24 and actual.calls == 5)
    end)
end)
