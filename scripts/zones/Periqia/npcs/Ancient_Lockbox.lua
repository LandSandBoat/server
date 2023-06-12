-----------------------------------
-- Area: Periqia
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
        [xi.assault.mission.SEAGULL_GROUNDED] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_BOX,     droprate = 400 },
                { itemid = xi.items.UNAPPRAISED_SWORD,   droprate = 200 },
                { itemid = xi.items.UNAPPRAISED_POLEARM, droprate = 200 },
                { itemid = xi.items.UNAPPRAISED_GLOVES,  droprate = 200 },
            },
        },

        [xi.assault.mission.REQUIEM] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_BOX,     droprate = 400 },
                { itemid = xi.items.UNAPPRAISED_GLOVES,  droprate = 200 },
                { itemid = xi.items.UNAPPRAISED_POLEARM, droprate = 200 },
                { itemid = xi.items.UNAPPRAISED_AXE,     droprate = 200 },
            },
        },

        [xi.assault.mission.SAVING_PRIVATE_RYAAF] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_BOX,     droprate = 500 },
                { itemid = xi.items.UNAPPRAISED_SHIELD,  droprate = 250 },
                { itemid = xi.items.UNAPPRAISED_POLEARM, droprate = 200 },
                { itemid = xi.items.UNAPPRAISED_AXE,     droprate =  50 },
            },
        },

        [xi.assault.mission.SHOOTING_DOWN_THE_BARON] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_BOW,     droprate = 600 },
                { itemid = xi.items.UNAPPRAISED_BOX,     droprate = 400 },
            },
        },

        [xi.assault.mission.BUILDING_BRIDGES] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_BOX,     droprate = 400 },
                { itemid = xi.items.UNAPPRAISED_POLEARM, droprate = 100 },
                { itemid = xi.items.UNAPPRAISED_AXE,     droprate = 400 },
            },
        },

        [xi.assault.mission.STOP_THE_BLOODSHED] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_CAPE,    droprate = 600 },
                { itemid = xi.items.UNAPPRAISED_SWORD,   droprate = 100 },
                { itemid = xi.items.UNAPPRAISED_POLEARM, droprate = 100 },
                { itemid = xi.items.UNAPPRAISED_BOX,     droprate = 200 },
            },
        },
    }

    local regItem =
    {
        [xi.assault.mission.SEAGULL_GROUNDED] =
        {
            {
                { itemid = xi.items.HI_RERAISER,    droprate = 700 },
                { itemid = 0,                       droprate = 300 },
            },
            {
                { itemid = xi.items.HI_POTION_TANK, droprate = 100 },
                { itemid = xi.items.HI_ETHER_TANK,  droprate = 100 },
                { itemid = 0,                       droprate = 800 },
            },
            {
                { itemid = xi.items.HI_POTION_P3,   droprate = 500 },
                { itemid = 0,                       droprate = 500 },
            },
        },

        [xi.assault.mission.REQUIEM] =
        {
            {
                { itemid = xi.items.HI_POTION_P3,  droprate = 500 },
                { itemid = 0,                      droprate = 500 },
            },
            {
                { itemid = xi.items.HI_ETHER_TANK, droprate = 100 },
                { itemid = 0,                      droprate = 900 },
            },
            {
                { itemid = xi.items.HI_RERAISER,   droprate = 500 },
                { itemid = 0,                      droprate = 500 },
            },
        },

        [xi.assault.mission.SAVING_PRIVATE_RYAAF] =
        {
            {
                { itemid = xi.items.HI_POTION_P3,   droprate = 1000 },
            },
            {
                { itemid = xi.items.HI_ETHER_TANK,  droprate = 250 },
                { itemid = 0,                       droprate = 750 },
            },
            {
                { itemid = xi.items.HI_POTION_TANK, droprate = 200 },
                { itemid = 0,                       droprate = 800 },
            },
            {
                { itemid = xi.items.HI_RERAISER,    droprate = 150 },
                { itemid = 0,                       droprate = 750 },
            },
        },

        [xi.assault.mission.SHOOTING_DOWN_THE_BARON] =
        {
            {
                { itemid = xi.items.HI_POTION_P2,   droprate = 850 },
                { itemid = 0,                       droprate = 150 },
            },
            {
                { itemid = xi.items.HI_POTION_P3,   droprate = 50 },
                { itemid = 0,                       droprate = 950 },
            },
            {
                { itemid = xi.items.HI_POTION_TANK, droprate = 400 },
                { itemid = 0,                       droprate = 600 },
            },
            {
                { itemid = xi.items.HI_RERAISER,    droprate = 200 },
                { itemid = 0,                       droprate = 800 },
            },
        },

        [xi.assault.mission.BUILDING_BRIDGES] =
        {
            {
                { itemid = xi.items.HI_POTION_P3,   droprate = 1000 },
            },
            {
                { itemid = xi.items.HI_POTION_TANK, droprate = 300 },
                { itemid = 0,                       droprate = 700 },
            },
            {
                { itemid = xi.items.HI_ETHER_TANK,  droprate = 300 },
                { itemid = 0,                       droprate = 700 },
            },
            {
                { itemid = xi.items.HI_RERAISER,    droprate = 250 },
                { itemid = 0,                       droprate = 750 },
            },
        },

        [xi.assault.mission.STOP_THE_BLOODSHED] =
        {
            {
                { itemid = xi.items.HI_POTION_P3,   droprate = 500 },
                { itemid = 0,                       droprate = 500 },
            },
            {
                { itemid = xi.items.REMEDY,         droprate = 900 },
                { itemid = 0,                       droprate = 100 },
            },
            {
                { itemid = xi.items.REMEDY,         droprate = 300 },
                { itemid = 0,                       droprate = 700 },
            },
        },
    }

    local area = player:getCurrentAssault()
    xi.UNAPPRAISED.assaultChestTrigger(player, npc, qItem[area], regItem[area])
end

return entity
