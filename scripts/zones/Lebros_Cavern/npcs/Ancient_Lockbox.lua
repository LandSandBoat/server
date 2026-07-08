-----------------------------------
-- Area: Lebros Cavern
-- Ancient Lockbox
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local qItem =
    {
        [xi.assault.mission.EXCAVATION_DUTY] =
        {
            {
                { itemId = xi.item.UNAPPRAISED_BOX,     weight = 300 },
                { itemId = xi.item.UNAPPRAISED_EARRING, weight = 700 },
            },
        },

        [xi.assault.mission.LEBROS_SUPPLIES] =
        {
            {
                { itemId = xi.item.UNAPPRAISED_BOX,  weight = 300 },
                { itemId = xi.item.UNAPPRAISED_CAPE, weight = 700 },
            },
        },

        [xi.assault.mission.TROLL_FUGITIVES] =
        {
            {
                { itemId = xi.item.UNAPPRAISED_AXE,       weight = 300 },
                { itemId = xi.item.UNAPPRAISED_POLEARM,   weight = 200 },
                { itemId = xi.item.UNAPPRAISED_HEADPIECE, weight = 100 },
                { itemId = xi.item.UNAPPRAISED_BOX,       weight = 400 },
            },
        },
    }

    local regItem =
    {
        [xi.assault.mission.EXCAVATION_DUTY] =
        {
            {
                { itemId = xi.item.REMEDY, weight = 900 },
                { itemId = 0,              weight = 100 },
            },

            {
                { itemId = xi.item.REMEDY, weight = 200 },
                { itemId = 0,              weight = 800 },
            },

            {
                { itemId = xi.item.HI_POTION_P3, weight = 400 },
                { itemId = 0,                    weight = 600 },
            },

            {
                { itemId = xi.item.HI_POTION_P3, weight = 200 },
                { itemId = 0,                    weight = 800 },
            },
        },

        [xi.assault.mission.LEBROS_SUPPLIES] =
        {
            {
                { itemId = xi.item.REMEDY, weight = 800 },
                { itemId = 0,              weight = 200 },
            },

            {
                { itemId = xi.item.RERAISER, weight = 200 },
                { itemId = 0,                weight = 800 },
            },

            {
                { itemId = xi.item.HI_POTION_TANK, weight = 100 },
                { itemId = 0,                      weight = 900 },
            },
        },

        [xi.assault.mission.TROLL_FUGITIVES] =
        {
            {
                { itemId = xi.item.HI_POTION_P3, weight = 800 },
                { itemId = 0,                    weight = 200 },
            },

            {
                { itemId = xi.item.RERAISER, weight = 200 },
                { itemId = 0,                weight = 800 },
            },

            {
                { itemId = xi.item.HI_POTION_TANK, weight = 100 },
                { itemId = 0,                      weight = 900 },
            },

            {
                { itemId = xi.item.HI_ETHER_TANK, weight = 100 },
                { itemId = 0,                     weight = 900 },
            },
        },
    }

    local area = player:getCurrentAssault()
    xi.appraisal.assaultChestTrigger(player, npc, qItem[area], regItem[area])
end

return entity
