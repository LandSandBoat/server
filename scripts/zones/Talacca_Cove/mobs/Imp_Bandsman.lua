-----------------------------------
-- Area: Talacca Cove
--   NM: Imp Bandsman
-----------------------------------
local ID = zones[xi.zone.TALACCA_COVE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.POISON)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 25)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.ATTP, 50)
    mob:setMod(xi.mod.STORETP, 110)
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    -- Skill used is not Bugle Call, return
    if skill:getID() ~= xi.mobSkill.BUGLE_CALL then
        return
    end

    local impId         = mob:getID()
    local currentTarget = mob:getTarget()
    local impAdd

    -- Set a timer for 3 seconds to summon an imp at the end of the Bugle Call animation
    mob:timer(3000, function(mobArg)
        local availableHelpers = {}

        -- Iterate through the list of Imp clones to find available helpers
        for cloneID = impId + 1, impId + 4 do
            local clone = GetMobByID(cloneID)
            if clone and not clone:isSpawned() then
                table.insert(availableHelpers, clone)
            end
        end

        -- All available helpers are already spawned, return
        if #availableHelpers == 0 then
            return
        end

        impAdd = utils.randomEntry(availableHelpers)
        SpawnMob(impAdd:getID())

        if currentTarget then
            impAdd:updateEnmity(currentTarget)
        end
    end)

    -- Set a timer for 4 seconds to check if the imp has arrived and display the appropriate message
    mob:timer(4000, function(mobArg)
        mobArg:addTP(1000)

        if impAdd then
            mobArg:messageText(impAdd, ID.text.HELP_HAS_ARRIVED, false)
            return
        end

        mobArg:messageText(mobArg, ID.text.NOBODY_COMES_TO_HELP, false)
    end)
end

return entity
