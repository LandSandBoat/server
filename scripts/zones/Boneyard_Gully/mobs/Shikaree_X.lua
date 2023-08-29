-----------------------------------
-- Area: Boneyard_Gully
--  Mob: Shikaree X
--  Quest: Tango with a Tracker, Requiem of Sin
--  Mission: CoP 5-3 Ulmia's Path (Head Wind)
-----------------------------------
local ID = require("scripts/zones/Boneyard_Gully/IDs")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

local dialogue =
{
    ID.text.ADVENTURER_STEAK,
    ID.text.MY_TURN,
    ID.text.YOURE_MINE,
}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 0)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 100)
    mob:setMod(xi.mod.SLEEPRES, 50)

    mob:addListener("ATTACK", "SHIKAREE_X_ATTACK", function(attacker, defender, action)
        if math.random() < 0.12 then
            attacker:setTP(3000)
        end
    end)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 695 then
        mob:messageText(mob, ID.text.END_THE_HUNT)
    end

    mob:setMobMod(xi.mobMod.SKILL_LIST, 0)
    mob:setLocalVar("control", 0)
    mob:setLocalVar("TP", 0)
end

entity.onMobFight = function(mob, target)
    if mob:getTP() == 3000 and mob:getLocalVar("control") == 0 then
        local shikY = GetMobByID(mob:getID() - 1)
        local shikZ = GetMobByID(mob:getID() - 2)
        local shikYTP = shikY:getLocalVar("TP")
        local shikZTP = shikZ:getLocalVar("TP")
        mob:setLocalVar("TP", 1)

        -- All shikaree are alive and have TP
        if shikY:isAlive() and shikZ:isAlive() then
            if shikYTP == 1 and shikZTP == 1 then
                mob:setLocalVar("control", 1)
                shikY:messageText(shikY, ID.text.MITHRAN_TRACKERS)
                shikY:updateEnmity(target)
                shikZ:updateEnmity(target)
                shikY:setMobMod(xi.mobMod.SKILL_LIST, 1166)
                mob:timer(7000, function(mobArg)
                    shikZ:setMobMod(xi.mobMod.SKILL_LIST, 1167)
                    mobArg:timer(7000, function(mobArg1)
                        mobArg1:setMobMod(xi.mobMod.SKILL_LIST, 1165)
                    end)
                end)

            -- Announce when TP ready if not all 3 are
            else
                mob:setLocalVar("control", 1)
                mob:messageText(mob, ID.text.READY_TO_RUMBLE)
            end

        -- Only Shik Y is alive and has TP
        elseif shikY:isAlive() and not shikZ:isAlive() then
            if shikYTP == 1 then
                shikY:messageText(shikY, ID.text.MITHRAN_TRACKERS)
                mob:setLocalVar("control", 1)
                shikY:updateEnmity(target)
                shikY:setMobMod(xi.mobMod.SKILL_LIST, 1166)
                mob:timer(7000, function(mobArg)
                    mobArg:setMobMod(xi.mobMod.SKILL_LIST, 1165)
                end)

            -- Announce when TP ready
            else
                mob:setLocalVar("control", 1)
                mob:messageText(mob, ID.text.READY_TO_RUMBLE)
            end

        -- Only Shik Z is alive and has TP
        elseif shikZ:isAlive() and not shikY:isAlive() then
            if shikZTP then
                shikZ:messageText(shikZ, ID.text.FOLLOW_LEAD)
                mob:setLocalVar("control", 1)
                shikZ:updateEnmity(target)
                shikZ:setMobMod(xi.mobMod.SKILL_LIST, 1167)
                mob:timer(7000, function(mobArg)
                    mobArg:setMobMod(xi.mobMod.SKILL_LIST, 1165)
                end)

            -- Announce when TP ready
            else
                mob:setLocalVar("control", 1)
                mob:messageText(mob, ID.text.READY_TO_RUMBLE)
            end

        -- Shik X is last alive
        else
                mob:messageText(mob, dialogue[math.random(1, 3)])
                mob:setMobMod(xi.mobMod.SKILL_LIST, 1165)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        mob:messageText(mob, ID.text.AT_MY_BEST)
        -- Reset controls so that remaining shiks don't get locked from weaponskilling
        GetMobByID(mob:getID() - 1):setLocalVar("control", 0)
        GetMobByID(mob:getID() - 2):setLocalVar("control", 0)
    end
end

return entity
