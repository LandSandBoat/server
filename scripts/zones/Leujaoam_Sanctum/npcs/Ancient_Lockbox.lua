-----------------------------------
-- Area: Leujaoam Sanctum
-- Ancient Lockbox
-----------------------------------
require("scripts/globals/appraisal")
require("scripts/globals/assault")
require("scripts/globals/items")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local qItem =
    {
        [xi.assault.mission.LEUJAOAM_CLEANSING] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_RING, droprate = 700 },
                { itemid = xi.items.UNAPPRAISED_BOX,  droprate = 300 },
            },
        },

        [xi.assault.mission.ORICHALCUM_SURVEY] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_NECKLACE, droprate = 300 },
                { itemid = xi.items.UNAPPRAISED_BOX,      droprate = 400 },
                { itemid = xi.items.UNAPPRAISED_GLOVES,   droprate = 300 },
            },
        },

        [xi.assault.mission.ESCORT_PROFESSOR_CHANOIX] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_CAPE, droprate = 600 },
                { itemid = xi.items.UNAPPRAISED_BOX,  droprate = 400 },
            },
        },

        [xi.assault.mission.SHANARHA_GRASS_CONSERVATION] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_SASH, droprate = 700 },
                { itemid = xi.items.UNAPPRAISED_BOX,  droprate = 300 },
            },
        },

        [xi.assault.mission.COUNTING_SHEEP] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_DAGGER, droprate = 600 },
                { itemid = xi.items.UNAPPRAISED_BOX,    droprate = 400 },
            },
        },

        [xi.assault.mission.SUPPLIES_RECOVER] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_DAGGER, droprate = 500 },
                { itemid = xi.items.UNAPPRAISED_GLOVES, droprate = 150 },
                { itemid = xi.items.UNAPPRAISED_BOX,    droprate = 350 },
            },
        },
    }

    local regItem =
    {
        [xi.assault.mission.LEUJAOAM_CLEANSING] =
        {
            {
                { itemid = xi.items.HI_POTION_P3, droprate = 1000 },
            },
            {
                { itemid = xi.items.HI_POTION_P3, droprate = 100 },
                { itemid = 0,                     droprate = 900 },
            },
            {
                { itemid = xi.items.REMEDY,       droprate = 530 },
                { itemid = 0,                     droprate = 470 },
            },
        },

        [xi.assault.mission.ORICHALCUM_SURVEY] =
        {
            {
                { itemid = xi.items.HI_POTION_P3, droprate = 1000 },
            },
            {
                { itemid = xi.items.REMEDY,       droprate = 530 },
                { itemid = 0,                     droprate = 470 },
            },
        },

        [xi.assault.mission.ESCORT_PROFESSOR_CHANOIX] =
        {
            {
                { itemid = xi.items.HI_POTION_P3,   droprate = 100 },
                { itemid = 0,                       droprate = 900 },
            },
            {
                { itemid = xi.items.HI_POTION_P2,   droprate = 850 },
                { itemid = 0,                       droprate = 150 },
            },
            {
                { itemid = xi.items.HI_POTION_TANK, droprate = 600 },
                { itemid = 0,                       droprate = 400 },
            },
            {
                { itemid = xi.items.RERAISER,       droprate = 150 },
                { itemid = 0,                       droprate = 850 },
            },
        },

        [xi.assault.mission.SHANARHA_GRASS_CONSERVATION] =
        {
            {
                { itemid = xi.items.HI_POTION_P3, droprate = 750 },
                { itemid = 0,                     droprate = 250 },
            },
            {
                { itemid = xi.items.REMEDY,       droprate = 800 },
                { itemid = 0,                     droprate = 200 },
            },
        },

        [xi.assault.mission.COUNTING_SHEEP] =
        {
            {
                { itemid = xi.items.HI_POTION_P2,   droprate = 1000 },
            },
            {
                { itemid = xi.items.HI_POTION_TANK, droprate = 500 },
                { itemid = 0,                       droprate = 500 },
            },
            {
                { itemid = xi.items.RERAISER,       droprate = 300 },
                { itemid = 0,                       droprate = 700 },
            },
        },

        [xi.assault.mission.SUPPLIES_RECOVERY] =
        {
            {
                { itemid = xi.items.HI_POTION_P3,   droprate = 850 },
                { itemid = 0,                       droprate = 150 },
            },
            {
                { itemid = xi.items.HI_RERAISER,    droprate = 500 },
                { itemid = 0,                       droprate = 500 },
            },
            {
                { itemid = xi.items.HI_POTION_TNAK, droprate = 600 },
                { itemid = 0,                       droprate = 400 },
            },
            {
                { itemid = xi.items.HI_ETHER_TNAK,  droprate = 400 },
                { itemid = 0,                       droprate = 600 },
            },
        },
    }

    local area = player:getCurrentAssault()
    xi.appraisal.assaultChestTrigger(player, npc, qItem[area], regItem[area])
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
