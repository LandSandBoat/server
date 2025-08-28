-----------------------------------
-- Era NPC
-- Utilities for custom Era NPC interactions
-----------------------------------
require("scripts/globals/npc_util")

xi = xi or {}
xi.eraNpc = xi.eraNpc or {}

function xi.eraNpc.giveInstantWarpScroll(player, npc, params)
    params = params or {}
    params.name = params.name or npc:getName()

    if player:hasItem(xi.item.SCROLL_OF_INSTANT_WARP) then
        return false
    end

    player:printToPlayer("Bro, you forgot your Warp scroll, don't worry, I gotchu :D", 0, params.name)
    npcUtil.giveItem(player, xi.item.SCROLL_OF_INSTANT_WARP)

    return true
end

function xi.eraNpc.tryWarp(player, npc, params)
    local time = os.time()
    params.name = params.name or npc:getName()

    if player:getLocalVar("[Era]WarpNpc") ~= npc:getID() or time > player:getLocalVar("[Era]WarpTime") then
        player:setLocalVar("[Era]WarpNpc", npc:getID())
        player:setLocalVar("[Era]WarpTime", time + 30)
        player:printToPlayer("Warning! The next time you click this NPC, you will be transported.", 0, params.name)
        player:printToPlayer(string.format("Destination: %s", params.destinationName), 0, params.name)
        return false
    end

    if params.check and not params.check() then
        player:printToPlayer(params.checkFailureText, 0, params.name)
        return false
    end

    if params.destination == "nation" then
        xi.teleport.toHomeNation(player)
    elseif params.destination == "warp" then
        player:warp()
    else
        player:setPos(unpack(params.destination))
    end

    return true
end

function xi.eraNpc.giveInstantWarpScrollThenTryWarp(player, npc, params)
    if xi.eraNpc.giveInstantWarpScroll(player, npc, params) then
        return
    end

    xi.eraNpc.tryWarp(player, npc, params)
end

local function getTotalExp(player)
    local totalExpToAchieveLevel =
    {
        [0] = 0,
        0, 500, 1250, 2250, 3500, 5000, 6750, 8750, 10950, 13350,
        15950, 18750, 21750, 24950, 28350, 31950, 35750, 39750, 43950, 48350,
        52950, 57750, 62750, 67850, 73050, 78350, 83750, 89250, 94850, 100550,
        106350, 112250, 118250, 124350, 130550, 136850, 143250, 149750, 156350, 163050,
        169850, 176750, 183750, 190850, 198050, 205350, 212750, 220250, 227850, 235550,
        243350, 251350, 260550, 270950, 282550, 295350, 309350, 324550, 340950, 358550,
        377350, 397350, 418850, 441850, 466350, 492350, 519850, 548850, 579350, 611350,
        645350, 681350, 719350, 759350, 801350, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
    }

    local totalExp = 0
    for job = xi.job.WAR, xi.job.RUN do
        totalExp = totalExp + totalExpToAchieveLevel[player:getJobLevel(job)]
    end

    return totalExp
end

function xi.eraNpc.broMoogleTrade(player, npc, trade)
    player:printToPlayer("Hey bro, I don't know what you're expecting me to do with this. I'm good.", 0, "B.R.O. Moogle")
end

function xi.eraNpc.broMoogleTrigger(player, npc)
    local zoneid = player:getZoneID()
    local totalExp = getTotalExp(player)
    local expCap = 1087850 -- Enough exp for reaching level 75 and leveling two subjobs to 37

    -- B.R.O. Moogle explanation for first timers
    if player:getCharVar("BroMoogleIntro") == 0 then
        player:printToPlayer("Hey bro, I'm one of Era's infamous buffing moogles!", 0, "B.R.O. Moogle")
        player:printToPlayer("We'll help you out on your adventures. Just hit us up every time you see us!", 0, "B.R.O. Moogle")
        player:printToPlayer("Talk to me again when you're ready for my Mighty Moogle Magic!", 0, "B.R.O. Moogle")
        player:printToPlayer("What? Why didn't I say it? Bro, we're not all the same... *Sigh* ... Kupo...", 0, "B.R.O. Moogle")
        player:setCharVar("BroMoogleIntro", 1)
        return
    end

    local time = os.time()

    if time > player:getLocalVar("[Era]BroBuffTime") then
        player:setLocalVar("[Era]BroBuffTime", time + 30)
        player:printToPlayer("Here are the buffs I'm authorized to give you, bro.", 0, "B.R.O. Moogle")
        player:addStatusEffect(xi.effect.RERAISE, 1, 0, 7200)

        -- Check for MOOGLEEXP event from settings
        if
            xi.settings.main.MOOGLEEXP == 1 or
            (xi.settings.main.MOOGLEEXP > 1 and xi.settings.main.MOOGLEEXP < os.time()) or
            (player:getMainLvl() < 75 and totalExp < expCap)
        then
            player:addStatusEffect(xi.effect.DEDICATION, 100, 60, 10800, 0, 80000) -- Current EXP Buff
        elseif totalExp >= expCap and player:getCharVar("BroLockV1") == 0 then
            player:printToPlayer("Oh, bro, you've grown so strong you don't need my magic anymore!", 0, "B.R.O. Moogle")
            player:setCharVar("BroLockV1", 1)
        end
    end

    if xi.eraNpc.giveInstantWarpScroll(player, npc, { name = "B.R.O. Moogle" }) then
        return
    end

    if player:getZone():getRegionID() == xi.region.JEUNO or zoneid == xi.zone.AHT_URHGAN_WHITEGATE then
        xi.eraNpc.tryWarp(player, npc, {
            destinationName = "Your Home Nation",
            destination     = "nation",
            name            = "B.R.O. Moogle",
        })

        -- Cleanup old vars
        player:setCharVar("letswarp", 0)
    end
end