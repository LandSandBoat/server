-----------------------------------
-- Assault: Golden Salvage
-- Instance 5500
-- Objective: Recover the golden figurehead.
-----------------------------------
local ID = zones[xi.zone.ILRUSI_ATOLL]
-----------------------------------

local content = InstanceAssault:new(
{
    zoneID           = xi.zone.ILRUSI_ATOLL,
    assaultID        = xi.assault.mission.GOLDEN_SALVAGE,
    instanceID       = xi.assault.instance.GOLDEN_SALVAGE,
    assaultArea      = xi.assault.assaultArea.ILRUSI_ATOLL,
    requiredOrders   = xi.ki.ILRUSI_ASSAULT_ORDERS,

    -- Retail capture coordinates are listed in x, z, y order; setPos takes x, y (height), z.
    runeOfReleasePos = { x = 380.000, y = -7.885, z = 64.999, rot = 0 },
    ancientBoxPos    = { x = 380.000, y = -7.752, z = 61.999, rot = 0 },
    releasePos       = { x = 7, z = 7 },

    -- Collision props gating the Golden Salvage area; opened at instance creation.
    wallNPCs         = { ID.npc._1jp, ID.npc._jja, ID.npc._jjb, ID.npc._1jo },

    -- Progress is set to 1 after opening the chest with the Golden Figurehead.
    suggestedLevel   = 60,
    basePoints       = 1100,
    requiredProgress = 1,

    entranceParams   =
    {
        instanceID   = xi.assault.instance.GOLDEN_SALVAGE,
        entryEvent   = { 219, 41, -4, 0, 60, 4, 1 },
        confirmEvent = { 219, 4 },
        memberEvent  = { 222, 4 },
    },
})

content.mobs =
{
    { baseID = ID.mob.PERCIPIENT_FISH, offset =  7 },
    { baseID = ID.mob.CURSED_CHEST,    offset = 11 },
}

content.loot =
{
    appraisalReward =
    {
        {
            { itemId = xi.item.UNAPPRAISED_EARRING, weight =  7000 },
            { itemId = xi.item.UNAPPRAISED_BOX,     weight =  3000 },
        },
    },

    bonusLoot =
    {
        {
            { itemId = xi.item.REMEDY,              weight = 10000 },
        },

        {
            { itemId = xi.item.HI_POTION_P3,        weight =  5000 },
            { itemId = xi.item.REMEDY,              weight =  5000 },
        },

        {
            { itemId = xi.item.HI_POTION_P3,        weight =  1000 },
            { itemId = xi.item.NONE,                weight =  9000 },
        },
    },
}

-- Retail captured positions, 18 regions, with some regions having multiple spawn points. TODO: Spawn regions?
-- Fish also seem to have spawn regions as well that need to be captured.
local chestSpawnPoints =
{
    [ 1] =
    {
        { x = 222.815, y =  -2.598, z =  -26.028 },
        { x = 222.981, y =  -2.374, z =  -31.139 },
        { x = 228.292, y =  -2.156, z =  -25.363 },
        { x = 228.597, y =  -2.288, z =  -31.253 },
    },
    [ 2] =
    {
        { x = 254.253, y =  -1.000, z =   29.583 },
        { x = 259.472, y =  -2.000, z =   24.611 },
        { x = 259.739, y =  -1.528, z =   30.681 },
    },
    [ 3] =
    {
        { x = 287.048, y =  -2.724, z =   49.817 },
        { x = 290.109, y =  -3.000, z =   47.068 },
    },
    [ 4] =
    {
        { x = 302.973, y =  -7.000, z =  -53.250 },
        { x = 303.300, y =  -7.500, z =  -56.050 },
        { x = 304.196, y =  -7.500, z =  -59.205 },
        { x = 306.678, y =  -7.000, z =  -55.765 },
        { x = 308.197, y =  -7.500, z =  -58.652 },
    },
    [ 5] =
    {
        { x = 317.109, y =  -4.491, z =  -22.393 },
        { x = 318.279, y =  -7.347, z =  -16.922 },
    },
    [ 6] =
    {
        { x = 333.867, y = -16.287, z = -148.647 },
        { x = 336.613, y = -16.294, z = -150.729 },
        { x = 339.151, y = -16.018, z = -187.016 },
        { x = 340.843, y = -16.219, z = -152.912 },
        { x = 342.024, y = -16.797, z = -144.020 },
    },
    [ 7] =
    {
        { x = 345.358, y =  -3.305, z =  107.569 },
        { x = 347.173, y =  -2.837, z =  112.185 },
        { x = 351.337, y =  -3.550, z =  107.287 },
    },
    [ 8] =
    {
        { x = 347.386, y = -16.302, z =  -13.217 },
        { x = 349.759, y = -16.028, z =  -10.616 },
    },
    [ 9] =
    {
        { x = 368.781, y = -16.276, z = -132.078 },
        { x = 372.355, y = -16.502, z = -127.022 },
        { x = 378.170, y = -15.000, z = -126.916 },
    },
    [10] =
    {
        { x = 433.062, y =  -7.499, z = -121.791 },
        { x = 436.278, y =  -7.500, z = -122.607 },
        { x = 438.778, y =  -7.500, z = -122.998 },
    },
    [11] =
    {
        { x = 454.148, y =  -7.000, z =  131.891 },
        { x = 455.183, y =  -7.740, z =  124.322 },
        { x = 461.871, y =  -4.575, z =  123.948 },
    },
    [12] =
    {
        { x = 467.187, y =  -7.499, z =  225.479 },
        { x = 468.074, y =  -7.499, z =  229.404 },
        { x = 469.415, y =  -7.499, z =  222.882 },
        { x = 471.071, y =  -7.000, z =  231.699 },
        { x = 475.257, y =  -7.500, z =  226.042 },
    },
    [13] =
    {
        { x = 463.875, y =  -2.305, z =  187.548 },
        { x = 470.484, y =  -2.239, z =  187.388 },
    },
    [14] =
    {
        { x = 506.696, y =  -7.500, z =  101.896 },
        { x = 508.958, y =  -7.500, z =  106.356 },
        { x = 511.790, y =  -7.500, z =  101.802 },
    },
    [15] =
    {
        { x = 529.484, y =  -5.110, z =  254.873 },
        { x = 530.257, y =  -6.640, z =  260.204 },
        { x = 541.296, y =  -7.999, z =  257.660 },
        { x = 541.307, y =  -5.643, z =  253.104 },
    },
    [16] =
    {
        { x = 536.697, y =  -4.337, z =  165.781 },
        { x = 539.176, y =  -4.912, z =  171.565 },
        { x = 544.142, y =  -7.035, z =  164.850 },
        { x = 545.364, y =  -6.736, z =  171.748 },
    },
    [17] =
    {
        { x = 545.765, y = -16.104, z =  131.891 },
    },
    [18] =
    {
        { x = 578.367, y = -15.782, z =   97.985 },
    },
}

function content:onInstanceCreated(instance)
    -- Assign a random Cursed Chest to be the one that holds the Golden Figurehead.
    local goldenChestId = ID.mob.CURSED_CHEST + math.randomInt(0, 11)
    instance:setLocalVar('[Chest]NonMimicId', goldenChestId)

    -- Assign 12 Cursed Chests randomly within 18 defined regions, one chest per region.
    local shuffledRegions = utils.shuffle(chestSpawnPoints)
    for i = 1, 12 do
        local chestId     = ID.mob.CURSED_CHEST + i - 1
        local region      = shuffledRegions[i]
        local position    = region[math.randomInt(1, #region)]
        local cursedChest = GetMobByID(chestId, instance)
        if cursedChest then
            cursedChest:setSpawn(position.x, position.y, position.z, 0)
        end
    end

    InstanceAssault.onInstanceCreated(self, instance)

    -- Keep bridges at _1ji, _1jj and _1jq removed/blocked for Golden Salvage.
    GetNPCByID(ID.npc._1ji, instance):setAnimation(xi.animation.CLOSE_DOOR)
    GetNPCByID(ID.npc._1jj, instance):setAnimation(xi.animation.CLOSE_DOOR)
    GetNPCByID(ID.npc._1jq, instance):setAnimation(xi.animation.CLOSE_DOOR)
end

return content:register()
