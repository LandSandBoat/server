-----------------------------------
-- Area: Ilrusi Atoll
--  Mob: Cursed Chest
-----------------------------------
---@type TMobEntity
local entity = {}

local function hideMimic(mob)
    local instance = mob:getInstance()
    local chestId  = mob:getID()

    DespawnMob(chestId, instance)

    local npcChest = GetNPCByID(chestId, instance)
    if npcChest then
        npcChest:setStatus(xi.status.NORMAL)
    end
end

entity.onMobSpawn = function(mob)
    -- Mimics only exist while revealed; the disguised chest is the NPC with
    -- the same ID (see scripts/assaults/Ilrusi_Atoll/golden_salvage.lua).
    mob:setLocalVar('[Timer]NoTarget', 0)
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
        hideMimic(mob)
    end
end

entity.onMobDisengage = function(mob)
    -- A slain mimic stays gone; only a live one re-disguises as a chest.
    if mob:isAlive() then
        hideMimic(mob)
    end
end

return entity
