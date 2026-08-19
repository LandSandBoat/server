local function mogItem(player, itemId)
    local item = player:findItem(itemId, xi.inv.MOGSAFE)
    assert(item, string.format('expected item %d in mog safe', itemId))

    return item
end

-- Add to inventory, then move into the mog safe.
local function stockSafe(player, itemId)
    player:addItem(itemId)

    local item = player:findItem(itemId, xi.inv.INVENTORY)
    assert(item, string.format('expected item %d in inventory', itemId))

    player.actions:moveItem(xi.inv.INVENTORY, item:getSlotID(), xi.inv.MOGSAFE, 1)
end

-- Sow a seed into the pot; returns the pot handle.
local function plant(player, seedId)
    stockSafe(player, seedId)

    local pot = mogItem(player, xi.item.EARTHEN_FLOWERPOT)
    player.actions:plantAdd(xi.inv.MOGSAFE, pot:getSlotID(), xi.inv.MOGSAFE, mogItem(player, seedId):getSlotID())

    return pot
end

-- Feed a crystal to the pot at a crystal stage.
local function feed(player, crystalId)
    stockSafe(player, crystalId)

    local pot = mogItem(player, xi.item.EARTHEN_FLOWERPOT)
    player.actions:plantAdd(xi.inv.MOGSAFE, pot:getSlotID(), xi.inv.MOGSAFE, mogItem(player, crystalId):getSlotID())
end

-- Check the plant (resets wilt), pass a stage's worth of days, then tick to grow until targetStep.
-- 120 days clears the longest non-mature stage (Tree Saplings @ 108).
local function growUntil(player, pot, targetStep)
    for _ = 1, 20 do
        if pot:getExData().step >= targetStep then
            return
        end

        player.actions:plantCheck(xi.inv.MOGSAFE, pot:getSlotID())
        xi.test.world:skipVanaDays(120)
        xi.test.world:tickEntity(player)
    end
end

-- Herb seed results with no crystal feed
local herbCrops =
{
    xi.item.CHUNK_OF_ROCK_SALT,
    xi.item.AMARYLLIS,
    xi.item.GREEN_ROCK,
    xi.item.KING_TRUFFLE,
}

local oreFeeds =
{
    { element = 'fire',      crystal = xi.item.FIRE_CRYSTAL,      ore = xi.item.CHUNK_OF_FIRE_ORE },
    { element = 'ice',       crystal = xi.item.ICE_CRYSTAL,       ore = xi.item.CHUNK_OF_ICE_ORE },
    { element = 'wind',      crystal = xi.item.WIND_CRYSTAL,      ore = xi.item.CHUNK_OF_WIND_ORE },
    { element = 'earth',     crystal = xi.item.EARTH_CRYSTAL,     ore = xi.item.CHUNK_OF_EARTH_ORE },
    { element = 'lightning', crystal = xi.item.LIGHTNING_CRYSTAL, ore = xi.item.CHUNK_OF_LIGHTNING_ORE },
    { element = 'water',     crystal = xi.item.WATER_CRYSTAL,     ore = xi.item.CHUNK_OF_WATER_ORE },
    { element = 'dark',      crystal = xi.item.DARK_CRYSTAL,      ore = xi.item.CHUNK_OF_DARK_ORE },
}

describe('Gardening', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WINDURST_WOODS })
        if player:isInEvent() then
            player.events:finish()
        end

        player:gotoMogHouse(xi.zone.WINDURST_WOODS)
        stockSafe(player, xi.item.EARTHEN_FLOWERPOT)

        local pot = mogItem(player, xi.item.EARTHEN_FLOWERPOT)
        player.actions:placeFurniture(xi.inv.MOGSAFE, pot:getSlotID(), 0, 0)
        player.actions:finishFurnishing()
    end)

    it('refuses to plant a pot into itself', function()
        local pot      = mogItem(player, xi.item.EARTHEN_FLOWERPOT)
        local potSlot  = pot:getSlotID()
        local wasKind  = pot:getExData().kind

        -- a real seed id, but the slot points back at the pot
        player.actions:plantAdd(xi.inv.MOGSAFE, potSlot, xi.inv.MOGSAFE, potSlot, xi.item.BAG_OF_HERB_SEEDS)

        local stillThere = player:findItem(xi.item.EARTHEN_FLOWERPOT, xi.inv.MOGSAFE)
        assert(stillThere, 'the pot consumed itself')
        assert(stillThere:getExData().kind == wasKind, 'the pot planted itself')
    end)

    it('refuses to plant something that is not in the slot', function()
        stockSafe(player, xi.item.FIRE_CRYSTAL)

        local pot     = mogItem(player, xi.item.EARTHEN_FLOWERPOT)
        local crystal = mogItem(player, xi.item.FIRE_CRYSTAL)

        -- names a seed in the packet but points at a crystal slot
        player.actions:plantAdd(xi.inv.MOGSAFE, pot:getSlotID(), xi.inv.MOGSAFE, crystal:getSlotID(), xi.item.BAG_OF_HERB_SEEDS)

        assert(player:findItem(xi.item.FIRE_CRYSTAL, xi.inv.MOGSAFE), 'the crystal was spent as a seed')
        assert(mogItem(player, xi.item.EARTHEN_FLOWERPOT):getExData().kind == pot:getExData().kind, 'a seed was planted from a crystal')
    end)

    it('hands a crystal back when the pot has no use for it', function()
        stockSafe(player, xi.item.FIRE_CRYSTAL)

        local pot     = mogItem(player, xi.item.EARTHEN_FLOWERPOT)
        local crystal = mogItem(player, xi.item.FIRE_CRYSTAL)

        -- nothing planted, so there is no sprout to feed
        player.actions:plantAdd(xi.inv.MOGSAFE, pot:getSlotID(), xi.inv.MOGSAFE, crystal:getSlotID())

        local kept = player:findItem(xi.item.FIRE_CRYSTAL, xi.inv.MOGSAFE)
        assert(kept, 'the crystal was eaten by a pot that had no use for it')
        assert(kept:state() == xi.itemState.FREE, 'state: ' .. tostring(kept:state()))
    end)

    it('grows a planted seed to maturity when tended', function()
        local pot = plant(player, xi.item.BAG_OF_HERB_SEEDS)

        assert(pot:getExData().kind == xi.gardening.plant.HERB_SEEDS, 'expected pot to be planted with herbs')
        assert(pot:getExData().step == xi.gardening.stage.INITIAL, 'expected freshly sown seed to be at the initial stage')

        growUntil(player, pot, xi.gardening.stage.MATURE_PLANT)

        assert(pot:getExData().step == xi.gardening.stage.MATURE_PLANT,
            string.format('expected plant to be mature (got stage %d)', pot:getExData().step))
    end)

    it('yields a crop when a mature plant is harvested', function()
        local pot = plant(player, xi.item.BAG_OF_HERB_SEEDS)

        growUntil(player, pot, xi.gardening.stage.MATURE_PLANT)
        assert(pot:getExData().step == xi.gardening.stage.MATURE_PLANT)

        player.actions:plantHarvest(xi.inv.MOGSAFE, pot:getSlotID())

        -- Pot is emptied after harvest.
        assert(pot:getExData().step == xi.gardening.stage.EMPTY, 'expected pot to be empty after harvest')
        assert(pot:getExData().kind == xi.gardening.plant.NONE)

        -- One of the herb crops lands in the mog safe.
        local gotCrop = false
        for _, cropId in ipairs(herbCrops) do
            if player:findItem(cropId, xi.inv.MOGSAFE) then
                gotCrop = true
                break
            end
        end

        assert(gotCrop, 'expected harvest to produce a herb crop')
    end)

    it('wilts a plant left unexamined for too long', function()
        local pot = plant(player, xi.item.BAG_OF_HERB_SEEDS)

        -- Leave it unchecked well past the wilt window.
        xi.test.world:skipVanaDays(200)
        xi.test.world:tickEntity(player)

        assert(pot:getExData().step == xi.gardening.stage.WILTED, 'expected neglected plant to wilt')
    end)

    it('records crystal feeds at each crystal stage', function()
        local pot = plant(player, xi.item.BAG_OF_FRUIT_SEEDS)
        assert(pot:getExData().kind == xi.gardening.plant.FRUIT_SEEDS, 'expected fruit seeds to grow a tree')

        -- First crystal stage: feed a fire crystal.
        growUntil(player, pot, xi.gardening.stage.FIRST_SPROUTS_CRYSTAL)
        assert(pot:getExData().step == xi.gardening.stage.FIRST_SPROUTS_CRYSTAL)

        feed(player, xi.item.FIRE_CRYSTAL)
        assert(pot:getExData().crystal1 == xi.element.FIRE, 'expected fire crystal to be recorded as the extra feed')
        assert(pot:getExData().step == xi.gardening.stage.SECOND_SPROUTS, 'expected feeding a crystal to advance the stage')

        -- Second crystal stage: feed an ice crystal.
        growUntil(player, pot, xi.gardening.stage.SECOND_SPROUTS_CRYSTAL)
        assert(pot:getExData().step == xi.gardening.stage.SECOND_SPROUTS_CRYSTAL)

        feed(player, xi.item.ICE_CRYSTAL)
        assert(pot:getExData().crystal2 == xi.element.ICE, 'expected ice crystal to be recorded as the common feed')

        growUntil(player, pot, xi.gardening.stage.MATURE_PLANT)
        assert(pot:getExData().step == xi.gardening.stage.MATURE_PLANT)
    end)

    it('dries a growing plant so it stops advancing', function()
        local pot = plant(player, xi.item.BAG_OF_HERB_SEEDS)

        growUntil(player, pot, xi.gardening.stage.SECOND_SPROUTS_2)
        local driedStage = pot:getExData().step

        player.actions:plantDry(xi.inv.MOGSAFE, pot:getSlotID())
        assert(pot:getExData().dried, 'expected plant to be marked dried')

        -- Dried plants no longer grow or wilt.
        player.actions:plantCheck(xi.inv.MOGSAFE, pot:getSlotID())
        xi.test.world:skipVanaDays(200)
        xi.test.world:tickEntity(player)

        assert(pot:getExData().step == driedStage, 'expected dried plant to not change stage')
    end)

    describe('yields', function()
        for _, feedEntry in ipairs(oreFeeds) do
            it(string.format('a %s-fed tree sapling yields %s ore', feedEntry.element, feedEntry.element), function()
                -- Ore is the rarest bucket, so grow and harvest until one drops.
                local gotOre = false
                for _ = 1, 40 do
                    local pot = plant(player, xi.item.BAG_OF_TREE_SAPLINGS)

                    growUntil(player, pot, xi.gardening.stage.FIRST_SPROUTS_CRYSTAL)
                    feed(player, feedEntry.crystal)

                    growUntil(player, pot, xi.gardening.stage.SECOND_SPROUTS_CRYSTAL)
                    feed(player, feedEntry.crystal)

                    growUntil(player, pot, xi.gardening.stage.MATURE_PLANT)
                    player.actions:plantHarvest(xi.inv.MOGSAFE, pot:getSlotID())

                    if player:findItem(feedEntry.ore, xi.inv.MOGSAFE) then
                        gotOre = true
                        break
                    end

                    -- A full mog safe blocks the next sowing.
                    player:delContainerItems(xi.inv.MOGSAFE)
                    stockSafe(player, xi.item.EARTHEN_FLOWERPOT)
                    local nextPot = mogItem(player, xi.item.EARTHEN_FLOWERPOT)
                    player.actions:placeFurniture(xi.inv.MOGSAFE, nextPot:getSlotID(), 0, 0)
                    player.actions:finishFurnishing()
                end

                assert(gotOre, string.format('expected %s feed to yield %s ore', feedEntry.element, feedEntry.element))
            end)
        end
    end)
end)
