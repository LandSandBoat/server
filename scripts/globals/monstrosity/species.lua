-----------------------------------
-- Monstrosity - Species, variants and purchased instincts
-----------------------------------
xi = xi or {}
xi.monstrosity = xi.monstrosity or {}

---@param species xi.monstrositySpecies
xi.monstrosity.getSpeciesLevel = function(player, species)
    return player:getMonstrosityData().levels[species]
end

---@param species xi.monstrositySpecies
xi.monstrosity.hasUnlockedSpecies = function(player, species)
    return xi.monstrosity.getSpeciesLevel(player, species) > 0
end

---@param species xi.monstrositySpecies
xi.monstrosity.setSpeciesLevel = function(player, species, level)
    local data = player:getMonstrosityData()
    data.levels[species] = level
    player:setMonstrosityData(data)
end

---@param species xi.monstrositySpecies
xi.monstrosity.unlockSpecies = function(player, species)
    if not xi.monstrosity.hasUnlockedSpecies(player, species) then
        xi.monstrosity.setSpeciesLevel(player, species, 1)
    end
end

-- Variants sit one bit each in a 32 byte field.
local function variantBit(variant)
    return { byte = math.floor(variant / 8), mask = bit.lshift(1, variant % 8) }
end

---@param data table
---@param variant xi.monstrosityVariant
xi.monstrosity.hasVariantBit = function(data, variant)
    local variantPos = variantBit(variant)

    return bit.band(data.variants[variantPos.byte] or 0, variantPos.mask) ~= 0
end

---@param variant xi.monstrosityVariant
xi.monstrosity.hasUnlockedVariant = function(player, variant)
    return xi.monstrosity.hasVariantBit(player:getMonstrosityData(), variant)
end

---@param data table
---@param variant xi.monstrosityVariant
xi.monstrosity.setVariantBit = function(data, variant)
    local variantPos = variantBit(variant)
    data.variants[variantPos.byte] = bit.bor(data.variants[variantPos.byte] or 0, variantPos.mask)
end

---@param variant xi.monstrosityVariant
xi.monstrosity.unlockVariant = function(player, variant)
    local data = player:getMonstrosityData()
    xi.monstrosity.setVariantBit(data, variant)
    player:setMonstrosityData(data)
end

-- Purchased instincts sit in bytes 20 to 23 of the instinct field, one bit per instinct.
xi.monstrosity.getPurchasedInstinctBits = function(player)
    local instincts = player:getMonstrosityData().instincts

    return bit.bor(
        instincts[20] or 0,
        bit.lshift(instincts[21] or 0, 8),
        bit.lshift(instincts[22] or 0, 16),
        bit.lshift(instincts[23] or 0, 24)
    )
end

---@param instinct xi.monstrosityInstinct
xi.monstrosity.addPurchasedInstinct = function(player, instinct)
    local data       = player:getMonstrosityData()
    local byteOffset = 20 + math.floor(instinct / 8)
    data.instincts[byteOffset] = bit.bor(data.instincts[byteOffset] or 0, bit.lshift(1, instinct % 8))
    player:setMonstrosityData(data)
end
