-----------------------------------
-- Area: Nyzul Isle (Path of Darkness)
--  Mob: Naja Salaheem
-----------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/allyassist")
-----------------------------------
local entity = {}

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

entity.onMobSpawn = function(mob)
    mob:addListener("WEAPONSKILL_STATE_ENTER", "WS_START_MSG", function(m, skillID)
        if skillID == 165 then
            m:showText(m, ID.text.CHA_CHING)
        elseif skillID == 168 then
            m:showText(m, ID.text.TWELVE_GOLD_COINS)
        elseif skillID == 169 then
            m:showText(m, ID.text.NINETY_NINE_SILVER_COINS)
        end
    end)
end

entity.onMobEngaged = function(mob, target)
    -- localVar because we don't want it to repeat she engages a new target.
    if mob:getLocalVar("started") == 0 then
        mob:showText(mob, ID.text.ALRRRIGHTY)
        mob:setLocalVar("started", 1)
    end
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() <= 50 and mob:getLocalVar("lowHPmsg") == 0 then
        mob:showText(mob, ID.text.OW)
        mob:setLocalVar("lowHPmsg", 1)
    elseif mob:getHPP() > 50 and mob:getLocalVar("lowHPmsg") == 1 then
        mob:setLocalVar("lowHPmsg", 0)
    end
end

entity.onMobDisengage = function(mob, target)
    local ready = mob:getLocalVar("ready")

    if ready == 1 then
        xi.ally.startAssist(mob, xi.ally.ASSIST_RANDOM)
    end
end

entity.onMobRoam = function(mob)
    -- Advance to Stage 2 area
    if mob:getLocalVar("Stage") == 2 then
        mob:showText(mob, ID.text.OH_ARE_WE_DONE)
        mob:pathThrough(stage2Position, xi.pathflag.SCRIPT)
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    -- Advance to Stage 3 area
    elseif mob:getLocalVar("Stage") == 3 then
        mob:showText(mob, ID.text.NOW_WERE_TALKIN)
        mob:pathThrough(stage3Position, xi.pathflag.SCRIPT)
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    end

    -- Ally Assist Check
    local ready = mob:getLocalVar("ready")

    -- Only start the path once
    if mob:isFollowingPath() then
        mob:setLocalVar("Stage", 0)
    -- Path must finish before Ally Asisst (no wallhacking!)
    elseif ready == 1 then
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        xi.ally.startAssist(mob, xi.ally.ASSIST_RANDOM)
    end
end

entity.onCriticalHit = function(mob)
    mob:showText(mob, ID.text.OW)
end

entity.onMobDeath = function(mob, player, optParams)
    -- Loss if Naja dies. Since player will be nil here, it'll only show once.
    mob:showText(mob, ID.text.ABQUHBAH)
    local instance = mob:getInstance()
    instance:fail()
end

return entity
