-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Old Sabertooth
-- Involved in Quest: The Fanged One
-- !pos 676 -10 -366 120
-----------------------------------
---@type TMobEntity
local entity = {}

local pathNodes =
{
    { x = 675, y = -10, z = -362 },
    { x = 674, y = -10, z = -368 },
    { x = 672, y = -9.1, z = -372 },
    { x = 668, y = -8.3, z = -376 },
    { x = 674, y = -10, z = -366 },
    { x = 675, y = -9.9, z = -361 },
    { x = 674, y = -9.5, z = -357 },
    { x = 673, y = -9.0, z = -352 },
    { x = 671, y = -8.9, z = -347 },
    { x = 668, y = -9.5, z = -341 },

}

entity.onMobSpawn = function(mob)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.STANDBACK))
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    mob:setMobAbilityEnabled(false)
    mob:setAutoAttackEnabled(false)
    mob:setRoamFlags(bit.bor(xi.roamFlag.IGNORE, xi.roamFlag.SCRIPTED))
    mob:pathThrough(pathNodes, xi.path.flag.PATROL)

    mob:addListener('TAKE_DAMAGE', 'PRIME_TAKE_DAMAGE', function(tiger, amount, attacker)
        if attacker then
            tiger:setLocalVar('tookDamage', 1)
            tiger:setMobAbilityEnabled(true)
            tiger:setAutoAttackEnabled(true)
            tiger:setBehaviour(0)
        end
    end)
end

entity.onMobFight = function(mob)
    if mob:getLocalVar('control') == 0 and mob:getLocalVar('tookDamage') == 0 then
        mob:setLocalVar('control', 1)
        mob:timer(15000, function(mobArg)
            local pos = mob:getPos()
            mob:pathTo(pos.x + math.random(-2, 2), pos.y, pos.z + math.random(-2, 2), 9)
            mobArg:setLocalVar('control', 0)
        end)
    end
end

entity.onMobDeath = function(mob, player, optParams)-- TODO: We currently can't move old sabertooth logic from mob script to quest script due to how the quest works
    local players = mob:getZone():getPlayers()
        for i, person in pairs(players) do -- can't use the variable name "player" because it's already being used
            if
                person:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_FANGED_ONE) == xi.questStatus.QUEST_ACCEPTED and
                person:checkDistance(mob) < 32
        then
            if mob:getLocalVar('tookDamage') == 0 then
                person:setCharVar('Quest[2][31]Prog', 1)
            else
                person:setCharVar('Quest[2][31]Timer', os.time() + 300)
            end
        end
    end
end

return entity
