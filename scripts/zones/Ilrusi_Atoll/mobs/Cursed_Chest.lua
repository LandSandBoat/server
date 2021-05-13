-----------------------------------
-- Area: Ilrusi Atoll
--  Mob: Cursed Chest
-----------------------------------
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
require("scripts/globals/status")
require("scripts/globals/assault")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    local instance = mob:getInstance()
    local figureheadChest = instance:getProgress()

    if mob:getID() ~= figureheadChest then
        mob:setMobMod(xi.mobMod.SOUND_RANGE, 2)
    else
        mob:setMobMod(xi.mobMod.SOUND_RANGE, 0)
        mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
    end
    mob:setLocalVar("despawn", 0)
    mob:setStatus(xi.status.NORMAL)
    mob:hideName(false)
end

entity.onTrigger = function(player, mob)
    if player:checkDistance(mob) >= 2 then
        player:messageSpecial(ID.text.CHEST_GET_CLOSER)
        return
    end

    if mob:getLocalVar("Complete") == 0 then
        player:messageSpecial(ID.text.CHEST)
        local mobID = mob:getID()
        local instance = mob:getInstance()
        local figureheadChest = instance:getProgress()

        if mobID == figureheadChest then
            mob:setLocalVar("Complete", 1)
            mob:entityAnimationPacket("open")
            player:messageSpecial(ID.text.GOLDEN)
            instance:setProgress(1)
            mob:timer(1000, function(mob) mob:entityAnimationPacket("open") end)
            mob:timer(15000, function(mob) mob:entityAnimationPacket("kesu") end)
            mob:timer(16000, function(mob) mob:setStatus(xi.status.DISAPPEAR) end)
        else
            mob:setStatus(1)
            mob:updateClaim(player)
        end
    end
end

entity.onMobEngaged = function(mob, target)
    mob:setStatus(1)
    mob:hideName(false)
    mob:setModelId(258)
    mob:setAnimationSub(0)
end

entity.onMobFight = function(mob, target)
    if mob:getAnimationSub() ~= 1 then
        mob:setAnimationSub(1)
    end

    if mob:checkDistance(target) < 21.6 then
        mob:setMobMod(xi.mobMod.DRAW_IN, 3)
        mob:setLocalVar("despawn", 0)
    else
        mob:setMobMod(xi.mobMod.DRAW_IN, 0)
        if mob:getLocalVar("despawn") == 0 then
            mob:setLocalVar("despawn", os.time() + 30)
        end
    end

    if mob:getLocalVar("despawn") ~= 0 then
        if mob:getLocalVar("despawn") < os.time() then
            mob:setStatus(xi.status.NORMAL)
            mob:disengage()
            mob:setAnimationSub(0)
            mob:setHP(mob:getMaxHP())
            mob:setModelId(960)
            mob:hideName(true)
        end
    end
end

entity.onMobDespawn = function(mob)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
