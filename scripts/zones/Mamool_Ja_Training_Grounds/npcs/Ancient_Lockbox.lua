-----------------------------------
-- Area: Mamool Ja Training Grounds
-- Ancient Lockbox
-----------------------------------
require("scripts/globals/appraisal")
require("scripts/globals/assault")
require("scripts/globals/items")
-----------------------------------

local entity = {}

entity.onTrigger = function(player, npc)
    local qItem =
    {
        [xi.assault.mission.IMPERIAL_AGENT_RESCUE] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_BOX,  droprate = 300 },
                { itemid = xi.items.UNAPPRAISED_RING, droprate = 700 },
            },
        },

        [xi.assault.mission.PREEMPTIVE_STRIKE] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_BOX,      droprate = 300 },
                { itemid = xi.items.UNAPPRAISED_NECKLACE, droprate = 700 },
            },
        },

        [xi.assault.mission.SAGELORD_ELIMINATION] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_HEADPIECE, droprate = 300 },
                { itemid = xi.items.UNAPPRAISED_POLEARM,   droprate = 150 },
                { itemid = xi.items.UNAPPRAISED_SWORD,     droprate = 150 },
                { itemid = xi.items.UNAPPRAISED_BOX,       droprate = 400 },
            },
        },

        [xi.assault.mission.BREAKING_MORALE] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_POLEARM, droprate = 300 },
                { itemid = xi.items.UNAPPRAISED_SWORD,   droprate = 400 },
                { itemid = xi.items.UNAPPRAISED_BOX,     droprate = 300 },
            },
        },

        [xi.assault.mission.THE_DOUBLE_AGENT] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_POLEARM, droprate = 250 },
                { itemid = xi.items.UNAPPRAISED_SWORD,   droprate = 400 },
                { itemid = xi.items.UNAPPRAISED_BOX,     droprate = 350 },
            },
        },

        [xi.assault.mission.IMPERIAL_TREASURE_RETRIEVAL] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_CAPE,  droprate = 500 },
                { itemid = xi.items.UNAPPRAISED_SRING, droprate = 400 },
            },
        },
    }

    local regItem =
    {
        [xi.assault.mission.IMPERIAL_AGENT_RESCUE] =
        {
            {
                { itemid = xi.items.HI_POTION_P2,    droprate = 900 },
                { itemid =    0, droprate = 100 },
            },
            {
                { itemid = xi.items.HI_POTION_TANK, droprate = 100 },
                { itemid =     0,                   droprate = 900 },
            },
            {
                { itemid = xi.items.RERAISER,       droprate = 530 },
                { itemid =    0,                    droprate = 470 },
            },
        },

        [xi.assault.mission.PREEMPTIVE_STRIKE] =
        {
            {
                { itemid = xi.items.HI_POTION_TANK, droprate = 100 },
                { itemid =     0,                   droprate = 900 },
            },
            {
                { itemid = xi.items.RERAISER,       droprate = 300 },
                { itemid =    0,                    droprate = 700 },
            },
            {
                { itemid = xi.items.HI_RERAISER,    droprate = 500 },
                { itemid =    0,                    droprate = 500 },
            },
        },

        [xi.assault.mission.SAGELORD_ELIMINATION] =
        {
            {
                { itemid = xi.items.HI_POTION_P3,   droprate = 1000 },
            },
            {
                { itemid = xi.items.RERAISER,       droprate = 150 },
                { itemid = 0,                       droprate = 850 },
            },
            {
                { itemid = xi.items.HI_POTION_TANK, droprate = 150 },
                { itemid = 0,                       droprate = 850 },
            },
            {
                { itemid = xi.items.HI_ETHER_TANK,  droprate = 150 },
                { itemid = 0,                       droprate = 850 },
            },
        },

        [xi.assault.mission.BREAKING_MORALE] =
        {
            {
                { itemid = xi.items.HI_POTION_P2,   droprate = 800 },
                { itemid = 0,                       droprate = 200 },
            },
            {
                { itemid = xi.items.HI_POTION_TANK, droprate = 300 },
                { itemid = 0,                       droprate = 700 },
            },
            {
                { itemid = xi.items.HI_ETHER_TANK,  droprate = 300 },
                { itemid = 0,                       droprate = 700 },
            },
        },

        [xi.assault.mission.THE_DOUBLE_AGENT] =
        {
            {
                { itemid = xi.items.HI_POTION_P3,   droprate = 1000 },
            },
            {
                { itemid = xi.items.RERAISER,       droprate = 300 },
                { itemid = 0,                       droprate = 700 },
            },
            {
                { itemid = xi.items.HI_POTION_TANK, droprate = 300 },
                { itemid = 0,                       droprate = 700 },
            },
            {
                { itemid = xi.items.HI_ETHER_TANK,  droprate = 300 },
                { itemid = 0,                       droprate = 700 },
            },
        },

        [xi.assault.mission.IMPERIAL_TREASURE_RETRIEVAL] =
        {
            {
                { itemid = xi.items.REMEDY,       droprate = 1000 },
            },
            {
                { itemid = xi.items.HI_POTION_P3, droprate = 300 },
                { itemid = 0,                     droprate = 700 },
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
