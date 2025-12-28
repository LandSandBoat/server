-----------------------------------
-- Area: One of many zones in Shadowreign zones
--   NM: Dark Ixion
-- Info: https://ffxiclopedia.fandom.com/wiki/Dark_Ixion
--       https://www.bg-wiki.com/ffxi/Dark_Ixion
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

    Roaming: runs fast and can be spooked via normal aggro/claim actions. If spooked, it does the same thing as attempting a claim but missing with a Stygian Ash
    Missed Claim: pauses for a few, then runs away very fast
    Claim: can only be claimed by landing a hit with Stygian Ash
    Targetting: Can damage and kill players riding Chocobo with Area of Effect attacks even if player is not in the Alliance fighting him.

    Mobskills:
    - has a normal set of TP moves, but telegraphs most/all of them
    - if he has an aura then his TP moves are doubled up back to back
    - has a special move that isn't listed in the combat log, that many have called 'Trample'
        - Trample: Charges forward, dealing high damage to,(400-1000) and lowering the MP (10-30%) of _ANYONE_ in his path. No message is displayed in the chat log, other than basic "<target> takes X damage."
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
-- TODO: dmg taken from front/rear (if we can)
local animationSubs =
{
    NORMAL      = 0, -- can trample
    TRAMPLE     = 1, -- animation during trample event
    HORN_BROKEN = 2, -- broken horn, cannot trample or double-up mobskills
    GLOWING     = 3, -- glowing: doubles up mobskills and used shortly during horn regrowth
}

xi.darkixion.hpValue = GetServerVariable('DarkIxion_HP')
xi.darkixion.hornState = GetServerVariable('DarkIxion_HornState')
xi.darkixion.hornStates =
{
    [1] =
    {
        animationSub = animationSubs.NORMAL,
        hideHP = true,
    },

    [2] =
    {
        animationSub = animationSubs.HORN_BROKEN,
        hideHP = false,
    },
}

local changeHornState = function(mob, state)
    xi.darkixion.hornState = state
    local hornStateData = xi.darkixion.hornStates[xi.darkixion.hornState]
    if not hornStateData then
        xi.darkixion.hornState = GetServerVariable('DarkIxion_HornState')
        if not xi.darkixion.hornStates[xi.darkixion.hornState] then
            xi.darkixion.hornState = 1
        end

        hornStateData = xi.darkixion.hornStates[xi.darkixion.hornState]
    end

    SetServerVariable('DarkIxion_HornState', xi.darkixion.hornState)
    if hornStateData.animationSub ~= mob:getAnimationSub() then
        mob:setAnimationSub(hornStateData.animationSub)
        mob:hideHP(hornStateData.hideHP)
    end

    -- reset phasechange timer
    mob:setLocalVar('phaseChange', GetSystemTime() + math.random(60, 240))
end

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
        },
    },
}

xi.darkixion.repop = function(mob)
    DespawnMob(mob:getID())
    local keys = {}
    for k, _ in pairs(xi.darkixion.zoneinfo) do
        table.insert(keys, k)
    end

    local randZoneID = keys[math.random(#keys)]
    SetServerVariable('DarkIxion_ZoneID', randZoneID)
    -- wiki says 'It can pop there in less than 10 seconds or take the whole 15 minutes'
    SetServerVariable('DarkIxion_PopTime', GetSystemTime() + math.random(1, 15 * 60)) -- based on onGameHour function timing
end

-- Adjustments made once to Dark Ixion when he begins roaming
xi.darkixion.roamingMods = function(mob)
    if mob:getLocalVar('RunAway') ~= 0 then
        mob:setBaseSpeed(70)
    else
        mob:setBaseSpeed(40)
    end

    -- don't take damage until the fight officially starts
    mob:setMod(xi.mod.UDMGPHYS, -10000)
    mob:setMod(xi.mod.UDMGRANGE, 0) -- TODO figure out how to make Ixion only take damage from stygian ash
    mob:setMod(xi.mod.UDMGBREATH, -10000)
    mob:setMod(xi.mod.UDMGMAGIC, -10000)
    mob:setMod(xi.mod.REGAIN, 0)

    -- restore hp just in case something caused him to regen while roaming
    if xi.darkixion.hpValue == 0 then
        xi.darkixion.hpValue = mob:getHP()
        SetServerVariable('DarkIxion_HP', xi.darkixion.hpValue)
    end

    mob:setHP(xi.darkixion.hpValue)

    -- restore horn status
    changeHornState(mob, xi.darkixion.hornState)

    -- ensure he's in initial state for beginning of fight
    mob:setMobSkillAttack(39)
    mob:setLocalVar('trampleCount', 0)
    mob:setBehavior(0)
    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)
end

xi.darkixion.zoneOnInit = function(zone)
    local ixion = zone:queryEntitiesByName('Dark_Ixion')[1]
    if not ixion then
        return
    end

    local ixionZoneID = GetServerVariable('DarkIxion_ZoneID')
    -- check this on only one zone to catch when ixion has no zone assignment
    if
        xi.darkixion.zoneinfo[ixionZoneID] == nil or
        (GetServerVariable('DarkIxion_PopTime') < GetSystemTime() and ixionZoneID == zone:getID())
    then
        -- reset zone ID but let him spawn next game hour
        if xi.darkixion.zoneinfo[ixionZoneID] == nil then
            xi.darkixion.repop(ixion)
        end

        -- 'If Dark Ixion is due to spawn or is already spawned during maintenance, he will spawn shortly after server comes back online.'
        SetServerVariable('DarkIxion_PopTime', GetSystemTime() + 10)
    elseif
        GetServerVariable('DarkIxion_PopTime') > GetSystemTime() and
        ixionZoneID == zone:getID()
    then
        -- leave zone alone, push back repop ... since zone was already randomized, implied by PopTime being in the future
        -- 'If he was not due to spawn during this time frame (after maintenance), his spawn window will reset to 21 hours after servers come online.'
        SetServerVariable('DarkIxion_PopTime', GetSystemTime() + 21 * 60 * 60)
    end
end

xi.darkixion.zoneOnGameHour = function(zone)
    local ixion = zone:queryEntitiesByName('Dark_Ixion')[1]
    if not ixion then
        return
    end

    local ixionZoneID = GetServerVariable('DarkIxion_ZoneID')
    local ixionPopTime = GetServerVariable('DarkIxion_PopTime')
    if
        ixionZoneID == zone:getID() and
        ixionPopTime < GetSystemTime() - 24 * 60 * 60
    then
        -- wander logic in onGameHour so even sleeping zones with no players can hold DI and cycle him out
        xi.darkixion.repop(ixion)
    elseif
        not ixion:isSpawned() and
        ixionZoneID == zone:getID() and
        ixionPopTime < GetSystemTime() - 45
    then
        -- if gamehour flip is within 45s, randomly spawn within next twice that
        ixion:setRespawnTime(math.random(0, 90))
    elseif
        ixion:isSpawned() and
        ixionZoneID ~= zone:getID()
    then
        -- really shouldn't be possible, but catch just in case a GM manually spawned him somewhere else
        if ixion:isEngaged() then
            -- cleanly handle run away mechanic
            ixion:disengage()
        else
            -- just go away
            DespawnMob(ixion:getID())
        end
    end
end

xi.darkixion.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.IXION_HORNBREAKER)
    end

    if optParams.isKiller or optParams.noKiller then
        -- only reset hp after dying (hp and horn status persist through zones when he runs away and despawns)
        xi.darkixion.hpValue = 0
        SetServerVariable('DarkIxion_HP', xi.darkixion.hpValue)
        changeHornState(mob, 1)
    end
end

xi.darkixion.onMobDespawn = function(mob)
    DisallowRespawn(mob:getID(), true)
    if mob:getZoneID() == GetServerVariable('DarkIxion_ZoneID') then
        xi.darkixion.repop(mob)
        SetServerVariable('DarkIxion_PopTime', GetSystemTime() + math.random(20, 24) * 60 * 60) -- repop 20-24 hours after death
    end
end

local checkHornBreak = function(mob, attacker)
    local animationSub = mob:getAnimationSub()
    if
        not xi.combat.behavior.isEntityBusy(mob) and
        (animationSub == animationSubs.NORMAL or animationSub == animationSubs.GLOWING) and
        (attacker ~= nil and attacker:isInfront(mob)) and
        math.random(1, 100) <= 5
    then
        changeHornState(mob, 2)
    end
end

xi.darkixion.onCriticalHit = function(mob, attacker)
    checkHornBreak(mob, attacker)
end

xi.darkixion.onWeaponskillHit = function(mob, attacker, weaponskill)
    checkHornBreak(mob, attacker)
end

xi.darkixion.onMobWeaponSkill = function(target, mob, skill)
    local skillID = skill:getID()
    if skillID == xi.mobSkill.DAMSEL_MEMENTO then -- sometimes after healing, fix horn
        if
            mob:getAnimationSub() == animationSubs.HORN_BROKEN and
            math.random(1, 100) <= 25
        then
            -- If horn is restored by heal, glow and allow animation to finish, then restore horn
            skill:setFinalAnimationSub(3)
            mob:queue(0, function(mobArg)
                mobArg:stun(500)
                changeHornState(mobArg, 1)
            end)
        end
    elseif skillID == xi.mobSkill.DI_GLOW then
        -- glow TP move telegraphs a damaging TP move, perform it now
        local skillList =
        {
            xi.mobSkill.WRATH_OF_ZEUS,
            xi.mobSkill.LIGHTNING_SPEAR,
            xi.mobSkill.ACHERON_KICK,
            xi.mobSkill.RAMPANT_STANCE,
        }

        local chosenSkill = utils.randomEntry(skillList)

        -- adjust behavior so he doesn't sneak another move in between the sequence
        mob:setBehavior(xi.behavior.NO_TURN + xi.behavior.STANDBACK)
        mob:setAutoAttackEnabled(false)
        mob:useMobAbility(chosenSkill)
        if mob:getAnimationSub() == animationSubs.GLOWING then
            -- queue a second if in glowing phase
            mob:useMobAbility(chosenSkill)
        end
    elseif
        skillID == xi.mobSkill.DI_HORN_ATTACK or
        skillID == xi.mobSkill.DI_BITE_ATTACK or
        skillID == xi.mobSkill.DI_KICK_ATTACK
    then
        -- determine if we want to run (trample) soon, do it randomly off autos, more frequent and more runs when low
        if mob:getAnimationSub() == animationSubs.NORMAL then
            local mobHPP = mob:getHPP()
            local trampleCount = mob:getLocalVar('trampleCount')

            local random = math.random(1, 100)
            if random <= 30 and mobHPP < 33 then
                trampleCount = trampleCount + math.random(1, 3)
            elseif random <= 20 and mobHPP < 50 then
                trampleCount = trampleCount + math.random(1, 2)
            elseif random <= 10 then
                trampleCount = trampleCount + 1
            end

            -- this variable will determine if Ixion can trample, but it's also gated by animation sub and a timestamp
            mob:setLocalVar('trampleCount', utils.clamp(trampleCount, 0, 3)) -- Safety net for trample count
        end
    end

    -- once TP move sequences are done, reset mob behaviors
    mob:queue(0, function(mobArg)
        if not xi.combat.behavior.isEntityBusy(mobArg) then
            mobArg:setBehavior(0)
            mobArg:setAutoAttackEnabled(true)
            mobArg:setMobAbilityEnabled(true)
        end
    end)
end

xi.darkixion.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.TERROR)

    mob:setMobMod(xi.mobMod.NO_REST, 10)
    mob:setMobMod(xi.mobMod.AOE_HIT_ALL, 1)
end

-- either turn in a random direction, or turn away from skillTarget to use acheron kick
local turnForSkill = function(mob, skillTarget)
    local mobPos = mob:getPos()
    local lookAtPos = { x = mobPos.x + math.random(-4, 4), y = mobPos.y, z = mobPos.z + math.random(-4, 4) }

    if skillTarget then
        local targetPos = skillTarget:getPos()
        lookAtPos.x = 2 * mobPos.x - targetPos.x
        lookAtPos.z = 2 * mobPos.z - targetPos.z
    end

    mob:lookAt(lookAtPos)
end

-- Dark Ixion CAN turn around to use this move on anyone with hate
local acheronKickPositioning = function(mob)
    local skillTarget = mob:getTarget() -- mobskill has TARGET_SELF flag, extract target from battleTarget
    local targets = mob:getEnmityList()
    if skillTarget then
        -- current target may not be on the enmity table, if it is then there's a slightly higher chance to target it
        table.insert(targets, { entity = skillTarget })
    end

    local potentialTargets = {}
    for _, entry in ipairs(targets) do
        if entry.entity and mob:checkDistance(entry.entity) < 15 then
            table.insert(potentialTargets, entry.entity)
        end
    end

    if #potentialTargets == 0 then
        return
    end

    skillTarget = utils.randomEntry(potentialTargets)

    turnForSkill(mob, skillTarget)
end

xi.darkixion.onMobSpawn = function(mob)
    xi.darkixion.roamingMods(mob)
    SetServerVariable('DarkIxion_PopTime', GetSystemTime())

    mob:setAggressive(true)
    mob:setRoamFlags(bit.bor(mob:getRoamFlags(), xi.roamFlag.SCRIPTED)) -- do not roam around, only path during roam via patrol path

    -- pre-mobskill listeners to turn mob as appropriate
    mob:addListener('WEAPONSKILL_STATE_ENTER', 'IXION_WS_STATE_ENTER', function(mobArg, skillId)
        if skillId == xi.mobSkill.ACHERON_KICK then
            acheronKickPositioning(mobArg)
        elseif skillId == xi.mobSkill.LIGHTNING_SPEAR then
            turnForSkill(mobArg, nil)
        end
    end)
end

xi.darkixion.onMobRoam = function(mob)
    if
        mob:getLocalVar('RunAway') ~= 0 and
        mob:getLocalVar('RunAway') + 60 < GetSystemTime()
    then
        -- 60s of running away, time to repop somewhere else
        xi.darkixion.repop(mob)
    end

    if not mob:isFollowingPath() then
        local pathList = xi.darkixion.zoneinfo[mob:getZoneID()].pathList
        if mob:checkDistance(pathList[1]) > 50 then
            -- not patrolling and is very far from first point in list, path back
            -- This ensures he always cleanly paths when roaming (doesn't clip through terrain)
            mob:pathTo(pathList[1].x, pathList[1].y, pathList[1].z, xi.path.flag.RUN)
        else
            -- patrol list persists through combat so if a wipe happens, Ixion will resume pathing when doing the runaway mechanic
            mob:pathThrough(pathList, bit.bor(xi.path.flag.RUN, xi.path.flag.PATROL))
        end
    end
end

xi.darkixion.onMobEngage = function(mob, target)
    xi.darkixion.roamingMods(mob)

    -- if stygian ash missed or aggro via any other means, immediately disengage (even if hearing/sight aggro 'If you get too close, DI runs away')
    if mob:getLocalVar('aeFromItemId') == xi.item.PINCH_OF_STYGIAN_ASH then
        mob:setLocalVar('RunAway', 0)
    else
        mob:disengage()
        -- TODO figure out how to make Ixion only take damage from stygian ash
        -- Note that xi.darkixion.roamingMods resets his hp to the stored value, so this is a display issue only
        -- i.e. there's no concern of say hitting him with high dmg WS, letting him run away, and doing it again when you find him in another zone
        return
    end

    mob:setMod(xi.mod.UDMGPHYS, 0)
    mob:setMod(xi.mod.UDMGRANGE, 0)
    mob:setMod(xi.mod.UDMGBREATH, 0)
    mob:setMod(xi.mod.UDMGMAGIC, 0)
    mob:setMod(xi.mod.REGAIN, 20) -- 'has tp regen': https://www.bluegartr.com/threads/59044-Ixion-discussion-thread/page8
    mob:setLocalVar('phaseChange', GetSystemTime() + math.random(60, 240))
end

xi.darkixion.onMobDisengage = function(mob)
    xi.darkixion.hpValue = mob:getHP()
    SetServerVariable('DarkIxion_HP', xi.darkixion.hpValue)

    xi.darkixion.roamingMods(mob)
    if mob:getLocalVar('RunAway') == 0 then
        mob:setBaseSpeed(70)
        -- disengage, standing still unclaimed before 'Running away'
        local waitTime = 15
        mob:stun(waitTime * 1000)
        mob:setLocalVar('RunAway', GetSystemTime() + waitTime)
    else
        -- just reset time until despawn
        mob:setLocalVar('RunAway', GetSystemTime())
    end

    -- no chance of him staying in this zone unless an ash is landed before he runs away and despawns
    mob:setAggressive(false)
    mob:setLocalVar('aeFromItemId', 0)
end

xi.darkixion.onMobFight = function(mob, target)
    -- This section deals with him glowing (double TP moves)
    local animationSub = mob:getAnimationSub()
    if
        not xi.combat.behavior.isEntityBusy(mob) and
        GetSystemTime() >= mob:getLocalVar('phaseChange') and
        (animationSub == animationSubs.NORMAL or
        animationSub == animationSubs.GLOWING)
    then
        mob:setLocalVar('phaseChange', GetSystemTime() + math.random(60, 240))

        -- alternate phase between normal (can trample) and glowing (double-up mobskills)
        animationSub = animationSub ~= animationSubs.NORMAL and animationSubs.NORMAL or animationSubs.GLOWING
        mob:setAnimationSub(animationSub)
        mob:stun(500)
    end

    -- Everything below deals with his charge attack (trample)
    if
        not xi.combat.behavior.isEntityBusy(mob) and
        mob:getLocalVar('trampleCount') >= 1 and
        GetSystemTime() >= mob:getLocalVar('nextTrampleTime') and
        animationSub == animationSubs.NORMAL  -- don't trample if horn is broken or any other sequence is happening
    then
        mob:setTP(0)
        xi.darkixion.beginTramplePath(mob)
    end

    if animationSub == animationSubs.TRAMPLE then
        -- cleanly exit trample when reaching the point (TODO check explicitly for a scripted path?)
        -- runPathTime timestamp hard exit in case of navmesh abuse
        if
            mob:isFollowingPath() and
            GetSystemTime() < mob:getLocalVar('tramplePathTime')
        then
            xi.darkixion.trampleEntitiesInFront(mob)
        else
            xi.darkixion.endTramplePath(mob)
        end
    end
end

-- Used by Trample mechanics
local getEnemiesInRange = function(mob, distance)
    local targetTypeFlag = xi.targetType.SELF + xi.targetType.ANY_ALLEGIANCE -- self + any_allegiance is the targetfind code for "target myself, and find any enemies in range"
    local aoeCenter = xi.aoeRadius.ATTACKER
    local enemies = mob:getEntitiesInRange(mob, xi.aoeType.ROUND, aoeCenter, distance, 0, targetTypeFlag)

    return enemies
end

xi.darkixion.beginTramplePath = function(mob)
    -- global table to track current trample path
    xi.darkixion.hitList = {}

    mob:setAnimationSub(animationSubs.TRAMPLE)
    mob:setLocalVar('isBusy', 1)
    mob:setAutoAttackEnabled(false)
    mob:setMobAbilityEnabled(false)
    mob:setBaseSpeed(70)
    mob:setBehavior(xi.behavior.NO_TURN + xi.behavior.STANDBACK)

    -- choose a random ENTITY within 30 yalms and charge towards them
    -- can also trample at someone close. Fallback to a random spot nearby
    mob:setLocalVar('trampleTargID', 0)
    local tramplePos = mob:getPos()
    tramplePos.x = tramplePos.x + math.random(-10, 10)
    tramplePos.z = tramplePos.z + math.random(-10, 10)
    local potentialTargets = getEnemiesInRange(mob, 30)
    local trampleTarget = nil
    if #potentialTargets > 0 then
        for i = 1, 3 do
            -- rather than loop the whole list, just try a few times to get an entity other than Ixion
            if trampleTarget == nil or trampleTarget == mob then
                trampleTarget = utils.randomEntry(potentialTargets)
            end
        end
    end

    -- ANY_ALLEGIANCE + SELF returns the actor itself in the list
    if trampleTarget and trampleTarget ~= mob then
        -- store targid of the trample destination to ensure pathing wonkiness doesn't make them avoid trample
        -- this target will be hit by trample if it's ever within 7 yalms during the trample pathing
        mob:setLocalVar('trampleTargID', trampleTarget:getTargID())

        -- choose point by drawing a line between Ixion and target, then extending it beyond
        local overshootDistance = 5
        local mobPos = mob:getPos()
        local xM  = mobPos.x
        local zM  = mobPos.z
        local targetPos = trampleTarget:getPos()
        local xT  = targetPos.x
        local yT  = targetPos.y
        local zT  = targetPos.z
        -- deltas
        local xD  = xT - xM
        local zD  = zT - zM

        -- complete the square
        local rss = math.sqrt(xD * xD + zD * zD)
        local xU  = xD / rss
        local zU  = zD / rss
        tramplePos = { x  = xT + (xU * overshootDistance), y = yT, z = zT + (zU * overshootDistance) }
    end

    mob:clearPath()
    mob:lookAt(tramplePos)
    xi.darkixion.trampleEntitiesInFront(mob)
    mob:pathTo(tramplePos.x, tramplePos.y, tramplePos.z, xi.path.flag.WALLHACK + xi.path.flag.RUN + xi.path.flag.SCRIPT + xi.path.flag.SLIDE)
    -- max time to let a single trample path take to avoid navmesh abuse
    -- some paths can take upwards of 20+s with certain terrain, but no need to let Ixion path that long
    mob:setLocalVar('tramplePathTime', GetSystemTime() + 15)
end

xi.darkixion.endTramplePath = function(mob)
    -- variable is unused until the next trample sequence
    xi.darkixion.hitList = {}

    local trampleCount = mob:getLocalVar('trampleCount') - 1
    if trampleCount > 0 then
        -- trample again at a random entity in range
        xi.darkixion.beginTramplePath(mob)
    else
        trampleCount = 0
        mob:setAnimationSub(animationSubs.NORMAL)
        mob:stun(500)

        mob:setLocalVar('isBusy', 0)
        mob:setAutoAttackEnabled(true)
        mob:setMobAbilityEnabled(true)
        mob:setBaseSpeed(40)
        mob:setBehavior(0)

        mob:setLocalVar('nextTrampleTime', GetSystemTime() + math.random(15, 60))
    end

    mob:setLocalVar('trampleCount', trampleCount)
end

xi.darkixion.trampleEntitiesInFront = function(mob)
    local trampleTargID = mob:getLocalVar('trampleTargID')

    -- find entities in range
    --  check if they're in a conal in front of Ixion
    --  skip them if they have already been considered during this path
    --  xi.mobSkill.DI_TRAMPLE otherwise
    local potentialTargets = getEnemiesInRange(mob, 7)
    for _, potentialTarget in ipairs(potentialTargets) do
        -- ANY_ALLEGIANCE + SELF returns the actor itself in the list
        -- targetfind has no height restrictions, just finding entities within a sphere of the mob
        -- TODO should we limit trample consideration to within 5 yalms vertically: math.abs(mob:getPos().y - potentialTarget:getPos().y) <= 5
        -- This would make things like the watchtowers in jugner_s somewhat safe, I believe this is a valid strategy in retail
        if
            potentialTarget and
            potentialTarget ~= mob
        then
            -- ignore if already considered during this trample path
            if not xi.darkixion.hitList[potentialTarget:getTargID()] then
                xi.darkixion.hitList[potentialTarget:getTargID()] = true

                -- trample the found entity if it's in front
                -- or if it's the original trample target (to avoid weird pathing issues causing the final target to be seen as not in front)
                if
                    potentialTarget:isInfront(mob, 30) or
                    potentialTarget:getTargID() == trampleTargID
                then
                    mob:useMobAbility(xi.mobSkill.DI_TRAMPLE, potentialTarget)
                end
            end
        end
    end
end
