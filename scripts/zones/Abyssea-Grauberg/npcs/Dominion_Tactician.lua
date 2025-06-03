-----------------------------------
-- Area: Abyssea - Grauberg
--  NPC: Dominion Tactician
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_GRAUBERG]
-----------------------------------
---@type TNpcEntity
local entity = {}

local itemType =
{
    ITEM        = 1,
    TEMP        = 2,
    AUGMENTED   = 3,
}

local tacticianItems =
{
    [itemType.ITEM] =
    {
    --  Sel      Item                       Cost
        [ 1] = { xi.item.UNKAI_DOMARU,     1500 },
        [ 2] = { xi.item.IGA_NINGI,        1500 },
        [ 3] = { xi.item.LANCERS_PLACKART, 1500 },
        [ 4] = { xi.item.CALLERS_DOUBLET,  1500 },
        [ 5] = { xi.item.MAVI_MINTAN,      1500 },
        [ 6] = { xi.item.NAVARCHS_FRAC,    1500 },
        [ 7] = { xi.item.CIRQUE_FARSETTO,  1500 },
        [ 8] = { xi.item.CHARIS_CASAQUE,   1500 },
        [ 9] = { xi.item.SAVANTS_GOWN,     1500 },
        [10] = { xi.item.INCRESCENT_SHADE,  300 },
        [11] = { xi.item.DECRESCENT_SHADE,  300 },
    },

    [itemType.TEMP] =
    {
    --  Sel      Item                    Cost
        [1] = { xi.item.PETRIFY_SCREEN, 300 },
        [2] = { xi.item.TERROR_SCREEN,  300 },
        [3] = { xi.item.AMNESIA_SCREEN, 300 },
        [4] = { xi.item.DOOM_SCREEN,    300 },
        [5] = { xi.item.POISON_SCREEN,  300 },
    },

    [itemType.AUGMENTED] =
    {
    --  Sel     Item                 Cost  Possible Augments { Augment ID, Minimum, Maximum }
        [1] = { xi.item.YATAGHAN,   2500, { { 45, 1,  8 }, { 328, 2, 6 }, { 187, 2, 6 }, { 787, 3, 8 }, { 1028, 2, 6 } } }, -- TODO: Should Aug 45 (DMG+) also apply Sub DMG?
        [2] = { xi.item.DOOM_TABAR, 2500, { { 45, 4, 12 }, { 786, 3, 7 }, { 512, 3, 8 }, { 250, 3, 6 }, { 1040, 2, 8 } } },
        [3] = { xi.item.YUKITSUGU,  2500, { { 45, 5, 14 }, { 177, 3, 6 }, { 332, 2, 6 }, { 788, 3, 7 }, { 1060, 2, 8 } } },
    },
}

-- This table and the following two functions can possibly be moved somewhere else in the future.  This is an attempt at
-- standardizing some of the augmented item logic.  If we end up recycling this code for other areas, augmentChance will
-- need to be passed into the giveAugmentedItem function.
local augmentChance =
{
    100,
    50,
    0,
    0,
}

local function isDuplicateAugment(paramList, augmentID)
    for i = 3, 9, 2 do
        if augmentID == paramList[i] then
            return true
        end
    end

    return false
end

local function giveAugmentedItem(player, itemID, augmentList, maxAugments)
    local itemParams = { itemID, 1, 0, 0, 0, 0, 0, 0, 0, 0 }
    local paramIndex = 3

    for i = 1, maxAugments do
        if math.random(1, 100) <= augmentChance[i] then
            local augmentTable = augmentList[math.random(1, #augmentList)]

            if not isDuplicateAugment(itemParams, augmentTable[1]) then
                itemParams[paramIndex] = augmentTable[1]
                itemParams[paramIndex + 1] = math.random(augmentTable[2], augmentTable[3])
                paramIndex = paramIndex + 2
            end
        end
    end

    if player:addItem(unpack(itemParams)) then
        player:messageSpecial(ID.text.ITEM_OBTAINED, itemID)
    else
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, itemID)
    end
end

entity.onTrigger = function(player, npc)
    local dominionNotes = player:getCurrency('dominion_note')
    local trophyMask = 0 -- 5 bits per trophy, cap at 30ea (31 can be displayed, but non-retail), 5th echelon is least sig

    player:startEvent(120, dominionNotes, 0, 0, 0, 0, trophyMask)
end

entity.onEventUpdate = function(player, csid, option, npc)
    local menuCategory = bit.band(option, 0xF)

    if menuCategory == 6 then
        -- TODO: Update percentages for each NM in question for the selected
        -- page.  Page selection is bit.rshift(option, 8)
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local itemCategory = bit.band(option, 0xF)
    local itemSelected = bit.rshift(option, 8)
    local dominionNotes = player:getCurrency('dominion_note')

    if
        itemCategory >= 1 and
        itemCategory <= 3 and
        dominionNotes >= tacticianItems[itemCategory][itemSelected][2]
    then
        local itemData = tacticianItems[itemCategory][itemSelected]

        if itemCategory == itemType.ITEM then
            if npcUtil.giveItem(player, { { itemData[1], 1 } }) then
                player:delCurrency('dominion_note', itemData[2])
            end
        elseif itemCategory == itemType.TEMP then
            if npcUtil.giveTempItem(player, { { itemData[1], 1 } }) then
                player:delCurrency('dominion_note', itemData[2])
            end
        elseif itemCategory == itemType.AUGMENTED then
            if giveAugmentedItem(player, itemData[1], itemData[3], 2) then
                player:delCurrency('dominion_note', itemData[2])
            end
        end
    end
end

return entity
