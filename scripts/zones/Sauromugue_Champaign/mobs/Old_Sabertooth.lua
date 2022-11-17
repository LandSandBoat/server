-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Old Sabertooth
-- Involved in Quest: The Fanged One
-- !pos 676 -10 -366 120
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.STANDBACK))
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    mob:SetMobAbilityEnabled(false)
    mob:SetAutoAttackEnabled(false)
    mob:setRoamFlags(256, 512)

    mob:addListener("TAKE_DAMAGE", "PRIME_TAKE_DAMAGE", function(tiger, amount, attacker)
        if attacker then
            tiger:setLocalVar("tookDamage", 1)
            tiger:SetMobAbilityEnabled(true)
            tiger:SetAutoAttackEnabled(true)
            tiger:setBehaviour(0)
        end
    end)
end

entity.onMobFight = function(mob)
    if mob:getLocalVar("control") == 0 and mob:getLocalVar("tookDamage") == 0 then
        mob:setLocalVar("control", 1)
        mob:timer(15000, function(mobArg)
            local pos = mob:getPos()
            mob:pathTo(pos.x + math.random(-2, 2), pos.y, pos.z + math.random(-2, 2), 9)
            mobArg:setLocalVar("control", 0)
        end)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local players = mob:getZone():getPlayers()

    for i, person in pairs(players) do -- can't use the variable name "player" because it's already being used
        if person:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_FANGED_ONE) == QUEST_ACCEPTED and person:checkDistance(mob) < 32 then
            if mob:getLocalVar("tookDamage") == 0 then
                person:setCharVar("TheFangedOneCS", 2)
            else
                person:setCharVar("TheFangedOneTimer", os.time() + 300)
            end
        end
    end
end

return entity
