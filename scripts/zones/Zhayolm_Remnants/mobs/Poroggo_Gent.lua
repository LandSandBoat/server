-----------------------------------
-- Area: Zhayolm Remnants
-- MOB: Poroggo Gent
-- Notes: 1st floor 100% drops a chest
-----------------------------------
local ID = zones[xi.zone.ZHAYOLM_REMNANTS]
-----------------------------------

local playerHealth = function(instance)
    local chars = instance:getChars()

    if instance:getLocalVar('allySize') ~= #chars then
        return false
    end

    for _, players in pairs(chars) do
        if players:getHP() == 0 then
            return false
        end
    end

    return true
end

---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DETECTION, xi.detects.SIGHT)
    mob:addListener('TREASUREPOOL', 'GENT_ADDED_DROPS', function(mobArg, target, itemid)
        -- 4f S gents will always drop 3 of each cell, if it drops
        local mobID = mob:getID()
        if utils.contains(mobID, utils.slice(ID.mob.POROGGO_GENT, 5, 12)) then -- this covers all S gents
            target:addTreasure(itemid, mobArg)
            target:addTreasure(itemid, mobArg)
        end
    end)
end

entity.onMobSpawn = function(mob)
    local instance = mob:getInstance()
    if instance and instance:getStage() == 1 then
        mob:setSpellList(0)
        mob:setMP(0)
        mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
        mob:setDelay(250)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()
        if instance and instance:getStage() == 1 and instance:getProgress() == 1 then
            instance:setProgress(2)
            xi.salvage.spawnTempChest(mob,
            {
                rate = 1000,
                itemID_1 = xi.item.BOTTLE_OF_FIGHTERS_DRINK,
                itemAmount_1 = 10
            })
            if instance:getLocalVar('cellsUsed') == 0 and playerHealth(instance) then
                SpawnMob(ID.mob.POROGGO_MADAME[1], instance)
            end
        end
    end
end

return entity
