local crystalToElement =
{
    [xi.item.FIRE_CRYSTAL]      = xi.element.FIRE,
    [xi.item.EARTH_CRYSTAL]     = xi.element.EARTH,
    [xi.item.WATER_CRYSTAL]     = xi.element.WATER,
    [xi.item.WIND_CRYSTAL]      = xi.element.WIND,
    [xi.item.ICE_CRYSTAL]       = xi.element.ICE,
    [xi.item.LIGHTNING_CRYSTAL] = xi.element.THUNDER,
    [xi.item.LIGHT_CRYSTAL]     = xi.element.LIGHT,
    [xi.item.DARK_CRYSTAL]      = xi.element.DARK,
}

describe('Crystals', function()
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.EAST_SARUTABARUTA })
        player:addStatusEffect(xi.effect.SIGNET, 0, 0, 0)
    end)

    it('of matching element drop when monster killed', function()
        local checkTable =
        {
            [xi.region.ELSHIMO_UPLANDS] =
            {
                [xi.zone.TEMPLE_OF_UGGALEPIH] =
                {
                    ['Iron_Maiden']     = xi.item.ICE_CRYSTAL,
                    ['Tonberry_Cutter'] = xi.item.LIGHT_CRYSTAL,
                },
            },
            [xi.region.SARUTABARUTA] =
            {
                [xi.zone.EAST_SARUTABARUTA] =
                {
                    ['Carrion_Crow']   = xi.item.FIRE_CRYSTAL,
                    ['Mandragora']     = xi.item.EARTH_CRYSTAL,
                    ['Yagudo_Acolyte'] = xi.item.WIND_CRYSTAL,
                    ['Pug_Pugil']      = xi.item.WATER_CRYSTAL,
                    ['Goblin_Fisher']  = xi.item.LIGHTNING_CRYSTAL,
                    ['Mad_Fox']        = xi.item.DARK_CRYSTAL,
                },
            },
        }

        for region, zones in pairs(checkTable) do
            -- Someone must control the region for crystals to drop.
            xi.test.world:setRegionOwner(region, xi.nation.WINDURST)

            for zone, mobs in pairs(zones) do
                player:gotoZone(zone)

                for mobName, crystal in pairs(mobs) do
                    local mob = player.entities:moveTo(mobName)

                    -- Ensure the mob has the correct element
                    assert(crystalToElement[crystal] == mob:getCrystalElement())

                    local gotCrystal = false
                    for _ = 1, 100 do
                        player:delContainerItems(xi.inv.INVENTORY)
                        player:setLevel(1)
                        -- Should have only one item in inventory
                        assert(1 == #player:getItems())

                        mob:spawn()
                        mob.assert:isAlive()

                        -- Need to be within range to count for crystal drops
                        player:setPos(mob:getXPos(), mob:getYPos(), mob:getZPos())
                        player:claimAndKillMob(mob, { waitForDespawn = true })
                        for _, item in ipairs(player:getItems()) do
                            if item:getID() == crystal then
                                gotCrystal = true
                                break
                            end

                            -- Mob dropped an unexpected crystal. Ignore other items
                            assert(crystalToElement[item:getID()] == nil)
                        end

                        if gotCrystal then
                            break
                        end
                    end

                    -- Did not get a crystal in 100 kills
                    assert(gotCrystal)
                end
            end
        end
    end)
end)

---@param world CSimulation
---@param ... CBaseEntity
local function waitForDespawn(world, ...)
    local stillSpawned = true
    local ticks = 0
    while stillSpawned do
        stillSpawned = false
        for _, entity in ipairs({ ... }) do
            if entity:isSpawned() then
                stillSpawned = true
                break
            end
        end

        if stillSpawned then
            world:skipTime(5)
            world:tick()
            ticks = ticks + 1
        end

        if ticks >= 20 then
            error('Entities did not spawn as expected.')
        end
    end
end

describe('Elementals', function()
    local player
    local thunderEle, earthEle

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.KONSCHTAT_HIGHLANDS })
        thunderEle = player.entities:get('Thunder_Elemental')
        earthEle = player.entities:get('Earth_Elemental')
    end)

    it('do not spawn with no matching weather', function()
        player:setWeather(xi.weather.NONE)
        waitForDespawn(xi.test.world, thunderEle, earthEle)

        thunderEle.assert.no:isAlive()
        earthEle.assert.no:isAlive()
    end)

    it('spawn during matching weather element', function()
        player:setWeather(xi.weather.THUNDER)
        thunderEle.assert:isAlive()
        earthEle.assert.no:isAlive()

        -- Earth weather spawns only Earth Elemental
        player:setWeather(xi.weather.DUST_STORM)
        waitForDespawn(xi.test.world, thunderEle)

        thunderEle.assert.no:isAlive()
        earthEle.assert:isAlive()

        -- Other weather has none of them
        player:setWeather(xi.weather.FOG)
        waitForDespawn(xi.test.world, thunderEle, earthEle)

        thunderEle.assert.no:isAlive()
        earthEle.assert.no:isAlive()
    end)
end)
