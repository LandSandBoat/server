-----------------------------------
-- Area: The Eldieme Necropolis
--  Mob: Cannau
-- Type: Quest mob (Escort for Hire - San d'Oria)
-----------------------------------
local ID = zones[xi.zone.THE_ELDIEME_NECROPOLIS]
-----------------------------------

local paths =
{
    a =
    {
        { 420.1353, -55.7500, -113.0108 },
        { 420.5172, -50.5000, -92.3980 },
        { 420.7853, -48.0000, -80.9449 },
        { 420.1439, -48.0000, -62.6844 },
        { 420.1455, -48.0000, -37.4090 },
        { 420.4471, -40.0000, -2.1618 },
        { 420.0862, -40.0000, 6.2132 },
        { 416.8051, -40.0000, 13.1823 },
        { 410.8650, -40.0000, 18.3037 },
        { 403.3914, -40.0000, 20.0852 },
        { 387.4955, -40.0000, 19.7460 },
        { 384.1628, -40.0000, 20.4002 },
        { 381.1465, -40.0000, 22.7548 },
        { 380.0881, -40.0000, 33.9712 },
        { 380.0894, -40.0000, 41.8352 },
        { 380.0899, -36.2500, 56.6229 },
        { 377.9265, -36.0000, 59.3818 },
        { 370.7227, -34.4173, 60.5267 },
        { 363.9377, -32.7500, 60.8102 },
        { 351.5795, -32.0000, 61.0793 },
        { 345.0939, -32.0000, 65.0727 },
        { 340.8333, -32.0000, 70.7862 },
        { 339.5077, -32.0000, 77.7366 },
        { 338.3835, -32.0000, 90.3990 },
        { 334.4100, -32.0000, 96.8683 },
        { 329.3667, -32.0000, 99.4929 },
        { 319.0573, -32.0000, 100.5203 },
        { 310.6649, -32.0000, 98.3382 },
        { 304.4429, -32.0000, 93.7408 },
        { 300.8259, -32.0000, 87.8495 },
        { 300.1134, -32.0000, 69.2996 },
        { 299.8133, -32.0000, 59.2362 },
        { 299.3235, -32.0000, 44.0240 },
        { 299.1374, -28.0000, 39.3237 },
        { 296.1167, -28.0000, 39.0188 },
        { 287.8274, -28.0000, 38.3179 },
        { 283.5451, -28.0000, 38.0371 },
        { 282.3895, -28.0000, 35.6486 },
        { 281.7157, -28.0000, 28.6572 },
        { 281.0091, -28.0000, 22.9207 },
        { 278.3416, -30.0000, 20.5345 },
        { 275.1552, -32.0000, 20.1921 },
        { 265.3758, -32.0000, 20.6615 },
        { 258.9025, -32.0000, 20.9432 },
        { 254.5690, -32.0000, 23.6204 },
        { 253.1734, -32.0000, 23.6478 },
        { 250.8558, -32.0000, 22.5088 },
        { 247.6052, -32.0000, 20.6995 },
        { 235.2229, -34.0000, 20.0637 },
        { 239.8884, -32.4173, 20.2776 },
        { 247.2930, -32.0000, 19.7050 },
        { 249.6811, -32.0000, 18.4333 },
        { 252.6929, -32.0000, 16.8074 },
        { 255.1403, -32.0000, 17.2349 },
        { 258.4610, -32.0000, 18.5378 },
        { 263.5227, -32.0000, 19.9259 },
        { 274.0029, -32.0000, 20.0030 },
        { 280.0026, -28.2500, 19.9286 },
        { 281.8575, -28.0000, 21.1404 },
        { 281.9194, -28.0000, 34.7331 },
        { 283.6332, -27.7500, 37.1919 },
        { 288.1396, -28.0000, 38.3820 },
        { 296.8263, -28.0000, 38.7196 },
        { 300.2317, -29.6683, 41.3554 },
        { 300.5895, -31.4183, 43.1102 },
        { 299.8826, -32.0000, 69.7004 },
        { 300.0537, -32.0000, 79.7765 },
        { 298.7496, -32.0000, 90.2460 },
        { 292.6199, -32.0000, 97.2675 },
        { 286.3421, -32.0000, 99.6262 },
        { 275.2870, -32.0000, 99.7623 },
        { 266.0588, -32.0000, 100.2768 },
        { 260.4991, -33.2500, 100.9039 },
        { 257.4967, -33.2500, 100.6178 },
        { 253.5542, -32.0000, 99.9453 },
        { 240.7391, -32.0000, 99.7499 },
        { 233.5802, -32.0000, 99.6826 },
        { 229.2107, -32.0000, 98.5239 },
        { 223.8904, -32.0000, 93.7688 },
        { 221.2304, -32.0000, 88.1065 },
        { 220.2242, -32.0000, 80.4941 },
        { 219.4579, -32.0000, 72.2903 },
        { 217.3535, -32.0000, 67.3672 },
        { 212.2952, -32.0000, 62.4625 },
        { 207.1399, -32.0000, 61.2332 },
        { 179.4823, -32.0000, 60.6559 },
        { 152.8211, -32.0000, 60.1353 },
        { 149.9143, -32.0000, 60.6744 },
        { 147.1871, -32.0000, 62.6687 },
        { 142.4135, -32.0000, 68.5773 },
        { 141.0102, -32.0000, 71.0705 },
        { 140.4328, -32.0000, 74.7549 },
        { 139.4079, -32.0000, 86.5842 },
        { 138.2784, -32.0000, 90.0676 },
        { 136.3411, -32.0000, 92.3810 },
        { 132.6102, -32.0000, 95.6736 },
        { 129.3319, -32.0000, 97.6548 },
        { 124.6337, -32.0000, 99.2329 },
        { 105.1722, -32.0000, 99.9412 },
        { 101.6815, -33.2500, 100.6851 },
        { 98.0158, -33.2500, 100.9463 },
        { 89.1777, -32.0000, 100.7680 },
        { 73.6100, -32.0000, 100.0763 },
        { 69.8687, -32.0000, 98.7351 },
        { 63.1545, -32.0000, 92.9249 },
        { 61.0671, -32.0000, 88.9838 },
        { 60.4715, -32.0000, 66.2753 },
        { 59.7150, -32.0000, 52.5104 },
        { 59.8998, -32.0000, 44.8167 },
        { 60.2695, -29.0000, 40.5529 },
        { 65.5639, -28.0000, 38.5197 },
        { 75.6634, -28.0000, 38.2150 },
        { 77.5906, -28.0000, 37.3551 },
        { 77.9793, -28.0000, 23.7925 },
        { 81.5917, -30.0000, 20.5714 },
        { 84.0700, -32.0000, 20.3511 },
        { 96.5271, -32.0000, 20.2539 },
        { 100.8568, -32.0000, 18.9433 },
        { 105.4747, -32.0000, 16.7413 },
        { 108.7079, -32.0000, 16.5300 },
        { 110.9026, -32.0000, 17.9755 },
        { 115.1132, -32.0000, 19.8863 },
        { 124.6272, -34.0000, 19.9516 },

    },
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
    local escortID = '[Escort]Cannau'
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
            utils.setQuestVar(v, 0, 103, 'Prog', 0)
        end

        return
    else
        local i = 0
        if next(party) ~= nil then
            for _, v in ipairs(party) do
                if v:getZoneID() == xi.zone.THE_ELDIEME_NECROPOLIS then
                    i = i + 1
                end
            end

            if i == 0 then -- Players in party on quest no longer in zone reset the escort
                DespawnMob(checkEscort)
                SetServerVariable(escortID, 0)
                for _, v in ipairs(party) do
                    utils.setQuestVar(v, 0, 103, 'Prog', 0)
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
                local prog = utils.getQuestVar(v, 0, 103, 'Prog')
                if prog == 2 then
                    utils.setQuestVar(v, 0, 103, 'Prog', 3) -- Completes the quest
                elseif prog == 1 then
                    utils.setQuestVar(v, 0, 103, 'Prog', 0) -- Resets the quest for players not in zone when escort started
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
    local questVar = utils.getQuestVar(player, 0, 103, 'Prog')

    if escort ~= nil then
        if progress == escortProgress.ENROUTE then
            mob:pathThrough(mob:getPos(), xi.path.flag.NONE)
            mob:showText(mob, ID.text.WHY_HAVE_WE_STOPPED)
            mob:setLocalVar('progress', escortProgress.PAUSED)
        elseif progress == escortProgress.PAUSED then
            mob:showText(mob, ID.text.COME_ALONG)
            mob:setLocalVar('progress', escortProgress.ENROUTE)
            mob:pathThrough(path[point], xi.path.flag.WALK)
        elseif progress == escortProgress.NONE then
            if GetPlayerByID(mob:getLocalVar('player')) == player then -- Only the player that got the CS can start
                mob:showText(mob, ID.text.NOW_GATHER)
                mob:setLocalVar('progress', escortProgress.ENROUTE)
                mob:setLocalVar('point', 1)
                mob:pathThrough(path[1], xi.path.flag.WALK)
                utils.setQuestVar(player, 0, 103, 'Prog', 2) -- Have to progress the player outside of the loop for some reason
                for _, v in ipairs(player:getParty()) do
                    if v:getZone() == mob:getZone() then
                        utils.setQuestVar(v, 0, 103, 'Prog', 2) -- Only players in zone when escort starts can progress
                        table.insert(party, v)
                    else
                        utils.setQuestVar(v, 0, 103, 'Prog', 0) -- Sets progress back to 0 to cover any wierdness
                    end
                end
            end
        elseif progress == escortProgress.COMPLETE then
            if questVar == 3 then
                mob:showText(mob, ID.text.YOU_FOUGHT_WELL)
                npcUtil.giveKeyItem(player, xi.ki.COMPLETION_CERTIFICATE)
                utils.setQuestVar(player, 0, 103, 'Prog', 4)
                mob:isAggroable(false)
            end

            for _, v in ipairs(player:getParty()) do
                if utils.getQuestVar(v, 0, 103, 'Prog') == 4 then
                    mob:isAggroable(false)
                    mob:timer(60000, function(mobArg)
                        mob:showText(mob, ID.text.GOOD_DAY)
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
    local escortID = '[Escort]Cannau'

    SetServerVariable(escortID, 0)
end

return entity
