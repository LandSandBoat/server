-----------------------------------
-- Nyzul Isle: Floor progression logic.
-----------------------------------
local ID = zones[xi.zone.NYZUL_ISLE]
-----------------------------------
xi = xi or {}
xi.nyzul = xi.nyzul or {}
-----------------------------------

xi.nyzul.getRelativeFloor = function(instance)
    local currentFloor  = instance:getLocalVar('[Nyzul]CurrentFloor')
    local startingFloor = instance:getLocalVar('Nyzul_Isle_StartingFloor')

    if currentFloor < startingFloor then
        return currentFloor + 100
    end

    return currentFloor
end

xi.nyzul.handleProgress = function(instance, progress)
    local stage      = instance:getStage()
    local isComplete = false

    if
        ((stage == xi.nyzul.objective.FREE_FLOOR or
        stage == xi.nyzul.objective.ELIMINATE_ENEMY_LEADER or
        stage == xi.nyzul.objective.ACTIVATE_ALL_LAMPS or
        stage == xi.nyzul.objective.ELIMINATE_SPECIFIED_ENEMY) and
        progress == 15)
        or
        ((stage == xi.nyzul.objective.ELIMINATE_ALL_ENEMIES or stage == xi.nyzul.objective.ELIMINATE_SPECIFIED_ENEMIES) and
        progress >= instance:getLocalVar('Eliminate'))
    then
        local chars        = instance:getChars()
        local currentFloor = instance:getLocalVar('[Nyzul]CurrentFloor')

        instance:setProgress(0)
        instance:setLocalVar('Eliminate', 0)
        instance:setLocalVar('potential_tokens', xi.nyzul.calculateTokens(instance))

        for _, players in ipairs(chars) do
            players:messageSpecial(ID.text.OBJECTIVE_COMPLETE, currentFloor)
        end

        isComplete = true
    end

    return isComplete
end

xi.nyzul.activateRuneOfTransfer = function(instance)
    for _, runeID in pairs(ID.npc.RUNE_OF_TRANSFER) do
        if GetNPCByID(runeID, instance):getStatus() == xi.status.NORMAL then
            GetNPCByID(runeID, instance):setAnimationSub(1)

            break
        end
    end
end

-----------------------------------
-- Mob progression functions.
-----------------------------------

xi.nyzul.enemyLeaderKill = function(mob)
    local instance = mob:getInstance()
    instance:setProgress(15)
end

xi.nyzul.specifiedGroupKill = function(mob)
    local instance = mob:getInstance()

    if instance:getStage() == xi.nyzul.objective.ELIMINATE_SPECIFIED_ENEMIES then
        instance:setProgress(instance:getProgress() + 1)
    end
end

xi.nyzul.specifiedEnemySet = function(mob)
    local instance = mob:getInstance()

    if instance:getStage() == xi.nyzul.objective.ELIMINATE_SPECIFIED_ENEMY then
        if instance:getLocalVar('Nyzul_Specified_Enemy') == mob:getID() then
            mob:setMobMod(xi.mobMod.CHECK_AS_NM, 1)
        end
    end
end

xi.nyzul.specifiedEnemyKill = function(mob)
    local instance = mob:getInstance()
    local stage    = instance:getStage()

    -- Eliminate specified enemy
    if stage == xi.nyzul.objective.ELIMINATE_SPECIFIED_ENEMY then
        if instance:getLocalVar('Nyzul_Specified_Enemy') == mob:getID() then
            instance:setProgress(15)
            instance:setLocalVar('Nyzul_Specified_Enemy', 0)
        end

    -- Eliminiate all enemies
    elseif stage == xi.nyzul.objective.ELIMINATE_ALL_ENEMIES then
        instance:setProgress(instance:getProgress() + 1)
    end
end

xi.nyzul.eliminateAllKill = function(mob)
    local instance = mob:getInstance()

    if instance:getStage() == xi.nyzul.objective.ELIMINATE_ALL_ENEMIES then
        instance:setProgress(instance:getProgress() + 1)
    end
end
