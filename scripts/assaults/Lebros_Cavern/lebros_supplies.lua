-----------------------------------
-- Assault: Lebros Supplies
-- Instance 6301
-- Objective: Deliver the provisions.
-----------------------------------
local ID = zones[xi.zone.LEBROS_CAVERN]
-----------------------------------

local content = InstanceAssault:new(
{
    zoneID           = xi.zone.LEBROS_CAVERN,
    assaultID        = xi.assault.mission.LEBROS_SUPPLIES,
    instanceID       = xi.assault.instance.LEBROS_SUPPLIES,
    assaultArea      = xi.assault.assaultArea.LEBROS_CAVERN,
    requiredOrders   = xi.ki.LEBROS_ASSAULT_ORDERS,

    runeOfReleasePos = { x = -330, y = -9.930,  z = -262, rot = 128 },
    ancientBoxPos    = { x = -330, y = -10.046, z = -265, rot = 128 },
    releasePos       = { x = 7, z = 8 },

    suggestedLevel   = 60,
    basePoints       = 1200,
    requiredProgress = 12,

    entranceParams   =
    {
        instanceID   = xi.assault.instance.LEBROS_SUPPLIES,
        entryEvent   = { 203, 22, -4, 0, 60, 2, 1 },
        confirmEvent = { 203, 4 },
        memberEvent  = { 208, 0 },
    },

    wallNPCs       = { ID.npc._1rp },
})

content.mobs =
{
    { baseID = ID.mob.CRIMSON_ERUCA, offset = 5 },
}

content.npcs =
{
    { baseID = ID.npc.YAZUHMA,          offset = 0 },
    { baseID = ID.npc.IMPERIAL_STORMER, offset = 11 },
}

content.loot =
{
    appraisalReward =
    {
        {
            { itemId = xi.item.UNAPPRAISED_CAPE, weight = 7000 },
            { itemId = xi.item.UNAPPRAISED_BOX,  weight = 3000 },
        },
    },

    bonusLoot =
    {
        {
            { itemId = xi.item.HI_POTION_P2,   weight = 10000 },
        },

        {
            { itemId = xi.item.RERAISER,       weight = 10000 },
        },

        {
            { itemId = xi.item.HI_POTION_TANK, weight = 10000 },
        },

        {
            { itemId = xi.item.HI_POTION_TANK, weight = 5000  },
            { itemId = xi.item.NONE,           weight = 5000  },
        },
    },
}

return content:register()
