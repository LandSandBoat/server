-----------------------------------
-- Area: Mamool Ja Training Grounds
-- Ancient Lockbox
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local qItem =
    {
        [xi.assault.mission.IMPERIAL_AGENT_RESCUE] =
        {
            {
                { itemid = xi.item.UNAPPRAISED_BOX,  droprate = 300 },
                { itemid = xi.item.UNAPPRAISED_RING, droprate = 700 },
            },
        },

        [xi.assault.mission.PREEMPTIVE_STRIKE] =
        {
            {
                { itemid = xi.item.UNAPPRAISED_BOX,      droprate = 300 },
                { itemid = xi.item.UNAPPRAISED_NECKLACE, droprate = 700 },
            },
        },
    }

    local regItem =
    {
        [xi.assault.mission.IMPERIAL_AGENT_RESCUE] =
        {
            {
                { itemid = xi.item.HI_POTION_P2, droprate = 900 },
                { itemid =    0,                 droprate = 100 },
            },

            {
                { itemid = xi.item.HI_POTION_TANK, droprate = 100 },
                { itemid =     0,                  droprate = 900 },
            },

            {
                { itemid = xi.item.RERAISER, droprate = 530 },
                { itemid =    0,             droprate = 470 },
            },
        },

        [xi.assault.mission.PREEMPTIVE_STRIKE] =
        {
            {
                { itemid = xi.item.HI_POTION_TANK, droprate = 100 },
                { itemid =     0,                   droprate = 900 },
            },

            {
                { itemid = xi.item.RERAISER, droprate = 300 },
                { itemid =    0,              droprate = 700 },
            },

            {
                { itemid = xi.item.HI_RERAISER, droprate = 500 },
                { itemid =    0,                 droprate = 500 },
            },
        },
    }

    local area = player:getCurrentAssault()
    xi.appraisal.assaultChestTrigger(player, npc, qItem[area], regItem[area])
end

return entity
