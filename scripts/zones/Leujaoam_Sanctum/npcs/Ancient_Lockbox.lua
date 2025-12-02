-----------------------------------
-- Area: Leujaoam Sanctum
-- Ancient Lockbox
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local qItem =
    {
        [xi.assault.mission.LEUJAOAM_CLEANSING] =
        {
            {
                { itemId = xi.item.UNAPPRAISED_RING, weight = 700 },
                { itemId = xi.item.UNAPPRAISED_BOX,  weight = 300 },
            },
        },

        [xi.assault.mission.ORICHALCUM_SURVEY] =
        {
            {
                { itemId = xi.item.UNAPPRAISED_NECKLACE, weight = 300 },
                { itemId = xi.item.UNAPPRAISED_BOX,      weight = 400 },
                { itemId = xi.item.UNAPPRAISED_GLOVES,   weight = 300 },
            },
        },
    }

    local regItem =
    {
        [xi.assault.mission.LEUJAOAM_CLEANSING] =
        {
            {
                { itemId = xi.item.HI_POTION_P3, weight = 1000 },
            },

            {
                { itemId = xi.item.HI_POTION_P3, weight = 100 },
                { itemId = 0,                    weight = 900 },
            },

            {
                { itemId = xi.item.REMEDY, weight = 530 },
                { itemId = 0,              weight = 470 },
            },
        },

        [xi.assault.mission.ORICHALCUM_SURVEY] =
        {
            {
                { itemId = xi.item.HI_POTION_P3, weight = 1000 },
            },

            {
                { itemId = xi.item.REMEDY, weight = 530 },
                { itemId = 0,              weight = 470 },
            },
        },
    }

    local area = player:getCurrentAssault()
    xi.appraisal.assaultChestTrigger(player, npc, qItem[area], regItem[area])
end

return entity
