-----------------------------------
-- Assault: Excavation Duty
-- Instance 6300
-- Objective: Destroy the 5 Brittle Rocks
-----------------------------------
local ID = zones[xi.zone.LEBROS_CAVERN]
-----------------------------------

local content = InstanceAssault:new(
{
    zoneID           = xi.zone.LEBROS_CAVERN,
    assaultID        = xi.assault.mission.EXCAVATION_DUTY,
    instanceID       = xi.assault.instance.EXCAVATION_DUTY,
    assaultArea      = xi.assault.assaultArea.LEBROS_CAVERN,
    requiredOrders   = xi.ki.LEBROS_ASSAULT_ORDERS,

    runeOfReleasePos = { x = 49.999, y = -40.837, z = 96.999, rot = 0 },
    ancientBoxPos    = { x = 50.000, y = -40.070, z = 99.999, rot = 0 },
    releasePos       = { x = 5, z = 10 },

    suggestedLevel   = 50,
    basePoints       = 1100,
    requiredProgress = 5,

    entranceParams   =
    {
        instanceID   = xi.assault.instance.EXCAVATION_DUTY,
        entryEvent   = { 203, 21, -4, 0, 50, 0, 1 },
        confirmEvent = { 203, 4 },
        memberEvent  = { 208, 0 },
    },
})

content.mobs =
{
    { baseID = ID.mob.VOLCANIC_BOMB, offset = 26 },
}

content.loot =
{
    appraisalReward = -- TODO: More data on loot. Box is 9/20 on current data.
    {
        {
            { itemId = xi.item.UNAPPRAISED_BOX,     weight = 3000 },
            { itemId = xi.item.UNAPPRAISED_EARRING, weight = 7000 },
        },
    },

    bonusLoot =
    {
        {
            { itemId = xi.item.REMEDY, weight = 9000 },
            { itemId = xi.item.NONE,   weight = 1000 },
        },

        {
            { itemId = xi.item.REMEDY, weight = 2000 },
            { itemId = xi.item.NONE,   weight = 8000 },
        },

        {
            { itemId = xi.item.HI_POTION_P3, weight = 4000 },
            { itemId = xi.item.NONE,         weight = 6000 },
        },

        {
            { itemId = xi.item.HI_POTION_P3, weight = 2000 },
            { itemId = xi.item.NONE,         weight = 8000 },
        },
    },
}

return content:register()
