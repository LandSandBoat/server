-----------------------------------
-- Area: Mamool Ja Training Grounds
-- Ancient Lockbox
-----------------------------------
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
require("scripts/globals/missions")
require("scripts/globals/appraisal")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local qItem =
    {
        [IMPERIAL_AGENT_RESCUE] =
        {
            {
                {itemid = 2286, droprate = 600}, -- ??? box
                {itemid = 2278, droprate = 300}, -- ??? ring
                {itemid =    0, droprate = 100}, -- Nothing
            },
        },
        [PREEMPTIVE_STRIKE] =
        {
            {
                {itemid = 2286, droprate = 600}, -- ??? Box
                {itemid = 2282, droprate = 300}, -- ??? Necklace
                {itemid =    0, droprate = 100}, -- Nothing
            },
        },
    }
    local regItem =
    {
        [IMPERIAL_AGENT_RESCUE] =
        {
            {
                {itemid = 4118, droprate = 900}, -- Hi-Potion 2
                {itemid =    0, droprate = 100}, -- Nothing
            },
            {
                {itemid = 13688, droprate = 100}, -- Hi-Potion Tank
                {itemid =     0, droprate = 900}, -- Nothing
            },
            {
                {itemid = 4172, droprate = 530}, -- Reraiser
                {itemid =    0, droprate = 470}, -- Nothing
            },
        },
        [PREEMPTIVE_STRIKE] =
        {
            {
                {itemid = 13688, droprate = 100}, -- Hi-Potion Tank
                {itemid =     0, droprate = 900}, -- Nothing
            },
            {
                {itemid = 4172, droprate = 300}, -- Reraiser
                {itemid =    0, droprate = 700}, -- Nothing
            },
            {
                {itemid = 4173, droprate = 500}, -- Hi-Reraiser
                {itemid =    0, droprate = 500}, -- Nothing
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
