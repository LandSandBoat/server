-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Old Sabertooth
-- Involved in Quest: The Fanged One
-- !pos 676 -10 -366 120
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    if player == nil then
        local players = mob:getZone():getPlayers()

        for i, person in pairs(players) do -- can't use the variable name "player" because it's already being used
            if
                person:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_FANGED_ONE) == QUEST_ACCEPTED and
                person:checkDistance(mob) < 32
            then
                person:setCharVar('TheFangedOneCS', 2)
            end
        end
    end
end

return entity
