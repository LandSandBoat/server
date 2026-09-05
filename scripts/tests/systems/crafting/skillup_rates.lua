describe('SkillUpRates', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer(
            {
                zone = xi.zone.SOUTHERN_SAN_DORIA,
            })
    end)

    local tries = 1000

    -- Skill up amounts follow the retail-log weight table in synthutils.cpp
    -- Percent chance of a +0.1 through +0.5 skill up given one occurred, indexed by floor distance (recipe level - charSkill / 10).
    local function runSkillUps(p, skillTenths, crystal, ingredient, expected)
        xi.test.world:setSeed(1)

        p:setSkillRank(xi.skill.WOODWORKING, 9)  -- rank cap 100.0 so the skill cap check never blocks
        p:setMod(xi.mod.SYNTH_SUCCESS_RATE, 300) -- clamps success to 99% so high distances still yield samples
        p:setMod(xi.mod.SYNTH_SPEED_WOODWORKING, 17000)

        local counts = { 0, 0, 0, 0, 0 }
        local total  = 0

        for i = 1, tries do
            if i % 200 == 0 then
                print(string.format('iter %d: %d skill ups', i, total))
            end

            p:setSkillLevel(xi.skill.WOODWORKING, skillTenths)
            p:addItem(crystal)
            p:addItem(ingredient)

            p.actions:craft(crystal, { ingredient })
            xi.test.world:skipTime(15)

            local gain = p:getCharSkillLevel(xi.skill.WOODWORKING) - skillTenths
            assert(gain >= 0 and gain <= 5, string.format('impossible skill up amount %d tenths', gain))

            if gain > 0 then
                counts[gain] = counts[gain] + 1
                total        = total + 1
            end

            p:delContainerItems(xi.inv.INVENTORY)
        end

        assert(total >= 200, string.format('only %d skill ups in %d synths, not enough samples', total, tries))

        for amount = 1, 5 do
            local expectedPercent = expected[amount] or 0
            local observedPercent = counts[amount] * 100.0 / total
            print(string.format('+0.%d: %d of %d (%.1f%%, expected %d%%)',
                amount, counts[amount], total, observedPercent, expectedPercent))

            if expectedPercent == 0 then
                assert(counts[amount] == 0, string.format(
                    '+0.%d must never occur at this distance, got %d', amount, counts[amount]))
            else
                local prob  = expectedPercent / 100.0
                local mean  = total * prob
                local sigma = math.sqrt(total * prob * (1.0 - prob))
                local lo    = mean - 4 * sigma
                local hi    = mean + 4 * sigma
                assert(counts[amount] >= lo and counts[amount] <= hi, string.format(
                    '+0.%d count %d outside 4 sigma range [%.0f, %.0f] (expected %.1f)',
                    amount, counts[amount], lo, hi, mean))
            end
        end
    end

    it('distance 2 gives 85/15', function()
        -- Willow Lumber cap 13, skill 11.0
        runSkillUps(player, 110, xi.item.WIND_CRYSTAL, xi.item.WILLOW_LOG,
            { [1] = 85, [2] = 15 })
    end)

    it('distance 5 gives 70/30', function()
        -- Willow Lumber cap 13, skill 8.0
        runSkillUps(player, 80, xi.item.WIND_CRYSTAL, xi.item.WILLOW_LOG,
            { [1] = 70, [2] = 30 })
    end)

    it('distance 7 gives 60/40', function()
        -- Willow Lumber cap 13, skill 6.0
        runSkillUps(player, 60, xi.item.WIND_CRYSTAL, xi.item.WILLOW_LOG,
            { [1] = 60, [2] = 40 })
    end)

    it('distance 10 gives 40/40/20', function()
        -- Walnut Lumber cap 19, skill 9.0
        runSkillUps(player, 90, xi.item.WIND_CRYSTAL, xi.item.WALNUT_LOG,
            { [1] = 40, [2] = 40, [3] = 20 })
    end)

    it('distance 14 gives 0/40/30/20/10 and never +0.1', function()
        -- Walnut Lumber cap 19, skill 5.0
        runSkillUps(player, 50, xi.item.WIND_CRYSTAL, xi.item.WALNUT_LOG,
            { [2] = 40, [3] = 30, [4] = 20, [5] = 10 })
    end)

    describe('desynth', function()
        local desynthTries = 2000

        -- Desynth skill up chance is the flat retail 5% in synthutils.cpp, same on break and success, in both craft systems.
        -- Leather Highboots desynth is leathercraft 6. successRateMod +100 never breaks, -100 always breaks.
        local function runDesynthSkillUps(p, skillTenths, successRateMod, modernSystem)
            xi.test.world:setSeed(1)
            xi.test.world:setSetting('map.CRAFT_MODERN_SYSTEM', modernSystem)
            xi.test.world:setSetting('map.CRAFT_CHANCE_MULTIPLIER', 1.0)

            p:setSkillRank(xi.skill.LEATHERCRAFT, 9)
            p:setMod(xi.mod.SYNTH_SUCCESS_RATE_DESYNTHESIS, successRateMod)
            p:setMod(xi.mod.SYNTH_SPEED_LEATHERCRAFT, 17000)

            local total = 0

            for i = 1, desynthTries do
                if i % 400 == 0 then
                    print(string.format('iter %d: %d skill ups', i, total))
                end

                p:setSkillLevel(xi.skill.LEATHERCRAFT, skillTenths)
                p:addItem(xi.item.LIGHTNING_CRYSTAL)
                p:addItem(xi.item.LEATHER_HIGHBOOTS)

                p.actions:craft(xi.item.LIGHTNING_CRYSTAL, { xi.item.LEATHER_HIGHBOOTS })
                xi.test.world:skipTime(15)

                local gain = p:getCharSkillLevel(xi.skill.LEATHERCRAFT) - skillTenths
                assert(gain >= 0 and gain <= 2, string.format('desynth skill up of %d tenths, retail only ever gave +0.1 or +0.2', gain))

                if gain > 0 then
                    total = total + 1
                end

                p:delContainerItems(xi.inv.INVENTORY)
            end

            local prob  = 0.05
            local mean  = desynthTries * prob
            local sigma = math.sqrt(desynthTries * prob * (1.0 - prob))
            local lo    = mean - 4 * sigma
            local hi    = mean + 4 * sigma
            print(string.format('%d skill ups in %d desynths (%.2f%%, expected 5%%)',
                total, desynthTries, total * 100.0 / desynthTries))

            assert(total >= lo and total <= hi, string.format(
                'skill up count %d outside 4 sigma range [%.0f, %.0f] (expected %.1f)', total, lo, hi, mean))
        end

        it('gap 5 on success gives a flat 5%', function()
            runDesynthSkillUps(player, 10, 100, true)
        end)

        it('gap 5 on break gives the same 5% with no break penalty', function()
            runDesynthSkillUps(player, 10, -100, true)
        end)

        it('gap 1 gives the same flat 5%', function()
            runDesynthSkillUps(player, 50, 100, true)
        end)

        it('gap 5 on break gives the same 5% under the era system', function()
            runDesynthSkillUps(player, 10, -100, false)
        end)
    end)
end)
