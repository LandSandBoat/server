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
                { itemid = xi.item.APPRAISAL_BOX,     droprate = 400 },
                { itemid = xi.item.APPRAISAL_SWORD,   droprate = 200 },
                { itemid = xi.item.APPRAISAL_POLEARM, droprate = 200 },
                { itemid = xi.item.APPRAISAL_GLOVES,  droprate = 200 },
            },
        },

        [xi.assault.mission.REQUIEM] =
        {
            {
                { itemid = xi.item.APPRAISAL_BOX,     droprate = 400 },
                { itemid = xi.item.APPRAISAL_GLOVES,  droprate = 200 },
                { itemid = xi.item.APPRAISAL_POLEARM, droprate = 200 },
                { itemid = xi.item.APPRAISAL_AXE,     droprate = 200 },
            },
        },
    }

    local regItem =
    {
        [xi.assault.mission.SEAGULL_GROUNDED] =
        {
            {
                { itemid = xi.item.HI_RERAISER, droprate = 700 },
                { itemid = 0,                    droprate = 300 },
            },

            {
                { itemid = xi.item.HI_POTION_TANK, droprate = 100 },
                { itemid = xi.item.HI_ETHER_TANK,  droprate = 100 },
                { itemid = 0,                       droprate = 800 },
            },

            {
                { itemid = xi.item.HI_POTION_III, droprate = 530 },
                { itemid = 0,                      droprate = 470 },
            },
        },

        [xi.assault.mission.REQUIEM] =
        {
            {
                { itemid = xi.item.HI_POTION_III, droprate = 500 },
                { itemid = 0,                      droprate = 500 },
            },

            {
                { itemid = xi.item.HI_ETHER_TANK, droprate = 100 },
                { itemid = 0,                      droprate = 900 },
            },

            {
                { itemid = xi.item.HI_RERAISER, droprate = 500 },
                { itemid = 0,                    droprate = 500 },
            },
        },
    }

    local area = player:getCurrentAssault()
    xi.appraisal.assaultChestTrigger(player, npc, qItem[area], regItem[area])
end

return entity
