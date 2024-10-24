-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Wanzo-Unzozo
-- Type: Quest mob (Escort for Hire - Windurst)
-----------------------------------
local ID = zones[xi.zone.GARLAIGE_CITADEL]
-----------------------------------

local paths =
{
    a =
    {
        { -380.8830, -12.0000, 391.8802 },
        { -378.7068, -6.12510, 368.4137 },
        { -379.2549, -6.00000, 346.8558 },
        { -357.3971, -6.00000, 338.0250 },
        { -341.3876, -3.25000, 339.8453 },
        { -340.9149, 0.000000, 297.0475 },
        { -336.8979, 0.000000, 288.6178 },
        { -342.1649, 0.000000, 270.2281 },
        { -354.1182, 0.000000, 268.7367 },
        { -354.2867, 0.000000, 249.9196 },
        { -340.2825, 0.000000, 249.7256 },
        { -337.6853, 0.000000, 221.3183 },
        { -314.6676, 0.000000, 218.6108 },
        { -300.1329, 0.000000, 226.1669 },
        { -275.1773, 0.000000, 217.3463 },
        { -271.0707, 0.000000, 219.7949 }, -- Middle of holes
        { -237.1567, 0.000000, 218.0966 },
        { -180.1768, 0.000000, 221.7442 },
        { -178.3567, 0.000000, 259.3759 },
        { -143.2720, 0.000000, 262.7013 },
        { -138.2194, 0.000000, 230.2753 },
        { -125.7615, 0.000000, 229.9893 },
        { -126.1223, 0.000000, 217.9252 },
        { -133.0517, 0.000000, 204.5436 }, -- Dead End
        { -126.1223, 0.000000, 217.9252 },
        { -125.7615, 0.000000, 229.9893 },
        { -138.2194, 0.000000, 230.2753 },
        { -138.9951, 0.000000, 254.4034 },
        { -106.9740, 0.000000, 262.5682 },
        { -100.8588, 0.000000, 256.1013 },
        { -97.54940, 0.000000, 222.0876 },
        { -65.87720, 0.000000, 217.7562 },
        { -57.52250, 0.000000, 192.7869 },
        { -60.73950, 5.927000, 153.6628 }, -- Basement
        { -54.09130, 7.176200, 143.8619 },
        { -42.03350, 6.000000, 144.9311 },
        { -30.21860, 7.443100, 137.7087 },
        { -17.81050, 6.567400, 147.5737 },
        { -16.16890, 8.139700, 138.4585 },
        { -20.54190, 6.000000, 118.7473 },
        { -19.41390, 2.750000, 101.3711 },
        { -101.4705, 0.000000, 100.9095 },
        { -167.2571, 0.000000, 98.46240 },
        { -177.5856, 0.000000, 94.07690 },
        { -210.6050, 0.000000, 102.8821 },
        { -220.0769, 0.000000, 110.8499 },
        { -216.9912, 0.000000, 128.0300 },
        { -219.6814, 0.000000, 139.8317 }, -- Destination

    },
    b =
    {
        { 0, 0, 0 },
    },
    c =
    {
        { 0, 0, 0 },
    }
}

local path = paths.a -- Only one path works atm

local escortProgress =
{
    NONE     = 0, -- Have not started pathing at all yet
    ENROUTE  = 1, -- Started pathing and is continuing along path
    PAUSED   = 2, -- Has paused pathing and awaiting orders
    COMPLETE = 3, -- Has reached the end of the escort mission
}

local party = {}

local entity = {}

entity.shouldMove = function(mob, progress)
    return not mob:isFollowingPath() and mob:getStatus() == xi.status.NORMAL and progress ~= escortProgress.COMPLETE
end

entity.onMobInitialize = function(mob)
    mob:setLocalVar('progress', escortProgress.NONE)
    mob:setSpeed(60)

    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.NO_DESPAWN, 1)
    mob:setAutoAttackEnabled(true)
end

entity.onMobRoam = function(mob)
    mob:setStatus(xi.status.NORMAL)
    local progress = mob:getLocalVar('progress')
    local escortID = '[Escort]Wanzo'
    local checkEscort = GetServerVariable(escortID)
    local player = GetPlayerByID(mob:getLocalVar('player'))

    local now = os.time()
    local expire = mob:getLocalVar('expire')
    if expire ~= 0 and expire <= now then
        if progress ~= escortProgress.COMPLETE then
            mob:showText(mob, ID.text.RAN_OUT_OF_TIME)
        end

        mob:setLocalVar('progress', escortProgress.NONE)
        DespawnMob(mob:getID())
        SetServerVariable(escortID, 0)
        for _, v in ipairs(player:getParty()) do
            utils.setQuestVar(v, 2, 88, 'Prog', 0)
        end

        return
    else
        local i = 0
        if next(party) ~= nil then
            for _, v in ipairs(party) do
                if v:getZoneID() == xi.zone.GARLAIGE_CITADEL then
                    i = i + 1
                end
            end

            if i == 0 then -- Players in party on quest no longer in zone reset the escort
                DespawnMob(checkEscort)
                SetServerVariable(escortID, 0)
                for _, v in ipairs(party) do
                    utils.setQuestVar(v, 2, 88, 'Prog', 0)
                end
            end
        end
    end
end

entity.onPath = function(mob)
    local progress = mob:getLocalVar('progress')
    local escort = mob:getLocalVar('escort')
    local player = GetPlayerByID(mob:getLocalVar('player'))

    if escort ~= nil and entity.shouldMove(mob, progress) then
        local point = mob:getLocalVar('point')
        if point == #path then
            mob:setLocalVar('progress', escortProgress.COMPLETE)
            for _, v in ipairs(player:getParty()) do
                local prog = utils.getQuestVar(v, 2, 88, 'Prog')
                if prog == 2 then
                    utils.setQuestVar(v, 2, 88, 'Prog', 3) -- Completes the quest
                elseif prog == 1 then
                    utils.setQuestVar(v, 2, 88, 'Prog', 0) -- Resets the quest for players not in zone when escort started
                end
            end
        elseif progress ~= escortProgress.COMPLETE then
            point = point + 1
            mob:setLocalVar('point', point)
            mob:pathThrough(path[point], xi.path.flag.WALK)
        end
    end
end

entity.onTrigger = function(player, mob)
    local progress = mob:getLocalVar('progress')
    local point = mob:getLocalVar('point')
    local escort = mob:getLocalVar('escort')
    local questVar = utils.getQuestVar(player, 2, 88, 'Prog')

    if escort ~= nil then
        if progress == escortProgress.ENROUTE then
            mob:pathThrough(mob:getPos(), xi.path.flag.NONE)
            mob:showText(mob, ID.text.WHATS_WRONG)
            mob:setLocalVar('progress', escortProgress.PAUSED)
        elseif progress == escortProgress.PAUSED then
            mob:showText(mob, ID.text.CMON_LETS_SKEDADDLE)
            mob:setLocalVar('progress', escortProgress.ENROUTE)
            mob:pathThrough(path[point], xi.path.flag.WALK)
        elseif progress == escortProgress.NONE then
            if GetPlayerByID(mob:getLocalVar('player')) == player then -- Only the player that got the CS can start
                mob:showText(mob, ID.text.LETS_GO)
                mob:setLocalVar('progress', escortProgress.ENROUTE)
                mob:setLocalVar('point', 1)
                mob:pathThrough(path[1], xi.path.flag.WALK)
                utils.setQuestVar(player, 2, 88, 'Prog', 2) -- Have to progress the player outside of the loop for some reason
                for _, v in ipairs(player:getParty()) do
                    if v:getZone() == mob:getZone() then
                        utils.setQuestVar(v, 2, 88, 'Prog', 2) -- Only players in zone when escort starts can progress
                        table.insert(party, v)
                    else
                        utils.setQuestVar(v, 2, 88, 'Prog', 0) -- Sets progress back to 0 to cover any wierdness
                    end
                end
            end
        elseif progress == escortProgress.COMPLETE then
            if questVar == 3 then
                mob:showText(mob, ID.text.I_THANK_YOU)
                npcUtil.giveKeyItem(player, xi.ki.COMPLETION_CERTIFICATE)
                utils.setQuestVar(player, 2, 88, 'Prog', 4)
                mob:isAggroable(false)
            end

            for _, v in ipairs(player:getParty()) do
                if utils.getQuestVar(v, 2, 88, 'Prog') == 4 then
                    mob:isAggroable(false)
                    mob:timer(60000, function(mobArg)
                        mob:showText(mob, ID.text.BYE_BYE)
                        mob:setStatus(xi.status.INVISIBLE)
                        DespawnMob(mob:getID())
                    end)
                end
            end
        end
    end
end

entity.onMobEngaged = function(mob, target)
end

entity.onMobDisengage = function(mob)
    if mob:getLocalVar('progress') == escortProgress.ENROUTE then
        local point = mob:getLocalVar('point')
        mob:pathThrough(path[point], xi.path.flag.WALK)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    mob:setStatus(xi.status.INVISIBLE)
end

entity.onMobDespawn = function(mob)
    local escortID = '[Escort]Wanzo'

    SetServerVariable(escortID, 0)
end

return entity
