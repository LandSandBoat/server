-----------------------------------
-- Area: Periqia
-- Ancient Lockbox
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local qItem =
    {
        [xi.assault.mission.SEAGULL_GROUNDED] =
        {
            {
                { itemId = xi.item.UNAPPRAISED_BOX,     weight = 400 },
                { itemId = xi.item.UNAPPRAISED_SWORD,   weight = 200 },
                { itemId = xi.item.UNAPPRAISED_POLEARM, weight = 200 },
                { itemId = xi.item.UNAPPRAISED_GLOVES,  weight = 200 },
            },
        },

        [xi.assault.mission.REQUIEM] =
        {
            {
                { itemId = xi.item.UNAPPRAISED_BOX,     weight = 400 },
                { itemId = xi.item.UNAPPRAISED_GLOVES,  weight = 200 },
                { itemId = xi.item.UNAPPRAISED_POLEARM, weight = 200 },
                { itemId = xi.item.UNAPPRAISED_AXE,     weight = 200 },
            },
        },

        [xi.assault.mission.SHOOTING_DOWN_THE_BARON] =
        {
            {
                { itemId = xi.item.UNAPPRAISED_BOW,   weight = 600 },
                { itemId = xi.item.UNAPPRAISED_BOX,   weight = 400 },
            },
        },
    }

    local regItem =
    {
        [xi.assault.mission.SEAGULL_GROUNDED] =
        {
            {
                { itemId = xi.item.HI_RERAISER,       weight = 700 },
                { itemId = 0,                         weight = 300 },
            },

            {
                { itemId = xi.item.HI_POTION_TANK,    weight = 100 },
                { itemId = xi.item.HI_ETHER_TANK,     weight = 100 },
                { itemId = 0,                         weight = 800 },
            },

            {
                { itemId = xi.item.HI_POTION_P3,      weight = 530 },
                { itemId = 0,                         weight = 470 },
            },
        },

        [xi.assault.mission.REQUIEM] =
        {
            {
                { itemId = xi.item.HI_POTION_P3,      weight = 500 },
                { itemId = 0,                         weight = 500 },
            },

            {
                { itemId = xi.item.HI_ETHER_TANK,     weight = 100 },
                { itemId = 0,                         weight = 900 },
            },

            {
                { itemId = xi.item.HI_RERAISER,       weight = 500 },
                { itemId = 0,                         weight = 500 },
            },
        },

        [xi.assault.mission.SHOOTING_DOWN_THE_BARON] =
        {
            {
                { itemId = xi.item.HI_POTION_P2,      weight = 850 },
                { itemId = 0,                         weight = 150 },
            },
            {
                { itemId = xi.item.HI_POTION_P3,      weight = 50 },
                { itemId = 0,                         weight = 950 },
            },
            {
                { itemId = xi.item.HI_POTION_TANK,    weight = 400 },
                { itemId = 0,                         weight = 600 },
            },
            {
                { itemId = xi.item.HI_RERAISER,       weight = 200 },
                { itemId = 0,                         weight = 800 },
            },
        },
    }

    local area = player:getCurrentAssault()
    xi.appraisal.assaultChestTrigger(player, npc, qItem[area], regItem[area])
end

return entity
