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
                { itemId = xi.item.UNAPPRAISED_BOX,  weight = 300 },
                { itemId = xi.item.UNAPPRAISED_RING, weight = 700 },
            },
        },

        [xi.assault.mission.PREEMPTIVE_STRIKE] =
        {
            {
                { itemId = xi.item.UNAPPRAISED_BOX,      weight = 300 },
                { itemId = xi.item.UNAPPRAISED_NECKLACE, weight = 700 },
            },
        },
    }

    local regItem =
    {
        [xi.assault.mission.IMPERIAL_AGENT_RESCUE] =
        {
            {
                { itemId = xi.item.HI_POTION_P2, weight = 900 },
                { itemId =    0,                 weight = 100 },
            },

            {
                { itemId = xi.item.HI_POTION_TANK, weight = 100 },
                { itemId =     0,                  weight = 900 },
            },

            {
                { itemId = xi.item.RERAISER, weight = 530 },
                { itemId =    0,             weight = 470 },
            },
        },

        [xi.assault.mission.PREEMPTIVE_STRIKE] =
        {
            {
                { itemId = xi.item.HI_POTION_TANK, weight = 100 },
                { itemId =     0,                  weight = 900 },
            },

            {
                { itemId = xi.item.RERAISER, weight = 300 },
                { itemId =    0,             weight = 700 },
            },

            {
                { itemId = xi.item.HI_RERAISER, weight = 500 },
                { itemId =    0,                weight = 500 },
            },
        },
    }

    local area = player:getCurrentAssault()
    xi.appraisal.assaultChestTrigger(player, npc, qItem[area], regItem[area])
end

return entity
