-----------------------------------
-- Area: Nyzul Isle (Path of Darkness)
--  Mob: Naja Salaheem
-----------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/allyassist")
require("scripts/globals/instance")
-----------------------------------

-- Path to Stage 2 Position
local stage2Position =
{
    499, 0, -531,
    500, 0, -509,
}

-- Path to Stage 3 Position
local stage3Position =
{
    490, 0, -500,
    473, 0, -499,
    473, 0, -486,
    459, 0, -486,
    460, 0, -446,
}

function onMobSpawn(mob)
    mob:addListener("WEAPONSKILL_STATE_ENTER", "WS_START_MSG", function(mob, skillID)
        if (skillID == 165) then
            mob:showText(mob, ID.text.CHA_CHING)
        elseif (skillID == 168) then
            mob:showText(mob, ID.text.TWELVE_GOLD_COINS)
        elseif (skillID == 169) then
            mob:showText(mob, ID.text.NINETY_NINE_SILVER_COINS)
        end
    end)
end

function onMobEngaged(mob, target)
    -- localVar because we don't want it to repeat she engages a new target.
    if (mob:getLocalVar("started") == 0) then
        mob:showText(mob, ID.text.ALRRRIGHTY)
        mob:setLocalVar("started", 1)
    end
end

function onMobFight(mob, target)
    if (mob:getHPP() <= 50 and mob:getLocalVar("lowHPmsg") == 0) then
        mob:showText(mob, ID.text.OW)
        mob:setLocalVar("lowHPmsg", 1)
    elseif (mob:getHPP() > 50 and mob:getLocalVar("lowHPmsg") == 1) then
        mob:setLocalVar("lowHPmsg", 0)
    end
end

function onMobDisengaged(mob, target)
    local ready = mob:getLocalVar("ready")

    if (ready == 1) then
        tpz.ally.startAssist(mob, tpz.ally.ASSIST_RANDOM)
    end
end

function onMobRoam(mob)
    -- Advance to Stage 2 area
    if (mob:getLocalVar("Stage") == 2) then
        mob:showText(mob, ID.text.OH_ARE_WE_DONE)
        mob:pathThrough(stage2Position, PATHFLAG_SCRIPT)
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    -- Advance to Stage 3 area
    elseif (mob:getLocalVar("Stage") == 3) then
        mob:showText(mob, ID.text.NOW_WERE_TALKIN)
        mob:pathThrough(stage3Position, PATHFLAG_SCRIPT)
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    end

    -- Ally Assist Check
    local ready = mob:getLocalVar("ready")

    -- Only start the path once
    if (mob:isFollowingPath()) then
        mob:setLocalVar("Stage", 0)
    -- Path must finish before Ally Asisst (no wallhacking!)
    elseif (ready == 1) then
        mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
        tpz.ally.startAssist(mob, tpz.ally.ASSIST_RANDOM)
    end
end

function onCriticalHit(mob)
    mob:showText(mob, ID.text.OW)
end

function onMobDeath(mob, player, isKiller)
    -- Loss if Naja dies. Since player will be nil here, it'll only show once.
    mob:showText(mob, ID.text.ABQUHBAH)
    local instance = mob:getInstance()
    instance:fail()
end
