-----------------------------------
--  Colonization Reives
-- https://www.bg-wiki.com/ffxi/Category:Reive#Colonization_Reive
-----------------------------------
require("scripts/globals/utils")
require("scripts/globals/zone")
-----------------------------------
xi = xi or {}
xi.reives = xi.reives or {}

-- NOTE: Reives blockers act like doors and blockers in other parts of the game.
--       One NPC acts as the visual element and another acts as the collision
--       blocker.

xi.reives.setupZone = function(zone)
    local ID = zones[zone:getID()]

    if xi.settings.main.ENABLE_SOA == 1 then
        for idx, _ in ipairs(ID.reive) do
            xi.reives.enableReive(ID, idx)
        end
    end
end

xi.reives.enableReive = function(ID, reiveNum)
    for _, entryId in pairs(ID.reive[reiveNum].mob) do
        SpawnMob(entryId)

        -- TODO: Set name flags (sword)
    end

    for _, entryId in pairs(ID.reive[reiveNum].obstacles) do
        GetMobByID(entryId):setAnimation(xi.animation.CLOSE_DOOR)
    end

    for _, entryId in pairs(ID.reive[reiveNum].collision) do
        GetNPCByID(entryId):setAnimation(xi.animation.CLOSE_DOOR)
    end
end

xi.reives.disableReive = function(ID, reiveNum)
    for _, entryId in pairs(ID.reive[reiveNum].mob) do
        DespawnMob(entryId)

        -- TODO: Mobs should go grey and fade away, instead of plain despawn
    end

    for _, entryId in pairs(ID.reive[reiveNum].obstacles) do
        GetMobByID(entryId):setAnimation(xi.animation.OPEN_DOOR)
    end

    for _, entryId in pairs(ID.reive[reiveNum].collision) do
        GetNPCByID(entryId):setAnimation(xi.animation.OPEN_DOOR)
    end
end
