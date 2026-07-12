-----------------------------------
-- Area: Ilrusi Atoll
--  Mob: Cursed Chest
-----------------------------------
local ID = zones[xi.zone.ILRUSI_ATOLL]
-----------------------------------
---@type TMobEntity
local entity = {}

-- Generally mobs that change model in front of the player do not update - this entity update forces the client to refresh the model for the player.
local function sendFullEntityUpdate(instance, mob)
    for _, member in pairs(instance:getChars()) do
        member:sendEntityUpdateToPlayer(mob, xi.entityUpdate.ENTITY_UPDATE, xi.updateType.UPDATE_ALL_MOB)
    end
end

-- All Cursed Chests are mobs under the hood, this dresses them up as chests to the player. The chest holding the Golden Figurehead (picked at instance creation) is flagged non-aggressive via its battle id.
local function disguiseChest(mob)
    mob:setModelId(960)
    mob:setMobFlags(4227)
    mob:setStatus(xi.status.NORMAL)
    mob:hideHP(true)
    mob:setMobMod(xi.mobMod.SPAWN_ANIMATIONSUB, 4)
    mob:setAnimationSub(4, false)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setLocalVar('[Chest]Revealed', 0)
    mob:setLocalVar('[Timer]NoTarget', 0)
    mob:setBattleID(0)
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.SIGHT, xi.detects.HEARING))
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 2)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 2)

    local instance = mob:getInstance()
    if instance and mob:getID() == instance:getLocalVar('[Chest]NonMimicId') then
        mob:setBattleID(1)
    end
end

-- Swaps the chest model and reveals a Mimic instead.
local function revealMimic(mob, target)
    local instance = mob:getInstance()
    if
        not instance or
        not mob:isSpawned() or
        mob:getLocalVar('[Chest]Revealed') == 1
    then
        return
    end

    mob:setLocalVar('[Chest]Revealed', 1)
    mob:setStatus(xi.status.UPDATE)
    mob:setModelId(258)
    mob:setMobFlags(131)
    mob:hideHP(false)
    mob:setAnimationSub(5, false)

    -- Chests in Golden Salvage spawn with a random rotation, this ensures they spawn looking at the player when revealed, just like retail.
    if target then
        mob:lookAt(target:getPos())
    end

    sendFullEntityUpdate(instance, mob)
end

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.HPP, -30) -- Retail captured, keeps the HP correct at all level caps.
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
    disguiseChest(mob)

    mob:setMod(xi.mod.SLASH_SDT, -5000)
    mob:setMod(xi.mod.PIERCE_SDT, -5000)
    mob:setMod(xi.mod.IMPACT_SDT, -5000)
    mob:setMod(xi.mod.HTH_SDT, -5000)

    mob:setMod(xi.mod.STORETP, 20)
end

entity.onTrigger = function(player, mob)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    -- A won battlefield keeps working
    if instance:failed() then
        return
    end

    -- Chest is already opened, return.
    if mob:getLocalVar('[Chest]Triggered') == 1 then
        return
    end

    -- Not within 2 yalms to trigger the chest, return.
    if player:checkDistance(mob) > 2 then
        player:messageSpecial(ID.text.MUST_BE_CLOSER_TO_OPEN_CHEST)
        return
    end

    -- Chest is a mimic, reveal it and return. Clicking it claims it to the player.
    if mob:getID() ~= instance:getLocalVar('[Chest]NonMimicId') then
        revealMimic(mob, player)
        mob:updateClaim(player)
        mob:updateEnmity(player)
        return
    end

    -- Chest holds the golden figurehead. Progress set to 1 marks the instance as won.
    local goldenChestId = mob:getID()

    mob:setLocalVar('[Chest]Triggered', 1)
    mob:entityAnimationPacket(xi.animationString.OPEN_CRATE_GLOW)
    player:messageSpecial(ID.text.CHEST)

    -- Chest stays open for a while before despawning.
    player:timer(3000, function(playerEntity)
        local instanceVictory = playerEntity:getInstance()
        if instanceVictory then
            playerEntity:messageSpecial(ID.text.GOLDEN)
        end
    end)

    -- Despawn the chest and mark the instance as won.
    player:timer(20000, function(playerEntity)
        local instanceVictory = playerEntity:getInstance()
        if instanceVictory and instanceVictory:getProgress() < 1 then
            DespawnMob(goldenChestId, instanceVictory)
            instanceVictory:setProgress(1)
        end
    end)
end

-- Chests have a aggro radius of 2 yalms.
entity.onMobEngage = function(mob, target)
    revealMimic(mob, target)
end

entity.onMobFight = function(mob, target)
    local distanceToTarget = mob:checkDistance(target)
    if distanceToTarget <= 3 then
        return
    end

    -- Handle draw-in.
    if distanceToTarget < 30 then
        mob:setLocalVar('[Timer]NoTarget', 0)
        target:setPos(mob:getXPos(), mob:getYPos(), mob:getZPos())
        target:messageBasic(xi.msg.basic.DRAWN_IN)
        return
    end

    -- Main target is out of range. Check additional targets.
    for _, hateEntry in pairs(mob:getEnmityList()) do
        if
            hateEntry and
            not hateEntry:isDead() and
            mob:checkDistance(hateEntry) < 30
        then
            mob:setLocalVar('[Timer]NoTarget', 0)
            return
        end
    end

    local currentTime   = GetSystemTime()
    local noTargetTimer = mob:getLocalVar('[Timer]NoTarget')
    if noTargetTimer == 0 then
        mob:setLocalVar('[Timer]NoTarget', currentTime)
        return
    end

    if currentTime - noTargetTimer >= 5 then
        mob:disengage()
    end
end

-- If a mimic disengages, change it back to a chest.
entity.onMobDisengage = function(mob)
    local instance = mob:getInstance()
    if
        not instance or
        not mob:isAlive() or
        mob:getLocalVar('[Chest]Revealed') == 0
    then
        return
    end

    disguiseChest(mob)
    sendFullEntityUpdate(instance, mob)
end

return entity
