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
    }

    local regItem =
    {
        [xi.assault.mission.IMPERIAL_AGENT_RESCUE] =
        {
            {
                { itemid = xi.items.HI_POTION_II, droprate = 900 },
                { itemid =    0,                  droprate = 100 },
            },

            {
                { itemid = xi.items.HI_POTION_TANK, droprate = 100 },
                { itemid =     0,                   droprate = 900 },
            },

            {
                { itemid = xi.items.RERAISER, droprate = 530 },
                { itemid =    0,              droprate = 470 },
            },
        },

        [xi.assault.mission.PREEMPTIVE_STRIKE] =
        {
            {
                { itemid = xi.items.HI_POTION_TANK, droprate = 100 },
                { itemid =     0,                   droprate = 900 },
            },

            {
                { itemid = xi.items.RERAISER, droprate = 300 },
                { itemid =    0,              droprate = 700 },
            },

            {
                { itemid = xi.items.HI_RERAISER, droprate = 500 },
                { itemid =    0,                 droprate = 500 },
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
