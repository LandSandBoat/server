-----------------------------------
-- Area: Periqia
-- Ancient Lockbox
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local qItem =
    {
        [xi.assault.mission.SEAGULL_GROUNDED] =
        {
            {
                { itemid = xi.item.UNAPPRAISED_BOX,     droprate = 400 },
                { itemid = xi.item.UNAPPRAISED_SWORD,   droprate = 200 },
                { itemid = xi.item.UNAPPRAISED_POLEARM, droprate = 200 },
                { itemid = xi.item.UNAPPRAISED_GLOVES,  droprate = 200 },
            },
        },

        [xi.assault.mission.REQUIEM] =
        {
            {
                { itemid = xi.item.UNAPPRAISED_BOX,     droprate = 400 },
                { itemid = xi.item.UNAPPRAISED_GLOVES,  droprate = 200 },
                { itemid = xi.item.UNAPPRAISED_POLEARM, droprate = 200 },
                { itemid = xi.item.UNAPPRAISED_AXE,     droprate = 200 },
            },
        },

        [xi.assault.mission.SHOOTING_DOWN_THE_BARON] =
        {
            {
                { itemid = xi.item.UNAPPRAISED_BOW,   droprate = 600 },
                { itemid = xi.item.UNAPPRAISED_BOX,   droprate = 400 },
            },
        },
    }

    local regItem =
    {
        [xi.assault.mission.SEAGULL_GROUNDED] =
        {
            {
                { itemid = xi.item.HI_RERAISER,       droprate = 700 },
                { itemid = 0,                         droprate = 300 },
            },

            {
                { itemid = xi.item.HI_POTION_TANK,    droprate = 100 },
                { itemid = xi.item.HI_ETHER_TANK,     droprate = 100 },
                { itemid = 0,                         droprate = 800 },
            },

            {
                { itemid = xi.item.HI_POTION_P3,      droprate = 530 },
                { itemid = 0,                         droprate = 470 },
            },
        },

        [xi.assault.mission.REQUIEM] =
        {
            {
                { itemid = xi.item.HI_POTION_P3,      droprate = 500 },
                { itemid = 0,                         droprate = 500 },
            },

            {
                { itemid = xi.item.HI_ETHER_TANK,     droprate = 100 },
                { itemid = 0,                         droprate = 900 },
            },

            {
                { itemid = xi.item.HI_RERAISER,       droprate = 500 },
                { itemid = 0,                         droprate = 500 },
            },
        },

        [xi.assault.mission.SHOOTING_DOWN_THE_BARON] =
        {
            {
                { itemid = xi.item.HI_POTION_P2,      droprate = 850 },
                { itemid = 0,                         droprate = 150 },
            },
            {
                { itemid = xi.item.HI_POTION_P3,      droprate = 50 },
                { itemid = 0,                         droprate = 950 },
            },
            {
                { itemid = xi.item.HI_POTION_TANK,    droprate = 400 },
                { itemid = 0,                         droprate = 600 },
            },
            {
                { itemid = xi.item.HI_RERAISER,       droprate = 200 },
                { itemid = 0,                         droprate = 800 },
            },
        },
    }

    local area = player:getCurrentAssault()
    xi.appraisal.assaultChestTrigger(player, npc, qItem[area], regItem[area])
end

return entity
