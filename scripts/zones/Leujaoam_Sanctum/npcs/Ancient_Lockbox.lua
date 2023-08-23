-----------------------------------
-- Area: Leujaoam Sanctum
-- Ancient Lockbox
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local qItem =
    {
        [xi.assault.mission.LEUJAOAM_CLEANSING] =
        {
            {
                { itemid = xi.item.UNAPPRAISED_RING, droprate = 700 },
                { itemid = xi.item.UNAPPRAISED_BOX,  droprate = 300 },
            },
        },

        [xi.assault.mission.ORICHALCUM_SURVEY] =
        {
            {
                { itemid = xi.item.UNAPPRAISED_NECKLACE, droprate = 300 },
                { itemid = xi.item.UNAPPRAISED_BOX,      droprate = 400 },
                { itemid = xi.item.UNAPPRAISED_GLOVES,   droprate = 300 },
            },
        },
    }

    local regItem =
    {
        [xi.assault.mission.LEUJAOAM_CLEANSING] =
        {
            {
                { itemid = xi.item.HI_POTION_III, droprate = 1000 },
            },

            {
                { itemid = xi.item.HI_POTION_III, droprate = 100 },
                { itemid = 0,                      droprate = 900 },
            },

            {
                { itemid = xi.item.REMEDY, droprate = 530 },
                { itemid = 0,               droprate = 470 },
            },
        },

        [xi.assault.mission.ORICHALCUM_SURVEY] =
        {
            {
                { itemid = xi.item.HI_POTION_III, droprate = 1000 },
            },

            {
                { itemid = xi.item.REMEDY, droprate = 530 },
                { itemid = 0,               droprate = 470 },
            },
        },
    }

    local area = player:getCurrentAssault()
    xi.appraisal.assaultChestTrigger(player, npc, qItem[area], regItem[area])
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
