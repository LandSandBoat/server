-----------------------------------
-- Event Storage NPCs
-- Olaky-Yayulaky (Windurst Waters), Poudoruchant (Southern San d'Oria), Gallagher (Port Bastok),
-- Garridan (Port Jeuno), Jarafah (Aht Urhgan Whitegate)
-- The NPC holds one of each listed event item for free. Taking it back costs a fee.
-----------------------------------
require('scripts/globals/npc_util')
-----------------------------------
xi = xi or {}
xi.eventStorage = xi.eventStorage or {}

-- { store event, storage menu }
local storageEvents =
{
    [xi.zone.AHT_URHGAN_WHITEGATE] = { 701, 702 },
    [xi.zone.PORT_BASTOK         ] = { 348, 349 },
    [xi.zone.PORT_JEUNO          ] = { 307, 308 },
    [xi.zone.SOUTHERN_SAN_DORIA  ] = { 778, 779 },
    [xi.zone.WINDURST_WATERS     ] = { 909, 910 },
}

-- 250 gil since the December 9, 2008 version update. The era module puts the old 500 back.
xi.eventStorage.withdrawalFee = 250

-- Each category is one parameter of the storage menu.
-- Bit n means the item at position n + 1 is in storage.
-- The client pairs bits with names by position, so the lists stay in the order the NPC recites them.
-- Race and gender locked slots hold every variant.
-- The player can only store the one they can wear.
-- Withdrawal gives the variant for the player's current race, which is how retail converts these items after a race change.
-- The client answers "Remove <item>" with an option number, not the bit.
-- The options for one category are not contiguous. optionBlocks holds { first position, option for that position } per block.
--
-- Source: http://www.playonline.com/ff11us/envi/racechange/
local categories =
{
    -- Furnishings 1
    {
        var          = '[eventStorage]furnishings1',
        optionBlocks = { { 1, 0 }, { 17, 64 } },
        items        =
        {
            xi.item.SAN_DORIAN_HOLIDAY_TREE,
            xi.item.BASTOKAN_HOLIDAY_TREE,
            xi.item.WINDURSTIAN_HOLIDAY_TREE,
            xi.item.KADOMATSU,
            xi.item.WING_EGG,
            xi.item.LAMP_EGG,
            xi.item.FLOWER_EGG,
            xi.item.ADVENTURING_CERTIFICATE,
            xi.item.TIMEPIECE,
            xi.item.MINIATURE_AIRSHIP,
            xi.item.PUMPKIN_LANTERN,
            xi.item.BOMB_LANTERN,
            xi.item.MANDRAGORA_LANTERN,
            xi.item.DREAM_PLATTER,
            xi.item.DREAM_COFFER,
            xi.item.DREAM_STOCKING,
            xi.item.COPY_OF_HOARY_SPIRE,
            xi.item.JEWELED_EGG,
            xi.item.SPRIG_OF_RED_BAMBOO_GRASS,
            xi.item.SPRIG_OF_BLUE_BAMBOO_GRASS,
            xi.item.SPRIG_OF_GREEN_BAMBOO_GRASS,
            xi.item.SNOWMAN_KNIGHT,
            xi.item.SNOWMAN_MINER,
            xi.item.SNOWMAN_MAGE,
            xi.item.BONBORI,
            xi.item.SET_OF_FESTIVAL_DOLLS,
            xi.item.MELODIUS_EGG,
            xi.item.CLOCKWORK_EGG,
            xi.item.HATCHLING_EGG,
            xi.item.HARPSICHORD,
            xi.item.ALDEBARAN_HORN,
        },
    },

    -- Weapons and shields
    {
        var          = '[eventStorage]weapons',
        optionBlocks = { { 1, 16 }, { 17, 92 } },
        items        =
        {
            xi.item.CHOCOBO_WAND,
            xi.item.TRICK_STAFF,
            xi.item.TREAT_STAFF,
            xi.item.TREAT_STAFF_II,
            xi.item.WOODEN_KATANA,
            xi.item.HARDWOOD_KATANA,
            xi.item.PITCHFORK,
            xi.item.PITCHFORK_P1,
            xi.item.CHARM_WAND_P1,
            xi.item.LOTUS_KATANA,
            xi.item.MOOGLE_ROD,
            xi.item.BATTLEDORE,
            xi.item.MIRACLE_WAND_P1,
            xi.item.SHINAI,
            xi.item.IBUSHI_SHINAI,
            xi.item.IBUSHI_SHINAI_P1,
            xi.item.TOWN_MOOGLE_SHIELD,
            xi.item.NOMAD_MOOGLE_SHIELD,
            xi.item.DREAM_BELL,
            xi.item.DREAM_BELL_P1,
        },
    },

    -- Armor - Head
    {
        var          = '[eventStorage]head',
        optionBlocks = { { 1, 32 }, { 17, 80 } },
        items        =
        {
            xi.item.PUMPKIN_HEAD,
            xi.item.HORROR_HEAD,
            xi.item.PUMPKIN_HEAD_II,
            xi.item.HORROR_HEAD_II,
            xi.item.DREAM_HAT,
            xi.item.DREAM_HAT_P1,
            xi.item.SPROUT_BERET,
            xi.item.GUIDE_BERET,
            xi.item.MANDRAGORA_BERET,
            xi.item.WITCH_HAT,
            xi.item.COVEN_HAT,
            xi.item.EGG_HELM,
            xi.item.MOOGLE_CAP,
            xi.item.NOMAD_CAP,
            xi.item.REDEYES,
            xi.item.SOL_CAP,
            xi.item.LUNAR_CAP,
            xi.item.SNOW_BUNNY_HAT_P1,
            xi.item.CHOCOBO_BERET,
        },
    },

    -- Armor - Body, Legs, Feet
    {
        var          = '[eventStorage]body',
        optionBlocks = { { 1, 48 }, { 17, 84 }, { 22, 126 } },
        items        =
        {
            { male = xi.item.ONOKO_YUKATA, female = xi.item.OMINA_YUKATA },
            { male = xi.item.LORDS_YUKATA, female = xi.item.LADYS_YUKATA },
            {
                [xi.race.HUME_M  ] = xi.item.HUME_GILET,
                [xi.race.HUME_F  ] = xi.item.HUME_TOP,
                [xi.race.ELVAAN_M] = xi.item.ELVAAN_GILET,
                [xi.race.ELVAAN_F] = xi.item.ELVAAN_TOP,
                [xi.race.TARU_M  ] = xi.item.TARUTARU_MAILLOT,
                [xi.race.TARU_F  ] = xi.item.TARUTARU_TOP,
                [xi.race.MITHRA  ] = xi.item.MITHRA_TOP,
                [xi.race.GALKA   ] = xi.item.GALKA_GILET,
            },
            {
                [xi.race.HUME_M  ] = xi.item.HUME_GILET_P1,
                [xi.race.HUME_F  ] = xi.item.HUME_TOP_P1,
                [xi.race.ELVAAN_M] = xi.item.ELVAAN_GILET_P1,
                [xi.race.ELVAAN_F] = xi.item.ELVAAN_TOP_P1,
                [xi.race.TARU_M  ] = xi.item.TARUTARU_MAILLOT_P1,
                [xi.race.TARU_F  ] = xi.item.TARUTARU_TOP_P1,
                [xi.race.MITHRA  ] = xi.item.MITHRA_TOP_P1,
                [xi.race.GALKA   ] = xi.item.GALKA_GILET_P1,
            },
            {
                [xi.race.HUME_M  ] = xi.item.HUME_TRUNKS,
                [xi.race.HUME_F  ] = xi.item.HUME_SHORTS,
                [xi.race.ELVAAN_M] = xi.item.ELVAAN_TRUNKS,
                [xi.race.ELVAAN_F] = xi.item.ELVAAN_SHORTS,
                [xi.race.TARU_M  ] = xi.item.TARUTARU_TRUNKS,
                [xi.race.TARU_F  ] = xi.item.TARUTARU_SHORTS,
                [xi.race.MITHRA  ] = xi.item.MITHRA_SHORTS,
                [xi.race.GALKA   ] = xi.item.GALKA_TRUNKS,
            },
            {
                [xi.race.HUME_M  ] = xi.item.HUME_TRUNKS_P1,
                [xi.race.HUME_F  ] = xi.item.HUME_SHORTS_P1,
                [xi.race.ELVAAN_M] = xi.item.ELVAAN_TRUNKS_P1,
                [xi.race.ELVAAN_F] = xi.item.ELVAAN_SHORTS_P1,
                [xi.race.TARU_M  ] = xi.item.TARUTARU_TRUNKS_P1,
                [xi.race.TARU_F  ] = xi.item.TARUTARU_SHORTS_P1,
                [xi.race.MITHRA  ] = xi.item.MITHRA_SHORTS_P1,
                [xi.race.GALKA   ] = xi.item.GALKA_TRUNKS_P1,
            },
            xi.item.DREAM_ROBE,
            xi.item.DREAM_ROBE_P1,
            { male = xi.item.OTOKO_YUKATA, female = xi.item.ONAGO_YUKATA },
            { male = xi.item.OTOKOGIMI_YUKATA, female = xi.item.ONNAGIMI_YUKATA },
            xi.item.DREAM_BOOTS,
            xi.item.DREAM_BOOTS_P1,
            {
                [xi.race.HUME_M  ] = xi.item.CUSTOM_GILET,
                [xi.race.HUME_F  ] = xi.item.CUSTOM_TOP,
                [xi.race.ELVAAN_M] = xi.item.MAGNA_GILET,
                [xi.race.ELVAAN_F] = xi.item.MAGNA_TOP,
                [xi.race.TARU_M  ] = xi.item.WONDER_MAILLOT,
                [xi.race.TARU_F  ] = xi.item.WONDER_TOP,
                [xi.race.MITHRA  ] = xi.item.SAVAGE_TOP,
                [xi.race.GALKA   ] = xi.item.ELDER_GILET,
            },
            {
                [xi.race.HUME_M  ] = xi.item.CUSTOM_GILET_P1,
                [xi.race.HUME_F  ] = xi.item.CUSTOM_TOP_P1,
                [xi.race.ELVAAN_M] = xi.item.MAGNA_GILET_P1,
                [xi.race.ELVAAN_F] = xi.item.MAGNA_TOP_P1,
                [xi.race.TARU_M  ] = xi.item.WONDER_MAILLOT_P1,
                [xi.race.TARU_F  ] = xi.item.WONDER_TOP_P1,
                [xi.race.MITHRA  ] = xi.item.SAVAGE_TOP_P1,
                [xi.race.GALKA   ] = xi.item.ELDER_GILET_P1,
            },
            {
                [xi.race.HUME_M  ] = xi.item.CUSTOM_TRUNKS,
                [xi.race.HUME_F  ] = xi.item.CUSTOM_SHORTS,
                [xi.race.ELVAAN_M] = xi.item.MAGNA_TRUNKS,
                [xi.race.ELVAAN_F] = xi.item.MAGNA_SHORTS,
                [xi.race.TARU_M  ] = xi.item.WONDER_TRUNKS,
                [xi.race.TARU_F  ] = xi.item.WONDER_SHORTS,
                [xi.race.MITHRA  ] = xi.item.SAVAGE_SHORTS,
                [xi.race.GALKA   ] = xi.item.ELDER_TRUNKS,
            },
            {
                [xi.race.HUME_M  ] = xi.item.CUSTOM_TRUNKS_P1,
                [xi.race.HUME_F  ] = xi.item.CUSTOM_SHORTS_P1,
                [xi.race.ELVAAN_M] = xi.item.MAGNA_TRUNKS_P1,
                [xi.race.ELVAAN_F] = xi.item.MAGNA_SHORTS_P1,
                [xi.race.TARU_M  ] = xi.item.WONDER_TRUNKS_P1,
                [xi.race.TARU_F  ] = xi.item.WONDER_SHORTS_P1,
                [xi.race.MITHRA  ] = xi.item.SAVAGE_SHORTS_P1,
                [xi.race.GALKA   ] = xi.item.ELDER_TRUNKS_P1,
            },
            xi.item.EERIE_CLOAK,
            xi.item.EERIE_CLOAK_P1,
            xi.item.TIDAL_TALISMAN,
            { male = xi.item.OTOKOGUSA_YUKATA, female = xi.item.ONNAGUSA_YUKATA },
            { male = xi.item.OTOKOESHI_YUKATA, female = xi.item.OMINAESHI_YUKATA },
            xi.item.DINNER_JACKET,
            xi.item.DINNER_HOSE,
        },
    },

    -- Furnishings 2
    {
        var          = '[eventStorage]furnishings2',
        optionBlocks = { { 1, 96 } },
        items        =
        {
            xi.item.STUFFED_CHOCOBO,
            xi.item.EGG_BUFFET,
            xi.item.ADAMANTOISE_STATUE,
            xi.item.BEHEMOTH_STATUE,
            xi.item.FAFNIR_STATUE,
            xi.item.PEPO_LANTERN,
            xi.item.CUSHAW_LANTERN,
            xi.item.CALABAZILLA_LANTERN,
            xi.item.JEUNOAN_TREE,
            xi.item.SHADOW_LORD_STATUE,
            xi.item.KABUTO_KAZARI,
            xi.item.KATANA_KAZARI,
            xi.item.ODIN_STATUE,
            xi.item.ALEXANDER_STATUE,
            xi.item.CARILLON_VERMEIL,
            xi.item.AEOLSGLOCKE,
            xi.item.LEAFBELL,
            xi.item.SAN_DORIAN_FLAG,
            xi.item.BASTOKAN_FLAG,
            xi.item.WINDURSTIAN_FLAG,
            xi.item.JACK_O_PRICKET,
            xi.item.DJINN_PRICKET,
            xi.item.KORRIGAN_PRICKET,
            xi.item.MANDRAGORA_PRICKET,
        },
    },
}

-- Every storable item id, race and gender variants included, to its category and position.
local slotByItemId = {}

-- The option the client returns for "Remove <item>" to its category and position.
local slotByOption = {}

for categoryIndex, category in ipairs(categories) do
    for position, entry in ipairs(category.items) do
        local slot = { categoryIndex, position }

        if type(entry) == 'table' then
            for _, itemId in pairs(entry) do
                slotByItemId[itemId] = slot
            end
        else
            slotByItemId[entry] = slot
        end

        local blockStart  = 1
        local blockOption = 0
        for _, block in ipairs(category.optionBlocks) do
            if position >= block[1] then
                blockStart  = block[1]
                blockOption = block[2]
            end
        end

        slotByOption[blockOption + position - blockStart] = slot
    end
end

-- The variant of a list entry the player can wear.
local function itemForPlayer(player, entry)
    if type(entry) == 'number' then
        return entry
    end

    -- getGender() returns 1 for male and 0 for female.
    if entry.male then
        return player:getGender() == 1 and entry.male or entry.female
    end

    return entry[player:getRace()]
end

xi.eventStorage.onTrade = function(player, npc, trade)
    local itemId = trade:getItemId(0)
    local slot   = slotByItemId[itemId]

    -- One listed item per trade. Anything else gets no reply.
    if not slot or not npcUtil.tradeMatches(trade, { { itemId, 1 } }) then
        return
    end

    local category = categories[slot[1]]
    local mask     = player:getCharVar(category.var)

    -- Only the variant the player can wear is accepted, and only while that slot is empty.
    if
        itemForPlayer(player, category.items[slot[2]]) ~= itemId or
        utils.mask.getBit(mask, slot[2] - 1)
    then
        return
    end

    -- Retail takes the item at trade time. Skipping the cutscene changes nothing.
    if not player:tradeComplete() then
        return
    end

    player:setCharVar(category.var, utils.mask.setBit(mask, slot[2] - 1, true))
    player:startEvent(storageEvents[player:getZoneID()][1], itemId)
end

xi.eventStorage.onTrigger = function(player, npc)
    local masks = {}
    for categoryIndex, category in ipairs(categories) do
        masks[categoryIndex] = player:getCharVar(category.var)
    end

    -- Furnishings 1, weapons, head, body, the player's gil, furnishings 2. Retail sends garbage in the last two.
    player:startEvent(storageEvents[player:getZoneID()][2], masks[1], masks[2], masks[3], masks[4], player:getGil(), masks[5], 0, 0)
end

xi.eventStorage.onEventFinish = function(player, csid, option, npc)
    local zoneId = player:getZoneID()
    local slot   = slotByOption[option]

    -- Every other way out of the menu returns 0x40000000.
    if csid ~= storageEvents[zoneId][2] or not slot then
        return
    end

    local category = categories[slot[1]]
    local mask     = player:getCharVar(category.var)

    if
        not utils.mask.getBit(mask, slot[2] - 1) or
        player:getGil() < xi.eventStorage.withdrawalFee
    then
        return
    end

    local itemId = itemForPlayer(player, category.items[slot[2]])

    if player:getFreeSlotsCount() == 0 then
        player:messageSpecial(zones[zoneId].text.ITEM_CANNOT_BE_OBTAINED, itemId)
        return
    end

    -- Retail hands an enchanted item back with its recast at the maximum.
    if GetReadOnlyItem(itemId):isSubType(xi.itemSubType.CHARGED) then
        if not player:addUsedItem(itemId) then
            return
        end

        player:messageSpecial(zones[zoneId].text.ITEM_OBTAINED, itemId)
    elseif not npcUtil.giveItem(player, itemId) then
        return
    end

    player:delGil(xi.eventStorage.withdrawalFee)
    player:setCharVar(category.var, utils.mask.setBit(mask, slot[2] - 1, false))
end
