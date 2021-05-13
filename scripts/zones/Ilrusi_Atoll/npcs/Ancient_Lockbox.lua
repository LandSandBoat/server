-----------------------------------
-- Area: Ilrusi Atoll
-- Ancient Lockbox
-----------------------------------
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
require("scripts/globals/missions")
require("scripts/globals/appraisal")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local qItem =
    {
        [GOLDEN_SALVAGE] =
        {
            {
                {itemid = 2277, droprate = 619}, -- ??? earring
                {itemid = 2286, droprate = 390}, -- ??? box
                {itemid = 0, droprate = 100}, -- Nothing
            },
        },
        [LAMIA_NO_13] =
        {
            {
                {itemid = 2286, droprate = 350}, -- ??? Box
                {itemid = 2194, droprate = 300}, -- ??? Bow
                {itemid = 2196, droprate = 350}, -- ??? Footwear
                {itemid = 0, droprate = 100}, -- Nothing
            },
        },
    }
    local regItem =
    {
        [GOLDEN_SALVAGE] =
        {
            {
                {itemid = 4118, droprate = 934}, -- Hi-Potion 2
                {itemid = 0, droprate = 100}, -- Nothing
            },
            {
                {itemid = 13688, droprate = 539}, -- Hi-Potion Tank
                {itemid = 0, droprate = 461}, -- Nothing
            },
            {
                {itemid = 4172, droprate = 255}, -- Reraiser
                {itemid = 0, droprate = 745}, -- Nothing
            },
        },
        [LAMIA_NO_13] =
        {
            {
                {itemid = 4119, droprate = 1000}, -- Hi Potion 3
            },
            {
                {itemid = 13688, droprate = 290}, -- Hi potion tank
                {itemid = 0, droprate = 710}, -- Nothing
            },
            {
                {itemid = 13689, droprate = 290}, -- Hi ether tank
                {itemid = 0, droprate = 710}, -- Nothing
            },
            {
                {itemid = 4173, droprate = 290}, -- Hi reraiser
                {itemid = 0, droprate = 710}, -- Nothing
            },
        },
    }
    local area = player:getCurrentAssault()
    appraisalUtil.assaultChestTrigger(player, npc, qItem[area], regItem[area], ID.text)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
