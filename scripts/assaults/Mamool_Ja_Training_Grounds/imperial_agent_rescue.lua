-----------------------------------
-- Assault: Imperial Agent Rescue
-- Instance 6600
-- Objective: Rescue the captured agent
-----------------------------------
local ID = zones[xi.zone.MAMOOL_JA_TRAINING_GROUNDS]
local rescueMobs = ID.mob[xi.assault.mission.IMPERIAL_AGENT_RESCUE]
-----------------------------------
local content = InstanceAssault:new(
{
    zoneID         = xi.zone.MAMOOL_JA_TRAINING_GROUNDS,
    assaultID      = xi.assault.mission.IMPERIAL_AGENT_RESCUE,
    instanceID     = xi.assault.instance.IMPERIAL_AGENT_RESCUE,
    assaultArea    = xi.assault.assaultArea.MAMOOL_JA_TRAINING_GROUNDS,
    requiredOrders = xi.ki.MAMOOL_JA_ASSAULT_ORDERS,

    runeOfReleasePos = { x = 220.000, y = 1.465, z = -504.999, rot = 0 },
    ancientBoxPos    = { x = 220.000, y = 1.619, z = -502.999, rot = 0 },
    releasePos       = { x = 8, z = 8 },

    suggestedLevel = 60,
    basePoints     = 1100,

    -- Bhaflau Thickets / Mamool Ja Training Grounds events.
    -- These replace the Leujaoam events that were previously copied here.
    entranceParams =
    {
        instanceID   = xi.assault.instance.IMPERIAL_AGENT_RESCUE,
        entryEvent   = { 505, 11, -4, 0, 60, 1, 1 },
        confirmEvent = { 505, 4 },
        memberEvent  = { 108, 1 },
    },
})

-- The gaps are pets spawned by their owning BST Warders.
content.mobs =
{
    { baseID = rescueMobs.MOBS_START[1], offset = 1 }, -- 17047553-17047554
    { baseID = rescueMobs.MOBS_START[3], offset = 1 }, -- 17047556-17047557
    { baseID = rescueMobs.MOBS_START[5], offset = 2 }, -- 17047559-17047561
    { baseID = rescueMobs.MOBS_START[8], offset = 3 }, -- 17047563-17047566
    { baseID = rescueMobs.GATES[1],      offset = 2 }, -- 17047567-17047569
}

content.loot =
{
    appraisalReward =
    {
        {
            { itemId = xi.item.UNAPPRAISED_BOX,  weight = 3000 },
            { itemId = xi.item.UNAPPRAISED_RING, weight = 7000 },
        },
    },

    bonusLoot =
    {
        {
            { itemId = xi.item.HI_POTION_P2, weight = 9000 },
            { itemId = xi.item.NONE,         weight = 1000 },
        },
        {
            { itemId = xi.item.HI_POTION_TANK, weight = 1000 },
            { itemId = xi.item.NONE,           weight = 9000 },
        },
        {
            { itemId = xi.item.RERAISER, weight = 5300 },
            { itemId = xi.item.NONE,     weight = 4700 },
        },
    },
}

-- Store the selected hatch separately from instance progress. Progress is
-- reserved by InstanceAssault for objective completion and must not contain
-- an NPC ID. Call the base method first so content.mobs are spawned normally.
function content:onInstanceCreated(instance)
    InstanceAssault.onInstanceCreated(self, instance)

    local selectedPot = math.randomInt(ID.npc.POT_HATCH, ID.npc.POT_HATCH + 2)
    instance:setLocalVar('ImperialAgentRescuePotId', selectedPot)
    instance:setLocalVar('ImperialAgentRescueTriggered', 0)
end

return content:register()
