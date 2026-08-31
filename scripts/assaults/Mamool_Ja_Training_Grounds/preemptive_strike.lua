-----------------------------------
-- Assault: Preemptive Strike
-- Instance 6600
-- Objective: Destroy the assassins.
-----------------------------------
local ID = zones[xi.zone.MAMOOL_JA_TRAINING_GROUNDS]
-----------------------------------

local content = InstanceAssault:new(
{
    zoneID           = xi.zone.MAMOOL_JA_TRAINING_GROUNDS,
    assaultID        = xi.assault.mission.PREEMPTIVE_STRIKE,
    instanceID       = xi.assault.instance.PREEMPTIVE_STRIKE,
    assaultArea      = xi.assault.assaultArea.MAMOOL_JA_TRAINING_GROUNDS,
    requiredOrders   = xi.ki.MAMOOL_JA_ASSAULT_ORDERS,

    runeOfReleasePos = { x = -55.000, y = 1.325, z = -103.000, rot = 128 },
    ancientBoxPos    = { x = -58.000, y = 1.519, z = -103.000, rot = 128 },
    releasePos       = { x = 8, z = 8 },

    suggestedLevel   = 60,
    basePoints       = 1000,
    requiredProgress = 13,

    entranceParams   =
    {
        instanceID   = xi.assault.instance.PREEMPTIVE_STRIKE,
        entryEvent   = { 505, 12, -4, 0, 60, 1, 1 },
        confirmEvent = { 505, 4 },
        memberEvent  = { 108, 1 },
    },
})

content.mobs =
{
    { baseID = ID.mob.PUK_EXECUTIONER, offset = 19 },
}

content.loot =
{
    appraisalReward =
    {
        {
            { itemId = xi.item.UNAPPRAISED_NECKLACE, weight = 7000 },
            { itemId = xi.item.UNAPPRAISED_BOX,      weight = 3000 },
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
            { itemId = xi.item.HI_POTION_TANK, weight = 5000 },
            { itemId = xi.item.NONE,           weight = 5000 },
        },
    },
}

return content:register()
