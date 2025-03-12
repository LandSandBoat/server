-----------------------------------
-- Einherjar: Treasure Generation
-----------------------------------
local ID = zones[xi.zone.HAZHALM_TESTING_GROUNDS]

local bossDrops = {
    -- Wing 1
    [ID.mob.HAKENMANN] = {
        { item = xi.item.CHUNK_OF_OROBON_MEAT, rate = 1000 },
    },
    [ID.mob.HILDESVINI] = {
        { item = xi.item.MARID_HIDE,         rate = 1000 },
        { item = xi.item.MARID_HIDE,         rate = 1000 },
        { item = xi.item.LOCK_OF_MARID_HAIR, rate = 1000 },
    },
    [ID.mob.HIMINRJOT] = {
        { item = xi.item.BUFFALO_HIDE,          rate = 1000 },
        { item = xi.item.SLICE_OF_BUFFALO_MEAT, rate = 1000 },
    },
    [ID.mob.HRAESVELG] = {
        { item = xi.item.MANTICORE_FANG,         rate = 1000 },
        { item = xi.item.LOCK_OF_MANTICORE_HAIR, rate = 1000 },
        { item = xi.item.MANTICORE_HIDE,         rate = 1000 },
    },
    [ID.mob.MORBOL_EMPEROR] = {
        { item = xi.item.AMERETAT_VINE,    rate = 1000 },
        { item = xi.item.LACQUER_TREE_LOG, rate = 1000 },
    },
    [ID.mob.NIHHUS] = {
        { item = xi.item.WIVRE_HORN, rate = 1000 },
        { item = xi.item.WIVRE_HIDE, rate = 1000 },
        { item = xi.item.WIVRE_MAUL, rate = 1000 },
    },
    -- Wing 2
    [ID.mob.ANDHRIMNIR] = {
        { item = xi.item.CORSE_BRACELET, rate = 1000 },
        { item = xi.item.CORSE_ROBE,     rate = 1000 },
        { item = xi.item.CORSE_BRACELET, rate = 1000 },
    },
    [ID.mob.ARIRI_SAMARIRI] = {
        { item = xi.item.POROGGO_HAT, rate = 1000 },
        { item = xi.item.POROGGO_HAT, rate = 1000 },
        { item = xi.item.POROGGO_HAT, rate = 1000 },
    },
    [ID.mob.BALRAHN] = {
        { item = xi.item.SOULFLAYER_TENTACLE, rate = 1000 },
        { item = xi.item.SOULFLAYER_STAFF,    rate = 1000 },
        { item = xi.item.SOULFLAYER_ROBE,     rate = 1000 },
    },
    [ID.mob.HRUNGNIR] = {
        { item = xi.item.CHUNK_OF_MYTHRIL_ORE, rate = 1000 },
        { item = xi.item.GOLEM_SHARD,          rate = 1000 },
        { item = xi.item.GOLEM_SHARD,          rate = 1000 },
    },
    [ID.mob.MOKKURALFI] = {
        { item = xi.item.CHUNK_OF_FLAN_MEAT, rate = 1000 },
        { item = xi.item.CHUNK_OF_FLAN_MEAT, rate = 1000 },
        { item = xi.item.CHUNK_OF_FLAN_MEAT, rate = 1000 },
    },
    [ID.mob.TANNGRISNIR] = {
        { item = xi.item.HANDFUL_OF_DRAGON_SCALES, rate = 1000 },
        { item = xi.item.HANDFUL_OF_DRAGON_SCALES, rate = 1000 },
        { item = xi.item.DRAGON_TALON,             rate = 1000 },
    },
    -- Wing 3
    [ID.mob.DENDAINSONNE] = {
        { item = xi.item.BEHEMOTH_HORN, rate = 1000 },
    },
    [ID.mob.FREKE] = {
        { item = xi.item.SLICE_OF_CERBERUS_MEAT, rate = 1000 },
        { item = xi.item.CERBERUS_CLAW,          rate = 50 }, -- 5% chance
    },
    [ID.mob.GORGIMERA] = {
        { item = xi.item.KHIMAIRA_HORN, rate = 1000 },
        { item = xi.item.KHIMAIRA_MANE, rate = 50 }, -- 5% chance
    },
    [ID.mob.MOTSOGNIR] = {
        { item = xi.item.DEMON_SKULL, rate = 1000 },
    },
    [ID.mob.STOORWORM] = {
        { item = xi.item.CHUNK_OF_HYDRA_MEAT, rate = 1000 },
    },
    [ID.mob.VAMPYR_JARL] = {
        { item = xi.item.VIAL_OF_DRAGON_BLOOD, rate = 1000 },
    },
}

local synthMaterials = {
    { item = xi.item.GOLD_INGOT,           rate = 300, max = 4 },
    { item = xi.item.PLATINUM_INGOT,       rate = 300, max = 4 },
    { item = xi.item.ANGELSTONE,           rate = 100, max = 3 },
    { item = xi.item.SCINTILLANT_INGOT,    rate = 100, max = 3 },
    { item = xi.item.ADAMAN_INGOT,         rate =  75, max = 4 },
    { item = xi.item.ORICHALCUM_INGOT,     rate =  50, max = 2 },
    { item = xi.item.IMPERIAL_WOOTZ_INGOT, rate =  50, max = 3 }, -- captures show 2 max, ffo.jp claims 3
    { item = xi.item.CHUNK_OF_KHROMA_ORE,  rate =  25, max = 1 }
}

local abjurations = {
    [xi.einherjar.wing.WING_1] = {
        xi.item.HADEAN_ABJURATION_HANDS,
        xi.item.HADEAN_ABJURATION_FEET,
        xi.item.PHANTASMAL_ABJURATION_HANDS,
        xi.item.PHANTASMAL_ABJURATION_LEGS,
        xi.item.WYRMAL_ABJURATION_HEAD,
        xi.item.EARTHEN_ABJURATION_LEGS,
        xi.item.NEPTUNAL_ABJURATION_HEAD,
        xi.item.NEPTUNAL_ABJURATION_LEGS,
        xi.item.DRYADIC_ABJURATION_FEET,
    },
    [xi.einherjar.wing.WING_2] = {
        xi.item.EARTHEN_ABJURATION_HANDS,
        xi.item.PHANTASMAL_ABJURATION_HEAD,
        xi.item.HADEAN_ABJURATION_HEAD,
        xi.item.HADEAN_ABJURATION_HANDS,
        xi.item.NEPTUNAL_ABJURATION_LEGS,
        xi.item.AQUARIAN_ABJURATION_FEET,
        xi.item.WYRMAL_ABJURATION_HEAD,
        xi.item.MARTIAL_ABJURATION_LEGS,
    },
    [xi.einherjar.wing.WING_3] = {
        xi.item.PHANTASMAL_ABJURATION_HEAD,
        xi.item.PHANTASMAL_ABJURATION_LEGS,
        xi.item.HADEAN_ABJURATION_LEGS,
        xi.item.NEPTUNAL_ABJURATION_HEAD,
        xi.item.AQUARIAN_ABJURATION_HANDS,
        xi.item.AQUARIAN_ABJURATION_FEET,
        xi.item.DRYADIC_ABJURATION_FEET,
        xi.item.MARTIAL_ABJURATION_LEGS,
        xi.item.MARTIAL_ABJURATION_FEET,
    }
}

-- Crafting rewards are generated based on the following steps:
-- 1. Roll to determine the number of different items (1, 2, or 3)
-- 2. Select N items based on their rates
-- 3. Apply linear decay formula to determine quantity (1-4: 40%, 30%, 20%, 10%, 1-2: 66%, 33%)
local function craftingMaterialRewards()
    local rewards = {}

    -- Step 1: Roll to determine the number of item types
    local roll = math.random(1, 100)
    local numItems = 1  -- Default to 1 item type

    if roll <= 30 then
        numItems = 1  -- 30% chance
    elseif roll <= 95 then
        numItems = 2  -- 65% chance
    else
        numItems = 3  -- 5% chance
    end

    -- Step 2: Select N items based on their rates
    local availableMaterials = { unpack(synthMaterials) }

    for _ = 1, numItems do
        -- Roll a random number within the total rate
        local itemRoll = math.random(1, 1000)

        -- Select item based on the weighted roll
        local cumulativeRate = 0
        for index, material in ipairs(availableMaterials) do
            cumulativeRate = cumulativeRate + material.rate
            if itemRoll <= cumulativeRate then
                -- Step 3: Apply linear decay formula to determine quantity
                local totalWeight = (material.max * (material.max + 1)) / 2
                local quantityRoll = math.random(1, totalWeight)

                local cumulativeQuantityWeight = 0
                local quantity = 1

                for n = 1, material.max do
                    cumulativeQuantityWeight = cumulativeQuantityWeight + (material.max + 1 - n)
                    if quantityRoll <= cumulativeQuantityWeight then
                        quantity = n
                        break
                    end
                end

                for _ = 1, quantity do
                    table.insert(rewards, material.item)
                end

                -- Remove the selected item to avoid duplicates
                table.remove(availableMaterials, index)
                break
            end
        end
    end

    return rewards
end

-- Einherjar Armoury Crate rewards generation
-- Note: Only for Wing 1-3, no crate in Odin's Chamber
xi.einherjar.getArmouryCrateRewards = function(bossId, chamberTier)
    local rewards = {}

    -- 1. Boss specific drops (1-3 guaranteed items, some bosses also have non-guaranteed drops)
    for _, lootEntry in ipairs(bossDrops[bossId]) do
        -- Roll each item in the boss table
        local itemId = lootEntry.item
        local itemRate = lootEntry.rate

        if math.random(1, 1000) <= itemRate then
            table.insert(rewards, itemId)
        end
    end

    -- 2. Crafting materials (1 (guaranteed) to 3 different types, with linear decay quantity)
    for _, item in ipairs(craftingMaterialRewards()) do
        table.insert(rewards, item)
    end

    -- 3. Wing specific abjuration (5% chance)
    if math.random(1, 100) <= 5 then
        table.insert(rewards, abjurations[chamberTier][math.random(1, #abjurations[chamberTier])])
    end

    -- 4. (Optional) 4. Heithrun special rewards (not guaranteed)
    -- TODO: Implement Heithrun

    return rewards
end
