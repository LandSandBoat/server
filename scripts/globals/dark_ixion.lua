-----------------------------------
-- Area: One of many zones in Shadowreign zones
--   NM: Dark Ixion
-- https://ffxiclopedia.fandom.com/wiki/Dark_Ixion
--[[
    Find DI by:
    - checking the server's zone var: "!checkvar server DarkIxion_ZoneID"
    - go to that zone: !zone <zoneID>
    - go to DI: !gotoname Dark_Ixion

    Outline of the mob's behavior:

    Will run away, most of the time to another zone, if:
    - Campaign Battle begins
    - a player scares it by getting too close
    - attacks or attempts to claim with a Stygian Ash but misses
    - or if whoever has successfully claimed it wipes.
    - His HP is preserved after wiping and him running away to another zone
    - If Dark Ixion is due to spawn or is already spawned during maintenance, he will spawn shortly after server comes back online.
    - If he was not due to spawn during this time frame, his spawn window will reset to 21 hours after servers come online.

    Roaming: runs very fast and can be spooked via normal aggro/claim actions. If spooked, it does the same thing as attempting a claim but missing with a Stygian Ash
    Claim: can only be claimed by landing a hit with Stygian Ash
    Targetting: Can damage and kill players riding Chocobo with Area of Effect attacks even if player is not in the Alliance fighting him.

    Mobskills:
    - has a normal set of TP moves, but telegraphs most/all of them
    - if he has an aura then his TP moves are doubled up back to back
    - has a special move that isn't listed in the combat log, that many have called 'Trample'
        - Trample: Charges forward, dealing high damage to,(400-1000) and lowering the MP (10-30%) of, anyone in his path. No message is displayed in the chat log.
        - When Dark Ixion's HP is low, he can do up to 3 Tramples in succession.
        - Can be avoided easily by moving out of its path.
        - May charge in the opposite, or an entirely random, direction from the one he is currently facing.
        - Will load a set number of targets in his path before ramming forward.
        - Occasionally, a person in his path will not be hit, as well as those wandering in its path after it has begun its charge.
--]]
-----------------------------------
require('scripts/globals/npc_util')

xi = xi or {}
xi.darkixion = xi.darkixion or {}

-- TODOs, notes, and reminders

-- mob:AnimationSub() -- 0 is normal || Charging is animation sub 1  || 2 is broken horn || 3 is glowing and causes horn to repair
-- TODO: dmg taken from front/rear (if we can)

xi.darkixion.zoneinfo =
{
    [xi.zone.JUGNER_FOREST_S] =
    {
        pathList =
        {
            { x = -191.5, y = 000.0, z =  092.0 },
            { x = -139.6, y = 005.0, z =  097.0 },
            { x = -064.0, y = 002.5, z =  093.0 },
            { x = -025.5, y = 004.5, z =  057.0 },
            { x = 0025.0, y = 006.0, z =  040.0 },
            { x = 0087.0, y = 002.0, z =  029.0 },
            { x = 0074.0, y = 000.0, z = -011.0 },
            { x = 0087.0, y = 000.0, z = -083.0 },
            { x = 0118.0, y = 000.0, z = -109.0 },
            { x = 0088.0, y = 000.0, z = -170.0 },
            { x = 0061.0, y = 002.0, z = -156.0 },
            { x = 0030.8, y = 002.0, z = -179.5 },
            { x = -031.8, y = 000.0, z = -196.5 },
            { x = -098.5, y = 000.0, z = -169.0 },
            { x = -177.5, y = 000.0, z = -152.0 },
            { x = -218.0, y = 000.0, z = -234.0 },
            { x = -323.0, y = 002.0, z = -260.7 },
            { x = -225.0, y = 007.0, z = -110.0 },
            { x = -220.7, y = 006.0, z = -107.0 },
            { x = -260.6, y = 006.0, z = -091.0 },
            { x = -259.0, y = 001.0, z = -030.5 },
            { x = -304.0, y = 001.4, z =  004.0 },
            { x = -299.0, y = 002.7, z =  072.5 },
            { x = -291.0, y = 009.0, z =  140.5 },
            { x = -202.7, y = 002.0, z =  139.0 },
        }
    },
    [xi.zone.WEST_SARUTABARUTA_S] =
    {
        pathList =
        {
            { x = 0231.8, y = -025.0, z = 258.5 },
            { x = 0227.5, y = -017.5, z = 209.0 },
            { x = 0134.6, y = -020.5, z = 195.0 },
            { x = 0068.0, y = -012.4, z = 194.8 },
            { x = 0068.0, y = -020.0, z = 254.0 },
            { x = -027.0, y = -012.0, z = 296.4 },
            { x = -019.0, y = -011.7, z = 349.0 },
            { x = 0016.0, y = -018.0, z = 405.6 },
            { x = 0092.0, y = -022.0, z = 391.5 },
            { x = 0143.7, y = -037.5, z = 344.6 },
            { x = 0098.8, y = -027.0, z = 269.0 },
        }
    },
    [xi.zone.ROLANBERRY_FIELDS_S] =
    {
        pathList =
        {
            { x = 0025.0, y = -008.7, z = -346.8 },
            { x = 0016.6, y = -007.7, z = -377.0 },
            { x = -020.0, y = -004.3, z = -328.0 },
            { x = -055.7, y = -001.0, z = -370.7 },
            { x = -051.0, y =  000.0, z = -465.0 },
            { x = -092.8, y =  004.2, z = -540.0 },
            { x = -032.0, y =  004.8, z = -584.5 },
            { x = -019.0, y =  001.0, z = -654.8 },
            { x = -071.0, y = -006.9, z = -631.6 },
            { x = -116.6, y = -007.0, z = -592.8 },
            { x = -109.8, y = -007.0, z = -553.0 },
            { x = -220.0, y =  004.0, z = -478.7 },
            { x = -219.0, y =  004.4, z = -344.0 },
            { x = -181.0, y =  004.4, z = -330.0 },
            { x = -171.0, y =  004.8, z = -303.0 },
            { x = -142.7, y =  004.6, z = -234.7 },
            { x = -185.0, y =  004.8, z = -186.0 },
            { x = -228.8, y =  004.5, z = -141.5 },
            { x = -235.7, y =  000.0, z = -052.0 },
            { x = -229.0, y = -003.6, z = -025.5 },
            { x = -209.6, y = -007.6, z = -037.5 },
            { x = -176.7, y = -007.0, z = -080.5 },
            { x = -141.3, y = -008.0, z = -089.0 },
            { x = -083.9, y = -007.7, z = -139.5 },
            { x = -042.0, y = -007.3, z = -185.0 },
        }
    },
    [xi.zone.GRAUBERG_S] =
    {
        pathList =
        {
            { x = 344.4, y =  036.7, z = -443.0 },
            { x = 310.5, y =  027.0, z = -429.5 },
            { x = 273.5, y =  016.3, z = -404.7 },
            { x = 212.0, y =  010.0, z = -393.6 },
            { x = 158.5, y = -004.8, z = -380.0 },
            { x = 093.0, y = -015.7, z = -333.8 },
            { x = 032.0, y = -019.0, z = -308.8 },
            { x = 000.7, y = -032.0, z = -280.5 },
            { x = 063.5, y = -029.5, z = -373.0 },
            { x = 130.6, y = -039.5, z = -208.0 },
            { x = 170.0, y = -023.5, z = -240.5 },
            { x = 225.0, y = -010.0, z = -290.0 },
            { x = 249.0, y =  008.6, z = -365.0 },
            { x = 302.0, y =  018.0, z = -388.0 },
            { x = 367.8, y =  017.0, z = -364.0 },
            { x = 436.0, y =  017.3, z = -332.6 },
            { x = 506.0, y =  015.0, z = -293.0 },
            { x = 539.5, y =  015.8, z = -296.7 },
            { x = 528.5, y =  025.0, z = -369.8 },
            { x = 506.5, y =  040.0, z = -399.0 },
            { x = 461.8, y =  039.0, z = -412.0 },
            { x = 388.8, y =  031.0, z = -408.7 },
        }
    },
    [xi.zone.BATALLIA_DOWNS_S] =
    {
        pathList =
        {
            { x = -083.0, y = -008.0, z =  035.0 },
            { x = -059.0, y = -008.0, z =  008.0 },
            { x = -090.5, y = -009.5, z = -027.0 },
            { x = -145.5, y = -018.0, z = -024.7 },
            { x = -181.5, y = -018.5, z = -004.0 },
            { x = -243.0, y = -022.2, z = -027.8 },
            { x = -301.0, y = -018.6, z = -017.0 },
            { x = -363.0, y = -024.0, z = -038.5 },
            { x = -459.0, y = -005.7, z =  033.5 },
            { x = -443.7, y = -011.5, z =  056.8 },
            { x = -418.7, y = -013.0, z =  175.0 },
            { x = -387.5, y = -013.8, z =  219.5 },
            { x = -299.0, y = -010.5, z =  220.8 },
            { x = -261.0, y = -005.5, z =  233.7 },
            { x = -254.5, y = -005.0, z =  293.8 },
            { x = -185.5, y =  002.5, z =  294.0 },
            { x = -086.0, y =  000.0, z =  257.5 },
            { x = -099.5, y =  002.0, z =  164.5 },
            { x = -049.5, y =  002.5, z =  103.0 },
            { x = 0000.0, y =  000.0, z =  046.0 },
        }
    },
    [xi.zone.FORT_KARUGO_NARUGO_S] =
    {
        pathList =
        {
            { x = -088.8, y = -068.0, z = -269.5 },
            { x = -025.0, y = -067.0, z = -282.5 },
            { x = 0023.7, y = -068.0, z = -232.0 },
            { x = 0054.7, y = -069.7, z = -178.0 },
            { x = 0085.0, y = -064.0, z = -165.5 },
            { x = 0105.5, y = -065.0, z = -180.0 },
            { x = 0136.0, y = -059.0, z = -215.5 },
            { x = 0180.7, y = -056.0, z = -195.5 },
            { x = 0198.0, y = -057.8, z = -146.7 },
            { x = 0199.0, y = -043.0, z = -062.5 },
            { x = 0200.8, y = -040.0, z = -026.4 },
            { x = 0205.7, y = -028.0, z =  021.3 },
            { x = 0256.6, y = -022.0, z =  025.0 },
            { x = 0281.6, y = -026.5, z =  010.0 },
            { x = 0259.5, y = -029.8, z = -049.5 },
            { x = 0239.0, y = -040.5, z = -100.0 },
            { x = 0205.7, y = -057.0, z = -145.0 },
            { x = 0194.0, y = -054.0, z = -186.0 },
            { x = 0180.7, y = -047.5, z = -227.2 },
            { x = 0135.0, y = -050.8, z = -251.0 },
            { x = 0107.8, y = -061.7, z = -295.5 },
            { x = 0097.0, y = -061.5, z = -307.5 },
            { x = 0041.0, y = -068.0, z = -321.0 },
            { x = -007.0, y = -067.9, z = -301.0 },
            { x = -052.5, y = -067.7, z = -275.0 },
        }
    },
    [xi.zone.EAST_RONFAURE_S] =
    {
        pathList =
        {
            { x = 236.0, y = -020.0, z = -323.0 },
            { x = 245.6, y = -019.5, z = -290.0 },
            { x = 291.0, y = -016.0, z = -257.5 },
            { x = 358.5, y = -016.0, z = -259.0 },
            { x = 384.7, y = -015.0, z = -227.0 },
            { x = 405.0, y = -016.7, z = -220.0 },
            { x = 434.0, y = -016.7, z = -220.0 },
            { x = 459.0, y = -015.7, z = -225.5 },
            { x = 469.0, y = -015.0, z = -256.0 },
            { x = 496.0, y = -015.0, z = -266.6 },
            { x = 498.0, y = -016.0, z = -303.0 },
            { x = 501.0, y = -015.0, z = -327.5 },
            { x = 509.0, y = -005.0, z = -376.8 },
            { x = 537.0, y = -005.5, z = -387.0 },
            { x = 537.0, y = -006.0, z = -437.0 },
            { x = 514.0, y = -009.0, z = -450.5 },
            { x = 480.0, y = -009.6, z = -446.6 },
            { x = 438.0, y = -010.0, z = -440.5 },
            { x = 411.4, y = -010.0, z = -393.0 },
            { x = 368.5, y = -010.0, z = -407.0 },
            { x = 346.0, y = -007.0, z = -429.8 },
            { x = 318.2, y =  000.0, z = -437.6 },
            { x = 271.5, y =  004.3, z = -461.6 },
            { x = 219.7, y = -017.0, z = -334.0 },
        }
    },
}

xi.darkixion.setupEntity = function(entity)
    entity.onMobDeath = function(mob, player, optParams)
        xi.darkixion.onMobDeath(mob, player, optParams)
    end

    entity.onMobDespawn = function(mob)
        xi.darkixion.onMobDespawn(mob)
    end

    entity.onMobSpawn = function(mob)
        xi.darkixion.onMobSpawn(mob)
    end

    entity.onMobRoam = function(mob)
        xi.darkixion.onMobRoam(mob)
    end

    entity.onMobEngage = function(mob, target)
        xi.darkixion.onMobEngage(mob, target)
    end

    entity.onMobDisengage = function(mob)
        xi.darkixion.onMobDisengage(mob)
    end
end

xi.darkixion.repop = function(mob)
    DespawnMob(mob:getID())
    local keys = {}
    for k, _ in pairs(xi.darkixion.zoneinfo) do
        table.insert(keys, k)
    end

    local randZoneID = keys[math.random(#keys)]
    SetServerVariable('DarkIxion_ZoneID', randZoneID)
    -- wiki says 'It can pop there in less than 10 seconds or take the whole 15 minutes'
    SetServerVariable('DarkIxion_PopTime', os.time() + math.random(1, 15 * 60)) -- based on onGameHour function timing
end

-- Adjustments made once to Dark Ixion when he begins roaming
xi.darkixion.roamingMods = function(mob)
    -- don't take damage until the fight officially starts
    mob:setMod(xi.mod.UDMGPHYS, -10000)
    mob:setMod(xi.mod.UDMGRANGE, -10000)
    mob:setMod(xi.mod.UDMGBREATH, -10000)
    mob:setMod(xi.mod.UDMGMAGIC, -10000)

    -- restore hp just in case something caused him to regen while roaming
    local diHP = GetServerVariable('DarkIxion_HP')
    if diHP == 0 then
        diHP = mob:getHP()
        SetServerVariable('DarkIxion_HP', diHP)
    end

    mob:setHP(diHP)

    -- restore horn status
    if GetServerVariable('DarkIxion_HornStatus') == 1 then
        mob:setAnimationSub(2)
        mob:hideHP(false)
    else
        mob:setAnimationSub(0)
        mob:hideHP(true)
    end

    mob:setMobSkillAttack(39)
    mob:setLocalVar('charging', 0)
    mob:setLocalVar('double', 0)
    mob:setLocalVar('lastHit', 0)
    mob:setBehavior(0)
    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)
end

xi.darkixion.zoneOnInit = function(zone)
    local ixion = zone:queryEntitiesByName('Dark_Ixion')[1]
    local ixionZoneID = GetServerVariable('DarkIxion_ZoneID')
    -- check this on only one zone to catch when ixion has no zone assignment
    if
        xi.darkixion.zoneinfo[ixionZoneID] == nil or
        (GetServerVariable('DarkIxion_PopTime') < os.time() and ixionZoneID == zone:getID())
    then
        -- reset zone ID but let him spawn next game hour
        if xi.darkixion.zoneinfo[ixionZoneID] == nil then
            xi.darkixion.repop(ixion)
        end

        -- 'If Dark Ixion is due to spawn or is already spawned during maintenance, he will spawn shortly after server comes back online.'
        SetServerVariable('DarkIxion_PopTime', os.time() + 10)
    elseif
        GetServerVariable('DarkIxion_PopTime') > os.time() and
        ixionZoneID == zone:getID()
    then
        -- leave zone alone, push back repop ... since zone was already randomized, implied by PopTime being in the future
        -- 'If he was not due to spawn during this time frame (after maintenance), his spawn window will reset to 21 hours after servers come online.'
        SetServerVariable('DarkIxion_PopTime', os.time() + 21 * 60 * 60)
    end
end

xi.darkixion.zoneOnGameHour = function(zone)
    local ixion = zone:queryEntitiesByName('Dark_Ixion')[1]
    if
        GetServerVariable('DarkIxion_ZoneID') == zone:getID() and
        GetServerVariable('DarkIxion_PopTime') < os.time() - 24 * 60 * 60
    then
        -- wander logic in onGameHour so even sleeping zones with no players can hold DI and cycle him out
        xi.darkixion.repop(ixion)
    elseif
        not ixion:isSpawned() and
        GetServerVariable('DarkIxion_ZoneID') == zone:getID() and
        GetServerVariable('DarkIxion_PopTime') < os.time() - 45
    then
        -- if gamehour flip is within 45s, randomly spawn within next twice that
        ixion:setRespawnTime(math.random(0, 90))
    elseif
        ixion:isSpawned() and
        GetServerVariable('DarkIxion_ZoneID') ~= zone:getID()
    then
        -- really shouldn't be possible, but catch just in case a GM manually spawned him somewhere else
        if ixion:isEngaged() then
            ixion:disengage()
        else
            DespawnMob(ixion:getID())
        end
    end
end

xi.darkixion.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.IXION_HORNBREAKER)
    -- only reset hp after being killed
    SetServerVariable('DarkIxion_HP', 0)
    SetServerVariable('DarkIxion_HornStatus', 0)
end

xi.darkixion.onMobDespawn = function(mob)
    DisallowRespawn(mob:getID(), true)
    if mob:getZoneID() == GetServerVariable('DarkIxion_ZoneID') then
        xi.darkixion.repop(mob)
        SetServerVariable('DarkIxion_PopTime', os.time() + math.random(20, 24) * 60 * 60) -- repop 20-24 hours after death
    end
end

xi.darkixion.onMobSpawn = function(mob)
    mob:setBaseSpeed(70)
    xi.darkixion.roamingMods(mob)
    SetServerVariable('DarkIxion_PopTime', os.time())
    mob:setLocalVar('wasKilled', 0)
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.STUNRES, 100)

    mob:setMobMod(xi.mobMod.NO_REST, 10)
    mob:setAggressive(true)
end

xi.darkixion.onMobRoam = function(mob)
    if
        mob:getLocalVar('RunAway') ~= 0 and
        mob:getLocalVar('RunAway') + 60 < os.time()
    then
        -- 60s of running away, time to repop somewhere else
        xi.darkixion.repop(mob)
    end

    if not mob:isFollowingPath() then
        -- Ensures he always cleanly paths (doesn't clip through terrain)
        local pathList = xi.darkixion.zoneinfo[mob:getZoneID()].pathList
        if not mob:atPoint(pathList[1].x, pathList[1].y, pathList[1].z) then
            mob:pathTo(pathList[1].x, pathList[1].y, pathList[1].z, xi.path.flag.RUN)
        else
            mob:pathThrough(pathList, bit.bor(xi.path.flag.RUN, xi.path.flag.PATROL))
        end
    end
end

xi.darkixion.onMobEngage = function(mob, target)
    mob:setMod(xi.mod.REGAIN, 20) -- 'has tp regen': https://www.bluegartr.com/threads/59044-Ixion-discussion-thread/page8
    xi.darkixion.roamingMods(mob)
    -- if stygian ash missed or aggro via any other means, immediately disengage (even if hearing aggro 'If you get too close, DI runs away')
    if mob:getLocalVar('StygianLanded') ~= 1 then
        mob:disengage()
    end

    mob:setMod(xi.mod.UDMGPHYS, 0)
    mob:setMod(xi.mod.UDMGRANGE, 0)
    mob:setMod(xi.mod.UDMGBREATH, 0)
    mob:setMod(xi.mod.UDMGMAGIC, 0)

    mob:setLocalVar('run', 0)
    mob:setLocalVar('PhaseChange', os.time() + math.random(60, 240))
end

xi.darkixion.onMobDisengage = function(mob)
    SetServerVariable('DarkIxion_HP', mob:getHP())
    if mob:getAnimationSub() == 2 then
        SetServerVariable('DarkIxion_HornStatus', 1)
    else
        SetServerVariable('DarkIxion_HornStatus', 0)
    end

    xi.darkixion.roamingMods(mob)
    if mob:getLocalVar('RunAway') == 0 then
        -- disengage, give one window of him standing still unclaimed before 'Running away'
        local waitTime = 15
        mob:stun(waitTime * 1000)
        mob:setLocalVar('RunAway', os.time() + waitTime)
    else
        -- just reset time until despawn
        mob:setLocalVar('RunAway', os.time())
    end

    -- no chance of him staying in this zone unless an ash is landed before he runs away and despawns
    mob:setAggressive(false)
    mob:setLocalVar('StygianLanded', 0)
end
