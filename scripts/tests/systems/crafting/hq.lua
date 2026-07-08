describe('HQ', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer(
            {
                zone  = xi.zone.SOUTHERN_SAN_DORIA,
            })
    end)

    local tries = 1000

    local function runSynths(p, skills, crystal, ings, nq, hq, expectedHQ, primarySpeedMod)
        for skillId, level in pairs(skills) do
            p:setSkillLevel(skillId, level * 10)
        end

        p:setMod(primarySpeedMod, 17000)
        p:changeContainerSize(xi.inventoryLocation.INVENTORY, 80)

        local nqTotal = 0
        local hqTotal = 0
        for i = 1, tries do
            if i % 200 == 0 then
                print(string.format('iter %d: NQ=%d HQ=%d', i, nqTotal, hqTotal))
            end

            -- Stack duplicate ingredients into one slot or 0x096 rejects.
            p:addItem(crystal)
            local counts = {}
            for _, ing in ipairs(ings) do
                counts[ing] = (counts[ing] or 0) + 1
            end

            for ing, count in pairs(counts) do
                p:addItem(ing, count)
            end

            local nqBefore = p:getItemCount(nq)
            local hqBefore = p:getItemCount(hq)

            p.actions:craft(crystal, ings)
            xi.test.world:skipTime(15)

            nqTotal = nqTotal + (p:getItemCount(nq) - nqBefore)
            hqTotal = hqTotal + (p:getItemCount(hq) - hqBefore)

            p:delContainerItems(xi.inv.INVENTORY)
        end

        local total  = nqTotal + hqTotal
        local hqRate = total > 0 and (hqTotal * 100.0 / total) or 0.0
        print(string.format(
            '%d attempts -> %d NQ + %d HQ (%d failed). HQ rate = %.2f%% (theoretical %.4f%%)',
            tries, nqTotal, hqTotal, tries - total, hqRate, expectedHQ))
        assert(total > 0, 'no synths succeeded')

        local prob     = expectedHQ / 100.0
        local expected = total * prob
        local sigma    = math.sqrt(total * prob * (1.0 - prob))
        local lo       = expected - 4 * sigma
        local hi       = expected + 4 * sigma
        assert(hqTotal >= lo and hqTotal <= hi, string.format(
            'HQ count %d outside 4σ range [%.0f, %.0f] (expected %.1f)',
            hqTotal, lo, hi, expected))
    end

    it('T0 HQ rate', function()
        runSynths(player,
            { [xi.skill.SMITHING] = 96, [xi.skill.GOLDSMITHING] = 30, [xi.skill.CLOTHCRAFT] = 48 },
            xi.item.EARTH_CRYSTAL,
            {
                xi.item.BRASS_INGOT,
                xi.item.ADAMAN_SHEET,
                xi.item.ADAMAN_CHAIN,
                xi.item.SPOOL_OF_GOLD_THREAD,
                xi.item.SQUARE_OF_RAINBOW_CLOTH,
                xi.item.SQUARE_OF_SHEEP_LEATHER,
                xi.item.SOUTHERN_PEARL,
                xi.item.HAUBERK,
            },
            xi.item.CURSED_HAUBERK, xi.item.CURSED_HAUBERK_M1,
            1.5625, xi.mod.SYNTH_SPEED_SMITHING)
    end)

    it('T1 HQ rate', function()
        runSynths(player,
            { [xi.skill.SMITHING] = 116, [xi.skill.GOLDSMITHING] = 50, [xi.skill.CLOTHCRAFT] = 68 },
            xi.item.EARTH_CRYSTAL,
            {
                xi.item.BRASS_INGOT,
                xi.item.ADAMAN_SHEET,
                xi.item.ADAMAN_CHAIN,
                xi.item.SPOOL_OF_GOLD_THREAD,
                xi.item.SQUARE_OF_RAINBOW_CLOTH,
                xi.item.SQUARE_OF_SHEEP_LEATHER,
                xi.item.SOUTHERN_PEARL,
                xi.item.HAUBERK,
            },
            xi.item.CURSED_HAUBERK, xi.item.CURSED_HAUBERK_M1,
            6.25, xi.mod.SYNTH_SPEED_SMITHING)
    end)

    it('T2 HQ rate', function()
        runSynths(player,
            { [xi.skill.CLOTHCRAFT] = 110 },
            xi.item.EARTH_CRYSTAL,
            {
                xi.item.SPOOL_OF_GOLD_THREAD,
                xi.item.SPOOL_OF_GOLD_THREAD,
                xi.item.SQUARE_OF_VELVET_CLOTH,
                xi.item.SQUARE_OF_VELVET_CLOTH,
                xi.item.SQUARE_OF_SILK_CLOTH,
                xi.item.SQUARE_OF_DAMASCENE_CLOTH,
                xi.item.SQUARE_OF_DAMASCENE_CLOTH,
                xi.item.SQUARE_OF_DAMASCENE_CLOTH,
            },
            xi.item.VERMILLION_CLOAK, xi.item.ROYAL_CLOAK,
            25.0, xi.mod.SYNTH_SPEED_CLOTHCRAFT)
    end)

    it('T3 HQ rate', function()
        runSynths(player,
            { [xi.skill.WOODWORKING] = 135 },
            xi.item.WIND_CRYSTAL,
            {
                xi.item.PIECE_OF_EBONY_LUMBER,
                xi.item.ICE_BEAD,
            },
            xi.item.ICE_STAFF, xi.item.AQUILOS_STAFF,
            50.0, xi.mod.SYNTH_SPEED_WOODWORKING)
    end)
end)
