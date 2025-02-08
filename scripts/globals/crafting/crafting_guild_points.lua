-----------------------------------
-- Guild Point NPCs (Union Representatives)
-----------------------------------
require('scripts/globals/crafting/crafting_utils')
require('scripts/globals/npc_util')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.crafting = xi.crafting or {}

-----------------------------------
-- Data
-----------------------------------
---@class hqCrystals : { id: xi.item, cost: integer }
local hqCrystals =
{
    [0] = { id = xi.item.ROBBER_RIG,       cost = 1500 }, -- Robber Rig is located in category 3. Not a typo.
    [1] = { id = xi.item.INFERNO_CRYSTAL,  cost =  200 },
    [2] = { id = xi.item.GLACIER_CRYSTAL,  cost =  200 },
    [3] = { id = xi.item.CYCLONE_CRYSTAL,  cost =  200 },
    [4] = { id = xi.item.TERRA_CRYSTAL,    cost =  200 },
    [5] = { id = xi.item.PLASMA_CRYSTAL,   cost =  200 },
    [6] = { id = xi.item.TORRENT_CRYSTAL,  cost =  200 },
    [7] = { id = xi.item.AURORA_CRYSTAL,   cost =  500 },
    [8] = { id = xi.item.TWILIGHT_CRYSTAL, cost =  500 },
}

local guildKeyItemTable =
{
    [xi.guild.FISHING] =
    {
        [0] = { id = xi.ki.FROG_FISHING,    rank = xi.craftRank.NOVICE,  cost =  30000 },
        [1] = { id = xi.ki.SERPENT_RUMORS,  rank = xi.craftRank.ADEPT,   cost =  95000 },
        [2] = { id = xi.ki.MOOCHING,        rank = xi.craftRank.VETERAN, cost = 115000 },
        [3] = { id = xi.ki.ANGLERS_ALMANAC, rank = xi.craftRank.VETERAN, cost =  20000 },
    },
    [xi.guild.WOODWORKING] =
    {
        [0] = { id = xi.ki.WOOD_PURIFICATION,    rank = xi.craftRank.NOVICE,  cost = 40000 },
        [1] = { id = xi.ki.WOOD_ENSORCELLMENT,   rank = xi.craftRank.NOVICE,  cost = 40000 },
        [2] = { id = xi.ki.LUMBERJACK,           rank = xi.craftRank.NOVICE,  cost = 10000 },
        [3] = { id = xi.ki.BOLTMAKER,            rank = xi.craftRank.NOVICE,  cost = 10000 },
        [4] = { id = xi.ki.WAY_OF_THE_CARPENTER, rank = xi.craftRank.VETERAN, cost = 20000 },
    },
    [xi.guild.SMITHING] =
    {
        [0] = { id = xi.ki.METAL_PURIFICATION,    rank = xi.craftRank.NOVICE,  cost = 40000 },
        [1] = { id = xi.ki.METAL_ENSORCELLMENT,   rank = xi.craftRank.NOVICE,  cost = 40000 },
        [2] = { id = xi.ki.CHAINWORK,             rank = xi.craftRank.NOVICE,  cost = 10000 },
        [3] = { id = xi.ki.SHEETING,              rank = xi.craftRank.NOVICE,  cost = 10000 },
        [4] = { id = xi.ki.WAY_OF_THE_BLACKSMITH, rank = xi.craftRank.VETERAN, cost = 20000 },
    },
    [xi.guild.GOLDSMITHING] =
    {
        [0] = { id = xi.ki.GOLD_PURIFICATION,    rank = xi.craftRank.NOVICE,  cost = 40000 },
        [1] = { id = xi.ki.GOLD_ENSORCELLMENT,   rank = xi.craftRank.NOVICE,  cost = 40000 },
        [2] = { id = xi.ki.CHAINWORK,            rank = xi.craftRank.NOVICE,  cost = 10000 },
        [3] = { id = xi.ki.SHEETING,             rank = xi.craftRank.NOVICE,  cost = 10000 },
        [4] = { id = xi.ki.CLOCKMAKING,          rank = xi.craftRank.NOVICE,  cost = 10000 },
        [5] = { id = xi.ki.WAY_OF_THE_GOLDSMITH, rank = xi.craftRank.VETERAN, cost = 20000 },
    },
    [xi.guild.CLOTHCRAFT] =
    {
        [0] = { id = xi.ki.CLOTH_PURIFICATION,  rank = xi.craftRank.NOVICE,  cost = 40000 },
        [1] = { id = xi.ki.CLOTH_ENSORCELLMENT, rank = xi.craftRank.NOVICE,  cost = 40000 },
        [2] = { id = xi.ki.SPINNING,            rank = xi.craftRank.NOVICE,  cost = 10000 },
        [3] = { id = xi.ki.FLETCHING,           rank = xi.craftRank.NOVICE,  cost = 10000 },
        [4] = { id = xi.ki.WAY_OF_THE_WEAVER,   rank = xi.craftRank.VETERAN, cost = 20000 },
    },
    [xi.guild.LEATHERCRAFT] =
    {
        [0] = { id = xi.ki.LEATHER_PURIFICATION,  rank = xi.craftRank.NOVICE,  cost = 40000 },
        [1] = { id = xi.ki.LEATHER_ENSORCELLMENT, rank = xi.craftRank.NOVICE,  cost = 40000 },
        [2] = { id = xi.ki.TANNING,               rank = xi.craftRank.NOVICE,  cost = 10000 },
        [3] = { id = xi.ki.WAY_OF_THE_TANNER,     rank = xi.craftRank.VETERAN, cost = 20000 },
    },
    [xi.guild.BONECRAFT] =
    {
        [0] = { id = xi.ki.BONE_PURIFICATION,     rank = xi.craftRank.NOVICE,  cost = 40000 },
        [1] = { id = xi.ki.BONE_ENSORCELLMENT,    rank = xi.craftRank.NOVICE,  cost = 40000 },
        [2] = { id = xi.ki.FILING,                rank = xi.craftRank.NOVICE,  cost = 10000 },
        [3] = { id = xi.ki.WAY_OF_THE_BONEWORKER, rank = xi.craftRank.VETERAN, cost = 20000 },
    },
    [xi.guild.ALCHEMY] =
    {
        [0] = { id = xi.ki.ANIMA_SYNTHESIS,        rank = xi.craftRank.NOVICE,  cost = 20000 },
        [1] = { id = xi.ki.ALCHEMIC_PURIFICATION,  rank = xi.craftRank.NOVICE,  cost = 40000 },
        [2] = { id = xi.ki.ALCHEMIC_ENSORCELLMENT, rank = xi.craftRank.NOVICE,  cost = 40000 },
        [3] = { id = xi.ki.TRITURATION,            rank = xi.craftRank.NOVICE,  cost = 10000 },
        [4] = { id = xi.ki.CONCOCTION,             rank = xi.craftRank.NOVICE,  cost = 20000 },
        [5] = { id = xi.ki.IATROCHEMISTRY,         rank = xi.craftRank.NOVICE,  cost = 10000 },
        [6] = { id = xi.ki.WAY_OF_THE_ALCHEMIST,   rank = xi.craftRank.VETERAN, cost = 20000 },
    },
    [xi.guild.COOKING] =
    {
        [0] = { id = xi.ki.RAW_FISH_HANDLING,     rank = xi.craftRank.NOVICE,  cost = 30000 },
        [1] = { id = xi.ki.NOODLE_KNEADING,       rank = xi.craftRank.NOVICE,  cost = 30000 },
        [2] = { id = xi.ki.PATISSIER,             rank = xi.craftRank.NOVICE,  cost =  8000 },
        [3] = { id = xi.ki.STEWPOT_MASTERY,       rank = xi.craftRank.NOVICE,  cost = 30000 },
        [4] = { id = xi.ki.WAY_OF_THE_CULINARIAN, rank = xi.craftRank.VETERAN, cost = 20000 },
    },
}

local guildItemTable =
{
    [xi.guild.FISHING] =
    {
        [0] = { id = xi.item.FISHERMANS_BELT,      rank = xi.craftRank.APPRENTICE, cost =  10000 },
        [1] = { id = xi.item.WADERS,               rank = xi.craftRank.JOURNEYMAN, cost =  70000 },
        [2] = { id = xi.item.FISHERMANS_APRON,     rank = xi.craftRank.ARTISAN,    cost = 100000 },
        [3] = { id = xi.item.FISHING_HOLE_MAP,     rank = xi.craftRank.VETERAN,    cost = 150000 },
        [4] = { id = xi.item.FISHERMANS_SIGNBOARD, rank = xi.craftRank.VETERAN,    cost = 200000 },
        -- There is a blank space here. Robber Rig SHOULD be here, but it isnt. It's with the crystals.
        [6] = { id = xi.item.NET_AND_LURE,         rank = xi.craftRank.ARTISAN,    cost =  50000 },
        [7] = { id = xi.item.FISHERMENS_EMBLEM,    rank = xi.craftRank.VETERAN,    cost =  15000 },
    },
    [xi.guild.WOODWORKING] =
    {
        [0] = { id = xi.item.CARPENTERS_BELT,      rank = xi.craftRank.NOVICE,     cost =  10000 },
        [1] = { id = xi.item.CARPENTERS_GLOVES,    rank = xi.craftRank.JOURNEYMAN, cost =  70000 },
        [2] = { id = xi.item.CARPENTERS_APRON,     rank = xi.craftRank.ARTISAN,    cost = 100000 },
        [3] = { id = xi.item.DRAWING_DESK,         rank = xi.craftRank.VETERAN,    cost = 150000 },
        [4] = { id = xi.item.CARPENTERS_SIGNBOARD, rank = xi.craftRank.VETERAN,    cost = 200000 },
        [5] = { id = xi.item.CARPENTERS_RING,      rank = xi.craftRank.CRAFTSMAN,  cost =  80000 },
        [6] = { id = xi.item.CARPENTERS_KIT,       rank = xi.craftRank.ARTISAN,    cost =  50000 },
        [7] = { id = xi.item.CARPENTERS_EMBLEM,    rank = xi.craftRank.VETERAN,    cost =  15000 },
    },
    [xi.guild.SMITHING] =
    {
        [0] = { id = xi.item.BLACKSMITHS_BELT,      rank = xi.craftRank.NOVICE,     cost =  10000 },
        [1] = { id = xi.item.SMITHYS_MITTS,         rank = xi.craftRank.JOURNEYMAN, cost =  70000 },
        [2] = { id = xi.item.BLACKSMITHS_APRON,     rank = xi.craftRank.ARTISAN,    cost = 100000 },
        [3] = { id = xi.item.MASTERSMITH_ANVIL,     rank = xi.craftRank.VETERAN,    cost = 150000 },
        [4] = { id = xi.item.BLACKSMITHS_SIGNBOARD, rank = xi.craftRank.VETERAN,    cost = 200000 },
        [5] = { id = xi.item.SMITHS_RING,           rank = xi.craftRank.CRAFTSMAN,  cost =  80000 },
        [6] = { id = xi.item.STONE_HEARTH,          rank = xi.craftRank.ARTISAN,    cost =  50000 },
        [7] = { id = xi.item.BLACKSMITHS_EMBLEM,    rank = xi.craftRank.VETERAN,    cost =  15000 },
    },
    [xi.guild.GOLDSMITHING] =
    {
        [0] = { id = xi.item.GOLDSMITHS_BELT,      rank = xi.craftRank.NOVICE,     cost =  10000 },
        [1] = { id = xi.item.SHADED_SPECTACLES,    rank = xi.craftRank.JOURNEYMAN, cost =  70000 },
        [2] = { id = xi.item.GOLDSMITHS_APRON,     rank = xi.craftRank.ARTISAN,    cost = 100000 },
        [3] = { id = xi.item.STACK_OF_FOOLS_GOLD,  rank = xi.craftRank.VETERAN,    cost = 150000 },
        [4] = { id = xi.item.GOLDSMITHS_SIGNBOARD, rank = xi.craftRank.VETERAN,    cost = 200000 },
        [5] = { id = xi.item.GOLDSMITHS_RING,      rank = xi.craftRank.CRAFTSMAN,  cost =  80000 },
        [6] = { id = xi.item.GEMSCOPE,             rank = xi.craftRank.ARTISAN,    cost =  50000 },
        [7] = { id = xi.item.GOLDSMITHS_EMBLEM,    rank = xi.craftRank.VETERAN,    cost =  15000 },
    },
    [xi.guild.CLOTHCRAFT] =
    {
        [0] = { id = xi.item.WEAVERS_BELT,          rank = xi.craftRank.NOVICE,     cost =  10000 },
        [1] = { id = xi.item.MAGNIFYING_SPECTACLES, rank = xi.craftRank.JOURNEYMAN, cost =  70000 },
        [2] = { id = xi.item.WEAVERS_APRON,         rank = xi.craftRank.ARTISAN,    cost = 100000 },
        [3] = { id = xi.item.GILT_TAPESTRY,         rank = xi.craftRank.VETERAN,    cost = 150000 },
        [4] = { id = xi.item.WEAVERS_SIGNBOARD,     rank = xi.craftRank.VETERAN,    cost = 200000 },
        [5] = { id = xi.item.TAILORS_RING,          rank = xi.craftRank.CRAFTSMAN,  cost =  80000 },
        [6] = { id = xi.item.SPINNING_WHEEL,        rank = xi.craftRank.ARTISAN,    cost =  50000 },
        [7] = { id = xi.item.WEAVERS_EMBLEM,        rank = xi.craftRank.VETERAN,    cost =  15000 },
    },
    [xi.guild.LEATHERCRAFT] =
    {
        [0] = { id = xi.item.TANNERS_BELT,      rank = xi.craftRank.NOVICE,     cost =  10000 },
        [1] = { id = xi.item.TANNERS_GLOVES,    rank = xi.craftRank.JOURNEYMAN, cost =  70000 },
        [2] = { id = xi.item.TANNERS_APRON,     rank = xi.craftRank.ARTISAN,    cost = 100000 },
        [3] = { id = xi.item.GOLDEN_FLEECE,     rank = xi.craftRank.VETERAN,    cost = 150000 },
        [4] = { id = xi.item.TANNERS_SIGNBOARD, rank = xi.craftRank.VETERAN,    cost = 200000 },
        [5] = { id = xi.item.TANNERS_RING,      rank = xi.craftRank.CRAFTSMAN,  cost =  80000 },
        [6] = { id = xi.item.HIDE_STRETCHER,    rank = xi.craftRank.ARTISAN,    cost =  50000 },
        [7] = { id = xi.item.TANNERS_EMBLEM,    rank = xi.craftRank.VETERAN,    cost =  15000 },
    },
    [xi.guild.BONECRAFT] =
    {
        [0] = { id = xi.item.BONEWORKERS_BELT,          rank = xi.craftRank.NOVICE,     cost =  10000 },
        [1] = { id = xi.item.PROTECTIVE_SPECTACLES,     rank = xi.craftRank.JOURNEYMAN, cost =  70000 },
        [2] = { id = xi.item.BONEWORKERS_APRON,         rank = xi.craftRank.ARTISAN,    cost = 100000 },
        [3] = { id = xi.item.DROGAROGAS_FANG,           rank = xi.craftRank.VETERAN,    cost = 150000 },
        [4] = { id = xi.item.BONEWORKERS_SIGNBOARD,     rank = xi.craftRank.VETERAN,    cost = 200000 },
        [5] = { id = xi.item.BONECRAFTERS_RING,         rank = xi.craftRank.CRAFTSMAN,  cost =  80000 },
        [6] = { id = xi.item.SET_OF_BONECRAFTING_TOOLS, rank = xi.craftRank.ARTISAN,    cost =  50000 },
        [7] = { id = xi.item.BONEWORKERS_EMBLEM,        rank = xi.craftRank.VETERAN,    cost =  15000 },
    },
    [xi.guild.ALCHEMY] =
    {
        [0] = { id = xi.item.ALCHEMISTS_BELT,      rank = xi.craftRank.NOVICE,     cost =  10000 },
        [1] = { id = xi.item.CADUCEUS,             rank = xi.craftRank.JOURNEYMAN, cost =  70000 },
        [2] = { id = xi.item.ALCHEMISTS_APRON,     rank = xi.craftRank.ARTISAN,    cost = 100000 },
        [3] = { id = xi.item.COPY_OF_EMERALDA,     rank = xi.craftRank.VETERAN,    cost = 150000 },
        [4] = { id = xi.item.ALCHEMISTS_SIGNBOARD, rank = xi.craftRank.VETERAN,    cost = 200000 },
        [5] = { id = xi.item.ALCHEMISTS_RING,      rank = xi.craftRank.CRAFTSMAN,  cost =  80000 },
        [6] = { id = xi.item.ALEMBIC,              rank = xi.craftRank.ARTISAN,    cost =  50000 },
        [7] = { id = xi.item.ALCHEMISTS_EMBLEM,    rank = xi.craftRank.VETERAN,    cost =  15000 },
    },
    [xi.guild.COOKING] =
    {
        [0] = { id = xi.item.CULINARIANS_BELT,        rank = xi.craftRank.NOVICE,     cost =  10000 },
        [1] = { id = xi.item.CHEFS_HAT,               rank = xi.craftRank.JOURNEYMAN, cost =  70000 },
        [2] = { id = xi.item.CULINARIANS_APRON,       rank = xi.craftRank.ARTISAN,    cost = 100000 },
        [3] = { id = xi.item.CORDON_BLEU_COOKING_SET, rank = xi.craftRank.VETERAN,    cost = 150000 },
        [4] = { id = xi.item.CULINARIANS_SIGNBOARD,   rank = xi.craftRank.VETERAN,    cost = 200000 },
        [5] = { id = xi.item.CHEFS_RING,              rank = xi.craftRank.CRAFTSMAN,  cost =  80000 },
        [6] = { id = xi.item.BRASS_CROCK,             rank = xi.craftRank.ARTISAN,    cost =  50000 },
        [7] = { id = xi.item.CULINARIANS_EMBLEM,      rank = xi.craftRank.VETERAN,    cost =  15000 },
    },
}

local function calculateKeyItemBitmask(player, rank, keyItemTable)
    local keyItemBits = 0

    for currentBit, keyItem in pairs(keyItemTable) do
        if rank >= keyItem.rank then
            if not player:hasKeyItem(keyItem.id) then
                keyItemBits = bit.bor(keyItemBits, bit.lshift(1, currentBit))
            end
        end
    end

    return keyItemBits
end

-----------------------------------
-- NPC Events
-----------------------------------
xi.crafting.guildPointOnTrade = function(player, npc, trade, csid, guildId)
    local ID                 = zones[player:getZoneID()]
    local _, remainingPoints = player:getCurrentGPItem(guildId)

    if player:getCharVar('[GUILD]currentGuild') - 1 == guildId then
        if remainingPoints == 0 then
            player:messageText(npc, ID.text.NO_MORE_GP_ELIGIBLE)
        else
            local totalPoints = 0
            for tradeSlot = 0, 8 do
                local items, points = player:addGuildPoints(guildId, tradeSlot)

                if items ~= 0 and points ~= 0 then
                    totalPoints = totalPoints + points
                    trade:confirmSlot(tradeSlot, items)
                end
            end

            if totalPoints > 0 then
                player:confirmTrade()
                player:startEvent(csid, totalPoints)
            end
        end
    end
end

xi.crafting.guildPointOnTrigger = function(player, csid, guildId)
    local currency                = xi.crafting.guildTable[guildId][2]
    local gpItem, remainingPoints = player:getCurrentGPItem(guildId)
    local rank                    = player:getSkillRank(xi.crafting.guildTable[guildId][1])
    local skillCap                = (rank + 1) * 10
    local keyItemBits             = calculateKeyItemBitmask(player, rank, guildKeyItemTable[guildId])

    player:startEvent(csid, player:getCurrency(currency), player:getCharVar('[GUILD]currentGuild') - 1, gpItem, remainingPoints, skillCap, 0, keyItemBits, 0)
end

xi.crafting.guildPointOnEventUpdate = function(player, option, target, guildId)
    local category           = bit.band(bit.rshift(option, 2), 3)

    local ID                 = zones[player:getZoneID()]
    local _, remainingPoints = player:getCurrentGPItem(guildId)
    local rank               = player:getSkillRank(xi.crafting.guildTable[guildId][1])
    local skillCap           = (rank + 1) * 10
    local currency           = xi.crafting.guildTable[guildId][2]
    local keyItems           = guildKeyItemTable[guildId]

    -- GP Key Item Option.
    if category == 3 then
        local keyItem = keyItems[bit.band(bit.rshift(option, 5), 15) - 1]

        if keyItem and rank >= keyItem.rank then
            if player:getCurrency(currency) >= keyItem.cost then
                player:delCurrency(currency, keyItem.cost)
                npcUtil.giveKeyItem(player, keyItem.id)
            else
                player:messageText(target, ID.text.NOT_HAVE_ENOUGH_GP, false, 6)
            end
        end

        player:updateEvent(player:getCurrency(currency), player:getCharVar('[GUILD]currentGuild') - 1, keyItem.cost, remainingPoints, skillCap, 0, calculateKeyItemBitmask(player, rank, guildKeyItemTable[guildId]), 1)

    -- GP Item Option.
    elseif category == 2 or category == 1 then
        local index    = bit.band(option, 3)
        local items    = guildItemTable[guildId]
        local item     = items[(category - 1) * 4 + index]
        local quantity = math.min(bit.rshift(option, 9), 12)
        local cost     = quantity * item.cost

        if item and rank >= item.rank then
            if player:getCurrency(currency) >= cost then
                local delivered = 0

                for count = 1, quantity do -- addItem does not appear to honor quantity if the item doesn't stack.
                    if player:addItem(item.id, true) then
                        player:delCurrency(currency, item.cost)
                        player:messageSpecial(ID.text.ITEM_OBTAINED, item.id)
                        delivered = delivered + 1
                    end
                end

                if delivered == 0 then
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item.id)
                end
            else
                player:messageText(target, ID.text.NOT_HAVE_ENOUGH_GP, false, 6)
            end
        end

        player:updateEvent(player:getCurrency(currency), player:getCharVar('[GUILD]currentGuild') - 1, item.cost, remainingPoints, skillCap, 0, calculateKeyItemBitmask(player, rank, guildKeyItemTable[guildId]), 1)

    -- HQ crystal Option.
    elseif
        category == 0 and
        option ~= utils.EVENT_CANCELLED_OPTION
    then
        local crystal  = hqCrystals[bit.band(bit.rshift(option, 5), 15)]
        local quantity = bit.rshift(option, 9)
        local cost     = quantity * crystal.cost

        if crystal and rank >= 3 then
            if
                player:getCurrency(currency) >= cost and
                npcUtil.giveItem(player, { { crystal.id, quantity } })
            then
                player:delCurrency(currency, cost)
            else
                player:messageText(target, ID.text.NOT_HAVE_ENOUGH_GP, false, 6)
            end
        end

        player:updateEvent(player:getCurrency(currency), player:getCharVar('[GUILD]currentGuild') - 1, crystal.cost, remainingPoints, skillCap, 0, calculateKeyItemBitmask(player, rank, guildKeyItemTable[guildId]), 1)
    end
end

xi.crafting.guildPointOnEventFinish = function(player, option, guildId)
    local ID   = zones[player:getZoneID()]
    local rank = player:getSkillRank(xi.crafting.guildTable[guildId][1])

    -- Contract Dialog.
    if bit.tobit(option) == -1 and rank >= 3 then
        local oldGuild = player:getCharVar('[GUILD]currentGuild') - 1
        player:setCharVar('[GUILD]currentGuild', guildId + 1)

        if oldGuild == -1 then
            player:messageSpecial(ID.text.GUILD_NEW_CONTRACT, guildId)
        else
            player:messageSpecial(ID.text.GUILD_TERMINATE_CONTRACT, guildId, oldGuild)
            player:setCharVar('[GUILD]daily_points', 1)
        end
    end
end
