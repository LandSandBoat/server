-----------------------------------
-- Area: Leujaoam Sanctum
-- Ancient Lockbox
-----------------------------------
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
require("scripts/globals/missions")
require("scripts/globals/appraisal")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local qItem =
    {
        [LEUJAOAM_CLEANSING] =
        {
            {
                {itemid = 2278, droprate = 600}, -- Appraisal (???) Ring
                {itemid = 2286, droprate = 300}, -- Appraisal (???) Box
                {itemid = 0,    droprate = 100}, -- Nothing
            },
        },
        [ORICHALCUM_SURVEY] =
        {
            {
                {itemid = 2282, droprate = 300}, -- Appraisal (???) Necklace
                {itemid = 2286, droprate = 550}, -- Appraisal (???) Box
                {itemid = 2195, droprate = 50 }, -- Appraisal (???) Gloves
                {itemid = 0,    droprate = 100}, -- Nothing
            },
        },
    }
    local regItem =
    {
        [LEUJAOAM_CLEANSING] =
        {
            {
                {itemid = 4119, droprate = 1000}, -- Hi-Potion III
            },
            {
                {itemid = 4119, droprate = 100}, -- Hi-Potion III
                {itemid = 0,    droprate = 900}, -- Nothing
            },
            {
                {itemid = 4155, droprate = 530}, -- Remedy
                {itemid = 0,    droprate = 470}, -- Nothing
            },
        },
        [ORICHALCUM_SURVEY] =
        {
            {
                {itemid = 4119, droprate = 1000}, -- Hi-Potion III
            },
            {
                {itemid = 4155, droprate = 530}, -- Remedy
                {itemid = 0,    droprate = 470}, -- Nothing
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
