-----------------------------------
-- Area: Boneyard_Gully
--  Mob: Shikaree Y
--  Quest: Tango with a Tracker, Requiem of Sin
--  Mission: CoP 5-3 Ulmia's Path (Head Wind)
-----------------------------------
local ID = require("scripts/zones/Boneyard_Gully/IDs")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

local dialogue =
{
    ID.text.TIME_WASTED,
    ID.text.TIME_TO_DIE,
    ID.text.SINS_JUDGED,
}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 0)
    mob:setMod(xi.mod.SLEEPRES, 50)

    mob:addListener("ATTACK", "SHIKAREE_Z_ATTACK", function(attacker, defender, action)
        if math.random() < 0.25 then
            attacker:setTP(3000)
        end
    end)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 0)
    mob:setLocalVar("control", 0)
    mob:setLocalVar("TP", 0)
end

entity.onMobFight = function(mob, target)
    if mob:getTP() == 3000 and mob:getLocalVar("control") == 0 then
        local shikY = GetMobByID(mob:getID() + 1)
        local shikX = GetMobByID(mob:getID() + 2)
        local shikYTP = shikY:getLocalVar("TP")
        local shikXTP = shikX:getLocalVar("TP")
        mob:setLocalVar("TP", 1)

        -- All shik are alive and have TP
        if shikY:isAlive() and shikX:isAlive() then
            if shikYTP == 1 and shikXTP == 1 then
                mob:setLocalVar("control", 1)
                shikY:messageText(shikY, ID.text.MITHRAN_TRACKERS)
                shikY:updateEnmity(target)
                shikX:updateEnmity(target)
                shikY:setMobMod(xi.mobMod.SKILL_LIST, 1166)
                mob:timer(7000, function(mobArg)
                    shikX:setMobMod(xi.mobMod.SKILL_LIST, 1165)
                    mobArg:timer(7000, function(mobArg1)
                        mobArg1:setMobMod(xi.mobMod.SKILL_LIST, 1167)
                    end)
                end)
            -- Doesn't announce TP ready, but set control
            else
                mob:setLocalVar("control", 1)
            end

        -- Only Shik Y is alive and has TP
        elseif shikY:isAlive() and not shikX:isAlive() then
            if shikYTP == 1 then
                mob:setLocalVar("control", 1)
                shikY:messageText(shikY, ID.text.MITHRAN_TRACKERS)
                shikY:updateEnmity(target)
                shikY:setMobMod(xi.mobMod.SKILL_LIST, 1166)
                mob:timer(7000, function(mobArg)
                    mobArg:setMobMod(xi.mobMod.SKILL_LIST, 1167)
                end)
            -- Doesn't announce TP ready, but set control
            else
                mob:setLocalVar("control", 1)
            end

        -- Only Shik X is alive and has TP
        elseif shikX:isAlive() and not shikY:isAlive() then
            if shikXTP == 1 then
                mob:setLocalVar("control", 1)
                shikX:messageText(shikX, ID.text.FOLLOW_LEAD)
                shikX:updateEnmity(target)
                shikX:setMobMod(xi.mobMod.SKILL_LIST, 1165)
                mob:timer(7000, function(mobArg)
                    mobArg:setMobMod(xi.mobMod.SKILL_LIST, 1167)
                end)
            -- Doesn't announce TP ready, but set control
            else
                mob:setLocalVar("control", 1)
            end

        -- Shik Z is last alive
        else
                mob:messageText(mob, dialogue[math.random(1, 3)])
                mob:setMobMod(xi.mobMod.SKILL_LIST, 1167)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        mob:messageText(mob, ID.text.HOW_IS_THIS_POSSIBLE)
        -- Reset controls so that remaining shiks don't get locked from weaponskilling
        GetMobByID(mob:getID() + 1):setLocalVar("control", 0)
        GetMobByID(mob:getID() + 2):setLocalVar("control", 0)
    end
end

return entity
