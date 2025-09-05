-----------------------------------
-- Area: Ilrusi Atoll
-- Ancient Lockbox
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local qItem =
    {
        [xi.assault.mission.EXTERMINATION] =
        {
            {
                { itemid = xi.item.UNAPPRAISED_BOX,      droprate = 500 },
                { itemid = xi.item.UNAPPRAISED_FOOTWEAR, droprate = 250 },
                { itemid = xi.item.UNAPPRAISED_POLEARM,  droprate = 250 },
                { itemid = xi.item.UNAPPRAISED_AXE,      droprate =  10 },
            },
        },
    }

    local regItem =
    {
        [xi.assault.mission.EXTERMINATION] =
        {
            {
                { itemid = xi.item.HI_POTION_P3,       droprate = 1000 },
            },

            {
                { itemid = xi.item.HI_RERAISER,        droprate = 150 },
                { itemid = 0,                          droprate = 850 },
            },

            {
                { itemid = xi.item.HI_POTION_TANK,     droprate = 400 },
                { itemid = xi.item.HI_ETHER_TANK,      droprate =  50 },
                { itemid = 0,                          droprate = 550 },
            },

            {
                { itemid = xi.item.WILLOW_FISHING_ROD, droprate = 50  },
                { itemid = 0,                          droprate = 950 },
            },
        },
    }

    local area = player:getCurrentAssault()
    xi.appraisal.assaultChestTrigger(player, npc, qItem[area], regItem[area])
end

return entity
