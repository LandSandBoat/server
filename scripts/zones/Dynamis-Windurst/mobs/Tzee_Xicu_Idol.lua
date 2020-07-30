-----------------------------------
-- Area: Dynamis - Windurst
--  Mob: Tzee Xicu Idol
-- Note: Mega Boss
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

function onMobEngaged(mob, target)
    local mobId = mob:getID()
    for i = mobId + 1, mobId + 2 do
        if not GetMobByID(i):isSpawned() then
            SpawnMob(i):updateEnmity(target)
        end
    end
end

function onMobDeath(mob, player, isKiller)
    dynamis.megaBossOnDeath(mob, player, isKiller)

    if isKiller then
        local mobId = mob:getID()
        for i = mobId + 1, mobId + 2 do
            if GetMobByID(i):isSpawned() then
                DespawnMob(i)
            end
        end
    end
end
