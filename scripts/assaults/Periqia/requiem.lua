-----------------------------------
-- Assault: Requiem
-- Instance 5602
-- Objective: Destroy the undead
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

    runeOfReleasePos = { x = -490.000, y = -9.695, z = -329.000, rot = 0 },
    ancientBoxPos    = { x = -490.000, y = -9.985, z = -326.000, rot = 0 },
    releasePos       = { x = 5, z = 9 }, -- "Unlocking Rune of Release (F-9)"

    wallNPCs         = { ID.npc._JKH, ID.npc._JKI },

    suggestedLevel   = 70,
    basePoints       = 1000,
    requiredProgress = 18, -- Every undead except the Draugar's Wyvern pets

    entranceParams   =
    {
        instanceID   = xi.assault.instance.REQUIEM,
        entryEvent   = { 143, 32, -4, 0, 70, 0, 1 },
        confirmEvent = { 143, 4 },
        memberEvent  = { 147, 0 },
    },
})

content.loot =
{
    appraisalReward =
    {
        {
            { itemId = xi.item.UNAPPRAISED_BOX,     weight = 4000 },
            { itemId = xi.item.UNAPPRAISED_GLOVES,  weight = 2000 },
            { itemId = xi.item.UNAPPRAISED_POLEARM, weight = 2000 },
            { itemId = xi.item.UNAPPRAISED_AXE,     weight = 2000 },
        },
    },

    bonusLoot =
    {
        {
            { itemId = xi.item.HI_POTION_P3,        weight = 5000 },
            { itemId = xi.item.NONE,                weight = 5000 },
        },

        {
            { itemId = xi.item.HI_ETHER_TANK,       weight = 1000 },
            { itemId = xi.item.NONE,                weight = 9000 },
        },

        {
            { itemId = xi.item.HI_RERAISER,         weight = 5000 },
            { itemId = xi.item.NONE,                weight = 5000 },
        },
    },
}

function content:onInstanceCreated(instance)
    InstanceAssault.onInstanceCreated(self, instance)

    for mobID = ID.mob.PUTRID_IMMORTAL_GUARD, ID.mob.PUTRID_IMMORTAL_GUARD + 22 do

        -- Any pets are skipped and spawned by their masters.
        if not GetMobByID(mobID, instance):getMaster() then
            SpawnMob(mobID, instance)
        end
    end

    GetNPCByID(ID.npc._1KH, instance):setAnimation(xi.animation.CLOSE_DOOR)
    GetNPCByID(ID.npc._1KT, instance):setAnimation(xi.animation.CLOSE_DOOR)
    GetNPCByID(ID.npc._JK5, instance):setAnimation(xi.animation.CLOSE_DOOR)
    GetNPCByID(ID.npc._JK6, instance):setAnimation(xi.animation.CLOSE_DOOR)
    GetNPCByID(ID.npc._JK7, instance):setAnimation(xi.animation.CLOSE_DOOR)
end

return content:register()
