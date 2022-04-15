-----------------------------------
-- Abyssea Sturdy Pyxis - Augmented item
-----------------------------------

xi = xi or {}
xi.pyxis = xi.pyxis or {}

xi.pyxis.augItem = {}
---------------------------------
-- drop id's for augmented items
-- uses zone id as the key
---------------------------------
local augdrops =
{
    [xi.zone.ABYSSEA_KONSCHTAT  ] = { 14644, 12324, 16128 },
    [xi.zone.ABYSSEA_TAHRONGI   ] = { 12420, 13464, 16265 },
    [xi.zone.ABYSSEA_LA_THEINE  ] = { 13087, 13925, 13212 },
    [xi.zone.ABYSSEA_ATTOHWA    ] = { 19309, 11932, 11880 },
    [xi.zone.ABYSSEA_MISAREAUX  ] = { 11424, 18963, 11684 },
    [xi.zone.ABYSSEA_VUNKERL    ] = { 13450, 11878, 11428 },
    [xi.zone.ABYSSEA_ALTEPA     ] = { 17664, 19310, 19267 },
    [xi.zone.ABYSSEA_ULEGUERAND ] = { 18964, 18774, 18875 },
    [xi.zone.ABYSSEA_GRAUBERG   ] = { 16660, 16485, 16971 },
}


---------------------------------------------------------------------------------------------
-- augs table holds potential augments with min/max values to be randomised for each item id
-- example: Tarutaru sash [13212] would have 6 potential augments, each with its own values
---------------------------------------------------------------------------------------------
local augs =
{
    [14644] = {augments = {{aug=42,  min=1, max=3 }, {aug=56,  min=1, max=6 }, {aug=33,  min=2, max=4 }, {aug=53,  min=1, max=5 }, {aug=55,  min=1, max=6 }, {aug=54,  min=1, max=6 }                                                                                                        }}, -- Dark Ring
    [12324] = {augments = {{aug=1,   min=2, max=17}, {aug=180, min=1, max=4 }, {aug=181, min=1, max=5 }, {aug=188, min=1, max=5 }, {aug=153, min=1, max=2 }, {aug=39,  min=1, max=2 }                                                                                                        }}, -- Tower Shield
    [16128] = {augments = {{aug=771, min=1, max=10}, {aug=773, min=1, max=10}, {aug=769, min=1, max=10}, {aug=775, min=1, max=10}, {aug=9,   min=10,max=16}, {aug=138, min=1, max=1 }                                                                                                        }}, -- Wivre Hairpin
    [12420] = {augments = {{aug=774, min=1, max=9 }, {aug=137, min=1, max=3 }, {aug=188, min=1, max=5 }, {aug=53,  min=1, max=3 }, {aug=329, min=2, max=5 }, {aug=137, min=1, max=1 }, {aug=1,   min=1, max=16}                                                                              }}, -- Adaman Barbuta
    [13464] = {augments = {{aug=791, min=7, max=9 }, {aug=185, min=1, max=3 }, {aug=179, min=1, max=3 }, {aug=183, min=1, max=3 }, {aug=516, min=1, max=3 }, {aug=335, min=1, max=3 }, {aug=133, min=1, max=3 }                                                                              }}, -- Demon's Ring
    [16265] = {augments = {{aug=1,   min=3, max=5 }, {aug=9,   min=2, max=5 }, {aug=513, min=1, max=3 }, {aug=195, min=2, max=5 }, {aug=772, min=3, max=4 }, {aug=41,  min=1, max=2 }                                                                                                        }}, -- Wivre Gorget
    [13087] = {augments = {{aug=1,   min=1, max=15}, {aug=9,   min=1, max=15}, {aug=518, min=1, max=4 }, {aug=517, min=1, max=4 }, {aug=516, min=1, max=4 }, {aug=51,  min=1, max=3 }, {aug=52,  min=1, max=3 }, {aug=140, min=1, max=3 }, {aug=141, min=1, max=3 }                          }}, -- Jeweled Collar
    [13925] = {augments = {{aug=768, min=1, max=4 }, {aug=182, min=1, max=5 }, {aug=183, min=2, max=4 }, {aug=198, min=1, max=5 }, {aug=31,  min=1, max=10}                                                                                                                                  }}, -- Rasetsu Jinpachi
    [13212] = {augments = {{aug=1,   min=1, max=15}, {aug=516, min=1, max=5 }, {aug=517, min=1, max=5 }, {aug=518, min=1, max=5 }, {aug=148, min=1, max=3 }, {aug=147, min=1, max=1 }                                                                                                        }}, -- Tarutaru Sash
    [19309] = {augments = {{aug=768, min=1, max=10}, {aug=772, min=1, max=10}, {aug=771, min=5, max=10}, {aug=1,   min=5, max=18}, {aug=514, min=1, max=5 }, {aug=187, min=3, max=5 }, {aug=23,  min=3, max=5 }, {aug=286, min=1, max=2 }, {aug=326, min=1, max=10}, {aug=327, min=1, max=5 }}}, -- Gleaming Spear
    [11932] = {augments = {{aug=774, min=1, max=10}, {aug=518, min=1, max=3 }, {aug=51,  min=1, max=3 }, {aug=323, min=1, max=6 }, {aug=289, min=1, max=5 }                                                                                                                                  }}, -- Lore Slops
    [11880] = {augments = {{aug=771, min=1, max=9 }, {aug=1,   min=1, max=15}, {aug=187, min=1, max=5 }, {aug=514, min=1, max=5 }, {aug=286, min=1, max=5 }, {aug=54,  min=1, max=1 }                                                                                                        }}, -- Versa Mufflers
    [11424] = {augments = {{aug=770, min=1, max=6 }, {aug=512, min=1, max=3 }, {aug=40,  min=1, max=3 }, {aug=145, min=1, max=3 }, {aug=195, min=1, max=5 }, {aug=116, min=1, max=3 }                                                                                                        }}, -- Gules Leggings
    [18963] = {augments = {{aug=775, min=1, max=10}, {aug=1,   min=1, max=20}, {aug=9,   min=1, max=20}, {aug=293, min=1, max=5 }, {aug=23,  min=1, max=10}                                                                                                                                  }}, -- Gleaming Zaghnal
    [11684] = {augments = {{aug=185, min=1, max=3 }, {aug=179, min=1, max=3 }, {aug=177, min=1, max=3 }, {aug=515, min=1, max=2 }, {aug=41,  min=1, max=1 }, {aug=184, min=1, max=3 }                                                                                                        }}, -- Light Earring
    [13450] = {augments = {{aug=769, min=1, max=5 }, {aug=180, min=1, max=3 }, {aug=516, min=1, max=3 }, {aug=517, min=1, max=3 }, {aug=53,  min=1, max=5 }                                                                                                                                  }}, -- Diamond Ring
    [11878] = {augments = {{aug=515, min=1, max=4 }, {aug=184, min=1, max=4 }, {aug=211, min=1, max=2 }, {aug=195, min=1, max=4 }, {aug=98,  min=1, max=4 }                                                                                                                                  }}, -- Gules Mittens
    [11428] = {augments = {{aug=1,   min=3, max=7 }, {aug=51,  min=1, max=3 }, {aug=52,  min=3, max=4 }, {aug=53,  min=2, max=10}, {aug=141, min=2, max=5 }                                                                                                                                  }}, -- Lore Sabots
    [17664] = {augments = {{aug=787, min=1, max=7 }, {aug=184, min=1, max=5 }, {aug=517, min=2, max=8 }, {aug=45,  min=2, max=9 }, {aug=1033,min=1, max=8 }                                                                                                                                  }}, -- Firmament
    [19310] = {augments = {{aug=788, min=2, max=7 }, {aug=177, min=2, max=6 }, {aug=29,  min=2, max=3 }, {aug=512, min=2, max=7 }, {aug=45,  min=6, max=15}, {aug=1052,min=2, max=8 }                                                                                                        }}, -- Guisarme
    [19267] = {augments = {{aug=784, min=2, max=7 }, {aug=178, min=2, max=6 }, {aug=25,  min=2, max=3 }, {aug=39,  min=2, max=7 }, {aug=45,  min=6, max=15}, {aug=1078,min=2, max=8 }                                                                                                        }}, -- Ribauldequin
    [18964] = {augments = {{aug=770, min=4, max=5 }, {aug=787, min=3, max=8 }, {aug=184, min=3, max=5 }, {aug=23,  min=1, max=3 }, {aug=198, min=2, max=7 }, {aug=512, min=3, max=3 }, {aug=45,  min=3, max=19}, {aug=1048,min=2, max=8 }                                                    }}, -- Dire Scythe
    [18774] = {augments = {{aug=786, min=1, max=7 }, {aug=181, min=1, max=6 }, {aug=41,  min=1, max=4 }, {aug=45,  min=2, max=5 }, {aug=1024,min=2, max=6 }                                                                                                                                  }}, -- Savate Fists
    [18875] = {augments = {{aug=789, min=3, max=7 }, {aug=182, min=3, max=6 }, {aug=512, min=3, max=8 }, {aug=45,  min=5, max=10}, {aug=1065,min=2, max=4 }, {aug=1064,min=2, max=4 }                                                                                                        }}, -- Vodun Mace
    [16660] = {augments = {{aug=786, min=2, max=5 }, {aug=187, min=1, max=6 }, {aug=512, min=3, max=8 }, {aug=45,  min=3, max=8 }, {aug=1040,min=2, max=4 }                                                                                                                                  }}, -- Doom Tabar
    [16485] = {augments = {{aug=787, min=2, max=8 }, {aug=184, min=1, max=5 }, {aug=25,  min=1, max=3 }, {aug=23,  min=1, max=2 }, {aug=45,  min=1, max=8 }, {aug=1028,min=2, max=4 }                                                                                                        }}, -- Yataghan
    [16971] = {augments = {{aug=788, min=2, max=5 }, {aug=177, min=3, max=6 }, {aug=1080,min=1, max=3 }, {aug=45,  min=5, max=8 }, {aug=1060,min=2, max=4 }                                                                                                                                  }}, -- Yukitsugu
}

-------------------------------------------------------------------------------
-- This table reduces the total number of augments available by chest tier.
-- removes total from right to left
-- so {5,4,3,2,0},
-- will decrease the total augments available for tier 1 chest by 5,
-- tier 2 by 4, tier 3 by 3 and tier 4 by 2, leaving the full total for tier 5
-------------------------------------------------------------------------------
local augTierDeduction =
{
    [14644] = {3,3,3,2,0}, -- Dark Ring
    [12324] = {5,2,2,0,0}, -- Tower Shield
    [16128] = {3,3,3,2,0}, -- Wivre Hairpin
    [12420] = {6,6,6,4,0}, -- Adaman Barbuta
    [13464] = {4,4,4,3,0}, -- Demon's Ring
    [16265] = {3,3,3,0,0}, -- Wivre Gorget
    [13087] = {7,7,3,2,0}, -- Jeweled Collar
    [13925] = {2,2,2,0,0}, -- Rasetsu Jinpachi
    [13212] = {5,5,3,2,0}, -- Tarutaru Sash
    [19309] = {6,5,4,3,0}, -- Gleaming Spear
    [11932] = {3,3,2,0,0}, -- Lore Slops
    [11880] = {2,2,2,0,0}, -- Versa Mufflers
    [11424] = {4,4,3,0,0}, -- Gules Leggings
    [18963] = {4,4,2,0,0}, -- Gleaming Zaghnal
    [11684] = {3,3,3,0,0}, -- Light Earring
    [13450] = {4,4,2,0,0}, -- Diamond Ring
    [11878] = {3,3,2,0,0}, -- Gules Mittens
    [11428] = {2,2,2,1,0}, -- Lore Sabots
    [17664] = {4,4,3,2,0}, -- Firmament
    [19310] = {4,4,3,2,0}, -- Guisarme
    [19267] = {4,4,3,2,0}, -- Ribauldequin
    [18964] = {6,6,4,2,0}, -- Dire Scythe
    [18774] = {3,3,2,0,0}, -- Savate Fists
    [18875] = {4,4,3,2,0}, -- Vodun Mace
    [16660] = {3,3,2,0,0}, -- Doom Tabar
    [16485] = {4,4,3,2,0}, -- Yataghan
    [16971] = {3,3,2,0,0}, -- Yukitsugu
}

local function GetAugItemID(npc, slot)
    return npc:getLocalVar("ITEM" .. slot .. "ID")
end

local function GetAugID(npc, slot, augmentnumber)
    return npc:getLocalVar("ITEM" .. slot .. "AU" .. augmentnumber)
end

local function GetAug(npc, slot, augmentnumber)
    return npc:getLocalVar("ITEM" .. slot .. "AUGMENT".. augmentnumber)
end

local function GetAugVal(npc, slot, augmentnumber)
    return npc:getLocalVar("ITEM" .. slot .. "AUG" .. augmentnumber .. "VAL")
end

local function SetAugItemID(npc, itemNum, augmentNum, augment)
    npc:setLocalVar("ITEM" .. itemNum .. "AU" .. augmentNum, augment)
end

local function GetAugment(npc, itemid, slot)
    local secondAugment = false
    local tier          = npc:getLocalVar("TIER")
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

    if math.random(100) > randLimit then
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
    npc:setLocalVar("ITEM" .. slot .. "AUGMENT1", aug1.aug)
    npc:setLocalVar("ITEM" .. slot .. "AUG1VAL", multival1 - 1)

    if secondAugment then
        randaugment2 = math.random(1,#augs[itemid].augments - augTierDeduction[itemid][tier])

        if randaugment2 == randaugment1 then
            randaugment2 = 0
        end

        if randaugment2 ~= 0 then
            aug2 = augs[itemid].augments[randaugment2]

            multival2 = math.random(aug2.min, aug2.max)

            if multival2 > 1 then
                augment2 = bit.bor(aug2.aug,bit.lshift(multival2 -1 ,11))
            else
                augment2 = aug2.aug
            end

            SetAugItemID(npc, slot, 2, augment2)
            npc:setLocalVar("ITEM" .. slot .. "AUGMENT2", aug2.aug)
            npc:setLocalVar("ITEM" .. slot .. "AUG2VAL", multival2 - 1)
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
        if npc:getLocalVar("ITEM1ID") == 0 then
            player:messageSpecial(zones[zoneId].text.ITEM_DISAPPEARED)
            return 0
        else
            if player:getFreeSlotsCount() == 0 then -- NOTE: check a var or somthing for the item
                player:messageSpecial(zones[zoneId].text.ITEM_CANNOT_BE_OBTAINED, item1)
                return 0
            elseif player:getFreeSlotsCount() > 0 then
                    if (GetAugItemID(npc,1) ~= 0) then
                    player:addItem(item1, 1, item1aug1, item1aug1val, item1aug2, item1aug2val)
                    xi.pyxis.messageChest(player, zones[zoneId].text.OBTAINS_ITEM, item1, 0, 0, 0)
                    npc:setLocalVar("ITEM1ID", 0)
                end
            end
        end
    elseif slot == 2 then
        if npc:getLocalVar("ITEM2ID") == 0 then
            player:messageSpecial(zones[zoneId].text.ITEM_DISAPPEARED)
            return 0
        else
            if player:getFreeSlotsCount() == 0 then -- NOTE: check a var or somthing for the item
                player:messageSpecial(zones[zoneId].text.ITEM_CANNOT_BE_OBTAINED, item2)
                return 0
            elseif player:getFreeSlotsCount() > 0 then
                    if GetAugItemID(npc,2) ~= 0 then
                    player:addItem(item2,1,item2aug1,item2aug1val,item2aug2,item2aug2val)
                    xi.pyxis.messageChest(player, zones[zoneId].text.OBTAINS_ITEM, item2, 0, 0, 0)
                    npc:setLocalVar("ITEM2ID", 0)
                end
            end
        end
    end

    if npc:getLocalVar("ITEM1ID") == 0 and npc:getLocalVar("ITEM2ID") == 0 then
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

    local chestid = npc:getLocalVar("CHESTID")
    local chest   = GetNPCByID(chestid)

    npc:setLocalVar("ITEM1ID",item1)
    GetAugment(chest, item1, 1)
    if item2 > 0 then
        npc:setLocalVar("ITEM1ID",item1)
        GetAugment(chest, item1, 1)
        npc:setLocalVar("ITEM2ID",item2)
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
