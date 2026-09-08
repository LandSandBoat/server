describe('Material loss', function()
    ---@type CClientEntityPair
    local player

    -- Behemoth Mantle (Leather 70): wool thread keeps the default rate, behemoth hide is a 100% material.
    local crystal    = xi.item.ICE_CRYSTAL
    local woolThread = xi.item.SPOOL_OF_WOOL_THREAD
    local hide       = xi.item.BEHEMOTH_HIDE
    local mantle     = xi.item.BEHEMOTH_MANTLE

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA })

        -- 11 levels under the recipe puts the break check at 0% success.
        player:setSkillLevel(xi.skill.LEATHERCRAFT, 590)
        player:setMod(xi.mod.SYNTH_SPEED_LEATHERCRAFT, 17000)
        player:changeContainerSize(xi.inventoryLocation.INVENTORY, 80)
    end)

    -- Runs one guaranteed break and returns how many of each ingredient survived it.
    local function breakSynth()
        player:addItem(crystal)
        player:addItem(woolThread)
        player:addItem(hide)

        player.actions:craft(crystal, { woolThread, hide })
        xi.test.world:skipTime(15)

        assert(not player:hasItem(mantle), 'synth 11 levels under the recipe must not succeed')

        local saved =
        {
            woolThread = player:getItemCount(woolThread),
            hide       = player:getItemCount(hide),
        }

        player:delContainerItems(xi.inv.INVENTORY)

        return saved
    end

    local function assertWithinFourSigma(observed, trials, probability, label)
        local expected = trials * probability
        local sigma    = math.sqrt(trials * probability * (1 - probability))
        local lo       = expected - 4 * sigma
        local hi       = expected + 4 * sigma

        assert(observed >= lo and observed <= hi, string.format(
            '%s: %d saved of %d outside 4 sigma range [%.0f, %.0f] (expected %.1f)',
            label, observed, trials, lo, hi, expected))
    end

    it('listed material is always lost on a break', function()
        for _ = 1, 40 do
            local saved = breakSynth()
            assert(saved.hide == 0, 'behemoth hide survived a break')
        end
    end)

    it('unlisted material keeps the 50% default', function()
        local breaks = 400
        local saved  = 0
        for _ = 1, breaks do
            saved = saved + breakSynth().woolThread
        end

        assertWithinFourSigma(saved, breaks, 0.5, 'wool thread')
    end)

    it('loss reductions still apply to a listed material', function()
        player:setMod(xi.mod.SYNTH_MATERIAL_LOSS, 5)
        player:setMod(xi.mod.SYNTH_MATERIAL_LOSS_LEATHERCRAFT, 5)

        local breaks = 400
        local saved  = 0
        for _ = 1, breaks do
            saved = saved + breakSynth().hide
        end

        -- 100 - 10, so one hide in ten survives.
        assertWithinFourSigma(saved, breaks, 0.1, 'behemoth hide')
    end)

    it('zero rate material always survives a break', function()
        -- Recipe 3049: Light Crystal + Broken Lu Shang's -> Lu Shang's, Wood 70. The broken rod is listed at 0.
        local lightCrystal = xi.item.LIGHT_CRYSTAL
        local brokenRod    = xi.item.BROKEN_LU_SHANGS_FISHING_ROD
        local luShangs     = xi.item.LU_SHANGS_FISHING_ROD

        player:setSkillLevel(xi.skill.WOODWORKING, 590)
        player:setMod(xi.mod.SYNTH_SPEED_WOODWORKING, 17000)

        for _ = 1, 20 do
            player:addItem(lightCrystal)
            player:addItem(brokenRod)

            player.actions:craft(lightCrystal, { brokenRod })
            xi.test.world:skipTime(15)

            player.assert.no:hasItem(lightCrystal)
            player.assert.no:hasItem(luShangs)
            player.assert:hasItem(brokenRod)

            player:delContainerItems(xi.inv.INVENTORY)
        end
    end)
end)
