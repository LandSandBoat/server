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

-- All 12 chests are shown as identical, clickable NPCs (treasure chest prop model); which of the 12 IDs holds the figurehead is random each run.
-- When a wrong chest springs, its NPC is hidden and the mimic mob (same ID, mimic model from its pool) is spawned in its place
-- It swaps back if it loses interest (see scripts/zones/Ilrusi_Atoll/mobs/Cursed_Chest.lua).

-- Positions confirmed from capture. Grouped by pools, so they are not too close to each other.
local cursedChestSpawnPoints =
{
    [1] =
    {
        { x = 222.981, y =  -2,     z =  -31.139, rot = 0 },
        { x = 228.292, y =  -2,     z =  -25.363, rot = 0 },
    },
    [2] =
    {
        { x = 254.253, y =  -1,     z =   29.583, rot = 0 },
        { x = 259.472, y =  -2,     z =   24.611, rot = 0 },
    },
    [3] =
    {
        { x = 290.109, y =  -3,     z =   47.068, rot = 0 },
    },
    [4] =
    {
        { x = 302.973, y =  -7,     z =  -53.250, rot = 0 },
        { x = 306.678, y =  -7,     z =  -55.765, rot = 0 },
    },
    [5] =
    {
        { x = 318.279, y =  -7,     z =  -16.922, rot = 0 },
    },
    [6] =
    {
        { x = 333.867, y = -16,     z = -148.647, rot = 0 },
        { x = 339.151, y = -16.018, z = -187.016, rot = 0 },
    },
    [7] =
    {
        { x = 345.358, y =  -3,     z =  107.569, rot = 0 },
    },
    [8] =
    {
        { x = 349.759, y = -16.028, z =  -10.616, rot = 0 },
    },
    [9] =
    {
        { x = 368.781, y = -16,     z = -132.078, rot = 0 },
        { x = 372.355, y = -16,     z = -127.022, rot = 0 },
        { x = 378.170, y = -15,     z = -126.916, rot = 0 },
    },
    [10] =
    {
        { x = 433.062, y =  -7,     z = -121.791, rot = 0 },
        { x = 436.278, y =  -7,     z = -122.607, rot = 0 },
    },
    [11] =
    {
        { x = 454.148, y =  -7,     z =  131.891, rot = 0 },
        { x = 455.183, y =  -7,     z =  124.322, rot = 0 },
    },
    [12] =
    {
        { x = 467.187, y =  -7,     z =  225.479, rot = 0 },
        { x = 471.071, y =  -7,     z =  231.699, rot = 0 },
    },
    [13] =
    {
        { x = 508.957, y =  -7,     z =  106.356, rot = 0 },
    },
    [14] =
    {
        { x = 530.257, y =  -6,     z =  260.204, rot = 0 },
        { x = 541.307, y =  -5,     z =  253.104, rot = 0 },
    },
    [15] =
    {
        { x = 545.765, y = -16,     z =  131.890, rot = 0 },
    },
    [16] =
    {
        { x = 578.367, y = -15,     z =   97.985, rot = 0 },
    },
}

local percipientFishSpawnPoints =
{
    -- Confirmed from capture
    { x = 224.228, y = -2,     z = -28.874, rot = 0 },
    { x = 256.659, y = -2,     z =  20.155, rot = 0 },
    { x = 294.499, y = -3,     z =  52.677, rot = 0 },
    { x = 310.627, y = -7,     z =  11.708, rot = 0 },
    { x = 314.816, y = -7,     z = -13.621, rot = 0 },
    { x = 338.232, y = -4,     z =  98.385, rot = 0 },
    { x = 344.061, y = -5,     z =  98.852, rot = 0 },
    { x = 344.571, y = -4,     z = 105.403, rot = 0 },
    { x = 406.046, y = -7,     z = 136.254, rot = 0 },
    { x = 425.228, y = -4,     z = 150.541, rot = 0 },
    { x = 466.457, y = -3,     z = 136.727, rot = 0 },
    { x = 467.151, y = -3,     z = 139.373, rot = 0 },
    { x = 501.241, y = -6.502, z = 205.9,   rot = 0 },
    { x = 505.912, y = -7,     z = 208.139, rot = 0 },
    { x = 518.554, y = -6,     z = 220.020, rot = 0 },
    { x = 533.173, y = -3,     z = 252.998, rot = 0 },
}

-- Mimic! Swap the chest NPC for the mimic mob and set it upon the player.
local function revealMimic(instance, chestId, player)
    local npcChest = GetNPCByID(chestId, instance)
    local mobChest = GetMobByID(chestId, instance)
    if not npcChest or not mobChest or mobChest:isSpawned() then
        return
    end

    npcChest:setStatus(xi.status.DISAPPEAR)
    mobChest:setSpawn(npcChest:getXPos(), npcChest:getYPos(), npcChest:getZPos(), npcChest:getRotPos())
    SpawnMob(chestId, instance)
    mobChest:updateClaim(player)
    mobChest:updateEnmity(player)
end

function content:onInstanceCreated(instance)
    InstanceAssault.onInstanceCreated(self, instance)

    -- Keep bridges at _1ji, _1jj and _1jq removed/blocked for Golden Salvage.
    GetNPCByID(ID.npc._1ji, instance):setAnimation(xi.animation.CLOSE_DOOR)
    GetNPCByID(ID.npc._1jj, instance):setAnimation(xi.animation.CLOSE_DOOR)
    GetNPCByID(ID.npc._1jq, instance):setAnimation(xi.animation.CLOSE_DOOR)

    -- Pick which chest is the non-mimic chest.
    local goldenChestId = math.randomInt(ID.mob.CURSED_CHEST_OFFSET, ID.mob.CURSED_CHEST_OFFSET + 11)
    instance:setLocalVar('[Chest]NonMimicId', goldenChestId)

    -- Pick 12 random points from the chest positions table.
    local shuffledChestPosTable = utils.shuffle(cursedChestSpawnPoints)
    for i = 1, 12 do
        local chestId  = ID.mob.CURSED_CHEST_OFFSET + i - 1
        local entry    = shuffledChestPosTable[i]
        local pos      = entry[math.randomInt(1, #entry)]
        local npcChest = GetNPCByID(chestId, instance)
        if npcChest then
            npcChest:setPos(pos.x, pos.y, pos.z, pos.rot)
            npcChest:setStatus(xi.status.NORMAL)
        end
    end

    -- Pick 7 random points from the fish positions table.
    local shuffledFishPosTable = utils.shuffle(percipientFishSpawnPoints)
    for i = 1, 7 do
        local fishId  = ID.mob.PERCIPIENT_FISH_OFFSET + i - 1
        local pos     = shuffledFishPosTable[i]
        local fishMob = GetMobByID(fishId, instance)
        if fishMob then
            fishMob:setSpawn(pos.x, pos.y, pos.z, pos.rot)
            fishMob:setPos(pos.x, pos.y, pos.z, pos.rot)
        end
    end
end

-- A chest NPC was clicked (routed from npcs/Cursed_Chest.lua). The golden
-- chest opens; any other chest is a mimic in disguise.
function content.onChestTrigger(player, npc)
    local instance = npc:getInstance()
    if
        not instance or
        instance:completed() or
        instance:failed() or
        npc:getStatus() ~= xi.status.NORMAL or
        npc:getLocalVar('[Chest]Triggered') == 1
    then
        return
    end

    if player:checkDistance(npc) > 2 then
        player:messageSpecial(ID.text.MUST_BE_CLOSER_TO_OPEN_CHEST)
        return
    end

    if npc:getID() ~= instance:getLocalVar('[Chest]NonMimicId') then
        revealMimic(instance, npc:getID(), player)
        return
    end

    npc:setLocalVar('[Chest]Triggered', 1)
    npc:entityAnimationPacket(xi.animationString.OPEN_CRATE_GLOW)

    -- Retail-like pacing for the golden chest sequence.
    player:messageSpecial(ID.text.CHEST)

    player:timer(3000, function(playerEntity)
        local timerInstance = playerEntity:getInstance()
        if timerInstance then
            playerEntity:messageSpecial(ID.text.GOLDEN)
        end
    end)

    player:timer(20000, function(playerEntity)
        local timerInstance = playerEntity:getInstance()
        if timerInstance and timerInstance:getProgress() < 1 then
            local goldenNpc = GetNPCByID(timerInstance:getLocalVar('[Chest]NonMimicId'), timerInstance)
            if goldenNpc then
                goldenNpc:setStatus(xi.status.DISAPPEAR)
            end

            timerInstance:setProgress(1)
        end
    end)
end

function content:onInstanceTimeUpdate(instance, elapsed)
    InstanceAssault.onInstanceTimeUpdate(self, instance, elapsed)

    if instance:completed() or instance:failed() then
        return
    end

    local goldenChestId = instance:getLocalVar('[Chest]NonMimicId')
    local chars         = instance:getChars()

    -- Getting within 2 yalms of a wrong chest springs the mimic.
    -- The golden chest never transforms; it must be clicked (see onChestTrigger).
    for chestId = ID.mob.CURSED_CHEST_OFFSET, ID.mob.CURSED_CHEST_OFFSET + 11 do
        if chestId ~= goldenChestId then
            local npcChest = GetNPCByID(chestId, instance)
            if npcChest and npcChest:getStatus() == xi.status.NORMAL then
                for _, player in pairs(chars) do
                    if
                        not player:isDead() and
                        utils.distanceWithin(player:getPos(), npcChest:getPos(), 2, true)
                    then
                        revealMimic(instance, chestId, player)
                        break
                    end
                end
            end
        end
    end
end

content.mobs =
{
    { baseID = ID.mob.PERCIPIENT_FISH_OFFSET, offset = 7 },
}

content.loot =
{
    appraisalReward =
    {
        {
            { itemId = xi.item.UNAPPRAISED_EARRING, weight = 7000 },
            { itemId = xi.item.UNAPPRAISED_BOX,     weight = 3000 },
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
