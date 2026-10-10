-----------------------------------
-- Area: Feretory (285)
--  NPC: Suibhne
-- !pos -366 -3.612 -466 285
-----------------------------------
local ID = zones[xi.zone.FERETORY]
-----------------------------------
---@type TNpcEntity
local entity = {}

-- Items Suibhne takes for a family or variant. Event 15 names the unlock as 128 plus a family, or 256 plus a variant.
-- A variant needs its family's base form at a minimum level (JP wiki). JP is silent on the Spriggan variants, so they follow suit.
local tradeUnlocks =
{
    { items = { xi.item.SLIME_FETISH },           count = 1,  species = xi.monstrositySpecies.ASTOLTIAN_SLIME  },
    { items = { xi.item.SPRIGGAN_FETISH },        count = 1,  species = xi.monstrositySpecies.EORZEAN_SPRIGGAN },
    { items = { xi.item.AKE_OME_SPIRIT },         count = 1,  variant = xi.monstrosityVariant.NEW_YEAR_MANDRAGORA,   family = xi.monstrositySpecies.MANDRAGORA,       level = 1  },
    { items = { xi.item.PACHYPODIUM_SPIRIT },     count = 25, variant = xi.monstrosityVariant.PACHYPODIUM,           family = xi.monstrositySpecies.MANDRAGORA,       level = 60 },
    { items = { xi.item.BEETLE_SPIRIT },          count = 25, variant = xi.monstrosityVariant.ONYX_BEETLE,           family = xi.monstrositySpecies.BEETLE,           level = 1  },
    { items = { xi.item.ANTLION_SPIRIT },         count = 25, variant = xi.monstrosityVariant.ONYX_ANTLION,          family = xi.monstrositySpecies.ANTLION,          level = 30 },
    { items = { xi.item.ADAMANTOISE_EGG },        count = 1,  variant = xi.monstrosityVariant.PYGMY_ADAMANTOISE,     family = xi.monstrositySpecies.ADAMANTOISE,      level = 1  },
    { items = { xi.item.SEAL_OF_GENBU_SCRAP },    count = 5,  variant = xi.monstrosityVariant.LEGENDARY_ADAMANTOISE, family = xi.monstrositySpecies.ADAMANTOISE,      level = 50 },
    { items = { xi.item.SEAL_OF_BYAKKO_SCRAP },   count = 5,  variant = xi.monstrosityVariant.LEGENDARY_TIGER,       family = xi.monstrositySpecies.TIGER,            level = 50 },
    { items = { xi.item.SEAL_OF_SUZAKU_SCRAP },   count = 5,  variant = xi.monstrosityVariant.LEGENDARY_ROC,         family = xi.monstrositySpecies.ROC,              level = 50 },
    { items = { xi.item.SHE_SLIME_SPIRIT },       count = 1,  variant = xi.monstrosityVariant.SHE_SLIME,             family = xi.monstrositySpecies.ASTOLTIAN_SLIME,  level = 1  },
    { items = { xi.item.METAL_SLIME_SPIRIT },     count = 1,  variant = xi.monstrosityVariant.METAL_SLIME,           family = xi.monstrositySpecies.ASTOLTIAN_SLIME,  level = 1  },
    { items = { xi.item.RED_SPRIGGAN_SPIRIT },    count = 1,  variant = xi.monstrosityVariant.SPRIGGAN_C,            family = xi.monstrositySpecies.EORZEAN_SPRIGGAN, level = 1  },
    { items = { xi.item.PURPLE_SPRIGGAN_SPIRIT }, count = 1,  variant = xi.monstrosityVariant.SPRIGGAN_G,            family = xi.monstrositySpecies.EORZEAN_SPRIGGAN, level = 1  },

    -- Any one of the four seals, all of a kind.
    {
        items   = { xi.item.SEAL_OF_GENBU_SCRAP, xi.item.SEAL_OF_SUZAKU_SCRAP, xi.item.SEAL_OF_SEIRYU_SCRAP, xi.item.SEAL_OF_BYAKKO_SCRAP },
        count   = 20,
        variant = xi.monstrosityVariant.LEGENDARY_MANTICORE,
        family  = xi.monstrositySpecies.MANTICORE,
        level   = 50,
    },
}

local function isUnlocked(player, unlock)
    if unlock.species then
        return xi.monstrosity.hasUnlockedSpecies(player, unlock.species)
    end

    return xi.monstrosity.hasUnlockedVariant(player, unlock.variant)
end

-- Families past 125 keep their base species code 128 higher.
local function isBaseFormAtLevel(player, unlock)
    if not unlock.family then
        return true
    end

    local data     = player:getMonstrosityData()
    local baseCode = unlock.family > 125 and unlock.family + 128 or unlock.family

    return data.species == baseCode and data.levels[unlock.family] >= unlock.level
end

entity.onTrade = function(player, npc, trade)
    if xi.settings.main.ENABLE_MONSTROSITY ~= 1 then
        return
    end

    for idx, unlock in ipairs(tradeUnlocks) do
        for _, itemId in ipairs(unlock.items) do
            if
                npcUtil.tradeHasExactly(trade, { { itemId, unlock.count } }) and
                not isUnlocked(player, unlock) and
                isBaseFormAtLevel(player, unlock)
            then
                player:setLocalVar('SUIBHNE_TRADE', idx)
                player:startEvent(15, unlock.species and 128 + unlock.species or 256 + unlock.variant, itemId, unlock.count)

                return
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    if xi.settings.main.ENABLE_MONSTROSITY ~= 1 then
        return
    end

    player:showText(npc, ID.text.SINKING_THY_CLAWS)
    player:startEvent(11)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid ~= 15 then
        return
    end

    local unlock = tradeUnlocks[player:getLocalVar('SUIBHNE_TRADE')]
    player:setLocalVar('SUIBHNE_TRADE', 0)

    if
        option ~= 2 or
        not unlock or
        not player:tradeComplete()
    then
        return
    end

    if unlock.species then
        xi.monstrosity.unlockSpecies(player, unlock.species)
    else
        xi.monstrosity.unlockVariant(player, unlock.variant)
    end

    player:messageSpecial(ID.text.MAY_POSSESS_NEW_SPECIES)
end

return entity
