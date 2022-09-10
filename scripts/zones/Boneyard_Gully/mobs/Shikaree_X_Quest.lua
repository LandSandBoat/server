-----------------------------------
-- Area: Boneyard_Gully
--  Mob: Shikaree X
--  Quest: Tango with a Tracker
-----------------------------------
local ID = require("scripts/zones/Boneyard_Gully/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------
local entity = {}

local dialogue =
{
    ID.text.ADVENTURER_STEAK,
    ID.text.MY_TURN,
    ID.text.YOURE_MINE,
}

entity.onMobSpawn = function(mob)
    mob:timer(1, function(mobArg)
        mobArg:setMobMod(xi.mobMod.SKILL_LIST, 0)
    end)

    mob:addListener("ATTACK", "SHIKAREE_X_ATTACK", function(attacker, defender, action)
        if math.random() < 0.12 then
            attacker:setTP(3000)
        end
    end)

    mob:addListener("TAKE_DAMAGE", "SHIKAREE_X_TAKE_DAMAGE", function(mobArg, amount, attacker)
        if amount > mob:getHP() then
            mobArg:messageTest(attacker, ID.text.AT_MY_BEST, false)
        end
    end)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 695 then
        mob:messageText(target, ID.text.END_THE_HUNT, false)
    end
    mob:setMobMod(xi.mobMod.SKILL_LIST, 0)
    mob:setLocalVar("control", 0)
    mob:setLocalVar("TP", 0)
end

entity.onMobFight = function(mob, target)
    if mob:getTP() == 3000 then
        local shik_Y = GetMobByID(mob:getID()-1)
        mob:setLocalVar("TP", 1)

        if shik_Y:isAlive() then
            if shik_Y:getLocalVar("TP") == 1 and mob:getLocalVar("control") == 0 then
                shik_Y:messageText(target, ID.text.MITHRAN_TRACKERS, false)
                shik_Y:updateEnmity(target)
                shik_Y:setMobMod(xi.mobMod.SKILL_LIST, 1166)
                mob:setLocalVar("control", 1)

                mob:timer(7000, function(mobArg)
                    mobArg:messageText(target, dialogue[math.random(1,3)], false)
                    mobArg:setMobMod(xi.mobMod.SKILL_LIST, 1165)
                end)
            elseif
                shik_Y:getLocalVar("TP") == 0 and
                mob:getLocalVar("control") == 0
            then
                mob:messageText(target, ID.text.READY_TO_RUMBLE, false)
                mob:setLocalVar("control", 1)
            end
        else
            mob:messageText(target, dialogue[math.random(1,3)], false)
            mob:setMobMod(xi.mobMod.SKILL_LIST, 1165)
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
