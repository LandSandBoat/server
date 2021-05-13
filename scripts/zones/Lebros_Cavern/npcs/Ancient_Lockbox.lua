-----------------------------------
-- Area: Lebros Cavern
-- Ancient Lockbox
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
require("scripts/globals/missions")
require("scripts/globals/status")
require("scripts/globals/appraisal")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local qItem =
    {
        [EXCAVATION_DUTY] =
        {
            {
                {itemid = 2286, droprate = xi.frequency.SUPER_COMMON}, -- ??? Box
                {itemid = 2277, droprate = xi.frequency.COMMON},       -- ??? Earring
                {itemid = 0,    droprate = xi.frequency.VERY_RARE},    -- Nothing
            },
        },
        [LEBROS_SUPPLIES] =
        {
            {
                {itemid = 2286, droprate = xi.frequency.SUPER_COMMON}, -- ??? Box
                {itemid = 2279, droprate = xi.frequency.COMMON},       -- ??? Cape
                {itemid = 0,    droprate = xi.frequency.VERY_RARE},    -- Nothing
            },
        },
    }
    local regItem =
    {
        [EXCAVATION_DUTY] =
        {
            {
                {itemid = 4155, droprate = xi.frequency.SUPER_COMMON}, -- Remedy
                {itemid = 0,    droprate = xi.frequency.RARE},         -- Nothing
            },
            {
                {itemid = 4155, droprate = xi.frequency.RARE},      -- Remedy
                {itemid = 0, droprate = xi.frequency.SUPER_COMMON}, -- Nothing
            },
            {
                {itemid = 4119, droprate = xi.frequency.COMMON}, -- Hi-Potion +3
                {itemid = 0,    droprate = xi.frequency.COMMON}, -- Nothing
            },
            {
                {itemid = 4119, droprate = 200},                        -- Hi-Potion +3
                {itemid = 0,    droprate = xi.frequency.SUPER_COMMON}, -- Nothing
            },
        },
        [LEBROS_SUPPLIES] =
        {
            {
                {itemid = 4155, droprate = xi.frequency.SUPER_COMMON}, -- Remedy
                {itemid = 0,    droprate = xi.frequency.RARE},         -- Nothing
            },
            {
                {itemid = 4172, droprate = xi.frequency.RARE},         -- Reraiser
                {itemid = 0,    droprate = xi.frequency.SUPER_COMMON}, -- Nothing
            },
            {
                {itemid = 13688, droprate = xi.frequency.RARE},         -- Hi-Potion Tank
                {itemid = 0,     droprate = xi.frequency.SUPER_COMMON}, -- Nothing
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
