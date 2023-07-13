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
    ID.text.SUGARPLUM,
    ID.text.MASSACRE_BEGIN,
    ID.text.HONEYCAKES,
}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 0)
    mob:setMod(xi.mod.SLEEPRES, 50)

    mob:addListener("ATTACK", "SHIKAREE_Y_ATTACK", function(attacker, defender, action)
        if math.random() < 0.25 then
            attacker:setTP(3000)
        end
    end)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 695 then
        mob:messageText(mob, ID.text.SCENT_OF_BLOOD)
    end

    mob:setMobMod(xi.mobMod.SKILL_LIST, 0)
    mob:setLocalVar("control", 0)
    mob:setLocalVar("TP", 0)
end

entity.onMobEngaged = function(mob, target)
    mob:messageText(mob, ID.text.BLOOD_RACING)
end

entity.onMobFight = function(mob, target)
    if mob:getTP() == 3000 and mob:getLocalVar("control") == 0 then
        local shikX = GetMobByID(mob:getID() + 1)
        local shikZ = GetMobByID(mob:getID() - 1)
        local shikXTP = shikX:getLocalVar("TP")
        local shikZTP = shikZ:getLocalVar("TP")
        mob:setLocalVar("TP", 1)

        -- All shikaree are alive and have TP
        if shikX:isAlive() and shikZ:isAlive() then
            if shikXTP == 1 and shikZTP == 1 then
                mob:setLocalVar("control", 1)
                shikX:messageText(shikX, ID.text.MITHRAN_TRACKERS)
                shikX:updateEnmity(target)
                shikZ:updateEnmity(target)
                shikX:setMobMod(xi.mobMod.SKILL_LIST, 1165)
                mob:timer(7000, function(mobArg)
                    shikZ:setMobMod(xi.mobMod.SKILL_LIST, 1167)
                    mobArg:timer(7000, function(mobArg1)
                        mobArg1:setMobMod(xi.mobMod.SKILL_LIST, 1166)
                    end)
                end)

            -- Announce when TP ready
            else
                mob:setLocalVar("control", 1)
                mob:messageText(mob, ID.text.READY_TO_REAP)
            end

        -- Only Shik Y is alive and has TP
        elseif shikX:isAlive() and not shikZ:isAlive() then
            if shikXTP == 1 then
                mob:setLocalVar("control", 1)
                shikX:messageText(mob, ID.text.MITHRAN_TRACKERS)
                shikX:updateEnmity(target)
                shikX:setMobMod(xi.mobMod.SKILL_LIST, 1165)
                mob:timer(7000, function(mobArg)
                    mobArg:setMobMod(xi.mobMod.SKILL_LIST, 1166)
                end)

            -- Announce when TP ready
            else
                mob:setLocalVar("control", 1)
                mob:messageText(target, ID.text.READY_TO_REAP)
            end

        -- Only Shik Z is alive and has TP
        elseif shikZ:isAlive() and not shikX:isAlive() then
            if shikZTP == 1 then
                mob:setLocalVar("control", 1)
                shikZ:messageText(shikZ, ID.text.FOLLOW_LEAD)
                shikZ:updateEnmity(target)
                shikZ:setMobMod(xi.mobMod.SKILL_LIST, 1167)
                mob:timer(7000, function(mobArg)
                    mobArg:setMobMod(xi.mobMod.SKILL_LIST, 1166)
                end)

            -- Announce when TP ready
            else
                mob:setLocalVar("control", 1)
                mob:messageText(mob, ID.text.READY_TO_REAP)
            end

        -- Shik Y is last alive
        else
                mob:messageText(mob, dialogue[math.random(1, 3)])
                mob:setMobMod(xi.mobMod.SKILL_LIST, 1166)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        mob:messageText(mob, ID.text.I_LOST)
        -- Reset controls so that remaining shiks don't get locked from weaponskilling
        GetMobByID(mob:getID() + 1):setLocalVar("control", 0)
        GetMobByID(mob:getID() - 1):setLocalVar("control", 0)
    end
end

return entity
