-----------------------------------
-- light_into_the_darkness
-- !instance 9300
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
--
-- TODO:
-- - (capped) Opening cs is missing (cs 4)
-- - cs needs NPC data:
--      - [Warning] Server need NPC <17158387>
--      - [Warning] Server need NPC <17158388>
--      - [Warning] Server need NPC <17158389>
--      - [Warning] Server need NPC <17158390>
--      - [Warning] Server need NPC <17158391>
--      - [Warning] Server need NPC <17158392>
--      - [Warning] Server need NPC <17158393>
--      - [Warning] Server need NPC <17158394>
--      - [Warning] Server need NPC <17158395>
--      - [Warning] Server need NPC <17158396>
--      - [Warning] Server need NPC <17158397>
-- - (capped) They should be buffing with Aquaveil, Blink, Stoneskin, Protect III, Shell III, Haste
-- - (capped) They should start roaming immediately, there is currently a delay and then they _all_ start
-- - (capped) Ending cs when you zone back into Pashhow Marshlands [S] (cs 902)
-- - Make Sapphire Quadav roam between groups (a triangle around the room is fine)
-- - Exit on fail zone and location is wrong
--
-- DONE:
-- - (capped) Exit cs (cs 10000)
-- - (capped) The Sapphirine Quadav models are wrong, they should have blue clubs
-- - (capped) The fight ends after defeating 7 henchmen (so presumably, any Quadavs will work)
-- - (capped) The henchmen look to have 2100ish HP each
-- - (capped) They should aggro to sound (so you can stand still and cast trusts at the start etc.)
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Ruhotz_Silvermines/IDs")
-----------------------------------
local instance_object = {}

instance_object.registryRequirements = function(player)
    -- TODO
    return true
end

instance_object.entryRequirements = function(player)
    -- TODO
    return true
end

instance_object.onInstanceCreated = function(instance)
    for i = 0, 9 do
        SpawnMob(ID.mob.SAPPHIRINE_QUADAV_OFFSET + i, instance)
    end
end

instance_object.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instance_object.afterInstanceRegister = function(player)
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    local deadCount = 0
    for i = 0, 9 do
        local mob = GetMobByID(ID.mob.SAPPHIRINE_QUADAV_OFFSET + i, instance)
        if mob:isDead() then
            deadCount = deadCount + 1
        end
    end

    if deadCount >= 7 and instance:getLocalVar("FLAGGED_DONE") == 0 then
        instance:complete()
        instance:setLocalVar("FLAGGED_DONE", 1)
    end
end

instance_object.onInstanceFailure = function(instance)
    local chars = instance:getChars()
    for _, v in ipairs(chars) do
        v:setPos(-385.602, 21.970, 456.359, 0, 90)
    end
end

instance_object.onInstanceProgressUpdate = function(instance, progress)
end

instance_object.onInstanceComplete = function(instance)
    -- TODO: This gets interrupted by aggressive actions
    local chars = instance:getChars()
    for _, v in ipairs(chars) do
        v:startEvent(10000)
    end
end

return instance_object
