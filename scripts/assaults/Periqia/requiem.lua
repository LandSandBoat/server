-----------------------------------
-- Assault: Requiem
-- Instance 5602
-- Objective: Defeat all 18 Undeads
-----------------------------------
local ID = zones[xi.zone.PERIQIA]
-----------------------------------

local content = InstanceAssault:new(
{
    zoneID           = xi.zone.PERIQIA,
    assaultID        = xi.assault.mission.REQUIEM,
    instanceID       = xi.assault.instance.REQUIEM,
    assaultArea      = xi.assault.assaultArea.PERIQIA,
    requiredOrders   = xi.ki.PERIQIA_ASSAULT_ORDERS,

    runeOfReleasePos = { x = -489.999, y = -9.694, z = -328.999, rot = 0 },
    ancientBoxPos    = { x = -490.000, y = -9.961, z = -326.000, rot = 0 },
    releasePos       = { x = 5, z = 9    },

    suggestedLevel   = 70,
    basePoints       = 1000,
    requiredProgress = 18,

    entranceParams   =
    {
        instanceID   = xi.assault.instance.REQUIEM,
        entryEvent   = { 143, 32, -4, 0, 70, 3, 1 },
        confirmEvent = { 143, 4 },
        memberEvent  = { 147, 0 },
    },
})

content.mobs =
{
    { baseID = ID.mob.REQUIEM_UNDEAD_OFFSET,      offset = 22 },
}

content.loot =
{
    appraisalReward =
    {
        {
            { itemId = xi.item.UNAPPRAISED_GLOVES,  weight = 2500 },
            { itemId = xi.item.UNAPPRAISED_AXE,     weight = 2500 },
            { itemId = xi.item.UNAPPRAISED_POLEARM, weight = 2500 },
            { itemId = xi.item.UNAPPRAISED_BOX,     weight = 2500 },
        },
    },

    bonusLoot =
    {
        {
            { itemId = xi.item.REMEDY,              weight = 10000 },
        },

        {
            { itemId = xi.item.HI_POTION_P3,        weight = 5000 },
            { itemId = xi.item.REMEDY,              weight = 5000 },
        },

        {
            { itemId = xi.item.HI_POTION_P3,        weight = 1000 },
            { itemId = xi.item.NONE,                weight = 9000 },
        },
    },
}

return content:register()
