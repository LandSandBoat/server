-----------------------------------
-- Area: Ilrusi Atoll
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
        [xi.assault.mission.GOLDEN_SALVAGE] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_EARRING,  droprate = 600 },
                { itemid = xi.items.UNAPPRAISED_BOX,      droprate = 400 },
            },
        },

        [xi.assault.mission.LAMIA_NO_13] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_FOOTWEAR, droprate = 350 },
                { itemid = xi.items.UNAPPRAISED_BOW,      droprate = 300 },
                { itemid = xi.items.UNAPPRAISED_BOX,      droprate = 350 },
            },
        },

        -- Poor sample rate
        [xi.assault.mission.EXTERMINATION] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_FOOTWEAR, droprate = 250 },
                { itemid = xi.items.UNAPPRAISED_BOX,      droprate = 500 },
                { itemid = xi.items.UNAPPRAISED_POLEARM,  droprate = 250 },
            },
        },

        -- Poor sample rate
        [xi.assault.mission.DEMOLITION_DUTY] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_SASH,     droprate = 500 },
                { itemid = xi.items.UNAPPRAISED_BOX,      droprate = 500 },
            },
        },

        -- Poor sample rate
        [xi.assault.mission.SEARAT_SALVATION] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_BOX,      droprate = 250 },
                { itemid = xi.items.UNAPPRAISED_DAGGER,   droprate = 750 },
            },
        },

        -- Poor sample rate
        [xi.assault.mission.APKALLU_SEIZURE] =
        {
            {
                { itemid = xi.items.UNAPPRAISED_POLEARM, droprate = 200 },
                { itemid = xi.items.UNAPPRAISED_AXE,     droprate = 200 },
                { itemid = xi.items.UNAPPRAISED_BOX,     droprate = 400 },
            },
        },
    }

    local regItem =
    {
        [xi.assault.mission.GOLDEN_SALVAGE] =
        {
            {
                { itemid = xi.items.RERAISER,       droprate = 250 },
                { itemid = 0,                       droprate = 750 },
            },
            {
                { itemid = xi.items.HI_POTION_TANK, droprate = 500 },
                { itemid = 0,                       droprate = 500 },
            },
            {
                { itemid = xi.items.HI_POTION_P2,   droprate = 950 },
                { itemid = 0,                       droprate =  50 },
            },
        },

        [xi.assault.mission.LAMIA_NO_13] =
        {
            {
                { itemid = xi.items.HI_POTION_P3,   droprate = 1000 },
            },
            {
                { itemid = xi.items.HI_ETHER_TANK,  droprate = 300 },
                { itemid = 0,                       droprate = 700 },
            },
            {
                { itemid = xi.items.HI_POTION_TANK, droprate = 300 },
                { itemid = 0,                       droprate = 700 },
            },
            {
                { itemid = xi.items.HI_RERAISER,    droprate = 300 },
                { itemid = 0,                       droprate = 700 },
            },
        },

        -- Poor sample rate
        [xi.assault.mission.EXTERMINATION] =
        {
            {
                { itemid = xi.items.HI_POTION_P3,   droprate = 1000 },
            },
            {
                { itemid = xi.items.HI_POTION_TANK, droprate = 500 },
                { itemid = 0,                       droprate = 500 },
            },
            {
                { itemid = xi.items.HI_RERAISER,    droprate = 150 },
                { itemid = 0,                       droprate = 850 },
            },
        },

        -- Poor sample rate
        [xi.assault.mission.DEMOLITION_DUTY] =
        {
            {
                { itemid = xi.items.HI_POTION_P3, droprate = 250 },
                { itemid = 0,                     droprate = 750 },
            },
            {
                { itemid = xi.items.REMEDY,       droprate = 800 },
                { itemid = 0,                     droprate = 200 },
            },
        },

        -- Poor sample rate
        [xi.assault.mission.SEARAT_SALVATION] =
        {
            {
                { itemid = xi.items.HI_POTION_P2,   droprate = 1000 },
            },
            {
                { itemid = xi.items.HI_POTION_P2,   droprate = 150 },
                { itemid = 0,                       droprate = 850 },
            },
            {
                { itemid = xi.items.HI_POTION_TANK, droprate = 300 },
                { itemid = 0,                       droprate = 700 },
            },
            {
                { itemid = xi.items.RERAISER,       droprate = 150 },
                { itemid = 0,                       droprate = 850 },
            },
        },

        -- Poor sample rate
        [xi.assault.mission.APKALLU_SEIZURE] =
        {
            {
                { itemid = xi.items.HI_POTION_P2,   droprate = 100 },
                { itemid = 0,                       droprate = 900 },
            },
            {
                { itemid = xi.items.HI_POTION_P3,   droprate = 750 },
                { itemid = 0,                       droprate = 250 },
            },
            {
                { itemid = xi.items.HI_POTION_TANK, droprate = 250 },
                { itemid = 0,                       droprate = 750 },
            },
            {
                { itemid = xi.items.HI_ETHER_TANK,  droprate = 250 },
                { itemid = 0,                       droprate = 750 },
            },
        },
    }

    local area = player:getCurrentAssault()
    xi.appraisal.assaultChestTrigger(player, npc, qItem[area], regItem[area])
end

return entity
