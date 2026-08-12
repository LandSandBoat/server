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

    it('skill 60.0 and above only ever gives +0.1', function()
        -- Lu Shangs Fishing Rod cap 70, skill 60.0: distance 10 would give 40/40/20 below level 60
        -- That means anything above +0.1 here means the gate broke.
        runSkillUps(player, 600, xi.item.LIGHT_CRYSTAL, xi.item.BROKEN_LU_SHANGS_FISHING_ROD,
            { [1] = 100 })
    end)
end)
