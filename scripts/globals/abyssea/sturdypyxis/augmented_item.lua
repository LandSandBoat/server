-----------------------------------
-- Abyssea Sturdy Pyxis - Augmented item
-----------------------------------
xi = xi or {}
xi.pyxis = xi.pyxis or {}

xi.pyxis.augItem = {}
-----------------------------------
-- drop id's for augmented items
-- uses zone id as the key
-----------------------------------
local augdrops =
{
    [xi.zone.ABYSSEA_KONSCHTAT] =
    {
        xi.item.DARK_RING,
        xi.item.TOWER_SHIELD,
        xi.item.WIVRE_HAIRPIN,
    },

    [xi.zone.ABYSSEA_TAHRONGI] =
    {
        xi.item.ADAMAN_BARBUTA,
        xi.item.DEMONS_RING,
        xi.item.WIVRE_GORGET,
    },

    [xi.zone.ABYSSEA_LA_THEINE] =
    {
        xi.item.JEWELED_COLLAR,
        xi.item.RASETSU_JINPACHI,
        xi.item.TARUTARU_SASH,
    },

    [xi.zone.ABYSSEA_ATTOHWA] =
    {
        xi.item.GLEAMING_SPEAR,
        xi.item.LORE_SLOPS,
        xi.item.VERSA_MUFFLERS,
    },

    [xi.zone.ABYSSEA_MISAREAUX] =
    {
        xi.item.GULES_LEGGINGS,
        xi.item.GLEAMING_ZAGHNAL,
        xi.item.LIGHT_EARRING,
    },

    [xi.zone.ABYSSEA_VUNKERL] =
    {
        xi.item.DIAMOND_RING,
        xi.item.GULES_MITTENS,
        xi.item.LORE_SABOTS,
    },

    [xi.zone.ABYSSEA_ALTEPA] =
    {
        xi.item.FIRMAMENT,
        xi.item.GUISARME,
        xi.item.RIBAULDEQUIN,
    },

    [xi.zone.ABYSSEA_ULEGUERAND] =
    {
        xi.item.DIRE_SCYTHE,
        xi.item.SAVATE_FISTS,
        xi.item.VODUN_MACE,
    },

    [xi.zone.ABYSSEA_GRAUBERG] =
    {
        xi.item.DOOM_TABAR,
        xi.item.YATAGHAN,
        xi.item.YUKITSUGU,
    },
}

-----------------------------------
-- augs table holds potential augments with min/max values to be randomised for each item id
-- example: Tarutaru sash [13212] would have 6 potential augments, each with its own values
-----------------------------------
local augs =
{
    [xi.item.DARK_RING] =
    {
        augments =
        {
            { aug = 42, min = 1, max = 3 },
            { aug = 56, min = 1, max = 6 },
            { aug = 33, min = 2, max = 4 },
            { aug = 53, min = 1, max = 5 },
            { aug = 55, min = 1, max = 6 },
            { aug = 54, min = 1, max = 6 },
        },
    },

    [xi.item.TOWER_SHIELD] =
    {
        augments =
        {
            { aug = 1,   min = 2, max = 17 },
            { aug = 180, min = 1, max = 4  },
            { aug = 181, min = 1, max = 5  },
            { aug = 188, min = 1, max = 5  },
            { aug = 153, min = 1, max = 2  },
            { aug = 39,  min = 1, max = 2  },
        },
    },

    [xi.item.WIVRE_HAIRPIN] =
    {
        augments =
        {
            { aug = 771, min = 1,  max = 10 },
            { aug = 773, min = 1,  max = 10 },
            { aug = 769, min = 1,  max = 10 },
            { aug = 775, min = 1,  max = 10 },
            { aug = 9,   min = 10, max = 16 },
            { aug = 138, min = 1,  max = 1  },
        },
    },

    [xi.item.ADAMAN_BARBUTA] =
    {
        augments =
        {
            { aug = 774, min = 1, max = 9  },
            { aug = 137, min = 1, max = 3  },
            { aug = 188, min = 1, max = 5  },
            { aug = 53,  min = 1, max = 3  },
            { aug = 329, min = 2, max = 5  },
            { aug = 137, min = 1, max = 1  },
            { aug = 1,   min = 1, max = 16 },
        },
    },

    [xi.item.DEMONS_RING] =
    {
        augments =
        {
            { aug = 791, min = 7, max = 9 },
            { aug = 185, min = 1, max = 3 },
            { aug = 179, min = 1, max = 3 },
            { aug = 183, min = 1, max = 3 },
            { aug = 516, min = 1, max = 3 },
            { aug = 335, min = 1, max = 3 },
            { aug = 133, min = 1, max = 3 },
        },
    },

    [xi.item.WIVRE_GORGET] =
    {
        augments =
        {
            { aug = 1,   min = 3, max = 5 },
            { aug = 9,   min = 2, max = 5 },
            { aug = 513, min = 1, max = 3 },
            { aug = 195, min = 2, max = 5 },
            { aug = 772, min = 3, max = 4 },
            { aug = 41,  min = 1, max = 2 },
        },
    },

    [xi.item.JEWELED_COLLAR] =
    {
        augments =
        {
            { aug = 1,   min = 1, max = 15 },
            { aug = 9,   min = 1, max = 15 },
            { aug = 518, min = 1, max = 4  },
            { aug = 517, min = 1, max = 4  },
            { aug = 516, min = 1, max = 4  },
            { aug = 51,  min = 1, max = 3  },
            { aug = 52,  min = 1, max = 3  },
            { aug = 140, min = 1, max = 3  },
            { aug = 141, min = 1, max = 3  },
        },
    },

    [xi.item.RASETSU_JINPACHI] =
    {
        augments =
        {
            { aug = 768, min = 1, max = 4  },
            { aug = 182, min = 1, max = 5  },
            { aug = 183, min = 2, max = 4  },
            { aug = 198, min = 1, max = 5  },
            { aug = 31,  min = 1, max = 10 },
        },
    },

    [xi.item.TARUTARU_SASH] =
    {
        augments =
        {
            { aug = 1,   min = 1, max = 15 },
            { aug = 516, min = 1, max = 5  },
            { aug = 517, min = 1, max = 5  },
            { aug = 518, min = 1, max = 5  },
            { aug = 148, min = 1, max = 3  },
            { aug = 147, min = 1, max = 1  },
        },
    },

    [xi.item.GLEAMING_SPEAR] =
    {
        augments =
        {
            { aug = 768, min = 1, max = 10 },
            { aug = 772, min = 1, max = 10 },
            { aug = 771, min = 5, max = 10 },
            { aug = 1,   min = 5, max = 18 },
            { aug = 514, min = 1, max = 5  },
            { aug = 187, min = 3, max = 5  },
            { aug = 23,  min = 3, max = 5  },
            { aug = 286, min = 1, max = 2  },
            { aug = 326, min = 1, max = 10 },
            { aug = 327, min = 1, max = 5  },
        },
    },

    [xi.item.LORE_SLOPS] =
    {
        augments =
        {
            { aug = 774, min = 1, max = 10 },
            { aug = 518, min = 1, max = 3  },
            { aug = 51,  min = 1, max = 3  },
            { aug = 323, min = 1, max = 6  },
            { aug = 289, min = 1, max = 5  },
        },
    },

    [xi.item.VERSA_MUFFLERS] =
    {
        augments =
        {
            { aug = 771, min = 1, max = 9  },
            { aug = 1,   min = 1, max = 15 },
            { aug = 187, min = 1, max = 5  },
            { aug = 514, min = 1, max = 5  },
            { aug = 286, min = 1, max = 5  },
            { aug = 54,  min = 1, max = 1  },
        },
    },

    [xi.item.GULES_LEGGINGS] =
    {
        augments =
        {
            { aug = 770, min = 1, max = 6 },
            { aug = 512, min = 1, max = 3 },
            { aug = 40,  min = 1, max = 3 },
            { aug = 145, min = 1, max = 3 },
            { aug = 195, min = 1, max = 5 },
            { aug = 116, min = 1, max = 3 },
        },
    },

    [xi.item.GLEAMING_ZAGHNAL] =
    {
        augments =
        {
            { aug = 775, min = 1, max = 10 },
            { aug = 1,   min = 1, max = 20 },
            { aug = 9,   min = 1, max = 20 },
            { aug = 293, min = 1, max = 5  },
            { aug = 23,  min = 1, max = 10 },
        },
    },

    [xi.item.LIGHT_EARRING] =
    {
        augments =
        {
            { aug = 185, min = 1, max = 3 },
            { aug = 179, min = 1, max = 3 },
            { aug = 177, min = 1, max = 3 },
            { aug = 515, min = 1, max = 2 },
            { aug = 41,  min = 1, max = 1 },
            { aug = 184, min = 1, max = 3 },
        },
    },

    [xi.item.DIAMOND_RING] =
    {
        augments =
        {
            { aug = 769, min = 1, max = 5 },
            { aug = 180, min = 1, max = 3 },
            { aug = 516, min = 1, max = 3 },
            { aug = 517, min = 1, max = 3 },
            { aug = 53,  min = 1, max = 5 },
        },
    },

    [xi.item.GULES_MITTENS] =
    {
        augments =
        {
            { aug = 515, min = 1, max = 4 },
            { aug = 184, min = 1, max = 4 },
            { aug = 211, min = 1, max = 2 },
            { aug = 195, min = 1, max = 4 },
            { aug = 98,  min = 1, max = 4 },
        },
    },

    [xi.item.LORE_SABOTS] =
    {
        augments =
        {
            { aug = 1,   min = 3, max = 7  },
            { aug = 51,  min = 1, max = 3  },
            { aug = 52,  min = 3, max = 4  },
            { aug = 53,  min = 2, max = 10 },
            { aug = 141, min = 2, max = 5  },
        },
    },

    [xi.item.FIRMAMENT] =
    {
        augments =
        {
            { aug = 787,  min = 1, max = 7 },
            { aug = 184,  min = 1, max = 5 },
            { aug = 517,  min = 2, max = 8 },
            { aug = 45,   min = 2, max = 9 },
            { aug = 1033, min = 1, max = 8 },
        },
    },

    [xi.item.GUISARME] =
    {
        augments =
        {
            { aug = 788,  min = 2, max = 7  },
            { aug = 177,  min = 2, max = 6  },
            { aug = 29,   min = 2, max = 3  },
            { aug = 512,  min = 2, max = 7  },
            { aug = 45,   min = 6, max = 15 },
            { aug = 1052, min = 2, max = 8  },
        },
    },

    [xi.item.RIBAULDEQUIN] =
    {
        augments =
        {
            { aug = 784,  min = 2, max = 7  },
            { aug = 178,  min = 2, max = 6  },
            { aug = 25,   min = 2, max = 3  },
            { aug = 39,   min = 2, max = 7  },
            { aug = 45,   min = 6, max = 15 },
            { aug = 1078, min = 2, max = 8  },
        },
    },

    [xi.item.DIRE_SCYTHE] =
    {
        augments =
        {
            { aug = 770,  min = 4, max = 5  },
            { aug = 787,  min = 3, max = 8  },
            { aug = 184,  min = 3, max = 5  },
            { aug = 23,   min = 1, max = 3  },
            { aug = 198,  min = 2, max = 7  },
            { aug = 512,  min = 3, max = 3  },
            { aug = 45,   min = 3, max = 19 },
            { aug = 1048, min = 2, max = 8  },
        },
    },

    [xi.item.SAVATE_FISTS] =
    {
        augments =
        {
            { aug = 786,  min = 1, max = 7 },
            { aug = 181,  min = 1, max = 6 },
            { aug = 41,   min = 1, max = 4 },
            { aug = 45,   min = 2, max = 5 },
            { aug = 1024, min = 2, max = 6 },
        },
    },

    [xi.item.VODUN_MACE] =
    {
        augments =
        {
            { aug = 789,  min = 3, max = 7  },
            { aug = 182,  min = 3, max = 6  },
            { aug = 512,  min = 3, max = 8  },
            { aug = 45,   min = 5, max = 10 },
            { aug = 1065, min = 2, max = 4  },
            { aug = 1064, min = 2, max = 4  },
        },
    },

    [xi.item.DOOM_TABAR] =
    {
        augments =
        {
            { aug = 786,  min = 2, max = 5 },
            { aug = 187,  min = 1, max = 6 },
            { aug = 512,  min = 3, max = 8 },
            { aug = 45,   min = 3, max = 8 },
            { aug = 1040, min = 2, max = 4 },
        },
    },

    [xi.item.YATAGHAN] =
    {
        augments =
        {
            { aug = 787,  min = 2, max = 8 },
            { aug = 184,  min = 1, max = 5 },
            { aug = 25,   min = 1, max = 3 },
            { aug = 23,   min = 1, max = 2 },
            { aug = 45,   min = 1, max = 8 },
            { aug = 1028, min = 2, max = 4 },
        },
    },

    [xi.item.YUKITSUGU] =
    {
        augments =
        {
            { aug = 788,  min = 2, max = 5 },
            { aug = 177,  min = 3, max = 6 },
            { aug = 1080, min = 1, max = 3 },
            { aug = 45,   min = 5, max = 8 },
            { aug = 1060, min = 2, max = 4 },
        },
    },
}

-----------------------------------
-- This table reduces the total number of augments available by chest tier.
-- removes total from right to left
-- so { 5, 4, 3, 2, 0 },
-- will decrease the total augments available for tier 1 chest by 5,
-- tier 2 by 4, tier 3 by 3 and tier 4 by 2, leaving the full total for tier 5
-----------------------------------
local augTierDeduction =
{
    [xi.item.DARK_RING       ] = { 3, 3, 3, 2, 0 },
    [xi.item.TOWER_SHIELD    ] = { 5, 2, 2, 0, 0 },
    [xi.item.WIVRE_HAIRPIN   ] = { 3, 3, 3, 2, 0 },
    [xi.item.ADAMAN_BARBUTA  ] = { 6, 6, 6, 4, 0 },
    [xi.item.DEMONS_RING     ] = { 4, 4, 4, 3, 0 },
    [xi.item.WIVRE_GORGET    ] = { 3, 3, 3, 0, 0 },
    [xi.item.JEWELED_COLLAR  ] = { 7, 7, 3, 2, 0 },
    [xi.item.RASETSU_JINPACHI] = { 2, 2, 2, 0, 0 },
    [xi.item.TARUTARU_SASH   ] = { 5, 5, 3, 2, 0 },
    [xi.item.GLEAMING_SPEAR  ] = { 6, 5, 4, 3, 0 },
    [xi.item.LORE_SLOPS      ] = { 3, 3, 2, 0, 0 },
    [xi.item.VERSA_MUFFLERS  ] = { 2, 2, 2, 0, 0 },
    [xi.item.GULES_LEGGINGS  ] = { 4, 4, 3, 0, 0 },
    [xi.item.GLEAMING_ZAGHNAL] = { 4, 4, 2, 0, 0 },
    [xi.item.LIGHT_EARRING   ] = { 3, 3, 3, 0, 0 },
    [xi.item.DIAMOND_RING    ] = { 4, 4, 2, 0, 0 },
    [xi.item.GULES_MITTENS   ] = { 3, 3, 2, 0, 0 },
    [xi.item.LORE_SABOTS     ] = { 2, 2, 2, 1, 0 },
    [xi.item.FIRMAMENT       ] = { 4, 4, 3, 2, 0 },
    [xi.item.GUISARME        ] = { 4, 4, 3, 2, 0 },
    [xi.item.RIBAULDEQUIN    ] = { 4, 4, 3, 2, 0 },
    [xi.item.DIRE_SCYTHE     ] = { 6, 6, 4, 2, 0 },
    [xi.item.SAVATE_FISTS    ] = { 3, 3, 2, 0, 0 },
    [xi.item.VODUN_MACE      ] = { 4, 4, 3, 2, 0 },
    [xi.item.DOOM_TABAR      ] = { 3, 3, 2, 0, 0 },
    [xi.item.YATAGHAN        ] = { 4, 4, 3, 2, 0 },
    [xi.item.YUKITSUGU       ] = { 3, 3, 2, 0, 0 },
}

local function GetAugItemID(npc, slot)
    return npc:getLocalVar('ITEM' .. slot .. 'ID')
end

local function GetAugID(npc, slot, augmentnumber)
    return npc:getLocalVar('ITEM' .. slot .. 'AU' .. augmentnumber)
end

local function GetAug(npc, slot, augmentnumber)
    return npc:getLocalVar('ITEM' .. slot .. 'AUGMENT'.. augmentnumber)
end

local function GetAugVal(npc, slot, augmentnumber)
    return npc:getLocalVar('ITEM' .. slot .. 'AUG' .. augmentnumber .. 'VAL')
end

local function SetAugItemID(npc, itemNum, augmentNum, augment)
    npc:setLocalVar('ITEM' .. itemNum .. 'AU' .. augmentNum, augment)
end

local function GetAugment(npc, itemid, slot)
    local secondAugment = false
    local tier          = npc:getLocalVar('TIER')
    local randaugment1  = 0
    local randaugment2  = 0
    local augment1      = 0
    local augment2      = 0
    local aug1          = 0
    local aug2          = 0
    local multival1     = 0
    local multival2     = 0
    local randLimit     = 98

    if tier == 5 then
        randLimit = 65
    elseif tier >= 3 then
        randLimit = 80
    end

    if math.random(1, 100) > randLimit then
        secondAugment = true
    end

    randaugment1 = math.random(1, #augs[itemid].augments - augTierDeduction[itemid][tier])
    aug1 = augs[itemid].augments[randaugment1]

    multival1 = math.random(aug1.min, aug1.max)

    if multival1 > 1 then
        augment1 = bit.bor(aug1.aug, bit.lshift(multival1 - 1 , 11))
    else
        augment1 = aug1.aug
    end

    SetAugItemID(npc, slot, 1, augment1)
    npc:setLocalVar('ITEM' .. slot .. 'AUGMENT1', aug1.aug)
    npc:setLocalVar('ITEM' .. slot .. 'AUG1VAL', multival1 - 1)

    if secondAugment then
        randaugment2 = math.random(1, #augs[itemid].augments - augTierDeduction[itemid][tier])

        if randaugment2 == randaugment1 then
            randaugment2 = 0
        end

        if randaugment2 ~= 0 then
            aug2 = augs[itemid].augments[randaugment2]

            multival2 = math.random(aug2.min, aug2.max)

            if multival2 > 1 then
                augment2 = bit.bor(aug2.aug, bit.lshift(multival2 - 1, 11))
            else
                augment2 = aug2.aug
            end

            SetAugItemID(npc, slot, 2, augment2)
            npc:setLocalVar('ITEM' .. slot .. 'AUGMENT2', aug2.aug)
            npc:setLocalVar('ITEM' .. slot .. 'AUG2VAL', multival2 - 1)
        end
    end
end

local function GiveAugItem(player, npc, slot)
    local zoneId       = npc:getZoneID()
    local item1        = GetAugItemID(npc, 1)
    local item2        = GetAugItemID(npc, 2)

    local item1aug1    = GetAug(npc, 1, 1)
    local item1aug1val = GetAugVal(npc, 1, 1)
    local item1aug2    = GetAug(npc, 1, 2)
    local item1aug2val = GetAugVal(npc, 1, 2)

    local item2aug1    = GetAug(npc, 2, 1)
    local item2aug1val = GetAugVal(npc, 2, 1)
    local item2aug2    = GetAug(npc, 2, 2)
    local item2aug2val = GetAugVal(npc, 2, 2)

    if slot == 1 then
        if npc:getLocalVar('ITEM1ID') == 0 then
            player:messageSpecial(zones[zoneId].text.ITEM_DISAPPEARED)
            return 0
        else
            if player:getFreeSlotsCount() == 0 then -- NOTE: check a var or somthing for the item
                player:messageSpecial(zones[zoneId].text.ITEM_CANNOT_BE_OBTAINED, item1)
                return 0
            elseif player:getFreeSlotsCount() > 0 then
                    if GetAugItemID(npc, 1) ~= 0 then
                    player:addItem(item1, 1, item1aug1, item1aug1val, item1aug2, item1aug2val)
                    xi.pyxis.messageChest(player, zones[zoneId].text.OBTAINS_ITEM, item1, 0, 0, 0)
                    npc:setLocalVar('ITEM1ID', 0)
                end
            end
        end
    elseif slot == 2 then
        if npc:getLocalVar('ITEM2ID') == 0 then
            player:messageSpecial(zones[zoneId].text.ITEM_DISAPPEARED)
            return 0
        else
            if player:getFreeSlotsCount() == 0 then -- NOTE: check a var or somthing for the item
                player:messageSpecial(zones[zoneId].text.ITEM_CANNOT_BE_OBTAINED, item2)
                return 0
            elseif player:getFreeSlotsCount() > 0 then
                    if GetAugItemID(npc, 2) ~= 0 then
                    player:addItem(item2, 1, item2aug1, item2aug1val, item2aug2, item2aug2val)
                    xi.pyxis.messageChest(player, zones[zoneId].text.OBTAINS_ITEM, item2, 0, 0, 0)
                    npc:setLocalVar('ITEM2ID', 0)
                end
            end
        end
    end

    if npc:getLocalVar('ITEM1ID') == 0 and npc:getLocalVar('ITEM2ID') == 0 then
        xi.pyxis.removeChest(player, npc, 0, 3)
    end
end

xi.pyxis.augItem.setAugmentItems = function(npc, tier)
    local zoneId = npc:getZoneID()
    local item1 = augdrops[zoneId][math.random(1, 3)]
    local item2 = 0

    if tier > 2 then
        if math.random(0, 100) > (90 / tier) then
            item2 = augdrops[zoneId][math.random(1, 3)]
        end
    end

    local chestid = npc:getLocalVar('CHESTID')
    local chest   = GetNPCByID(chestid)

    npc:setLocalVar('ITEM1ID', item1)
    GetAugment(chest, item1, 1)
    if item2 > 0 then
        npc:setLocalVar('ITEM1ID', item1)
        GetAugment(chest, item1, 1)
        npc:setLocalVar('ITEM2ID', item2)
        GetAugment(chest, item2, 2)
    end
end

xi.pyxis.augItem.updateEvent = function(player, npc)
    local augmentFlag    = 0x0202
    player:updateEvent(GetAugItemID(npc, 1), augmentFlag, GetAugID(npc, 1, 1), GetAugID(npc, 1, 2), GetAugItemID(npc, 2), augmentFlag, GetAugID(npc, 2, 1), GetAugID(npc, 2, 2))
end

xi.pyxis.augItem.giveAugItem = function(player, npc, option)
    local itemSelected = bit.rshift(option, 16)
    if itemSelected > 0 and itemSelected <= 2 then
        GiveAugItem(player, npc, itemSelected)
    end
end
