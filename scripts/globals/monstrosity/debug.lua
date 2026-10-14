-----------------------------------
-- Monstrosity - GM helpers
-----------------------------------
xi = xi or {}
xi.monstrosity = xi.monstrosity or {}

-- Completes the quest, sets every family to 99, and unlocks every variant and purchasable instinct.
-- Variants with no retail unlock are included.
xi.monstrosity.unlockAll = function(player)
    player:completeQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.MONSTROSITY)
    player:addKeyItem(xi.keyItem.RING_OF_SUPERNAL_DISJUNCTION)

    local data = player:getMonstrosityData()
    for _, species in pairs(xi.monstrositySpecies) do
        data.levels[species] = 99
    end

    -- Level instincts follow from the levels. These are the purchasable ones.
    for byteOffset = 20, 23 do
        data.instincts[byteOffset] = 0xFF
    end

    for _, variant in pairs(xi.monstrosityVariant) do
        xi.monstrosity.setVariantBit(data, variant)
    end

    player:setMonstrosityData(data)
end
