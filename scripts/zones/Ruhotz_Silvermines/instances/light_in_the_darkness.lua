-----------------------------------
-- light_in_the_darkness
-- !instance 9300
-- MINE_SHAFT_KEY : !addkeyitem 961
--
-- WIKI:
-- - After a cutscene, you will find 9 Sapphirine Quadav and 1 Sapphire Quadav.
-- - Kill any 7 Quadav to complete the objective.
-- - You have 30 minutes to complete the objective.
-- - The Quadav will appear rather close to the player characters, in front of them. Moving away from them before any comes close enough, will give time to prepare for battle without aggravating them.
-- - The Quadav are in three groups of three Sapphirine Quadav with the Sapphire Quadav slowly roaming between the three groups.
-- - The Sapphire Quadav has about 2000 HP and can use Benediction.
-- - Killing the Sapphire Quadav will cause the Sapphirine Quadav to scatter, making it easier to pick them off one by one.
-- - They will still be aggressive as usual after scattering, but only after they stop "fleeing".
-- - It is possible to kill them one by one, as long as the Quadav of choice is a good distance from the other two in the group.
-- - They all have fairly low HP and Defense but are highly resistant or immune to Gravity and Bind.
-- - They have True Hearing.
-- - Trusts are allowed.
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Ruhotz_Silvermines/IDs")
-----------------------------------
local instanceObject = {}

instanceObject.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.MINE_SHAFT_KEY)
end

instanceObject.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.MINE_SHAFT_KEY)
end

instanceObject.onInstanceCreated = function(instance)
    for i = 0, 9 do
        SpawnMob(ID.mob.SAPPHIRINE_QUADAV_OFFSET + i, instance)
    end
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instanceObject.afterInstanceRegister = function(player)
    player:delKeyItem(xi.ki.MINE_SHAFT_KEY)

    local questStatus = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.LIGHT_IN_THE_DARKNESS)
    local questProgVar = player:getCharVar("Quest[7][19]Prog")
    if
        questStatus == QUEST_ACCEPTED and
        (questProgVar == 4 or questProgVar == 7)
    then
        -- TODO: Player is not locked during this CS and will aggro the mobs
        player:startEvent(4)
    end
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    local deadCount = 0
    for i = 0, 9 do
        local mob = GetMobByID(ID.mob.SAPPHIRINE_QUADAV_OFFSET + i, instance)
        if mob:isDead() then
            deadCount = deadCount + 1
        end
    end

    if deadCount >= 7 then
        instance:complete()
    end
end

instanceObject.onInstanceFailure = function(instance)
    local chars = instance:getChars()
    for _, v in ipairs(chars) do
        local questProgVar = v:getCharVar("Quest[7][19]Prog")
        if questProgVar == 4 then
            v:setCharVar("Quest[7][19]Prog", 7)
        end

        v:setPos(-385.602, 21.970, 456.359, 0, 90)
    end
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
end

instanceObject.onInstanceComplete = function(instance)
    local chars = instance:getChars()
    for _, v in ipairs(chars) do
        local questProgVar = v:getCharVar("Quest[7][19]Prog")
        if questProgVar == 4 or questProgVar == 7 then
            v:setCharVar("Quest[7][19]Prog", 5)
        end

        v:startEvent(10000)
    end
end

return instanceObject
