-----------------------------------
-- Area: Full Moon Fountain
--  Mob: Ajido-Marujido
-- Ally during Windurst Mission 9-2
-----------------------------------
local ID = require("scripts/zones/Full_Moon_Fountain/IDs")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.REFRESH, 1)
    mob:setMobMod(tpz.mobMod.TELEPORT_CD, 30)
end

function onMobSpawn(mob)
    mob:addListener("MAGIC_START", "MAGIC_MSG", function(mob, spell, action)
        -- Burst
        if spell:getID() == 212 then
            mob:showText(mob, ID.text.PLAY_TIME_IS_OVER)
        -- Flood
        elseif spell:getID() == 214 then
            mob:showText(mob, ID.text.YOU_SHOULD_BE_THANKFUL)
        end
    end)
end

function onMobRoam(mob)
    local wait = mob:getLocalVar("wait")
    if wait > 40 then
        -- pick a random living target from the two enemies
        local inst = mob:getBattlefield():getArea()
        local instOffset = ID.mob.MOON_READING_OFFSET + (6 * (inst - 1))
        local target = GetMobByID(instOffset + math.random(4, 5))
        if not target:isDead() then
            mob:addEnmity(target, 0, 1)
            mob:setLocalVar("wait", 0)
        end
    else
        mob:setLocalVar("wait", wait+3)
    end
end

function onMobEngaged(mob, target)
    mob:setMobMod(tpz.mobMod.TELEPORT_TYPE, 0)
end

function onMobFight(mob, target)
    if mob:getHPP() < 50 and mob:getLocalVar("saidMessage") == 0 then
        mob:showText(mob, ID.text.DONT_GIVE_UP)
        mob:setLocalVar("saidMessage", 1)
    end
    if target:isEngaged() then
        mob:setMobMod(tpz.mobMod.TELEPORT_TYPE, 1)
    end
end

function onMobDisengage(mob)
    mob:setLocalVar("wait", 0)
end

function onMobDeath(mob, player, isKiller)
    mob:getBattlefield():lose()
        for _, player in ipairs(mob:getBattlefield():getPlayers()) do
            player:messageSpecial(ID.text.UNABLE_TO_PROTECT)
        end
end
