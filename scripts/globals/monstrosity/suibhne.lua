-----------------------------------
-- Monstrosity - Suibhne (Feretory)
-- Takes items for families and variants. The bee quiz is scripts/quests/hiddenQuests/Monstrosity_Bee.lua.
-----------------------------------
xi = xi or {}
xi.monstrosity = xi.monstrosity or {}

-- Items Suibhne takes for a family or variant. Event 15 names the unlock as 128 plus a family, or 256 plus a variant.
-- A variant needs its family's base form, or the listed form, at a minimum level (JP wiki). JP is silent on the
-- Spriggan variants, so they follow suit.
xi.monstrosity.suibhneUnlocks =
{
    {
        items   = { xi.item.SLIME_FETISH },
        count   = 1,
        species = xi.monstrositySpecies.ASTOLTIAN_SLIME,
    },
    {
        items   = { xi.item.SPRIGGAN_FETISH },
        count   = 1,
        species = xi.monstrositySpecies.EORZEAN_SPRIGGAN,
    },
    {
        items   = { xi.item.AKE_OME_SPIRIT },
        count   = 1,
        variant = xi.monstrosityVariant.NEW_YEAR_MANDRAGORA,
        family  = xi.monstrositySpecies.MANDRAGORA,
        level   = 1,
    },
    {
        items   = { xi.item.PACHYPODIUM_SPIRIT },
        count   = 25,
        variant = xi.monstrosityVariant.PACHYPODIUM,
        family  = xi.monstrositySpecies.MANDRAGORA,
        level   = 60,
    },
    {
        items   = { xi.item.BEETLE_SPIRIT },
        count   = 25,
        variant = xi.monstrosityVariant.ONYX_BEETLE,
        family  = xi.monstrositySpecies.BEETLE,
        level   = 1,
    },
    {
        items   = { xi.item.ANTLION_SPIRIT },
        count   = 25,
        variant = xi.monstrosityVariant.ONYX_ANTLION,
        family  = xi.monstrositySpecies.ANTLION,
        level   = 30,
    },
    {
        items   = { xi.item.ADAMANTOISE_EGG },
        count   = 1,
        variant = xi.monstrosityVariant.PYGMY_ADAMANTOISE,
        family  = xi.monstrositySpecies.ADAMANTOISE,
        level   = 1,
    },
    {
        items   = { xi.item.SEAL_OF_GENBU_SCRAP },
        count   = 5,
        variant = xi.monstrosityVariant.LEGENDARY_ADAMANTOISE,
        family  = xi.monstrositySpecies.ADAMANTOISE,
        level   = 50,
    },
    {
        items   = { xi.item.SEAL_OF_BYAKKO_SCRAP },
        count   = 5,
        variant = xi.monstrosityVariant.LEGENDARY_TIGER,
        family  = xi.monstrositySpecies.TIGER,
        level   = 50,
    },
    {
        items   = { xi.item.SEAL_OF_SUZAKU_SCRAP },
        count   = 5,
        variant = xi.monstrosityVariant.LEGENDARY_ROC,
        family  = xi.monstrositySpecies.ROC,
        level   = 50,
    },
    {
        items   = { xi.item.CREEL_OF_MOAT_CARP },
        count   = 1,
        variant = xi.monstrosityVariant.BASKET_BURDENED_CRAB,
        family  = xi.monstrositySpecies.CRAB,
        level   = 1,
    },
    {
        items   = { xi.item.CREEL_OF_FOREST_CARP },
        count   = 1,
        variant = xi.monstrosityVariant.VERMILLION_BASKET_BURDENED_CRAB,
        family  = xi.monstrositySpecies.CRAB,
        form    = 256 + xi.monstrosityVariant.VERMILLION_CRAB,
        level   = 15,
    },
    {
        items   = { xi.item.SHE_SLIME_SPIRIT },
        count   = 1,
        variant = xi.monstrosityVariant.SHE_SLIME,
        family  = xi.monstrositySpecies.ASTOLTIAN_SLIME,
        level   = 1,
    },
    {
        items   = { xi.item.METAL_SLIME_SPIRIT },
        count   = 1,
        variant = xi.monstrosityVariant.METAL_SLIME,
        family  = xi.monstrositySpecies.ASTOLTIAN_SLIME,
        level   = 1,
    },
    {
        items   = { xi.item.RED_SPRIGGAN_SPIRIT },
        count   = 1,
        variant = xi.monstrosityVariant.SPRIGGAN_C,
        family  = xi.monstrositySpecies.EORZEAN_SPRIGGAN,
        level   = 1,
    },
    {
        items   = { xi.item.PURPLE_SPRIGGAN_SPIRIT },
        count   = 1,
        variant = xi.monstrosityVariant.SPRIGGAN_G,
        family  = xi.monstrositySpecies.EORZEAN_SPRIGGAN,
        level   = 1,
    },

    -- Any one of the four seals, all of a kind.
    {
        items   = { xi.item.SEAL_OF_GENBU_SCRAP, xi.item.SEAL_OF_SUZAKU_SCRAP, xi.item.SEAL_OF_SEIRYU_SCRAP, xi.item.SEAL_OF_BYAKKO_SCRAP },
        count   = 20,
        variant = xi.monstrosityVariant.LEGENDARY_MANTICORE,
        family  = xi.monstrositySpecies.MANTICORE,
        level   = 50,
    },
}

-- Families past 125 keep their base species code 128 higher.
local lastLowFamily    = 125
local highFamilyOffset = 128

-- Takes the Monstrosity data rather than the player, as building it is costly.
xi.monstrosity.canSuibhneUnlock = function(data, unlock)
    if unlock.species then
        return data.levels[unlock.species] == 0
    end

    if xi.monstrosity.hasVariantBit(data, unlock.variant) then
        return false
    end

    local baseCode = unlock.family
    if unlock.family > lastLowFamily then
        baseCode = unlock.family + highFamilyOffset
    end

    return data.species == (unlock.form or baseCode) and data.levels[unlock.family] >= unlock.level
end

-- JP wiki: in a form that qualifies, Suibhne names one item at random. Any qualifying item is still accepted.
xi.monstrosity.suibhneGreet = function(player, npc)
    local data     = player:getMonstrosityData()
    local requests = {}
    for _, unlock in ipairs(xi.monstrosity.suibhneUnlocks) do
        if unlock.family and xi.monstrosity.canSuibhneUnlock(data, unlock) then
            table.insert(requests, unlock)
        end
    end

    local ID = zones[xi.zone.FERETORY]
    if #requests == 0 then
        player:showText(npc, ID.text.SINKING_THY_CLAWS)
        return
    end

    local request = utils.randomEntry(requests)
    player:showText(npc, ID.text.BRING_ME_ITEM, utils.randomEntry(request.items), request.count)
end
