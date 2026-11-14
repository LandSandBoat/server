-----------------------------------
-- Assault: Orichalcum Survey
-- Instance 6901
-- Objective: Find the Orichalcum ore
-----------------------------------
local ID = zones[xi.zone.LEUJAOAM_SANCTUM]
-----------------------------------

local content = InstanceAssault:new(
{
    zoneID           = xi.zone.LEUJAOAM_SANCTUM,
    assaultID        = xi.assault.mission.ORICHALCUM_SURVEY,
    instanceID       = xi.assault.instance.ORICHALCUM_SURVEY,
    assaultArea      = xi.assault.assaultArea.LEUJAOAM_SANCTUM,
    requiredOrders   = xi.ki.LEUJAOAM_ASSAULT_ORDERS,

    runeOfReleasePos = { x = -432, y = -27, z = 169, rot = 49 },
    ancientBoxPos    = { x = -432, y = -27, z = 167, rot = 129 },
    releasePos       = { x = 7, z = 8 },

    suggestedLevel   = 50,
    basePoints       = 1200,
    requiredProgress = 1,

    wallNPCs       = { ID.npc._1xo },

    entranceParams   =
    {
        instanceID   = xi.assault.instance.ORICHALCUM_SURVEY,
        entryEvent   = { 140, 2, -4, 0, 50, 0, 1 },
        confirmEvent = { 140, 4 },
        memberEvent  = { 147, 0 },
    },
})

content.mobs =
{
    { baseID = ID.mob.QIQIRN_MINER, offset = 7 },
}

content.npcs =
{
    { baseID = ID.npc.MINING_POINTS, offset = 9 },
    { baseID = ID.npc.MULWAHAH, offset = 0 },
}

function content:onInstanceCreated(instance)
    InstanceAssault.onInstanceCreated(self, instance)

    local mulwahah = GetNPCByID(ID.npc.MULWAHAH, instance)
    if mulwahah then
        mulwahah:setStatus(xi.status.NORMAL)
    end

    for i = 0, 9 do
        local pointID = ID.npc.MINING_POINTS + i
        local point   = GetNPCByID(pointID, instance)

        if point then
            point:setStatus(xi.status.NORMAL)
        end
    end
end

content.loot =
{
    appraisalReward =
    {
        {
            { itemId = xi.item.UNAPPRAISED_GLOVES,   weight = 3500 },
            { itemId = xi.item.UNAPPRAISED_NECKLACE, weight = 3500 },
            { itemId = xi.item.UNAPPRAISED_BOX,      weight = 3000 },
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
