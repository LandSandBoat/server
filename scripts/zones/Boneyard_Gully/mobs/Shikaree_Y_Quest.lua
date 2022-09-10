-----------------------------------
-- Area: Boneyard_Gully
--  Mob: Shikaree Y
--  Quest: Tango with a Tracker
-----------------------------------
local ID = require("scripts/zones/Boneyard_Gully/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/spell_data")
require("scripts/globals/status")
-----------------------------------
local entity = {}

local dialogue =
{
    ID.text.SUGARPLUM,
    ID.text.MASSACRE_BEGIN,
    ID.text.HONEYCAKES,
}

local magicBurst =
{
    xi.magic.spell.FIRE_II,
    xi.magic.spell.THUNDER_II,
    xi.magic.spell.STONE_II,
    xi.magic.spell.BLIZZARD_II,
    xi.magic.spell.WATER_II,
    xi.magic.spell.AERO_II,
}

entity.onMobEngaged = function(mob, target)
    mob:messageText(target, ID.text.BLOOD_RACING, false)
end

entity.onMobSpawn = function(mob)
    mob:timer(1, function(mobArg)
        mobArg:setMobMod(xi.mobMod.SKILL_LIST, 0)
    end)

    mob:addListener("ATTACK", "SHIKAREE_Y_ATTACK", function(attacker, defender, action)
        if math.random() < 0.25 then
            attacker:setTP(3000)
        end
    end)

    mob:addListener("TAKE_DAMAGE", "SHIKAREE_X_TAKE_DAMAGE", function(mobArg, amount, attacker)
        if amount > mob:getHP() then
            mobArg:messageTest(attacker, ID.text.I_LOST, false)
        end
    end)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 695 then
        mob:messageText(target, ID.text.SCENT_OF_BLOOD, false)
    end
    mob:setMobMod(xi.mobMod.SKILL_LIST, 0)
    mob:setLocalVar("control", 0)
    mob:setLocalVar("TP", 0)
end

entity.onMobFight = function(mob, target)
    if mob:getTP() == 3000 then
        local shik_X = GetMobByID(mob:getID()+1)
        mob:setLocalVar("TP", 1)

        if shik_X:isAlive() then
            if shik_X:getLocalVar("TP") == 1 and mob:getLocalVar("control") == 0 then
                shik_X:messageText(target, ID.text.MITHRAN_TRACKERS, false)
                shik_X:updateEnmity(target)
                shik_X:setMobMod(xi.mobMod.SKILL_LIST, 1165)
                mob:setLocalVar("control", 1)

                mob:timer(7000, function(mobArg)
                    mobArg:messageText(target, dialogue[math.random(1,3)], false)
                    mobArg:setMobMod(xi.mobMod.SKILL_LIST, 1166)

                    mobArg:queue(0, function(mobArg2)
                        mobArg2:castSpell(magicBurst[math.random(1,6)])
                    end)
                end)
            elseif
                shik_X:getLocalVar("TP") == 0 and
                mob:getLocalVar("control") == 0
            then
                mob:messageText(target, ID.text.READY_TO_REAP, false)
                mob:setLocalVar("control", 1)
            end
        else
            mob:messageText(target, dialogue[math.random(1,3)], false)
            mob:setMobMod(xi.mobMod.SKILL_LIST, 1166)
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
