-----------------------------------
-- Area: Periqia
-- Ancient Lockbox
-----------------------------------
local ID = require("scripts/zones/Periqia/IDs")
require("scripts/globals/missions")
require("scripts/globals/appraisal")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local qItem =
    {
        [SEAGULL_GROUNDED] =
        {
            {
                {itemid = 2286, droprate = 500}, -- ??? box
                {itemid = 2190, droprate = 300}, -- ??? sword
                {itemid = 2192, droprate = 300}, -- ??? polearm
                {itemid = 2195, droprate = 100}, -- ??? gloves
                {itemid = 0,    droprate = 100}, -- Nothing
            },
        },
        [REQUIEM] =
        {
            {
                {itemid = 2286, droprate = 400}, -- ??? box
                {itemid = 2195, droprate = 70},  -- ??? Gloves
                {itemid = 2192, droprate = 330}, -- ??? Polearm
                {itemid = 2193, droprate = 100}, -- ??? Axe
                {itemid = 0,    droprate = 100}, -- Nothing
            },
        },
    }
    local regItem =
    {
        [SEAGULL_GROUNDED] =
        {
            {
                {itemid = 4173, droprate = 700}, -- Hi-Reraiser
                {itemid = 0,    droprate = 300}, -- Nothing
            },
            {
                {itemid = 13688, droprate = 100}, -- Hi-Potion Tank
                {itemid = 13689, droprate = 100}, -- Hi-Ether Tank
                {itemid = 0,     droprate = 800}, -- Nothing
            },
            {
                {itemid = 4119, droprate = 530}, -- Hi-Potion 3
                {itemid = 0,    droprate = 470}, -- Nothing
            },
        },
        [REQUIEM] =
        {
            {
                {itemid = 4119, droprate = 500}, -- Hi Potion 3
                {itemid = 0,    droprate = 500}, -- Nothing
            },
            {
                {itemid = 13689, droprate = 100}, -- Hi-Ether Tank
                {itemid = 0,     droprate = 900}, -- Nothing
            },
            {
                {itemid = 4173, droprate = 500}, -- Hi-Reraiser
                {itemod = 0,    droprate = 500}, -- Nothing
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
