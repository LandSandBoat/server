-----------------------------------
-- Assault: Leujaoam Cleansing
-- Instance 6900
-- Objective: Defeat all 15 Leujaoam Worms
-----------------------------------
local ID = zones[xi.zone.LEUJAOAM_SANCTUM]
-----------------------------------

local content = InstanceAssault:new(
{
    zoneID           = xi.zone.LEUJAOAM_SANCTUM,
    assaultID        = xi.assault.mission.LEUJAOAM_CLEANSING,
    instanceID       = xi.assault.instance.LEUJAOAM_CLEANSING,
    assaultArea      = xi.assault.assaultArea.LEUJAOAM_SANCTUM,
    requiredOrders   = xi.ki.LEUJAOAM_ASSAULT_ORDERS,

    runeOfReleasePos = { x = 476.000, y = 8.479, z = 40.000, rot = 49 },
    ancientBoxPos    = { x = 476.000, y = 8.479, z = 39.000, rot = 49 },
    releasePos       = { x = 8, z = 8 },

    suggestedLevel   = 50,
    basePoints       = 1000,
    requiredProgress = 14,

    entranceParams   =
    {
        instanceID   = xi.assault.instance.LEUJAOAM_CLEANSING,
        entryEvent   = { 140, 1, -4, 0, 50, 0, 1 },
        confirmEvent = { 140, 4 },
        memberEvent  = { 147, 0 },
    },
})

content.mobs =
{
    { baseID = ID.mob.LEUJAOAM_WORM, offset = 14 },
}

content.loot =
{
    appraisalReward =
    {
        {
            { itemId = xi.item.UNAPPRAISED_RING, weight = 7000 },
            { itemId = xi.item.UNAPPRAISED_BOX,  weight = 3000 },
        },
    },

    bonusLoot =
    {
        {
            { itemId = xi.item.REMEDY,       weight = 10000 },
        },

        {
            { itemId = xi.item.HI_POTION_P3, weight = 5000 },
            { itemId = xi.item.REMEDY,       weight = 5000 },
        },

        {
            { itemId = xi.item.HI_POTION_P3, weight = 1000 },
            { itemId = xi.item.NONE,         weight = 9000 },
        },
    },
}

return content:register()
